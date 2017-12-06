From: takuo.koguchi@gmail.com (Takuo Koguchi)
Date: Thu,  7 Dec 2017 03:00:00 +0900
Subject: [PATCH] spi: sun4i: disable clocks in the remove function
In-Reply-To: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
Message-ID: <1512583209-19398-1-git-send-email-takuo.koguchi.sw@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mclk and hclk need to be disabled since pm_runtime_disable does
not disable the clocks.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 V2: use pm_runtime_force_suspend to avoid unbalance disable
     call.
     Compile test only, no runtime test.
 drivers/spi/spi-sun4i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635..ca733b2 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,6 +525,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	pm_runtime_force_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.7.4
