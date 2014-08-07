From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 7 Aug 2014 11:43:07 +0800
Subject: [PATCH] USB: atmel_usba_udc: fix it to deal with final DMA channel
Message-ID: <1407382987-11242-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As, the interrupt for DMA is counted from 1, so need to checked
the USBA_NR_DMAS, in old way, it only check (USBA_NR_DMAS - 1),
so fix it.

Reported-by: Max Liao <liaops@embest-tech.com>
Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 906e65f..c9fe67e 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1661,7 +1661,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (dma_status) {
 		int i;
 
-		for (i = 1; i < USBA_NR_DMAS; i++)
+		for (i = 1; i <= USBA_NR_DMAS; i++)
 			if (dma_status & (1 << i))
 				usba_dma_irq(udc, &udc->usba_ep[i]);
 	}
-- 
1.8.5.2
