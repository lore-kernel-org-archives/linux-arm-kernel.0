From: ysato@users.sourceforge.jp (Yoshinori Sato)
Date: Sun,  1 Mar 2015 16:43:35 +0900
Subject: [PATCH] clkdev: clk_add_alias don't put origin clock
Message-ID: <1425195815-14895-1-git-send-email-ysato@users.sourceforge.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refer to 'r' later.
So don't put in clk_add_alias.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 043fd36..fddb999 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -318,7 +318,6 @@ int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
 		return PTR_ERR(r);
 
 	l = clkdev_alloc(r, alias, alias_dev_name);
-	clk_put(r);
 	if (!l)
 		return -ENODEV;
 	clkdev_add(l);
@@ -334,6 +333,7 @@ void clkdev_drop(struct clk_lookup *cl)
 	mutex_lock(&clocks_mutex);
 	list_del(&cl->node);
 	mutex_unlock(&clocks_mutex);
+	clk_put(cl->clk);
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
-- 
2.1.4
