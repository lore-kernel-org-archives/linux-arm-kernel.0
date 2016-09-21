From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 21 Sep 2016 15:04:06 +0800
Subject: [PATCH 2/2] phy-sun4i-usb: add support for host mode of phy0 on A64
 SoC
In-Reply-To: <20160921070406.27445-1-icenowy@aosc.xyz>
References: <20160921070406.27445-1-icenowy@aosc.xyz>
Message-ID: <20160921070406.27445-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OTG phy of A64 can be put into the host mode with an OHCI/EHCI pair,
just like the H3 SoC.

Some A64 boards (such as Pine64 series) use the USB OTG port as a generic
USB-A port, and thus can be fully support by the driver now.

The register's name is changed to PHY_OTG_CFG, as it's described in the
A64 downstream BSP kernel source, at drivers/usb/host/sunxi_hci.h .

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/phy/phy-sun4i-usb.c | 46 +++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index a4db658..9287247 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -47,7 +47,7 @@
 #define REG_PHYBIST			0x08
 #define REG_PHYTUNE			0x0c
 #define REG_PHYCTL_A33			0x10
-#define REG_PHY_UNK_H3			0x20
+#define REG_PHY_OTG_CFG			0x20
 
 #define REG_PMU_UNK1			0x10
 
@@ -107,6 +107,7 @@ struct sun4i_usb_phy_cfg {
 	u8 phyctl_offset;
 	bool dedicated_clocks;
 	bool enable_pmu_unk1;
+	bool route_otg;
 };
 
 struct sun4i_usb_phy_data {
@@ -135,6 +136,7 @@ struct sun4i_usb_phy_data {
 	int id_det;
 	int vbus_det;
 	struct delayed_work detect;
+	bool otg_routed;
 };
 
 #define to_sun4i_usb_phy_data(phy) \
@@ -263,10 +265,11 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		writel(val & ~2, phy->pmu + REG_PMU_UNK1);
 	}
 
-	if (data->cfg->type == sun8i_h3_phy) {
-		if (phy->index == 0) {
-			val = readl(data->base + REG_PHY_UNK_H3);
-			writel(val & ~1, data->base + REG_PHY_UNK_H3);
+	if (data->cfg->route_otg) {
+		if (phy->index == 0 && data->otg_routed) {
+			/* Route the OTG PHY to HCI */
+			val = readl(data->base + REG_PHY_OTG_CFG);
+			writel(val & ~1, data->base + REG_PHY_OTG_CFG);
 		}
 	} else {
 		/* Enable USB 45 Ohm resistor calibration */
@@ -283,7 +286,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 
 	sun4i_usb_phy_passby(phy, 1);
 
-	if (phy->index == 0) {
+	if (phy->index == 0 && !data->otg_routed) {
 		data->phy0_init = true;
 
 		/* Enable pull-ups */
@@ -310,7 +313,7 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
 	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
 	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
 
-	if (phy->index == 0) {
+	if (phy->index == 0 && !data->otg_routed) {
 		/* Disable pull-ups */
 		sun4i_usb_phy0_update_iscr(_phy, ISCR_DPDM_PULLUP_EN, 0);
 		sun4i_usb_phy0_update_iscr(_phy, ISCR_ID_PULLUP_EN, 0);
@@ -377,7 +380,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 
 	/* For phy0 only turn on Vbus if we don't have an ext. Vbus */
 	if (phy->index == 0 && sun4i_usb_phy0_have_vbus_det(data) &&
-				data->vbus_det)
+				data->vbus_det && !data->otg_routed)
 		return 0;
 
 	ret = regulator_enable(phy->vbus);
@@ -387,7 +390,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 	phy->regulator_on = true;
 
 	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
-	if (phy->index == 0 && sun4i_usb_phy0_poll(data))
+	if (phy->index == 0 && sun4i_usb_phy0_poll(data) && !data->otg_routed)
 		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
 
 	return 0;
@@ -408,7 +411,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	 * phy0 vbus typically slowly discharges, sometimes this causes the
 	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
 	 */
-	if (phy->index == 0 && !sun4i_usb_phy0_poll(data))
+	if (phy->index == 0 && !sun4i_usb_phy0_poll(data) && !data->otg_routed)
 		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
 
 	return 0;
@@ -567,7 +570,17 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&data->mutex);
-	INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
+	if (device_property_read_bool(dev, "allwinner,otg-routed")) {
+		/*
+		 * PHY0 is routed to HCI rather than OTG Controller.
+		 * In this situation, the port can only be used as a host port.
+		 */
+		data->otg_routed = true;
+	} else {
+		/* ID/Vbus detection is only meaningful when it's really OTG */
+		INIT_DELAYED_WORK(&data->detect,
+				  sun4i_usb_phy0_id_vbus_det_scan);
+	}
 	dev_set_drvdata(dev, data);
 	data->cfg = of_device_get_match_data(dev);
 	if (!data->cfg)
@@ -647,7 +660,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(phy->reset);
 		}
 
-		if (i) { /* No pmu for usbc0 */
+		/* PMU is only valid on PHYs in HCI mode */
+		if (i || data->otg_routed) {
 			snprintf(name, sizeof(name), "pmu%d", i);
 			res = platform_get_resource_byname(pdev,
 							IORESOURCE_MEM, name);
@@ -719,6 +733,7 @@ static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
 	.enable_pmu_unk1 = false,
+	.route_otg = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
@@ -728,6 +743,7 @@ static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
 	.enable_pmu_unk1 = false,
+	.route_otg = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
@@ -737,6 +753,7 @@ static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = false,
+	.route_otg = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
@@ -746,6 +763,7 @@ static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
 	.enable_pmu_unk1 = false,
+	.route_otg = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
@@ -755,6 +773,7 @@ static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = false,
+	.route_otg = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
@@ -764,6 +783,7 @@ static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = false,
+	.route_otg = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
@@ -772,6 +792,7 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.disc_thresh = 3,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = true,
+	.route_otg = true,
 };
 
 static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
@@ -781,6 +802,7 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = true,
+	.route_otg = true,
 };
 
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
-- 
2.10.0
