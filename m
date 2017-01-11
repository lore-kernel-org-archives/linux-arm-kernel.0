From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 11 Jan 2017 13:11:08 +0100
Subject: [PATCH] usb: gadget: udc: atmel: remove memory leak
Message-ID: <20170111121108.20411-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bbe097f092b0 ("usb: gadget: udc: atmel: fix endpoint name")
introduced a memory leak when unbinding the driver. The endpoint names
would not be freed. Solve that by including the name as a string in struct
usba_ep so it is freed when the endpoint is.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 3 ++-
 drivers/usb/gadget/udc/atmel_usba_udc.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index f3212db9bc37..12c7687216e6 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1978,7 +1978,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
 			goto err;
 		}
-		ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", ep->index);
+		sprintf(ep->name, "ep%d", ep->index);
+		ep->ep.name = ep->name;
 
 		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
 		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 3e1c9d589dfa..b03b2ebfc53a 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -280,6 +280,7 @@ struct usba_ep {
 	void __iomem				*ep_regs;
 	void __iomem				*dma_regs;
 	void __iomem				*fifo;
+	char					name[8];
 	struct usb_ep				ep;
 	struct usba_udc				*udc;
 
-- 
2.11.0
