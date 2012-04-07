From: shijie8@gmail.com (Huang Shijie)
Date: Sat,  7 Apr 2012 01:29:35 -0400
Subject: [PATCH] mxs-dma : assign the dma cookie before we enable the dma
 channel
Message-ID: <1333776575-3462-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma chain may finished very fast, so an interrupt may arises before
we assign the dma cookie. In this case, the mxs_dma_int_handler() may
hit the BUG_ON() in dma_cookie_complete().

So assign the dma cookie before we enable the dma channel.

Acked-by: Sam Gandhi <samgandhi9@gmail.com>
Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/dma/mxs-dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index a1e2d00..1e16d0e 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -210,10 +210,12 @@ static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
 static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
+	dma_cookie_t cookie;
 
+	cookie = dma_cookie_assign(tx);
 	mxs_dma_enable_chan(mxs_chan);
 
-	return dma_cookie_assign(tx);
+	return cookie;
 }
 
 static void mxs_dma_tasklet(unsigned long data)
-- 
1.7.4.4
