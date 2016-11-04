From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Nov 2016 20:43:36 +0900
Subject: [PATCH 3/3] ARM: cache-uniphier: clean up active way setup code
In-Reply-To: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1478259816-24965-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, the active way setup function is called with a fixed value zero
for the second argument only when enabling the outer-cache.
The code can be simpler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mm/cache-uniphier.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index c71ab7c..58ba2bd 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -71,8 +71,7 @@
  * @ctrl_base: virtual base address of control registers
  * @rev_base: virtual base address of revision registers
  * @op_base: virtual base address of operation registers
- * @way_present_mask: each bit specifies if the way is present
- * @way_locked_mask: each bit specifies if the way is locked
+ * @way_mask: each bit specifies if the way is present
  * @nsets: number of associativity sets
  * @line_size: line size in bytes
  * @range_op_max_size: max size that can be handled by a single range operation
@@ -83,8 +82,7 @@ struct uniphier_cache_data {
 	void __iomem *rev_base;
 	void __iomem *op_base;
 	void __iomem *way_ctrl_base;
-	u32 way_present_mask;
-	u32 way_locked_mask;
+	u32 way_mask;
 	u32 nsets;
 	u32 line_size;
 	u32 range_op_max_size;
@@ -234,17 +232,13 @@ static void __uniphier_cache_enable(struct uniphier_cache_data *data, bool on)
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
@@ -307,7 +301,7 @@ static void __init uniphier_cache_enable(void)
 
 	list_for_each_entry(data, &uniphier_cache_list, list) {
 		__uniphier_cache_enable(data, true);
-		__uniphier_cache_set_locked_ways(data, 0);
+		__uniphier_cache_set_active_ways(data);
 	}
 }
 
@@ -381,7 +375,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
 
 	data->line_size = line_size;
 	data->nsets = nsets;
-	data->way_present_mask = ((u32)1 << cache_size / nsets / line_size) - 1;
+	data->way_mask = GENMASK(cache_size / nsets / line_size - 1, 0);
 
 	data->ctrl_base = of_iomap(np, 0);
 	if (!data->ctrl_base) {
-- 
1.9.1
