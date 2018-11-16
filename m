From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 16 Nov 2018 22:09:06 +0530
Subject: [PATCH v2 02/12] drm/sun4i: sun6i_mipi_dsi: Support instruction loop
 selection
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
Message-ID: <20181116163916.29621-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instruction loop selection would require before writing
loop number registers, so enable idle, LP11 bits on
loop selection register.

Reference code available in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

(dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
	3<<(4*DSI_INST_ID_DLY);

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 43ab7127d428..3ac002c4d8b3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -438,6 +438,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 {
 	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+		     DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
+		     DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
 		     SUN6I_DSI_INST_LOOP_NUM_N1(delay));
-- 
2.18.0.321.gffc6fa0e3
