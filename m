From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 15 Nov 2013 15:54:16 +0800
Subject: [PATCH] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()
Message-ID: <CAPgLHd_-cpipSk5+SVPwZ0_Jzx2P5tJVFaj8Rxkbb_+yFVqvEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Once a spi_master_get() call succeeds, we need an additional
spi_master_put() call to free the memory, otherwise we will
leak a reference to master. Fix by removing the unnecessary
spi_master_get() call.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9e2020d..9c82d7b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1439,7 +1439,7 @@ err0:
 
 static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
 	pm_runtime_disable(&pdev->dev);
