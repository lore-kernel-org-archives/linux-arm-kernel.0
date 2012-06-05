From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  5 Jun 2012 11:44:45 +0100
Subject: [PATCH] clkdev: Fix leak in devm_clk_put()
Message-ID: <1338893085-12376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Surprisingly devres_destroy() doesn't call the destructor for the resource
it is destroying, causing devm_clk_put() to be ineffectual.

Use the newly added devres_release() instead to fix this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clkdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index c535cf8..c7a4eee 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -133,7 +133,7 @@ void devm_clk_put(struct device *dev, struct clk *clk)
 {
 	int ret;
 
-	ret = devres_destroy(dev, devm_clk_release, devm_clk_match, clk);
+	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
 
 	WARN_ON(ret);
 }
-- 
1.7.10
