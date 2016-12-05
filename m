From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon,  5 Dec 2016 03:47:10 +0200
Subject: [PATCH] mtd: nand: lpc32xx: fix invalid error handling of a requested
 irq
Message-ID: <20161205014710.2015-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
disabled or enabled, in the latter case IRQs are allocated starting
at least from the value specified by NR_IRQS and going upwards, so
the check of (irq >= NR_IRQ) to decide about an error code returned by
platform_get_irq() is completely invalid, don't attempt to overrule
irq subsystem in the driver.

The change fixes LPC32xx NAND MLC driver initialization on boot.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/mtd/nand/lpc32xx_mlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 8523881..bc6e49a 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -776,7 +776,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	init_completion(&host->comp_controller);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if ((host->irq < 0) || (host->irq >= NR_IRQS)) {
+	if (host->irq < 0) {
 		dev_err(&pdev->dev, "failed to get platform irq\n");
 		res = -EINVAL;
 		goto err_exit3;
-- 
2.10.2
