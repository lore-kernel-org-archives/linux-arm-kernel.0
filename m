From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jun 2016 15:48:04 +0200
Subject: [RFC v4 5/7] extcon: usb-gpio: make debounce value configurable in
 devicetree
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465393686-16644-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Baldyga <r.baldyga@samsung.com>

This patch adds devicetree property for setting debounce value. It allows
to set debounce time shorter or longer depending on the needs of given
platform.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/extcon/extcon-usb-gpio.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index 85b8a0ce5731..e1d5929bca81 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -103,6 +103,7 @@ static int usb_extcon_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct usb_extcon_info *info;
+	u32 debounce;
 	int ret;
 
 	if (!np && !ACPI_HANDLE(dev))
@@ -113,6 +114,11 @@ static int usb_extcon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->dev = dev;
+
+	ret = of_property_read_u32(np, "debounce", &debounce);
+	if (ret < 0)
+		debounce = USB_GPIO_DEBOUNCE_MS;
+
 	info->id_gpiod = devm_gpiod_get_optional(&pdev->dev, "id", GPIOD_IN);
 	info->vbus_gpiod = devm_gpiod_get_optional(&pdev->dev, "vbus",
 						   GPIOD_IN);
@@ -134,16 +140,14 @@ static int usb_extcon_probe(struct platform_device *pdev)
 	}
 
 	if (info->id_gpiod)
-		ret = gpiod_set_debounce(info->id_gpiod,
-			USB_GPIO_DEBOUNCE_MS * 1000);
+		ret = gpiod_set_debounce(info->id_gpiod, debounce * 1000);
 	if (!ret && info->vbus_gpiod) {
-		ret = gpiod_set_debounce(info->vbus_gpiod,
-			USB_GPIO_DEBOUNCE_MS * 1000);
+		ret = gpiod_set_debounce(info->vbus_gpiod, debounce * 1000);
 		if (ret < 0 && info->id_gpiod)
 			gpiod_set_debounce(info->vbus_gpiod, 0);
 	}
 	if (ret < 0)
-		info->debounce_jiffies = msecs_to_jiffies(USB_GPIO_DEBOUNCE_MS);
+		info->debounce_jiffies = msecs_to_jiffies(debounce);
 
 	INIT_DELAYED_WORK(&info->wq_detcable, usb_extcon_detect_cable);
 
-- 
1.9.1
