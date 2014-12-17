From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 17 Dec 2014 17:18:48 +0800
Subject: [PATCH 1/2] USB: gadget: udc: atmel: change setting for DMA
Message-ID: <1418807929-31952-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet, when transfer using DMA, the control
setting for IN packet only need END_BUF_EN, END_BUF_IE, CH_EN,
while for OUT packet, need more two bits END_TR_EN and END_TR_IE
to be configured.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 drivers/usb/gadget/udc/atmel_usba_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ce88237..63e90f5 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -716,10 +716,10 @@ static int queue_dma(struct usba_udc *udc, struct usba_ep *ep,
 	req->using_dma = 1;
 	req->ctrl = USBA_BF(DMA_BUF_LEN, req->req.length)
 			| USBA_DMA_CH_EN | USBA_DMA_END_BUF_IE
-			| USBA_DMA_END_TR_EN | USBA_DMA_END_TR_IE;
+			| USBA_DMA_END_BUF_EN;
 
-	if (ep->is_in)
-		req->ctrl |= USBA_DMA_END_BUF_EN;
+	if (!ep->is_in)
+		req->ctrl |= USBA_DMA_END_TR_EN | USBA_DMA_END_TR_IE;
 
 	/*
 	 * Add this request to the queue and submit for DMA if
-- 
2.1.0.24.g4109c28
