From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 15 Sep 2010 11:40:14 +0800
Subject: [PATCH 3/3] arm/clkdev: Allow common struct clk usage
In-Reply-To: <1284522014.516876.675872472687.0.gpush@pororo>
Message-ID: <1284522014.517930.215380014193.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of small changes to allow the common struct clk infrastructure
on ARM. The common clock API provides clk_put, and we no longer need
mach/clkdev.h (as we don't need __clk_put anymore).

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/common/clkdev.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index e2b2bb6..d7dc1f8 100644
--- a/arch/arm/common/clkdev.c
+++ b/arch/arm/common/clkdev.c
@@ -21,7 +21,10 @@
 #include <linux/slab.h>
 
 #include <asm/clkdev.h>
+
+#ifndef CONFIG_USE_COMMON_STRUCT_CLK
 #include <mach/clkdev.h>
+#endif
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
@@ -87,14 +90,21 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get);
 
+#ifndef CONFIG_USE_COMMON_STRUCT_CLK
+/* For the common struct clk case, clk_put is provided by the kernel-wide
+ * API. */
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
 }
 EXPORT_SYMBOL(clk_put);
 
+#endif
+
 void clkdev_add(struct clk_lookup *cl)
 {
+	clk_common_init(cl->clk);
 	mutex_lock(&clocks_mutex);
 	list_add_tail(&cl->node, &clocks);
 	mutex_unlock(&clocks_mutex);
