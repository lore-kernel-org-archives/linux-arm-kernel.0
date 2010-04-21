From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Wed, 21 Apr 2010 21:37:31 +0300
Subject: [PATCH] arm: mxc: utilise usecount field in clock operations
Message-ID: <b9f250fee8e5300e859b2afc234868ba7632f619.1271864861.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk->usecount can be used by platform code to check if a clock is active or
not.

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/clock.c |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 323ff8c..c791f38 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -50,15 +50,15 @@ static DEFINE_MUTEX(clocks_mutex);
 
 static void __clk_disable(struct clk *clk)
 {
-	if (clk == NULL || IS_ERR(clk))
+	if (clk == NULL || IS_ERR(clk) || !clk->usecount)
 		return;
 
-	__clk_disable(clk->parent);
-	__clk_disable(clk->secondary);
-
-	WARN_ON(!clk->usecount);
-	if (!(--clk->usecount) && clk->disable)
-		clk->disable(clk);
+	if (!(--clk->usecount)) {
+		if (clk->disable)
+			clk->disable(clk);
+		__clk_disable(clk->parent);
+		__clk_disable(clk->secondary);
+	}
 }
 
 static int __clk_enable(struct clk *clk)
@@ -66,12 +66,13 @@ static int __clk_enable(struct clk *clk)
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
-	__clk_enable(clk->parent);
-	__clk_enable(clk->secondary);
-
-	if (clk->usecount++ == 0 && clk->enable)
-		clk->enable(clk);
+	if (clk->usecount++ == 0) {
+		__clk_enable(clk->parent);
+		__clk_enable(clk->secondary);
 
+		if (clk->enable)
+			clk->enable(clk);
+	}
 	return 0;
 }
 
@@ -160,17 +161,27 @@ EXPORT_SYMBOL(clk_set_rate);
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	int ret = -EINVAL;
+	struct clk *prev_parent = clk->parent;
 
 	if (clk == NULL || IS_ERR(clk) || parent == NULL ||
 	    IS_ERR(parent) || clk->set_parent == NULL)
 		return ret;
 
+	if (clk->usecount != 0) {
+		clk_enable(parent);
+	}
+
 	mutex_lock(&clocks_mutex);
 	ret = clk->set_parent(clk, parent);
-	if (ret == 0)
+	if (ret == 0) {
 		clk->parent = parent;
+	}
 	mutex_unlock(&clocks_mutex);
 
+	if (clk->usecount != 0) {
+		clk_disable(prev_parent);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_parent);
-- 
1.7.0.4
