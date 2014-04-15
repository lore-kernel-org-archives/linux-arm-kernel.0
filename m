From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:13:35 +0200
Subject: [PATCH 4/6] dma: mmp_pdma: Fix physical channel memory allocation size
In-Reply-To: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397574817-15559-5-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use sizeof(*var) instead of sizeof(type) when calling devm_k*alloc().
This avoids using the wrong type as was done to allocate the physical
channels array.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/mmp_pdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 643f225..7ed7850 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -858,8 +858,7 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	struct mmp_pdma_chan *chan;
 	int ret;
 
-	chan = devm_kzalloc(pdev->dev, sizeof(struct mmp_pdma_chan),
-			    GFP_KERNEL);
+	chan = devm_kzalloc(pdev->dev, sizeof(*chan), GFP_KERNEL);
 	if (chan == NULL)
 		return -ENOMEM;
 
@@ -946,8 +945,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 			irq_num++;
 	}
 
-	pdev->phy = devm_kcalloc(pdev->dev,
-				 dma_channels, sizeof(struct mmp_pdma_chan),
+	pdev->phy = devm_kcalloc(pdev->dev, dma_channels, sizeof(*pdev->phy),
 				 GFP_KERNEL);
 	if (pdev->phy == NULL)
 		return -ENOMEM;
-- 
1.8.3.2
