From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 28 Mar 2017 19:07:36 +0300
Subject: [PATCH linux-next v2 1/4] usb: gadget: udc: atmel: Check fifo
 configuration values against device tree
In-Reply-To: <cover.1490715349.git.cristian.birsan@microchip.com>
References: <cover.1490715349.git.cristian.birsan@microchip.com>
Message-ID: <4b91a4973e19a5b7ac05d5e0f5b4dcc8cffb75cf.1490715349.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Check fifo configuration values against device tree values for endpoint fifo
in auto configuration mode (fifo_mode=0).

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 2035906b..3fd43fb 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
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
