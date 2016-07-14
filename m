From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:33:04 +0100
Subject: Applied "spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()" to the spi tree
In-Reply-To: <1468321722-16568-1-git-send-email-weiyj_lk@163.com>
Message-ID: <E1bNjZQ-0001rC-Ju@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: fix reference leak to master in s3c64xx_spi_remove()

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

>From 9f135787b1d29b0069059b580c1c77965e5e8af4 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Date: Tue, 12 Jul 2016 11:08:42 +0000
Subject: [PATCH] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()

Once a spi_master_get() call succeeds, we need an additional
spi_master_put() call to free the memory, otherwise we will
leak a reference to master. Fix by removing the unnecessary
spi_master_get() call.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index df88fa161d8a..001c9ebf884d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1211,7 +1211,7 @@ err0:
 
 static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
 	pm_runtime_get_sync(&pdev->dev);
-- 
2.8.1
