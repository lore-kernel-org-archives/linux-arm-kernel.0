From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 4 Dec 2009 01:02:41 +0200
Subject: [PATCH] arm: mxc: utilise usecount field in clock operations
Message-ID: <3b125ff8668917c7969b2cdf733f94cb415c83bd.1275034568.git.amit.kucheria@verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the clock refcounting when reparenting is used.

Boot-tested on imx51 babbage board.

Sascha pointed out a good explanation of refcounting here:
http://www.spinics.net/lists/arm-kernel/msg85879.html

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/clock.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 323ff8c..2ed3ab1 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -52,13 +52,14 @@ static void __clk_disable(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
 		return;
-
-	__clk_disable(clk->parent);
-	__clk_disable(clk->secondary);
-
 	WARN_ON(!clk->usecount);
-	if (!(--clk->usecount) && clk->disable)
-		clk->disable(clk);
+
+	if (!(--clk->usecount)) {
+		if (clk->disable)
+			clk->disable(clk);
+		__clk_disable(clk->parent);
+		__clk_disable(clk->secondary);
+	}
 }
 
 static int __clk_enable(struct clk *clk)
@@ -66,12 +67,13 @@ static int __clk_enable(struct clk *clk)
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
 
@@ -160,17 +162,28 @@ EXPORT_SYMBOL(clk_set_rate);
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	int ret = -EINVAL;
+	struct clk *old;
 
 	if (clk == NULL || IS_ERR(clk) || parent == NULL ||
 	    IS_ERR(parent) || clk->set_parent == NULL)
 		return ret;
 
+	if (clk->usecount)
+		clk_enable(parent);
+
 	mutex_lock(&clocks_mutex);
 	ret = clk->set_parent(clk, parent);
-	if (ret == 0)
+	if (ret == 0) {
+		old = clk->parent;
 		clk->parent = parent;
+	} else {
+		old = parent;
+	}
 	mutex_unlock(&clocks_mutex);
 
+	if (clk->usecount)
+		clk_disable(old);
+
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_parent);
-- 
1.7.0.4
