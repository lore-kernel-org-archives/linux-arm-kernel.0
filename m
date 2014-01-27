From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 27 Jan 2014 09:44:07 +0800
Subject: [PATCH] dma: mmp_pdma: add IRQF_SHARED when request irq
Message-ID: <1390787047-11507-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

For some SOCes use mmp_pdma, they have several dma controllers
sharing same irq.
So add IRQF_SHARED to flag when request irq. It can make multiple
controllers share the same irq.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/dma/mmp_pdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 32e58ee..b86415b 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -866,8 +866,8 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	phy->base = pdev->base;
 
 	if (irq) {
-		ret = devm_request_irq(pdev->dev, irq, mmp_pdma_chan_handler, 0,
-				       "pdma", phy);
+		ret = devm_request_irq(pdev->dev, irq, mmp_pdma_chan_handler,
+				       IRQF_SHARED, "pdma", phy);
 		if (ret) {
 			dev_err(pdev->dev, "channel request irq fail!\n");
 			return ret;
@@ -964,8 +964,8 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (irq_num != dma_channels) {
 		/* all chan share one irq, demux inside */
 		irq = platform_get_irq(op, 0);
-		ret = devm_request_irq(pdev->dev, irq, mmp_pdma_int_handler, 0,
-				       "pdma", pdev);
+		ret = devm_request_irq(pdev->dev, irq, mmp_pdma_int_handler,
+				       IRQF_SHARED, "pdma", pdev);
 		if (ret)
 			return ret;
 	}
-- 
1.8.3.2
