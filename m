From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 17 Aug 2018 06:03:43 -0700
Subject: [PATCH 3/3] dmaengine: at_xdmac: move spin_lock_bh to spin_lock in
 tasklet
Message-ID: <1534511023-7871-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/dma/at_xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4bf7256..4e55768 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1600,7 +1600,7 @@ static void at_xdmac_tasklet(unsigned long data)
 		if (atchan->status & AT_XDMAC_CIS_ROIS)
 			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
 
-		spin_lock_bh(&atchan->lock);
+		spin_lock(&atchan->lock);
 		desc = list_first_entry(&atchan->xfers_list,
 					struct at_xdmac_desc,
 					xfer_node);
@@ -1610,7 +1610,7 @@ static void at_xdmac_tasklet(unsigned long data)
 		txd = &desc->tx_dma_desc;
 
 		at_xdmac_remove_xfer(atchan, desc);
-		spin_unlock_bh(&atchan->lock);
+		spin_unlock(&atchan->lock);
 
 		if (!at_xdmac_chan_is_cyclic(atchan)) {
 			dma_cookie_complete(txd);
-- 
2.7.4
