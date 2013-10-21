From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 21 Oct 2013 15:42:49 +0200
Subject: [PATCH 1/2] spi/s3c64xx: Do not ignore return value of
 spi_master_resume/suspend
Message-ID: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During PM resume and suspend do not ignore the return value of
spi_master_suspend() or spi_master_resume(). Instead pass it further.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 512b889..59f4fd9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1480,7 +1480,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
-	spi_master_suspend(master);
+	int ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
 
 	/* Disable the clock */
 	clk_disable_unprepare(sdd->src_clk);
@@ -1506,9 +1508,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 
 	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
-	spi_master_resume(master);
-
-	return 0;
+	return spi_master_resume(master);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
1.7.9.5
