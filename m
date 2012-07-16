From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 16:46:01 -0500
Subject: [PATCH] clk: fix compile for OF && !COMMON_CLK
Message-ID: <1342475161-20402-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit 766e6a4ec602d0c107 (clk: add DT clock binding support),
compiling with OF && !COMMON_CLK is broken.

Reported-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Reported-by: Prashant Gaikwad <pgaikwad@nvidia.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/clk/clkdev.c |    2 +-
 include/linux/clk.h  |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 20649b3..8f87b0f 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -24,7 +24,7 @@
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index)
 {
 	struct of_phandle_args clkspec;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 8b70342..35f7492 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_CLK_H
 #define __LINUX_CLK_H
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 
@@ -313,19 +314,19 @@ int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
 struct device_node;
 struct of_phandle_args;
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 static inline struct clk *of_clk_get_by_name(struct device_node *np,
 					     const char *name)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 #endif
 
-- 
1.7.9.5
