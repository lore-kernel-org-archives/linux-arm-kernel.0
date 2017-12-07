From: Tobias.Jordan@elektrobit.com (Tobias Jordan)
Date: Thu, 7 Dec 2017 15:04:53 +0100
Subject: [PATCH] spi: sun6i: disable/unprepare clocks on remove
Message-ID: <20171207140453.55krsazvnfqr7ooe@agrajag.zerfleddert.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable
clocks, so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
disable/unprepare them if we're not suspended.
Replacing pm_runtime_disable() by pm_runtime_force_suspend() will ensure
that sun6i_spi_runtime_suspend() is called if needed.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3558fe900e8af spi: sunxi: Add Allwinner A31 SPI controller driver
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
Found by LDV and discussed as RFC before; compile-tested.

 drivers/spi/spi-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fb38234249a8..8533f4edd00a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -541,7 +541,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.11.0
