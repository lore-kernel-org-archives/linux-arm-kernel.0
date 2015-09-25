From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 25 Sep 2015 08:47:29 +0800
Subject: [PATCH RESEND] phy: sun4i-usb: Use devm_gpiod_get_optional for
 optional GPIOs
Message-ID: <1443142049.13662.1.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both data->id_det_gpio and data->vbus_det_gpio are optional, so use
devm_gpiod_get_optional for them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
This patch was sent on https://lkml.org/lkml/2015/8/21/177

 drivers/phy/phy-sun4i-usb.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 731b395..b12964b 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -551,19 +551,15 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	data->id_det_gpio = devm_gpiod_get(dev, "usb0_id_det", GPIOD_IN);
-	if (IS_ERR(data->id_det_gpio)) {
-		if (PTR_ERR(data->id_det_gpio) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		data->id_det_gpio = NULL;
-	}
-
-	data->vbus_det_gpio = devm_gpiod_get(dev, "usb0_vbus_det", GPIOD_IN);
-	if (IS_ERR(data->vbus_det_gpio)) {
-		if (PTR_ERR(data->vbus_det_gpio) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		data->vbus_det_gpio = NULL;
-	}
+	data->id_det_gpio = devm_gpiod_get_optional(dev, "usb0_id_det",
+						    GPIOD_IN);
+	if (IS_ERR(data->id_det_gpio))
+		return PTR_ERR(data->id_det_gpio);
+
+	data->vbus_det_gpio = devm_gpiod_get_optional(dev, "usb0_vbus_det",
+						      GPIOD_IN);
+	if (IS_ERR(data->vbus_det_gpio))
+		return PTR_ERR(data->vbus_det_gpio);
 
 	if (of_find_property(np, "usb0_vbus_power-supply", NULL)) {
 		data->vbus_power_supply = devm_power_supply_get_by_phandle(dev,
-- 
2.1.0
