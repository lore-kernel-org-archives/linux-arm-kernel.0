From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Dec 2013 12:38:32 +0100
Subject: [PATCH 1/3] dma: mv_xor: take channel spinlock in mv_xor_status()
In-Reply-To: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388144314-1581-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv_xor_status() function accesses the mv_xor_chan structure, but
was not taking the corresponding spinlock. This patch fixes this
problem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 53fb0c8..526ab27 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -701,14 +701,20 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
 	enum dma_status ret;
 
+	spin_lock_bh(&mv_chan->lock);
+
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE) {
 		mv_xor_clean_completed_slots(mv_chan);
+		spin_unlock_bh(&mv_chan->lock);
 		return ret;
 	}
-	mv_xor_slot_cleanup(mv_chan);
+	__mv_xor_slot_cleanup(mv_chan);
 
-	return dma_cookie_status(chan, cookie, txstate);
+	ret = dma_cookie_status(chan, cookie, txstate);
+	spin_unlock_bh(&mv_chan->lock);
+
+	return ret;
 }
 
 static void mv_dump_xor_regs(struct mv_xor_chan *chan)
-- 
1.8.3.2
