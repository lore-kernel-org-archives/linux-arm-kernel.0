From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:23:11 +0200
Subject: [PATCH 3/4] USB: host: ohci-at91: merge ohci_at91_of_init in
 ohci_hcd_at91_drv_probe
In-Reply-To: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1439216592-11381-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As device tree support is now mandatory, merge ohci_at91_of_init() in
ohci_hcd_at91_drv_probe().

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/host/ohci-at91.c | 145 +++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 82 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 8e17d5ba26c6..cdd91c551c7b 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -449,16 +449,17 @@ static const struct of_device_id at91_ohci_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, at91_ohci_dt_ids);
 
-static int ohci_at91_of_init(struct platform_device *pdev)
+/*-------------------------------------------------------------------------*/
+
+static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int i, gpio, ret;
-	enum of_gpio_flags flags;
 	struct at91_usbh_data	*pdata;
-	u32 ports;
-
-	if (!np)
-		return 0;
+	int			i;
+	int			gpio;
+	int			ret;
+	enum of_gpio_flags	flags;
+	u32			ports;
 
 	/* Right now device-tree probed devices don't get dma_mask set.
 	 * Since shared usb code relies on it, set it here for now.
@@ -489,89 +490,69 @@ static int ohci_at91_of_init(struct platform_device *pdev)
 
 	pdev->dev.platform_data = pdata;
 
-	return 0;
-}
-
-/*-------------------------------------------------------------------------*/
-
-static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
-{
-	struct at91_usbh_data	*pdata;
-	int			i;
-	int			gpio;
-	int			ret;
-
-	ret = ohci_at91_of_init(pdev);
-	if (ret)
-		return ret;
+	at91_for_each_port(i) {
+		/*
+		 * do not configure PIO if not in relation with
+		 * real USB port on board
+		 */
+		if (i >= pdata->ports) {
+			pdata->vbus_pin[i] = -EINVAL;
+			pdata->overcurrent_pin[i] = -EINVAL;
+			break;
+		}
 
-	pdata = dev_get_platdata(&pdev->dev);
+		if (!gpio_is_valid(pdata->vbus_pin[i]))
+			continue;
+		gpio = pdata->vbus_pin[i];
 
-	if (pdata) {
-		at91_for_each_port(i) {
-			/*
-			 * do not configure PIO if not in relation with
-			 * real USB port on board
-			 */
-			if (i >= pdata->ports) {
-				pdata->vbus_pin[i] = -EINVAL;
-				pdata->overcurrent_pin[i] = -EINVAL;
-				break;
-			}
+		ret = gpio_request(gpio, "ohci_vbus");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"can't request vbus gpio %d\n", gpio);
+			continue;
+		}
+		ret = gpio_direction_output(gpio,
+					!pdata->vbus_pin_active_low[i]);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"can't put vbus gpio %d as output %d\n",
+				gpio, !pdata->vbus_pin_active_low[i]);
+			gpio_free(gpio);
+			continue;
+		}
 
-			if (!gpio_is_valid(pdata->vbus_pin[i]))
-				continue;
-			gpio = pdata->vbus_pin[i];
+		ohci_at91_usb_set_power(pdata, i, 1);
+	}
 
-			ret = gpio_request(gpio, "ohci_vbus");
-			if (ret) {
-				dev_err(&pdev->dev,
-					"can't request vbus gpio %d\n", gpio);
-				continue;
-			}
-			ret = gpio_direction_output(gpio,
-						!pdata->vbus_pin_active_low[i]);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"can't put vbus gpio %d as output %d\n",
-					gpio, !pdata->vbus_pin_active_low[i]);
-				gpio_free(gpio);
-				continue;
-			}
+	at91_for_each_port(i) {
+		if (!gpio_is_valid(pdata->overcurrent_pin[i]))
+			continue;
+		gpio = pdata->overcurrent_pin[i];
 
-			ohci_at91_usb_set_power(pdata, i, 1);
+		ret = gpio_request(gpio, "ohci_overcurrent");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"can't request overcurrent gpio %d\n",
+				gpio);
+			continue;
 		}
 
-		at91_for_each_port(i) {
-			if (!gpio_is_valid(pdata->overcurrent_pin[i]))
-				continue;
-			gpio = pdata->overcurrent_pin[i];
-
-			ret = gpio_request(gpio, "ohci_overcurrent");
-			if (ret) {
-				dev_err(&pdev->dev,
-					"can't request overcurrent gpio %d\n",
-					gpio);
-				continue;
-			}
-
-			ret = gpio_direction_input(gpio);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"can't configure overcurrent gpio %d as input\n",
-					gpio);
-				gpio_free(gpio);
-				continue;
-			}
+		ret = gpio_direction_input(gpio);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"can't configure overcurrent gpio %d as input\n",
+				gpio);
+			gpio_free(gpio);
+			continue;
+		}
 
-			ret = request_irq(gpio_to_irq(gpio),
-					  ohci_hcd_at91_overcurrent_irq,
-					  IRQF_SHARED, "ohci_overcurrent", pdev);
-			if (ret) {
-				gpio_free(gpio);
-				dev_err(&pdev->dev,
-					"can't get gpio IRQ for overcurrent\n");
-			}
+		ret = request_irq(gpio_to_irq(gpio),
+				  ohci_hcd_at91_overcurrent_irq,
+				  IRQF_SHARED, "ohci_overcurrent", pdev);
+		if (ret) {
+			gpio_free(gpio);
+			dev_err(&pdev->dev,
+				"can't get gpio IRQ for overcurrent\n");
 		}
 	}
 
-- 
2.1.4
