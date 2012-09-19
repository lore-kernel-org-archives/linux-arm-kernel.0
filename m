From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 07:42:32 -0400
Subject: [PATCH] clk: Fix release in devm_clk_put()
Message-ID: <1348054952-15652-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Surprisingly devres_destroy() doesn't call the destructor for the
resource it is destroying, use the newly added devres_release() instead
to fix this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Rebased on top of the creation of clk-devres.c.

It appears this also got silently dropped by the patch system :/

 drivers/clk/clk-devres.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index f1e7a83..8f57154 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -48,7 +48,7 @@ void devm_clk_put(struct device *dev, struct clk *clk)
 {
 	int ret;
 
-	ret = devres_destroy(dev, devm_clk_release, devm_clk_match, clk);
+	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
 
 	WARN_ON(ret);
 }
-- 
1.7.10.4
