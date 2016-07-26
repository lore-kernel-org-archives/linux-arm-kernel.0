From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 26 Jul 2016 14:56:50 +0000
Subject: [PATCH] spi: mediatek: remove spi_master_put in mtk_spi_remove()
Message-ID: <1469545010-32327-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The call to spi_master_put() in mtk_spi_remove() is redundant since
the master is registered using devm_spi_register_master() and no
reference hold by using spi_master_get() in mtk_spi_remove().

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/spi/spi-mt65xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0be89e0..899d7a8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -685,7 +685,6 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	mtk_spi_reset(mdata);
-	spi_master_put(master);
 
 	return 0;
 }
