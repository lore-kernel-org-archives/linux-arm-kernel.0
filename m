From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:07 +0200
Subject: [PATCH 05/12] DMAENGINE: terminate transfers on PL08X mere throughly
In-Reply-To: <1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to terminate pending tasklets and be sure to disable not
only the channel but it's IRQ:s when we terminate all work on
a PL08X channel.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d1a4813..65f595c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -312,6 +312,8 @@ static void pl08x_stop_phy_chan(struct pl08x_phy_chan *ch)
 	/* Disable channel */
 	val = readl(ch->base + PL080_CH_CONFIG);
 	val &= ~PL080_CONFIG_ENABLE;
+	val &= ~PL080_CONFIG_ERR_IRQ_MASK;
+	val &= ~PL080_CONFIG_TC_IRQ_MASK;
 	writel(val, ch->base + PL080_CH_CONFIG);
 }
 
@@ -1653,13 +1655,15 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			pl08x_put_phy_channel(pl08x, plchan->phychan);
 			plchan->phychan = NULL;
 		}
-
+		/* Stop any pending tasklet */
+		tasklet_disable(&plchan->tasklet);
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
 			pl08x_free_txd(pl08x, plchan->at);
-			pl08x_free_txd_list(pl08x, plchan);
 			plchan->at = NULL;
 		}
+		/* Dequeue jobs not yet fired as well */
+		pl08x_free_txd_list(pl08x, plchan);
 		break;
 	case DMA_PAUSE:
 		pl08x_pause_phy_chan(plchan->phychan);
-- 
1.6.3.3
