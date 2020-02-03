--------------------------------
-- Minimap Coordinates
--
-- Displays the player's location coordinates as "(x,y)" in the zone text above
-- the minimap.
--
-- Author: Rohan Verghese
-- Email: rverghes@gmail.com
--------------------------------
local ADDON_NAME,MinimapCoordinates = ...
local MC = MinimapCoordinates

MC.updatePeriodInSeconds = 0.2
MC.timeSinceLastUpdate = 0
MC.Frame = CreateFrame("Frame")

MC.Frame:RegisterEvent("ZONE_CHANGED")
MC.Frame:RegisterEvent("ZONE_CHANGED_INDOORS")
MC.Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

MC.Frame:SetScript("OnUpdate", function(self,elapsed)
	MC.timeSinceLastUpdate = MC.timeSinceLastUpdate + elapsed
	if MC.timeSinceLastUpdate > MC.updatePeriodInSeconds then
		MC.UpdateMinimapText()
	end
end)

MC.Frame:SetScript("OnEvent", function(self,event,...)
	MC.UpdateMinimapText()
end)

function MC.UpdateMinimapText()
	local minimapText = GetMinimapZoneText()
	local text = minimapText
	local uiMapID = C_Map.GetBestMapForUnit("player")
	if uiMapID then
		local position = C_Map.GetPlayerMapPosition(uiMapID, "player")
		if position then
			text = string.format("(%d,%d) %s",position.x*100, position.y*100, minimapText)
		end
	end
	MinimapZoneText:SetText(text)
	MC.timeSinceLastUpdate = 0;
end