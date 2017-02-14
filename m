From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 14 Feb 2017 18:09:03 +0200
Subject: [PATCH 1/4 linux-next] usb: gadget: udc: atmel: Check fifo
 configuration values against device tree
In-Reply-To: <cover.1487007870.git.cristian.birsan@microchip.com>
References: <cover.1487007870.git.cristian.birsan@microchip.com>
Message-ID: <f71b15dfe79e227491aced411af203297e746603.1487007870.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Check fifo configuration values against device tree values for endpoint
fifo in auto configuration mode (fifo_mode=0).

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 11bbce2..ce8bf8b 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -371,7 +371,7 @@ static struct usba_fifo_cfg mode_4_cfg[] = {
 };
 /* Add additional configurations here */
 
-int usba_config_fifo_table(struct usba_udc *udc)
+static int usba_config_fifo_table(struct usba_udc *udc)
 {
 	int n;
 
@@ -2118,14 +2118,34 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 			dev_err(&pdev->dev, "of_probe: fifo-size error(%d)\n", ret);
 			goto err;
 		}
-		ep->fifo_size = fifo_mode ? udc->fifo_cfg[i].fifo_size : val;
+		if (fifo_mode) {
+			if (val < udc->fifo_cfg[i].fifo_size) {
+				dev_warn(&pdev->dev,
+					 "of_probe: fifo-size table value not supported by HW, using DT value\n");
+				ep->fifo_size = val;
+			} else {
+				ep->fifo_size = udc->fifo_cfg[i].fifo_size;
+			}
+		} else {
+			ep->fifo_size = val;
+		}
 
 		ret = of_property_read_u32(pp, "atmel,nb-banks", &val);
 		if (ret) {
 			dev_err(&pdev->dev, "of_probe: nb-banks error(%d)\n", ret);
 			goto err;
 		}
-		ep->nr_banks = fifo_mode ? udc->fifo_cfg[i].nr_banks : val;
+		if (fifo_mode) {
+			if (val < udc->fifo_cfg[i].nr_banks) {
+				dev_warn(&pdev->dev,
+					 "of_probe: nb-banks table value not supported by HW, using DT value\n");
+				ep->nr_banks = val;
+			} else {
+				ep->nr_banks = udc->fifo_cfg[i].nr_banks;
+			}
+		} else {
+			ep->nr_banks = val;
+		}
 
 		ep->can_dma = of_property_read_bool(pp, "atmel,can-dma");
 		ep->can_isoc = of_property_read_bool(pp, "atmel,can-isoc");
-- 
2.7.4
