From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Wed, 9 Aug 2017 11:35:21 -0500
Subject: [PATCH] mtd: nand: mtk: fix error return code in mtk_ecc_probe()
Message-ID: <20170809163521.GA4941@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() returns an error code, but the mtk_ecc driver
ignores it and always returns -EINVAL. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/nand/mtk_ecc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mtk_ecc.c b/drivers/mtd/nand/mtk_ecc.c
index 6c3a4aa..7f3b065 100644
--- a/drivers/mtd/nand/mtk_ecc.c
+++ b/drivers/mtd/nand/mtk_ecc.c
@@ -464,8 +464,8 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
-		return -EINVAL;
+		dev_err(dev, "failed to get irq: %d\n", irq);
+		return irq;
 	}
 
 	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
-- 
2.5.0
