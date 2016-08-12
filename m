From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 12 Aug 2016 11:06:21 +0800
Subject: [PATCH RESEND v2 2/3] phy: sun4i: add support for A64 usb phy
In-Reply-To: <20160812030622.4492-1-icenowy@aosc.xyz>
References: <20160812030622.4492-1-icenowy@aosc.xyz>
Message-ID: <20160812030622.4492-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's something unknown in the pmu part that shared with H3.
It's renamed as PMU_UNK1 from PMU_UNK_H3.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/phy/phy-sun4i-usb.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0a45bc6..a4db658 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -49,7 +49,7 @@
 #define REG_PHYCTL_A33			0x10
 #define REG_PHY_UNK_H3			0x20
 
-#define REG_PMU_UNK_H3			0x10
+#define REG_PMU_UNK1			0x10
 
 #define PHYCTL_DATA			BIT(7)
 
@@ -97,6 +97,7 @@ enum sun4i_usb_phy_type {
 	sun6i_a31_phy,
 	sun8i_a33_phy,
 	sun8i_h3_phy,
+	sun50i_a64_phy,
 };
 
 struct sun4i_usb_phy_cfg {
@@ -105,6 +106,7 @@ struct sun4i_usb_phy_cfg {
 	u32 disc_thresh;
 	u8 phyctl_offset;
 	bool dedicated_clocks;
+	bool enable_pmu_unk1;
 };
 
 struct sun4i_usb_phy_data {
@@ -180,8 +182,9 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 
 	mutex_lock(&phy_data->mutex);
 
-	if (phy_data->cfg->type == sun8i_a33_phy) {
-		/* A33 needs us to set phyctl to 0 explicitly */
+	if (phy_data->cfg->type == sun8i_a33_phy ||
+	    phy_data->cfg->type == sun50i_a64_phy) {
+		/* A33 or A64 needs us to set phyctl to 0 explicitly */
 		writel(0, phyctl);
 	}
 
@@ -255,14 +258,16 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
+	if (data->cfg->enable_pmu_unk1) {
+		val = readl(phy->pmu + REG_PMU_UNK1);
+		writel(val & ~2, phy->pmu + REG_PMU_UNK1);
+	}
+
 	if (data->cfg->type == sun8i_h3_phy) {
 		if (phy->index == 0) {
 			val = readl(data->base + REG_PHY_UNK_H3);
 			writel(val & ~1, data->base + REG_PHY_UNK_H3);
 		}
-
-		val = readl(phy->pmu + REG_PMU_UNK_H3);
-		writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
 	} else {
 		/* Enable USB 45 Ohm resistor calibration */
 		if (phy->index == 0)
@@ -713,6 +718,7 @@ static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
+	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
@@ -721,6 +727,7 @@ static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
 	.disc_thresh = 2,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
+	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
@@ -729,6 +736,7 @@ static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
+	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
@@ -737,6 +745,7 @@ static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
 	.disc_thresh = 2,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
+	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
@@ -745,6 +754,7 @@ static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
+	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
@@ -753,6 +763,7 @@ static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
+	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
@@ -760,6 +771,16 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.type = sun8i_h3_phy,
 	.disc_thresh = 3,
 	.dedicated_clocks = true,
+	.enable_pmu_unk1 = true,
+};
+
+static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
+	.num_phys = 2,
+	.type = sun50i_a64_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.enable_pmu_unk1 = true,
 };
 
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
@@ -770,6 +791,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-usb-phy", .data = &sun8i_a23_cfg },
 	{ .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
 	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun50i-a64-usb-phy", .data = &sun50i_a64_cfg},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.9.2
