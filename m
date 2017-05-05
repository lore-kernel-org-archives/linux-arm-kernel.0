From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:52 +0200
Subject: [PATCH 09/10] dma: mv_xor_v2: remove unnecessary write to DESQ_STOP
 register
In-Reply-To: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493978274-12805-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

Remove unnecessary write to DESQ_STOP register, this register is used to
enable or disable the XOR engine, and not to issue all pending
descriptors in the queue. mv_xor_v2 driver already writes to this
register and enable XOR engine in the mv_xor_v2_descq_init() function,
called during initialization.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor_v2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 5292ff2..f386b88 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -535,9 +535,6 @@ static void mv_xor_v2_issue_pending(struct dma_chan *chan)
 	mv_xor_v2_add_desc_to_desq(xor_dev, xor_dev->npendings);
 	xor_dev->npendings = 0;
 
-	/* Activate the channel */
-	writel(0, xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_STOP_OFF);
-
 	spin_unlock_bh(&xor_dev->lock);
 }
 
-- 
2.7.4
