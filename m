From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:23:12 +0200
Subject: [PATCH 4/4] USB: host: ohci-at91: merge loops in
 ohci_hcd_at91_drv_probe
In-Reply-To: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1439216592-11381-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ohci_hcd_at91_drv_probe() has four at91_for_each_port. They can be merged
into two loops without changing the driver behaviour.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/host/ohci-at91.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index cdd91c551c7b..342ffd140122 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -477,33 +477,21 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		pdata->ports = ports;
 
 	at91_for_each_port(i) {
-		gpio = of_get_named_gpio_flags(np, "atmel,vbus-gpio", i, &flags);
-		pdata->vbus_pin[i] = gpio;
-		if (!gpio_is_valid(gpio))
-			continue;
-		pdata->vbus_pin_active_low[i] = flags & OF_GPIO_ACTIVE_LOW;
-	}
-
-	at91_for_each_port(i)
-		pdata->overcurrent_pin[i] =
-			of_get_named_gpio_flags(np, "atmel,oc-gpio", i, &flags);
-
-	pdev->dev.platform_data = pdata;
-
-	at91_for_each_port(i) {
 		/*
 		 * do not configure PIO if not in relation with
 		 * real USB port on board
 		 */
 		if (i >= pdata->ports) {
 			pdata->vbus_pin[i] = -EINVAL;
-			pdata->overcurrent_pin[i] = -EINVAL;
-			break;
+			continue;
 		}
 
-		if (!gpio_is_valid(pdata->vbus_pin[i]))
+		gpio = of_get_named_gpio_flags(np, "atmel,vbus-gpio", i,
+					       &flags);
+		pdata->vbus_pin[i] = gpio;
+		if (!gpio_is_valid(gpio))
 			continue;
-		gpio = pdata->vbus_pin[i];
+		pdata->vbus_pin_active_low[i] = flags & OF_GPIO_ACTIVE_LOW;
 
 		ret = gpio_request(gpio, "ohci_vbus");
 		if (ret) {
@@ -525,6 +513,14 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 	}
 
 	at91_for_each_port(i) {
+		if (i >= pdata->ports) {
+			pdata->overcurrent_pin[i] = -EINVAL;
+			continue;
+		}
+
+		pdata->overcurrent_pin[i] =
+			of_get_named_gpio_flags(np, "atmel,oc-gpio", i, &flags);
+
 		if (!gpio_is_valid(pdata->overcurrent_pin[i]))
 			continue;
 		gpio = pdata->overcurrent_pin[i];
@@ -556,6 +552,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		}
 	}
 
+	pdev->dev.platform_data = pdata;
+
 	device_init_wakeup(&pdev->dev, 1);
 	return usb_hcd_at91_probe(&ohci_at91_hc_driver, pdev);
 }
-- 
2.1.4
