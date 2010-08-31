From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:08 +0200
Subject: [PATCH 06/12] DMAENGINE: free txd list if submission fails on PL08X
In-Reply-To: <1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes oversubscribed channels fail to mux in a signal line for
the transmission, and we bail out. Make sure we also clean out any
pending txd lists when this happens.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 65f595c..65892d5 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1270,6 +1270,7 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 	ret = prep_phy_channel(plchan, txd);
 	if (ret) {
 		/* No physical channel available, cope with it */
+		pl08x_free_txd_list(pl08x, plchan);
 		spin_unlock_irqrestore(&plchan->lock, flags);
 		return -EBUSY;
 	}
-- 
1.6.3.3
