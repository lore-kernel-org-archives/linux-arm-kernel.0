From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 07 Jan 2014 13:03:43 +0100
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
Message-ID: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure clk->kref is dereferenced only when clk is not NULL.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Hi Sachin,

please try if this patch fixes the exyno5420 boot crash.

Thanks,
Sylwester

 drivers/clk/clk.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e3e0327..a1fe86f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2179,24 +2179,25 @@ EXPORT_SYMBOL_GPL(devm_clk_unregister);
  */
 int __clk_get(struct clk *clk)
 {
-	if (clk && !try_module_get(clk->owner))
-		return 0;
+	if (clk) {
+		if (!try_module_get(clk->owner))
+			return 0;

-	kref_get(&clk->ref);
+		kref_get(&clk->ref);
+	}
 	return 1;
 }

 void __clk_put(struct clk *clk)
 {
-	if (WARN_ON_ONCE(IS_ERR(clk)))
+	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
 		return;

 	clk_prepare_lock();
 	kref_put(&clk->ref, __clk_release);
 	clk_prepare_unlock();

-	if (clk)
-		module_put(clk->owner);
+	module_put(clk->owner);
 }

 /***        clk rate change notifiers        ***/
--
1.7.9.5
