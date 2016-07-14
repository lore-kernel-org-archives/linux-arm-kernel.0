From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:32:52 +0100
Subject: Applied "spi: s3c64xx: use error code from clk_prepare_enable()" to
 the spi tree
In-Reply-To: <1467989201-14661-5-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bNjZE-0001mT-Vp@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: use error code from clk_prepare_enable()

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

>From 25981d8281ee4cbbd6f7c5bc0f8c048ad9548037 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 12 Jul 2016 19:02:13 +0900
Subject: [PATCH] spi: s3c64xx: use error code from clk_prepare_enable()

If clk_prepare_enable() fails do not return -EBUSY but use the
value provided by the function itself.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0a93eb98c2b6..3d21f8a35837 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1133,9 +1133,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err_deref_master;
 	}
 
-	if (clk_prepare_enable(sdd->clk)) {
+	ret = clk_prepare_enable(sdd->clk);
+	if (ret) {
 		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
-		ret = -EBUSY;
 		goto err_deref_master;
 	}
 
@@ -1148,9 +1148,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	if (clk_prepare_enable(sdd->src_clk)) {
+	ret = clk_prepare_enable(sdd->src_clk);
+	if (ret) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
-		ret = -EBUSY;
 		goto err_disable_clk;
 	}
 
-- 
2.8.1
