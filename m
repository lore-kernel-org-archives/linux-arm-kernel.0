From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 May 2013 18:25:45 +0200
Subject: [PATCH 1/7] USB: gadget: atmel_usba: move global struct usba_ep
 usba_ep to struct usba_udc
Message-ID: <1369067151-3178-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we can have multiple usb gadget instance

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/gadget/atmel_usba_udc.c |   20 +++++++++++---------
 drivers/usb/gadget/atmel_usba_udc.h |    1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f2a970f..d2ffd04 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -29,7 +29,6 @@
 
 
 static struct usba_udc the_udc;
-static struct usba_ep *usba_ep;
 
 #ifdef CONFIG_USB_GADGET_DEBUG_FS
 #include <linux/debugfs.h>
@@ -1147,7 +1146,7 @@ static int do_test_mode(struct usba_udc *udc)
 		 * Test_SE0_NAK: Force high-speed mode and set up ep0
 		 * for Bulk IN transfers
 		 */
-		ep = &usba_ep[0];
+		ep = &udc->usba_ep[0];
 		usba_writel(udc, TST,
 				USBA_BF(SPEED_CFG, USBA_SPEED_CFG_FORCE_HIGH));
 		usba_ep_writel(ep, CFG,
@@ -1165,7 +1164,7 @@ static int do_test_mode(struct usba_udc *udc)
 		break;
 	case 0x0400:
 		/* Test_Packet */
-		ep = &usba_ep[0];
+		ep = &udc->usba_ep[0];
 		usba_ep_writel(ep, CFG,
 				USBA_BF(EPT_SIZE, USBA_EPT_SIZE_64)
 				| USBA_EPT_DIR_IN
@@ -1668,7 +1667,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 
 		for (i = 1; i < USBA_NR_ENDPOINTS; i++)
 			if (dma_status & (1 << i))
-				usba_dma_irq(udc, &usba_ep[i]);
+				usba_dma_irq(udc, &udc->usba_ep[i]);
 	}
 
 	ep_status = USBA_BFEXT(EPT_INT, status);
@@ -1677,10 +1676,10 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 
 		for (i = 0; i < USBA_NR_ENDPOINTS; i++)
 			if (ep_status & (1 << i)) {
-				if (ep_is_control(&usba_ep[i]))
-					usba_control_irq(udc, &usba_ep[i]);
+				if (ep_is_control(&udc->usba_ep[i]))
+					usba_control_irq(udc, &udc->usba_ep[i]);
 				else
-					usba_ep_irq(udc, &usba_ep[i]);
+					usba_ep_irq(udc, &udc->usba_ep[i]);
 			}
 	}
 
@@ -1705,7 +1704,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 		DBG(DBG_BUS, "%s bus reset detected\n",
 		    usb_speed_string(udc->gadget.speed));
 
-		ep0 = &usba_ep[0];
+		ep0 = &udc->usba_ep[0];
 		ep0->ep.desc = &usba_ep0_desc;
 		ep0->state = WAIT_FOR_SETUP;
 		usba_ep_writel(ep0, CFG,
@@ -1841,6 +1840,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	struct resource *regs, *fifo;
 	struct clk *pclk, *hclk;
 	struct usba_udc *udc = &the_udc;
+	static struct usba_ep *usba_ep;
 	int irq, ret, i;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, CTRL_IOMEM_ID);
@@ -1896,6 +1896,8 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	if (!usba_ep)
 		goto err_alloc_ep;
 
+	udc->usba_ep = usba_ep;
+
 	the_udc.gadget.ep0 = &usba_ep[0].ep;
 
 	INIT_LIST_HEAD(&usba_ep[0].ep.ep_list);
@@ -2008,7 +2010,7 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&udc->gadget);
 
 	for (i = 1; i < pdata->num_ep; i++)
-		usba_ep_cleanup_debugfs(&usba_ep[i]);
+		usba_ep_cleanup_debugfs(&udc->usba_ep[i]);
 	usba_cleanup_debugfs(udc);
 
 	if (gpio_is_valid(udc->vbus_pin)) {
diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
index d65a618..0841986 100644
--- a/drivers/usb/gadget/atmel_usba_udc.h
+++ b/drivers/usb/gadget/atmel_usba_udc.h
@@ -319,6 +319,7 @@ struct usba_udc {
 	int vbus_pin_inverted;
 	struct clk *pclk;
 	struct clk *hclk;
+	struct usba_ep *usba_ep;
 
 	u16 devstatus;
 
-- 
1.7.10.4
