From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Nov 2016 20:43:34 +0900
Subject: [PATCH 1/3] ARM: cache-uniphier: call kzalloc() after DT property
 parsing
In-Reply-To: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478259816-24965-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1478259816-24965-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allocate memory after DT property parsing that has more possibility
of failure.  This will decrease the number of bail-out points for
kfree().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mm/cache-uniphier.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index dfe97b4..58f2ddb 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -328,7 +328,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
 					unsigned int *cache_level)
 {
 	struct uniphier_cache_data *data;
-	u32 level, cache_size;
+	u32 level, line_size, nsets, cache_size;
 	struct device_node *next_np;
 	int ret = 0;
 
@@ -354,36 +354,34 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		return -EINVAL;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	if (of_property_read_u32(np, "cache-line-size", &data->line_size) ||
-	    !is_power_of_2(data->line_size)) {
+	if (of_property_read_u32(np, "cache-line-size", &line_size) |
+	    !is_power_of_2(line_size)) {
 		pr_err("L%d: cache-line-size is unspecified or invalid\n",
 		       *cache_level);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
-	if (of_property_read_u32(np, "cache-sets", &data->nsets) ||
-	    !is_power_of_2(data->nsets)) {
+	if (of_property_read_u32(np, "cache-sets", &nsets) ||
+	    !is_power_of_2(nsets)) {
 		pr_err("L%d: cache-sets is unspecified or invalid\n",
 		       *cache_level);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	if (of_property_read_u32(np, "cache-size", &cache_size) ||
-	    cache_size == 0 || cache_size % (data->nsets * data->line_size)) {
+	    cache_size == 0 || cache_size % (nsets * line_size)) {
 		pr_err("L%d: cache-size is unspecified or invalid\n",
 		       *cache_level);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
-	data->way_present_mask =
-		((u32)1 << cache_size / data->nsets / data->line_size) - 1;
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->line_size = line_size;
+	data->nsets = nsets;
+	data->way_present_mask = ((u32)1 << cache_size / nsets / line_size) - 1;
 
 	data->ctrl_base = of_iomap(np, 0);
 	if (!data->ctrl_base) {
-- 
1.9.1
