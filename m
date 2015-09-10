From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Sep 2015 19:17:46 +0200
Subject: [PATCH 2/2] dma: pxa_dma: fix residue corner case
In-Reply-To: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
References: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1441905466-17459-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A very tiny temporal window exists in the residue calculation where :
 - upon entering residue calculation, the transfer is ongoing
 - when reading the current transfer pointer, it just changed to
   the "finisher/linker" descriptor

In this case, the he residue returned is thw whole transfer length
instead of 0. Fix it.

This appears almost in one extreme case, where the driver is used
by older clients which inquire for residue in interrupt context, such
as the xmsc91x ethernet driver, in a tight loop :
  interrupt_handler()
    dmaengine_submit()
    do {
      dmaengine_tx_status()
    } while (residue > 0 || status != DMA_ERROR)

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 5647c1579c44..bf064277518e 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1186,6 +1186,16 @@ static unsigned int pxad_residue(struct pxad_chan *chan,
 	else
 		curr = phy_readl_relaxed(chan->phy, DTADR);
 
+	/*
+	 * curr has to be actually read before checking descriptor
+	 * completion, so that a curr inside a status updater
+	 * descriptor implies the following test returns true, and
+	 * preventing reordering of curr load and the test.
+	 */
+	rmb();
+	if (is_desc_completed(vd))
+		goto out;
+
 	for (i = 0; i < sw_desc->nb_desc - 1; i++) {
 		hw_desc = sw_desc->hw_desc[i];
 		if (sw_desc->hw_desc[0]->dcmd & PXA_DCMD_INCSRCADDR)
-- 
2.1.4
