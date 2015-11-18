From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 22:02:39 +0100
Subject: [PATCH] staging/emxx_udc: fix 64-bit warnings
Message-ID: <4127718.gSaDyyMLEa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_SHMOBILE is coming to arm64, which creates new warnings in allmodconfig:

drivers/staging/emxx_udc/emxx_udc.c: In function '_nbu2ss_out_dma':
drivers/staging/emxx_udc/emxx_udc.c:843:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  _nbu2ss_writel(&preg->EP_DCR[num].EP_TADR, (u32)pBuffer);

This is clearly a mistake from confusing a dma_addr_t with a pointer,
so the fix is to use the correct types in two places.

The third warning of this kind is a check for an unaligned pointer,
which should be done by casting the pointer to uintptr_t, not int.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 4e6c16af40fc..c168845cbb91 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -823,7 +823,7 @@ static int _nbu2ss_out_dma(
 	u32		length
 )
 {
-	u8		*pBuffer;
+	dma_addr_t	pBuffer;
 	u32		mpkt;
 	u32		lmpkt;
 	u32		dmacnt;
@@ -836,7 +836,7 @@ static int _nbu2ss_out_dma(
 		return 1;		/* DMA is forwarded */
 
 	req->dma_flag = TRUE;
-	pBuffer = (u8 *)req->req.dma;
+	pBuffer = req->req.dma;
 	pBuffer += req->req.actual;
 
 	/* DMA Address */
@@ -1034,7 +1034,7 @@ static int _nbu2ss_in_dma(
 	u32		length
 )
 {
-	u8		*pBuffer;
+	dma_addr_t	pBuffer;
 	u32		mpkt;		/* MaxPacketSize */
 	u32		lmpkt;		/* Last Packet Data Size */
 	u32		dmacnt;		/* IN Data Size */
@@ -1080,7 +1080,7 @@ static int _nbu2ss_in_dma(
 	_nbu2ss_writel(&preg->EP_DCR[num].EP_DCR2, data);
 
 	/* Address setting */
-	pBuffer = (u8 *)req->req.dma;
+	pBuffer = req->req.dma;
 	pBuffer += req->req.actual;
 	_nbu2ss_writel(&preg->EP_DCR[num].EP_TADR, (u32)pBuffer);
 
@@ -2728,7 +2728,7 @@ static int nbu2ss_ep_queue(
 	spin_lock_irqsave(&udc->lock, flags);
 
 #ifdef USE_DMA
-	if ((u32)req->req.buf & 0x3)
+	if ((uintptr_t)req->req.buf & 0x3)
 		req->unaligned = TRUE;
 	else
 		req->unaligned = FALSE;
