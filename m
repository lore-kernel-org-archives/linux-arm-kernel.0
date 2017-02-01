From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  1 Feb 2017 22:30:09 +0900
Subject: [PATCH 2/2] ARM: cache-uniphier: clean up active way setup code
Message-ID: <1485955809-5122-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, the active way setup function is called with a fixed value zero
for the second argument.  The code can be simpler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 4.10-rc1


 arch/arm/mm/cache-uniphier.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index dfe97b4..f57b080 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt)		"uniphier: " fmt
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/log2.h>
@@ -71,8 +72,7 @@
  * @ctrl_base: virtual base address of control registers
  * @rev_base: virtual base address of revision registers
  * @op_base: virtual base address of operation registers
- * @way_present_mask: each bit specifies if the way is present
- * @way_locked_mask: each bit specifies if the way is locked
+ * @way_mask: each bit specifies if the way is present
  * @nsets: number of associativity sets
  * @line_size: line size in bytes
  * @range_op_max_size: max size that can be handled by a single range operation
@@ -83,8 +83,7 @@ struct uniphier_cache_data {
 	void __iomem *rev_base;
 	void __iomem *op_base;
 	void __iomem *way_ctrl_base;
-	u32 way_present_mask;
-	u32 way_locked_mask;
+	u32 way_mask;
 	u32 nsets;
 	u32 line_size;
 	u32 range_op_max_size;
@@ -234,17 +233,13 @@ static void __uniphier_cache_enable(struct uniphier_cache_data *data, bool on)
 	writel_relaxed(val, data->ctrl_base + UNIPHIER_SSCC);
 }
 
-static void __init __uniphier_cache_set_locked_ways(
-					struct uniphier_cache_data *data,
-					u32 way_mask)
+static void __init __uniphier_cache_set_active_ways(
+					struct uniphier_cache_data *data)
 {
 	unsigned int cpu;
 
-	data->way_locked_mask = way_mask & data->way_present_mask;
-
 	for_each_possible_cpu(cpu)
-		writel_relaxed(~data->way_locked_mask & data->way_present_mask,
-			       data->way_ctrl_base + 4 * cpu);
+		writel_relaxed(data->way_mask, data->way_ctrl_base + 4 * cpu);
 }
 
 static void uniphier_cache_maint_range(unsigned long start, unsigned long end,
@@ -307,7 +302,7 @@ static void __init uniphier_cache_enable(void)
 
 	list_for_each_entry(data, &uniphier_cache_list, list) {
 		__uniphier_cache_enable(data, true);
-		__uniphier_cache_set_locked_ways(data, 0);
+		__uniphier_cache_set_active_ways(data);
 	}
 }
 
@@ -382,8 +377,8 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		goto err;
 	}
 
-	data->way_present_mask =
-		((u32)1 << cache_size / data->nsets / data->line_size) - 1;
+	data->way_mask = GENMASK(cache_size / data->nsets / data->line_size - 1,
+				 0);
 
 	data->ctrl_base = of_iomap(np, 0);
 	if (!data->ctrl_base) {
-- 
2.7.4
