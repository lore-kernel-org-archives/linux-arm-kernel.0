From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:58 +0000
Subject: [PATCH v4 15/23] drm/rockchip: dw-mipi-dsi: configure PHY before
 enabling
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-16-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bias, bandgap and PLL should all be configured before we enable
them.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Squash together two patches that both affect initialization order of
  the PHY
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 78d676b7e516..4fee5176c606 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -413,12 +413,17 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 
 	dw_mipi_dsi_phy_write(dsi, 0x44, HSFREQRANGE_SEL(testdin));
 
-	dw_mipi_dsi_phy_write(dsi, 0x19, PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
 	dw_mipi_dsi_phy_write(dsi, 0x17, INPUT_DIVIDER(dsi->input_div));
 	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_LOW_SEL(dsi->feedback_div) |
 					 LOW_PROGRAM_EN);
 	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_HIGH_SEL(dsi->feedback_div) |
 					 HIGH_PROGRAM_EN);
+	dw_mipi_dsi_phy_write(dsi, 0x19, PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
+
+	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
+					 BIASEXTR_SEL(BIASEXTR_127_7));
+	dw_mipi_dsi_phy_write(dsi, 0x22, HIGH_PROGRAM_EN |
+					 BANDGAP_SEL(BANDGAP_96_10));
 
 	dw_mipi_dsi_phy_write(dsi, 0x20, POWER_CONTROL | INTERNAL_REG_CURRENT |
 					 BIAS_BLOCK_ON | BANDGAP_ON);
@@ -429,10 +434,6 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 					 SETRD_MAX | POWER_MANAGE |
 					 TER_RESISTORS_ON);
 
-	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
-					 BIASEXTR_SEL(BIASEXTR_127_7));
-	dw_mipi_dsi_phy_write(dsi, 0x22, HIGH_PROGRAM_EN |
-					 BANDGAP_SEL(BANDGAP_96_10));
 
 	dw_mipi_dsi_phy_write(dsi, 0x70, TLP_PROGRAM_EN | 0xf);
 	dw_mipi_dsi_phy_write(dsi, 0x71, THS_PRE_PROGRAM_EN | 0x55);
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
