From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  2 Dec 2015 20:36:55 +0100
Subject: [PATCH] USB: host: ohci-at91: fix a crash in
 ohci_hcd_at91_overcurrent_irq
Message-ID: <1449085015-5538-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt handler, ohci_hcd_at91_overcurrent_irq may be called right
after registration. At that time, pdev->dev.platform_data is not yet set,
leading to a NULL pointer dereference.

Fixes: e4df92279fd9 (USB: host: ohci-at91: merge loops in ohci_hcd_at91_drv_probe)
Reported-by: Peter Rosin <peda@axentia.se>
Tested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/host/ohci-at91.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 342ffd140122..8c6e15bd6ff0 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -473,6 +473,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
+	pdev->dev.platform_data = pdata;
+
 	if (!of_property_read_u32(np, "num-ports", &ports))
 		pdata->ports = ports;
 
@@ -483,6 +485,7 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		 */
 		if (i >= pdata->ports) {
 			pdata->vbus_pin[i] = -EINVAL;
+			pdata->overcurrent_pin[i] = -EINVAL;
 			continue;
 		}
 
@@ -513,10 +516,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 	}
 
 	at91_for_each_port(i) {
-		if (i >= pdata->ports) {
-			pdata->overcurrent_pin[i] = -EINVAL;
-			continue;
-		}
+		if (i >= pdata->ports)
+			break;
 
 		pdata->overcurrent_pin[i] =
 			of_get_named_gpio_flags(np, "atmel,oc-gpio", i, &flags);
@@ -552,8 +553,6 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		}
 	}
 
-	pdev->dev.platform_data = pdata;
-
 	device_init_wakeup(&pdev->dev, 1);
 	return usb_hcd_at91_probe(&ohci_at91_hc_driver, pdev);
 }
-- 
2.5.0
