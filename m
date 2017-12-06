From: takuo.koguchi@gmail.com (Takuo Koguchi)
Date: Thu,  7 Dec 2017 00:22:13 +0900
Subject: [PATCH] spi: sun4i: disable clocks in the remove function
Message-ID: <1512573752-13091-1-git-send-email-takuo.koguchi.sw@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mclk and hclk need to be disabled explicitly since pm_runtime_disable does
not disable the clocks.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 drivers/spi/spi-sun4i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635..9011c09 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,6 +525,11 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = dev_get_drvdata(&pdev->dev);
+	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(sspi->mclk);
+	clk_disable_unprepare(sspi->hclk);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.7.4
