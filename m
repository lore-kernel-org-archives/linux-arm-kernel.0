From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 21 Aug 2016 14:16:38 +0200
Subject: [PATCH v3 6/7] phy-sun4i-usb: Add "allwinner,
 usb0-usb-a-connector" dt property
In-Reply-To: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
References: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471781799-10457-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some devices the musb otg controller can be used in both device and
host mode, but requires software mode switching since there is no id pin
connected. The usb0 phy code will default to device mode in this case.

On some systems usb0 is connected to a female USB-A port. It can still
be used in device mode when using software mode switching and a USB
A to A cable. To configure the controller to support both modes we must
set its "dr_mode" dt property to "otg" (*). For these setups the device
mode default is wrong, for a female USB-A port the default should be
host mode.

This commit adds support to the sun4i phy code for a new
"allwinner,usb0-usb-a-connector" dt property which can be used in dt
files to indicate this scenario and when present it changes the default
mode to host mode.

*) dr_mode = "host" is used when device mode is _never_ used. E.g.
a wifi module soldered onto the PCB is connected to the musb controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patchset
Changes in v3:
-No changes
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 2 ++
 drivers/phy/phy-sun4i-usb.c                             | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 287150d..8646b53 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -35,6 +35,8 @@ Optional properties:
 - usb0_vbus-supply : regulator phandle for controller usb0 vbus
 - usb1_vbus-supply : regulator phandle for controller usb1 vbus
 - usb2_vbus-supply : regulator phandle for controller usb2 vbus
+- allwinner,usb0-usb-a-connector: usb0 is connected to an USB-A connector,
+                     rather then an USB-B connector as one would expect (bool)
 
 Example:
 	usbphy: phy at 0x01c13400 {
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 03f030b..0b05f17 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -137,6 +137,7 @@ struct sun4i_usb_phy_data {
 	int vbus_det_irq;
 	int id_det;
 	int vbus_det;
+	int id_det_default;
 	struct delayed_work detect;
 };
 
@@ -328,7 +329,7 @@ static int sun4i_usb_phy0_get_id_det(struct sun4i_usb_phy_data *data)
 		if (data->id_det_gpio)
 			return gpiod_get_value_cansleep(data->id_det_gpio);
 		else
-			return 1; /* Fallback to peripheral mode */
+			return data->id_det_default;
 	case USB_DR_MODE_HOST:
 		return 0;
 	case USB_DR_MODE_PERIPHERAL:
@@ -627,6 +628,12 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
+	/* Set id-det default for when there is no id-det gpio */
+	if (of_property_read_bool(np, "allwinner,usb0-usb-a-connector"))
+		data->id_det_default = 0; /* Host (USB-A connector) */
+	else
+		data->id_det_default = 1; /* Device (USB-B connector) */
+
 	data->id_det_gpio = devm_gpiod_get_optional(dev, "usb0_id_det",
 						    GPIOD_IN);
 	if (IS_ERR(data->id_det_gpio))
-- 
2.7.4
