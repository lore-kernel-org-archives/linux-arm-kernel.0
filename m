From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 1 Feb 2018 10:34:31 +0100
Subject: [PATCH 1/2] usb: gadget: udc: atmel: remove code related to platform
 stuff
Message-ID: <20180201093432.21919-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the removal of AVR platforms, code related to platform stuff
is useless.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 73 +--------------------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 075eaaa8a408..dc2604ec38f8 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2019,7 +2019,6 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static void at91sam9rl_toggle_bias(struct usba_udc *udc, int is_on)
 {
 	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
@@ -2204,71 +2203,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 err:
 	return ERR_PTR(ret);
 }
-#else
-static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
-						    struct usba_udc *udc)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif
-
-static struct usba_ep * usba_udc_pdata(struct platform_device *pdev,
-						 struct usba_udc *udc)
-{
-	struct usba_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct usba_ep *eps;
-	int i;
-
-	if (!pdata)
-		return ERR_PTR(-ENXIO);
-
-	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * pdata->num_ep,
-			   GFP_KERNEL);
-	if (!eps)
-		return ERR_PTR(-ENOMEM);
-
-	udc->gadget.ep0 = &eps[0].ep;
-
-	udc->vbus_pin = pdata->vbus_pin;
-	udc->vbus_pin_inverted = pdata->vbus_pin_inverted;
-	udc->num_ep = pdata->num_ep;
-
-	INIT_LIST_HEAD(&eps[0].ep.ep_list);
-
-	for (i = 0; i < pdata->num_ep; i++) {
-		struct usba_ep *ep = &eps[i];
-
-		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
-		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
-		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
-		ep->ep.ops = &usba_ep_ops;
-		ep->ep.name = pdata->ep[i].name;
-		ep->fifo_size = pdata->ep[i].fifo_size;
-		usb_ep_set_maxpacket_limit(&ep->ep, ep->fifo_size);
-		ep->udc = udc;
-		INIT_LIST_HEAD(&ep->queue);
-		ep->nr_banks = pdata->ep[i].nr_banks;
-		ep->index = pdata->ep[i].index;
-		ep->can_dma = pdata->ep[i].can_dma;
-		ep->can_isoc = pdata->ep[i].can_isoc;
-
-		if (i == 0) {
-			ep->ep.caps.type_control = true;
-		} else {
-			ep->ep.caps.type_iso = ep->can_isoc;
-			ep->ep.caps.type_bulk = true;
-			ep->ep.caps.type_int = true;
-		}
-
-		ep->ep.caps.dir_in = true;
-		ep->ep.caps.dir_out = true;
-
-		if (i)
-			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
-	}
-
-	return eps;
-}
 
 static int usba_udc_probe(struct platform_device *pdev)
 {
@@ -2335,10 +2269,7 @@ static int usba_udc_probe(struct platform_device *pdev)
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 	clk_disable_unprepare(pclk);
 
-	if (pdev->dev.of_node)
-		udc->usba_ep = atmel_udc_of_init(pdev, udc);
-	else
-		udc->usba_ep = usba_udc_pdata(pdev, udc);
+	udc->usba_ep = atmel_udc_of_init(pdev, udc);
 
 	toggle_bias(udc, 0);
 
@@ -2462,7 +2393,7 @@ static struct platform_driver udc_driver = {
 	.driver		= {
 		.name		= "atmel_usba_udc",
 		.pm		= &usba_udc_pm_ops,
-		.of_match_table	= of_match_ptr(atmel_udc_dt_ids),
+		.of_match_table	= atmel_udc_dt_ids,
 	},
 };
 
-- 
2.12.2
