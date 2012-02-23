From: christian.riesch@omicron.at (Christian Riesch)
Date: Thu, 23 Feb 2012 08:58:00 +0100
Subject: [PATCH] davinci_cpdma: Fix channel number written to teardown
 registers
Message-ID: <1329983880-23921-1-git-send-email-christian.riesch@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chan->chan_num is 0..CPDMA_MAX_CHANNELS-1 for tx channels and
CPDMA_MAX_CHANNELS..2*CPDMA_MAX_CHANNELS-1 for rx channels. However,
the rx and tx teardown registers expect zero based channel numbering.

Since the upper bits of the registers are reserved, the teardown also
worked before, this patch is cleanup only.

Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
---
 drivers/net/ethernet/ti/davinci_cpdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index c97d2f5..3455876 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -822,7 +822,7 @@ int cpdma_chan_stop(struct cpdma_chan *chan)
 	dma_reg_write(ctlr, chan->int_clear, chan->mask);
 
 	/* trigger teardown */
-	dma_reg_write(ctlr, chan->td, chan->chan_num);
+	dma_reg_write(ctlr, chan->td, chan_linear(chan));
 
 	/* wait for teardown complete */
 	timeout = jiffies + HZ/10;	/* 100 msec */
-- 
1.7.0.4
