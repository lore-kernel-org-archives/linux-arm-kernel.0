From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:18 +0000
Subject: [PATCH v2 16/26] drm/rockchip: dw-mipi-dsi: configure bias and
 bandgap before enable
In-Reply-To: <20170121163128.22240-1-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
Message-ID: <20170121163128.22240-17-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should configure these functions before enabling them.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 5b3068e9e8db..ce1e6f9a2041 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -420,6 +420,11 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dw_mipi_dsi_phy_write(dsi, 0x18, LOOP_DIV_HIGH_SEL(dsi->feedback_div) |
 					 HIGH_PROGRAM_EN);
 
+	dw_mipi_dsi_phy_write(dsi, 0x22, LOW_PROGRAM_EN |
+					 BIASEXTR_SEL(BIASEXTR_127_7));
+	dw_mipi_dsi_phy_write(dsi, 0x22, HIGH_PROGRAM_EN |
+					 BANDGAP_SEL(BANDGAP_96_10));
+
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
2.11.0.197.gb556de5.dirty
