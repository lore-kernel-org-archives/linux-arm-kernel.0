From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jun 2016 15:48:03 +0200
Subject: [RFC v4 4/7] extcon: usb-gpio: Add support for VBUS detection
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465393686-16644-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VBUS pin detection support to extcon-usb-gpio driver for boards
which have both VBUS and ID pins, or only one of them.

The logic behind reporting USB and USB-HOST extcon cables is not
affected. The driver however will report extcon changes for USB-VBUS and
USB-ID.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Some parts base on old Robert's patchset.
---
 drivers/extcon/extcon-usb-gpio.c | 125 +++++++++++++++++++++++++++++++--------
 1 file changed, 99 insertions(+), 26 deletions(-)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index a36aab007022..85b8a0ce5731 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -35,7 +35,9 @@ struct usb_extcon_info {
 	struct extcon_dev *edev;
 
 	struct gpio_desc *id_gpiod;
+	struct gpio_desc *vbus_gpiod;
 	int id_irq;
+	int vbus_irq;
 
 	unsigned long debounce_jiffies;
 	struct delayed_work wq_detcable;
@@ -44,6 +46,8 @@ struct usb_extcon_info {
 static const unsigned int usb_extcon_cable[] = {
 	EXTCON_USB,
 	EXTCON_USB_HOST,
+	EXTCON_USB_ID,
+	EXTCON_USB_VBUS,
 	EXTCON_NONE,
 };
 
@@ -55,7 +59,8 @@ static void usb_extcon_detect_cable(struct work_struct *work)
 						    wq_detcable);
 
 	/* check ID and update cable state */
-	id = gpiod_get_value_cansleep(info->id_gpiod);
+	id = info->id_gpiod ? gpiod_get_value_cansleep(info->id_gpiod) : 1;
+
 	if (id) {
 		/*
 		 * ID = 1 means USB HOST cable detached.
@@ -73,6 +78,14 @@ static void usb_extcon_detect_cable(struct work_struct *work)
 		extcon_set_cable_state_(info->edev, EXTCON_USB, false);
 		extcon_set_cable_state_(info->edev, EXTCON_USB_HOST, true);
 	}
+
+	if (info->id_gpiod)
+		extcon_set_cable_state_(info->edev, EXTCON_USB_ID, id);
+	if (info->vbus_gpiod) {
+		int vbus = gpiod_get_value_cansleep(info->vbus_gpiod);
+
+		extcon_set_cable_state_(info->edev, EXTCON_USB_VBUS, vbus);
+	}
 }
 
 static irqreturn_t usb_irq_handler(int irq, void *dev_id)
@@ -100,9 +113,11 @@ static int usb_extcon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->dev = dev;
-	info->id_gpiod = devm_gpiod_get(&pdev->dev, "id", GPIOD_IN);
-	if (IS_ERR(info->id_gpiod)) {
-		dev_err(dev, "failed to get ID GPIO\n");
+	info->id_gpiod = devm_gpiod_get_optional(&pdev->dev, "id", GPIOD_IN);
+	info->vbus_gpiod = devm_gpiod_get_optional(&pdev->dev, "vbus",
+						   GPIOD_IN);
+	if (!info->id_gpiod && !info->vbus_gpiod) {
+		dev_err(dev, "failed to get GPIOs\n");
 		return PTR_ERR(info->id_gpiod);
 	}
 
@@ -118,27 +133,54 @@ static int usb_extcon_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = gpiod_set_debounce(info->id_gpiod,
-				 USB_GPIO_DEBOUNCE_MS * 1000);
+	if (info->id_gpiod)
+		ret = gpiod_set_debounce(info->id_gpiod,
+			USB_GPIO_DEBOUNCE_MS * 1000);
+	if (!ret && info->vbus_gpiod) {
+		ret = gpiod_set_debounce(info->vbus_gpiod,
+			USB_GPIO_DEBOUNCE_MS * 1000);
+		if (ret < 0 && info->id_gpiod)
+			gpiod_set_debounce(info->vbus_gpiod, 0);
+	}
 	if (ret < 0)
 		info->debounce_jiffies = msecs_to_jiffies(USB_GPIO_DEBOUNCE_MS);
 
 	INIT_DELAYED_WORK(&info->wq_detcable, usb_extcon_detect_cable);
 
-	info->id_irq = gpiod_to_irq(info->id_gpiod);
-	if (info->id_irq < 0) {
-		dev_err(dev, "failed to get ID IRQ\n");
-		return info->id_irq;
+	if (info->id_gpiod) {
+		info->id_irq = gpiod_to_irq(info->id_gpiod);
+		if (info->id_irq < 0) {
+			dev_err(dev, "failed to get ID IRQ\n");
+			return info->id_irq;
+		}
+		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
+						usb_irq_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						pdev->name, info);
+		if (ret < 0) {
+			dev_err(dev, "failed to request handler for ID IRQ\n");
+			return ret;
+		}
 	}
 
-	ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
-					usb_irq_handler,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					pdev->name, info);
-	if (ret < 0) {
-		dev_err(dev, "failed to request handler for ID IRQ\n");
-		return ret;
+	if (info->vbus_gpiod) {
+		info->vbus_irq = gpiod_to_irq(info->vbus_gpiod);
+		if (info->vbus_irq < 0) {
+			dev_err(dev, "failed to get VBUS IRQ\n");
+			return info->vbus_irq;
+		}
+		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
+						usb_irq_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						pdev->name, info);
+		if (ret < 0) {
+			dev_err(dev, "failed to request handler for VBUS IRQ\n");
+			return ret;
+		}
 	}
 
 	platform_set_drvdata(pdev, info);
@@ -166,9 +208,16 @@ static int usb_extcon_suspend(struct device *dev)
 	int ret = 0;
 
 	if (device_may_wakeup(dev)) {
-		ret = enable_irq_wake(info->id_irq);
-		if (ret)
-			return ret;
+		if (info->id_gpiod) {
+			ret = enable_irq_wake(info->id_irq);
+			if (ret)
+				return ret;
+		}
+		if (info->vbus_gpiod) {
+			ret = enable_irq_wake(info->vbus_irq);
+			if (ret)
+				goto err;
+		}
 	}
 
 	/*
@@ -176,8 +225,16 @@ static int usb_extcon_suspend(struct device *dev)
 	 * as GPIOs used behind I2C subsystem might not be
 	 * accessible until resume completes. So disable IRQ.
 	 */
-	disable_irq(info->id_irq);
+	if (info->id_gpiod)
+		disable_irq(info->id_irq);
+	if (info->vbus_gpiod)
+		disable_irq(info->vbus_irq);
+
+	return ret;
 
+err:
+	if (info->id_gpiod)
+		disable_irq_wake(info->id_irq);
 	return ret;
 }
 
@@ -187,17 +244,33 @@ static int usb_extcon_resume(struct device *dev)
 	int ret = 0;
 
 	if (device_may_wakeup(dev)) {
-		ret = disable_irq_wake(info->id_irq);
-		if (ret)
-			return ret;
+		if (info->id_gpiod) {
+			ret = disable_irq_wake(info->id_irq);
+			if (ret)
+				return ret;
+		}
+		if (info->vbus_gpiod) {
+			ret = disable_irq_wake(info->vbus_irq);
+			if (ret)
+				goto err;
+		}
 	}
 
-	enable_irq(info->id_irq);
+	if (info->id_gpiod)
+		enable_irq(info->id_irq);
+	if (info->vbus_gpiod)
+		enable_irq(info->vbus_irq);
+
 	if (!device_may_wakeup(dev))
 		queue_delayed_work(system_power_efficient_wq,
 				   &info->wq_detcable, 0);
 
 	return ret;
+
+err:
+	if (info->id_gpiod)
+		enable_irq_wake(info->id_irq);
+	return ret;
 }
 #endif
 
-- 
1.9.1
