From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Sep 2013 17:45:59 +0200
Subject: [PATCH] clk: fix function name in devm_clk_put kernel-doc comment
Message-ID: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The paragraph about clk_put already specifies this restriction about
clk_put.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I suspect that devm_clk_put is used more often than necessary. After some
grepping around e.g. looking at drivers/tty/serial/clps711x.c it doesn't
seem necessary to call it as the driver core already cares about calling
the devm cleanup callbacks.
The only reason I see being valid to call devm_clk_put is that a device
continues to be bound and still it's sure that the clk in question isn't
needed anymore. Ah, and maybe to enforce an order during cleanup, but
then there is no reason to use devm, the normal functions would just do
fine. I'm replying to this mail with a few patches.

Best regards
Uwe

 include/linux/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 9a6d045..c713ba0 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -214,7 +214,7 @@ void clk_put(struct clk *clk);
  * clock source are balanced by clk_disable calls prior to calling
  * this function.
  *
- * clk_put should not be called from within interrupt context.
+ * devm_clk_put should not be called from within interrupt context.
  */
 void devm_clk_put(struct device *dev, struct clk *clk);
 
-- 
1.8.4.rc3
