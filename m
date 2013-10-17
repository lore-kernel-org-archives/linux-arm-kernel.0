From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Oct 2013 14:45:41 +0200
Subject: [PATCH] spi: spi-s3c64xx: Add missing pm_runtime_put on setup fail
Message-ID: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pm_runtime_put() wasn't called if clock rate could not be set up in
s3c64xx_spi_setup() leading to invalid count of device pm_runtime usage.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a80376d..0ddaff2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1121,6 +1121,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	return 0;
 
 setup_exit:
+	pm_runtime_put(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
 	disable_cs(sdd, spi);
 
-- 
1.7.9.5
