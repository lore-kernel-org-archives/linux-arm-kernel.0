From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 30 Sep 2015 19:42:15 +0200
Subject: [PATCH v2 2/2] dma: pxa_dma: fix residue corner case
In-Reply-To: <1443634935-28989-1-git-send-email-robert.jarzmik@free.fr>
References: <1443634935-28989-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1443634935-28989-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A very tiny temporal window exists in the residue calculation where :
 - upon entering residue calculation, the transfer is ongoing
 - when reading the current transfer pointer, it just changed to
   the "finisher/linker" descriptor

In this case, the residue returned is the whole transfer length instead
of 0. Fix it.

This appears almost in one extreme case, where the driver is used
by older clients which inquire for residue in interrupt context, such
as the smsc91x ethernet driver, in a tight loop :
  interrupt_handler()
    dmaengine_submit()
    do {
      dmaengine_tx_status()
    } while (residue > 0 || status != DMA_ERROR)

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: reworded the commit message for typos
---
 drivers/dma/pxa_dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 7d3ff56caa0a..51f294e4227c 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1185,6 +1185,16 @@ static unsigned int pxad_residue(struct pxad_chan *chan,
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
