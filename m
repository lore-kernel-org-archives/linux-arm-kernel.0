From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue, 12 Jul 2016 11:08:42 +0000
Subject: [PATCH -next] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()
Message-ID: <1468321722-16568-1-git-send-email-weiyj_lk@163.com>
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
index df88fa1..001c9eb 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1211,7 +1211,7 @@ err0:
 
 static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
 	pm_runtime_get_sync(&pdev->dev);
