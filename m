From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Jul 2016 20:13:33 +0100
Subject: Applied "spi: mediatek: remove spi_master_put in mtk_spi_remove()" to
 the spi tree
In-Reply-To: <1469545010-32327-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <E1bSUGr-00051R-Fx@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: remove spi_master_put in mtk_spi_remove()

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

>From c2b08cede727387a5e19b40fa8e1a1e3a53e8527 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Tue, 26 Jul 2016 14:56:50 +0000
Subject: [PATCH] spi: mediatek: remove spi_master_put in mtk_spi_remove()

The call to spi_master_put() in mtk_spi_remove() is redundant since
the master is registered using devm_spi_register_master() and no
reference hold by using spi_master_get() in mtk_spi_remove().

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0be89e052428..899d7a8f0889 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -685,7 +685,6 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	mtk_spi_reset(mdata);
-	spi_master_put(master);
 
 	return 0;
 }
-- 
2.8.1
