From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Oct 2013 18:06:46 +0200
Subject: [PATCH] spi/s3c64xx: Add missing pm_runtime_set_active() call in
 probe()
Message-ID: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark device as PM runtime active during initialization to reflect
actual device power/clocks state. This reduces the enable count for SPI
bus controller gate clock so it can be disabled when the bus controller
is not used.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0ddaff2..ae07c3a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1429,6 +1429,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	if (spi_register_master(master)) {
-- 
1.7.9.5
