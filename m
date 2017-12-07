From: takuo.koguchi@gmail.com (Takuo Koguchi)
Date: Thu,  7 Dec 2017 16:20:14 +0900
Subject: [PATCH V3] spi: sun4i: disable clocks in the remove function
In-Reply-To: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
Message-ID: <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mclk and hclk need to be disabled. Since pm_runtime_disable does
not disable the clocks, use pm_runtime_force_suspend instead.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 V3: remove redundant pm_runtime_disable call.
     Compile test only, no runtime test done.
 drivers/spi/spi-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635..4141003 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,7 +525,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.7.4
