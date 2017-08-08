From: broonie@kernel.org (Mark Brown)
Date: Tue, 08 Aug 2017 12:06:39 +0100
Subject: Applied "spi/bcm63xx-hspi: fix error return code in
 bcm63xx_hsspi_probe()" to the spi tree
In-Reply-To: <20170808045944.GA19600@embeddedgus>
Message-ID: <E1df2LP-00055E-6Q@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi/bcm63xx-hspi: fix error return code in bcm63xx_hsspi_probe()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 378da4a65f3a0390837b38145bb5d8c2d20c2cf7 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 7 Aug 2017 23:59:44 -0500
Subject: [PATCH] spi/bcm63xx-hspi: fix error return code in
 bcm63xx_hsspi_probe()

platform_get_irq() returns an error code, but the spi-bcm63xx-hsspi
driver ignores it and always returns -ENXIO. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 4da2d4a524ca..b03fc1850ae9 100644
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
2.13.2
