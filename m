From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 7 Aug 2017 23:59:44 -0500
Subject: [PATCH] spi/bcm63xx-hspi: fix error return code in
 bcm63xx_hsspi_probe()
Message-ID: <20170808045944.GA19600@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() returns an error code, but the spi-bcm63xx-hsspi
driver ignores it and always returns -ENXIO. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 475a790..cbcba61 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -338,8 +338,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq\n");
-		return -ENXIO;
+		dev_err(dev, "no irq: %d\n", irq);
+		return irq;
 	}
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.5.0
