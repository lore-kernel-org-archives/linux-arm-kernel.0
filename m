From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 28 Sep 2016 15:41:48 +0800
Subject: [PATCH v1] usb: ohci-at91: Use descriptor-based gpio APIs
Message-ID: <1475048509-3042-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the descriptor-based interface to manipulate GPIOs, instead of
the legacy integer-based interface.

In the meanwhile, remove unneeded vbus_pin_active_low[...] member.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 drivers/usb/host/ohci-at91.c | 120 ++++++++++---------------------------------
 1 file changed, 28 insertions(+), 92 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index d177372..b0c7827 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -14,8 +14,8 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/io.h>
@@ -36,11 +36,10 @@
 
 #define AT91_MAX_USBH_PORTS	3
 struct at91_usbh_data {
-	int vbus_pin[AT91_MAX_USBH_PORTS];	/* port power-control pin */
-	int overcurrent_pin[AT91_MAX_USBH_PORTS];
+	struct gpio_desc *vbus_pin[AT91_MAX_USBH_PORTS];
+	struct gpio_desc *overcurrent_pin[AT91_MAX_USBH_PORTS];
 	u8 ports;				/* number of ports on root hub */
 	u8 overcurrent_supported;
-	u8 vbus_pin_active_low[AT91_MAX_USBH_PORTS];
 	u8 overcurrent_status[AT91_MAX_USBH_PORTS];
 	u8 overcurrent_changed[AT91_MAX_USBH_PORTS];
 };
@@ -243,11 +242,7 @@ static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int
 	if (!valid_port(port))
 		return;
 
-	if (!gpio_is_valid(pdata->vbus_pin[port]))
-		return;
-
-	gpio_set_value(pdata->vbus_pin[port],
-		       pdata->vbus_pin_active_low[port] ^ enable);
+	gpiod_set_value(pdata->vbus_pin[port], enable);
 }
 
 static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
@@ -255,11 +250,7 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
 	if (!valid_port(port))
 		return -EINVAL;
 
-	if (!gpio_is_valid(pdata->vbus_pin[port]))
-		return -EINVAL;
-
-	return gpio_get_value(pdata->vbus_pin[port]) ^
-		pdata->vbus_pin_active_low[port];
+	return gpiod_get_value(pdata->vbus_pin[port]);
 }
 
 /*
@@ -406,16 +397,13 @@ static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
 {
 	struct platform_device *pdev = data;
 	struct at91_usbh_data *pdata = dev_get_platdata(&pdev->dev);
-	int val, gpio, port;
+	int val, port;
 
 	/* From the GPIO notifying the over-current situation, find
 	 * out the corresponding port */
 	at91_for_each_port(port) {
-		if (gpio_is_valid(pdata->overcurrent_pin[port]) &&
-				gpio_to_irq(pdata->overcurrent_pin[port]) == irq) {
-			gpio = pdata->overcurrent_pin[port];
+		if (gpiod_to_irq(pdata->overcurrent_pin[port]) == irq)
 			break;
-		}
 	}
 
 	if (port == AT91_MAX_USBH_PORTS) {
@@ -423,7 +411,7 @@ static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	val = gpio_get_value(gpio);
+	val = gpiod_get_value(pdata->overcurrent_pin[port]);
 
 	/* When notified of an over-current situation, disable power
 	   on the corresponding port, and mark this port in
@@ -454,9 +442,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct at91_usbh_data	*pdata;
 	int			i;
-	int			gpio;
 	int			ret;
-	enum of_gpio_flags	flags;
+	int			err;
 	u32			ports;
 
 	/* Right now device-tree probed devices don't get dma_mask set.
@@ -477,36 +464,12 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		pdata->ports = ports;
 
 	at91_for_each_port(i) {
-		/*
-		 * do not configure PIO if not in relation with
-		 * real USB port on board
-		 */
-		if (i >= pdata->ports) {
-			pdata->vbus_pin[i] = -EINVAL;
-			pdata->overcurrent_pin[i] = -EINVAL;
-			continue;
-		}
-
-		gpio = of_get_named_gpio_flags(np, "atmel,vbus-gpio", i,
-					       &flags);
-		pdata->vbus_pin[i] = gpio;
-		if (!gpio_is_valid(gpio))
-			continue;
-		pdata->vbus_pin_active_low[i] = flags & OF_GPIO_ACTIVE_LOW;
-
-		ret = gpio_request(gpio, "ohci_vbus");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"can't request vbus gpio %d\n", gpio);
-			continue;
-		}
-		ret = gpio_direction_output(gpio,
-					!pdata->vbus_pin_active_low[i]);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"can't put vbus gpio %d as output %d\n",
-				gpio, !pdata->vbus_pin_active_low[i]);
-			gpio_free(gpio);
+		pdata->vbus_pin[i] = devm_gpiod_get_optional(&pdev->dev,
+							     "atmel,vbus-gpio",
+							     GPIOD_IN);
+		if (IS_ERR(pdata->vbus_pin[i])) {
+			err = PTR_ERR(pdata->vbus_pin[i]);
+			dev_err(&pdev->dev, "unable to claim gpio \"vbus\": %d\n", err);
 			continue;
 		}
 
@@ -518,37 +481,21 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 			break;
 
 		pdata->overcurrent_pin[i] =
-			of_get_named_gpio_flags(np, "atmel,oc-gpio", i, &flags);
-
-		if (!gpio_is_valid(pdata->overcurrent_pin[i]))
-			continue;
-		gpio = pdata->overcurrent_pin[i];
-
-		ret = gpio_request(gpio, "ohci_overcurrent");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"can't request overcurrent gpio %d\n",
-				gpio);
+			devm_gpiod_get_optional(&pdev->dev,
+						"atmel,oc-gpio", GPIOD_IN);
+		if (IS_ERR(pdata->overcurrent_pin[i])) {
+			err = PTR_ERR(pdata->overcurrent_pin[i]);
+			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);
 			continue;
 		}
 
-		ret = gpio_direction_input(gpio);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"can't configure overcurrent gpio %d as input\n",
-				gpio);
-			gpio_free(gpio);
-			continue;
-		}
-
-		ret = request_irq(gpio_to_irq(gpio),
-				  ohci_hcd_at91_overcurrent_irq,
-				  IRQF_SHARED, "ohci_overcurrent", pdev);
-		if (ret) {
-			gpio_free(gpio);
-			dev_err(&pdev->dev,
-				"can't get gpio IRQ for overcurrent\n");
-		}
+		ret = devm_request_irq(&pdev->dev,
+				       gpiod_to_irq(pdata->overcurrent_pin[i]),
+				       ohci_hcd_at91_overcurrent_irq,
+				       IRQF_SHARED,
+				       "ohci_overcurrent", pdev);
+		if (ret)
+			dev_info(&pdev->dev, "failed to request gpio \"overcurrent\" IRQ\n");
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
@@ -561,19 +508,8 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 	int			i;
 
 	if (pdata) {
-		at91_for_each_port(i) {
-			if (!gpio_is_valid(pdata->vbus_pin[i]))
-				continue;
+		at91_for_each_port(i)
 			ohci_at91_usb_set_power(pdata, i, 0);
-			gpio_free(pdata->vbus_pin[i]);
-		}
-
-		at91_for_each_port(i) {
-			if (!gpio_is_valid(pdata->overcurrent_pin[i]))
-				continue;
-			free_irq(gpio_to_irq(pdata->overcurrent_pin[i]), pdev);
-			gpio_free(pdata->overcurrent_pin[i]);
-		}
 	}
 
 	device_init_wakeup(&pdev->dev, 0);
-- 
2.7.4
