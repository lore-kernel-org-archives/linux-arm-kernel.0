From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 15 Aug 2014 19:42:36 +0200
Subject: [PATCH 08/15] dmaengine: edma: fix two faults which happen with the
 8250_dma user
In-Reply-To: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1408124563-31541-9-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rx path of the 8250_dma user in the RX-timeout case:
- it starts the RX transfer
  if the rx-timeout interrupt occurs, it dmaengine_pause() the transfer
- step two is dmaengine_terminate_all() on this channel.
- based on dmaengine_tx_status() it learns the number of transferred
  bytes.
- the rx interrupt occurs, it does not start the RX-transfer because
  according to dmaengine_tx_status() the status of the current transfer
  is still DMA_IN_PROGRESS because the earlier dmaengine_terminate_all()
  did not reset this.
- on rx-timeout it invokes dmaengine_pause() again. This time, it
  segfaults because the channel has no descriptor yet.

To make the upper case work better, this patch adds dma_cookie_complete()
to complete the cookie. Also it adds is an additional check for echan->edesc
in case the channel has no descriptor assigned.

Cc: Joel Fernandes <joelf@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/dma/edma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d08c4de..ff05dd4 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -256,6 +256,7 @@ static int edma_terminate_all(struct edma_chan *echan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
+		dma_cookie_complete(&echan->edesc->vdesc.tx);
 		echan->edesc = NULL;
 		edma_stop(echan->ch_num);
 	}
@@ -282,7 +283,7 @@ static int edma_slave_config(struct edma_chan *echan,
 static int edma_dma_pause(struct edma_chan *echan)
 {
 	/* Pause/Resume only allowed with cyclic mode */
-	if (!echan->edesc->cyclic)
+	if (!echan->edesc || !echan->edesc->cyclic)
 		return -EINVAL;
 
 	edma_pause(echan->ch_num);
-- 
2.0.1
