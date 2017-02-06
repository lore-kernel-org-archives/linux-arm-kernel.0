From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Mon, 6 Feb 2017 22:02:50 +0200
Subject: [PATCH linux-next] fixup! usb: gadget: udc: atmel: Update endpoint
 allocation scheme
Message-ID: <1486411370-24023-1-git-send-email-cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
Fixes since previous patch:
	- Fix coding style
	- Validate parameters againsta device tree values
	- Update error message display
	- Update Kconfig comments

 drivers/usb/gadget/udc/Kconfig          |  5 ++--
 drivers/usb/gadget/udc/atmel_usba_udc.c | 48 ++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 4b69f28..6a991b7 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -62,8 +62,9 @@ config USB_ATMEL_USBA
 
 	  The fifo_mode parameter is used to select endpoint allocation mode.
 	  fifo_mode = 0 is used to let the driver autoconfigure the endpoints.
-	  In this case 2 banks are allocated for isochronous endpoints and
-	  only one bank is allocated for the rest of the endpoints.
+	  In this case 2 banks are allocated so that they could be use as
+	  isochronous endpoints and only one bank is allocated for the rest
+	  of the endpoints.
 
 	  fifo_mode = 1 is a generic maximum fifo size (1024 bytes) configuration
 	  allowing the usage of ep1 - ep6
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 11bbce2..37f71e5 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -321,7 +321,6 @@ static inline void usba_cleanup_debugfs(struct usba_udc *udc)
 
 static ushort fifo_mode;
 
-/* "modprobe ... fifo_mode=1" etc */
 module_param(fifo_mode, ushort, 0x0);
 MODULE_PARM_DESC(fifo_mode, "Endpoint configuration mode");
 
@@ -369,9 +368,10 @@ static struct usba_fifo_cfg mode_4_cfg[] = {
 { .hw_ep_num = 7, .fifo_size = 8,	.nr_banks = 2, },
 { .hw_ep_num = 8, .fifo_size = 8,	.nr_banks = 2, },
 };
+
 /* Add additional configurations here */
 
-int usba_config_fifo_table(struct usba_udc *udc)
+static int usba_config_fifo_table(struct usba_udc *udc)
 {
 	int n;
 
@@ -1076,11 +1076,9 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver);
 static int atmel_usba_stop(struct usb_gadget *gadget);
 
-static struct usb_ep *atmel_usba_match_ep(
-		struct usb_gadget		*gadget,
-		struct usb_endpoint_descriptor	*desc,
-		struct usb_ss_ep_comp_descriptor *ep_comp
-)
+static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
+				struct usb_endpoint_descriptor	*desc,
+				struct usb_ss_ep_comp_descriptor *ep_comp)
 {
 	struct usb_ep	*_ep;
 	struct usba_ep *ep;
@@ -1100,7 +1098,6 @@ static struct usb_ep *atmel_usba_match_ep(
 		ep = to_usba_ep(_ep);
 
 		switch (usb_endpoint_type(desc)) {
-
 		case USB_ENDPOINT_XFER_CONTROL:
 			break;
 
@@ -1141,7 +1138,7 @@ static struct usb_ep *atmel_usba_match_ep(
 		ep->udc->configured_ep++;
 	}
 
-return _ep;
+	return _ep;
 }
 
 static const struct usb_gadget_ops usba_udc_ops = {
@@ -1855,7 +1852,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 		 * but it's clearly harmless...
 		 */
 		if (!(usba_ep_readl(ep0, CFG) & USBA_EPT_MAPPED))
-			dev_dbg(&udc->pdev->dev,
+			dev_warn(&udc->pdev->dev,
 				 "ODD: EP0 configuration is invalid!\n");
 
 		/* Preallocate other endpoints */
@@ -1864,8 +1861,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 			ep = &udc->usba_ep[i];
 			usba_ep_writel(ep, CFG, ep->ept_cfg);
 			if (!(usba_ep_readl(ep, CFG) & USBA_EPT_MAPPED))
-				dev_dbg(&udc->pdev->dev,
-				 "ODD: EP%d configuration is invalid!\n", i);
+				dev_warn(&udc->pdev->dev,
+					 "ODD: EP%d configuration is invalid!\n", i);
 		}
 	}
 
@@ -2089,8 +2086,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		while ((pp = of_get_next_child(np, pp)))
 			udc->num_ep++;
 		udc->configured_ep = 1;
-	} else
+	} else {
 		udc->num_ep = usba_config_fifo_table(udc);
+	}
 
 	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * udc->num_ep,
 			   GFP_KERNEL);
@@ -2118,14 +2116,34 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 			dev_err(&pdev->dev, "of_probe: fifo-size error(%d)\n", ret);
 			goto err;
 		}
-		ep->fifo_size = fifo_mode ? udc->fifo_cfg[i].fifo_size : val;
+		if (fifo_mode) {
+			if (val < udc->fifo_cfg[i].fifo_size) {
+				dev_warn(&pdev->dev,
+					 "of_probe: using fifo-size from DT instead of table\n");
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
+					 "of_probe: using nb-banks from DT instead of table\n");
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
