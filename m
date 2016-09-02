From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  3 Sep 2016 01:17:20 +0200
Subject: [PATCH] dmaengine: sirf: fix irq number error check
Message-ID: <20160902231737.1721916-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_of_parse_and_map() returns 0 on error, no NO_IRQ, so the
failure condition can never be met.

This changes the comparison to check for zero instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/sirf-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index a96e4a480de5..8f62edad51be 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -866,7 +866,7 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	}
 
 	sdma->irq = irq_of_parse_and_map(dn, 0);
-	if (sdma->irq == NO_IRQ) {
+	if (!sdma->irq) {
 		dev_err(dev, "Error mapping IRQ!\n");
 		return -EINVAL;
 	}
-- 
2.9.0
