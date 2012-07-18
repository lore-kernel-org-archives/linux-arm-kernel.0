From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jul 2012 11:52:22 +0800
Subject: [PATCH v2 1/2] clk: fix clk_get on of_clk_get_by_name return check
In-Reply-To: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
References: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1342583543-20404-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 766e6a4 (clk: add DT clock binding support) plugs device
tree clk lookup of_clk_get_by_name into clk_get, and fall on non-DT
lookup clk_get_sys if DT lookup fails.

The return check on of_clk_get_by_name takes (clk != NULL) as a
successful DT lookup.  But it's not the case.  For any system that
does not define clk lookup in device tree, ERR_PTR(-ENOENT) will be
returned, and consequently, all the client drivers calling clk_get
in their probe functions will fail to probe with error code -ENOENT
returned.

Fix the issue by checking of_clk_get_by_name return with !IS_ERR(clk),
and update of_clk_get and of_clk_get_by_name for !CONFIG_OF build
correspondingly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
 drivers/clk/clkdev.c |    2 +-
 include/linux/clk.h  |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 20649b3..69085e0 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -157,7 +157,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 
 	if (dev) {
 		clk = of_clk_get_by_name(dev->of_node, con_id);
-		if (clk && __clk_get(clk))
+		if (!IS_ERR(clk) && __clk_get(clk))
 			return clk;
 	}
 
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 9e9b875..6283e2e 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_CLK_H
 #define __LINUX_CLK_H
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 
@@ -370,12 +371,12 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
-	return NULL;
+	return ERR_PTR(-ENOENT);
 }
 static inline struct clk *of_clk_get_by_name(struct device_node *np,
 					     const char *name)
 {
-	return NULL;
+	return ERR_PTR(-ENOENT);
 }
 #endif
 
-- 
1.7.4.1
