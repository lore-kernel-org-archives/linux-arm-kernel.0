From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:20 +0200
Subject: [PATCH 02/12] dma: mmp_pdma: clear DRCMR when free a phy channel
In-Reply-To: <1375870770-14263-1-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
Message-ID: <1375870770-14263-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiang Wang <wangx@marvell.com>

In mmp pdma, phy channels are allocated/freed dynamically.
The mapping from DMA request to DMA channel number in DRCMR
should be cleared when a phy channel is freed. Otherwise
conflicts will happen when:
1. A is using channel 2 and free it after finished, but A
still maps to channel 2 in DRCMR of A.
2. Now another one B gets channel 2. So B maps to channel 2
too in DRCMR of B.
In the datasheet, it is described that "Do not map two active
requests to the same channel since it produces unpredictable
results" and we can observe that during test.

Signed-off-by: Xiang Wang <wangx@marvell.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 226158d..2844eaf 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -252,10 +252,16 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 {
 	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(pchan->chan.device);
 	unsigned long flags;
+	u32 reg;
 
 	if (!pchan->phy)
 		return;
 
+	/* clear the channel mapping in DRCMR */
+	reg = pchan->phy->vchan->drcmr;
+	reg = ((reg < 64) ? 0x0100 : 0x1100) + ((reg & 0x3f) << 2);
+	writel(0, pchan->phy->base + reg);
+
 	spin_lock_irqsave(&pdev->phy_lock, flags);
 	pchan->phy->vchan = NULL;
 	pchan->phy = NULL;
-- 
1.8.3.1
