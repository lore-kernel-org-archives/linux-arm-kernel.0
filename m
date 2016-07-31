From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 31 Jul 2016 19:25:35 +0800
Subject: [PATCH 2/3] phy: sun4i: add support for A64 usb phy
In-Reply-To: <20160731112536.4625-1-icenowy@aosc.xyz>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
Message-ID: <20160731112536.4625-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's something unknown in the pmu part.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/phy/phy-sun4i-usb.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0a45bc6..6f94369 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -97,6 +97,7 @@ enum sun4i_usb_phy_type {
 	sun6i_a31_phy,
 	sun8i_a33_phy,
 	sun8i_h3_phy,
+	sun50i_a64_phy,
 };
 
 struct sun4i_usb_phy_cfg {
@@ -180,8 +181,9 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 
 	mutex_lock(&phy_data->mutex);
 
-	if (phy_data->cfg->type == sun8i_a33_phy) {
-		/* A33 needs us to set phyctl to 0 explicitly */
+	if (phy_data->cfg->type == sun8i_a33_phy ||
+	    phy_data->cfg->type == sun50i_a64_phy) {
+		/* A33 or A64 needs us to set phyctl to 0 explicitly */
 		writel(0, phyctl);
 	}
 
@@ -264,6 +266,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		val = readl(phy->pmu + REG_PMU_UNK_H3);
 		writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
 	} else {
+		/* A64 needs also this unknown bit */
+		if (data->cfg->type == sun50i_a64_phy) {
+			val = readl(phy->pmu + REG_PMU_UNK_H3);
+			writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
+		}
+
 		/* Enable USB 45 Ohm resistor calibration */
 		if (phy->index == 0)
 			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
@@ -762,6 +770,14 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.dedicated_clocks = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
+	.num_phys = 2,
+	.type = sun50i_a64_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+};
+
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
@@ -770,6 +786,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-usb-phy", .data = &sun8i_a23_cfg },
 	{ .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
 	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun50i-a64-usb-phy", .data = &sun50i_a64_cfg},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.9.0
