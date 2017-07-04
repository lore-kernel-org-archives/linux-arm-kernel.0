From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 14:37:03 +0200
Subject: [PATCH v3] phy: allwinner: phy-sun4i-usb: Add log when probing
Message-ID: <20170704123703.18916-1-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When phy-sun4i-usb's probing fails, it does not print the reason in
kernel log, forcing the developer to edit this driver to add info logs.
This commit makes the kernel print the reason of phy-sun4i-usb's probing
failure or a success message.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

Nothing new in v3, the driver has just been moved to the directory
allwinner so updating the patch to reflect this change. Sorry for the
delay, completely forgot it hadn't been merged/acked back then.

v2:
  - removing (from v1) debug message when devm_ioremap_resource fails,
  - changing dev_info to dev_dbg when driver is successfully loaded,

 drivers/phy/allwinner/phy-sun4i-usb.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index bbf06cfe5898..3bea17b9405a 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -653,19 +653,25 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 
 	data->id_det_gpio = devm_gpiod_get_optional(dev, "usb0_id_det",
 						    GPIOD_IN);
-	if (IS_ERR(data->id_det_gpio))
+	if (IS_ERR(data->id_det_gpio)) {
+		dev_err(dev, "Couldn't request ID GPIO\n");
 		return PTR_ERR(data->id_det_gpio);
+	}
 
 	data->vbus_det_gpio = devm_gpiod_get_optional(dev, "usb0_vbus_det",
 						      GPIOD_IN);
-	if (IS_ERR(data->vbus_det_gpio))
+	if (IS_ERR(data->vbus_det_gpio)) {
+		dev_err(dev, "Couldn't request VBUS detect GPIO\n");
 		return PTR_ERR(data->vbus_det_gpio);
+	}
 
 	if (of_find_property(np, "usb0_vbus_power-supply", NULL)) {
 		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
 						     "usb0_vbus_power-supply");
-		if (IS_ERR(data->vbus_power_supply))
+		if (IS_ERR(data->vbus_power_supply)) {
+			dev_err(dev, "Couldn't get the VBUS power supply\n");
 			return PTR_ERR(data->vbus_power_supply);
+		}
 
 		if (!data->vbus_power_supply)
 			return -EPROBE_DEFER;
@@ -674,8 +680,10 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	data->dr_mode = of_usb_get_dr_mode_by_phy(np, 0);
 
 	data->extcon = devm_extcon_dev_allocate(dev, sun4i_usb_phy0_cable);
-	if (IS_ERR(data->extcon))
+	if (IS_ERR(data->extcon)) {
+		dev_err(dev, "Couldn't allocate our extcon device\n");
 		return PTR_ERR(data->extcon);
+	}
 
 	ret = devm_extcon_dev_register(dev, data->extcon);
 	if (ret) {
@@ -690,8 +698,13 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		snprintf(name, sizeof(name), "usb%d_vbus", i);
 		phy->vbus = devm_regulator_get_optional(dev, name);
 		if (IS_ERR(phy->vbus)) {
-			if (PTR_ERR(phy->vbus) == -EPROBE_DEFER)
+			if (PTR_ERR(phy->vbus) == -EPROBE_DEFER) {
+				dev_err(dev,
+					"Couldn't get regulator %s... Deferring probe\n",
+					name);
 				return -EPROBE_DEFER;
+			}
+
 			phy->vbus = NULL;
 		}
 
@@ -775,6 +788,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy_provider);
 	}
 
+	dev_dbg(dev, "successfully loaded\n");
+
 	return 0;
 }
 
-- 
2.11.0
