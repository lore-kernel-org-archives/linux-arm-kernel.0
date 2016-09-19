From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:32 +0100
Subject: [PATCH 18/27] drm/rockchip: dw-mipi-dsi: configure bias and bandgap
 before enable
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-23-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should configure these functions before enabling them.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index e310c3d81bb8..65c89367d8b2 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -421,6 +421,11 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_HIGH_SEL(dsi->feedback_div) |
 					 HIGH_PROGRAM_EN);
 
+	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
+					 BIASEXTR_SEL(BIASEXTR_127_7));
+	dw_mipi_dsi_phy_write(dsi, 0x22, HIGH_PROGRAM_EN |
+					 BANDGAP_SEL(BANDGAP_96_10));
+
 	dw_mipi_dsi_phy_write(dsi, 0x20, POWER_CONTROL | INTERNAL_REG_CURRENT |
 					 BIAS_BLOCK_ON | BANDGAP_ON);
 
@@ -430,10 +435,6 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 					 SETRD_MAX | POWER_MANAGE |
 					 TER_RESISTORS_ON);
 
-	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
-					 BIASEXTR_SEL(BIASEXTR_127_7));
-	dw_mipi_dsi_phy_write(dsi, 0x22, HIGH_PROGRAM_EN |
-					 BANDGAP_SEL(BANDGAP_96_10));
 
 	dw_mipi_dsi_phy_write(dsi, 0x70, TLP_PROGRAM_EN | 0xf);
 	dw_mipi_dsi_phy_write(dsi, 0x71, THS_PRE_PROGRAM_EN | 0x55);
-- 
2.10.0.278.g4f427b1.dirty
