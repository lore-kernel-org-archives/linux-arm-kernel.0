From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 16:46:15 +0530
Subject: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
Message-ID: <20181113111633.20189-9-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The horizontal and vertical back porch calculation in BSP
code is simply following the Linux drm comment diagram, in
include/drm/drm_modes.h which is

[hv]back porch = [hv]total - [hv]sync_end

BSP code form BPI-M64-bsp is calculating vertical back porch as
(from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)

timmings->ver_sync_time= panel_info->lcd_vspw;
timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;

vbp = panel->lcd_vbp;
vspw = panel->lcd_vspw;
dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
=>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
=>  timmings->ver_back_porch
=>  mode->vtotal - mode->end

Which evatually same as mode->vtotal - mode->vsync_end so update the
same in SUN6I_DSI_BASIC_SIZE0_VBP

On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
value.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index cdd44a1307b3..eeea977604ac 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
 		     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
 					       mode->vsync_start) |
-		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
-					       mode->vdisplay));
+		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
+					       mode->vsync_end));
 
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE1_REG,
 		     SUN6I_DSI_BASIC_SIZE1_VACT(mode->vdisplay) |
-- 
2.18.0.321.gffc6fa0e3
