From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  8 Aug 2015 21:11:39 +0900
Subject: [PATCH] ARM: Feroceon: use of_iomap() to map register base
Message-ID: <1439035899-1783-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sequence of of_address_to_resource() and ioremap() can be
replaced with of_iomap().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mm/cache-feroceon-l2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 097181e..5c1b7a7 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -368,7 +368,6 @@ int __init feroceon_of_init(void)
 	struct device_node *node;
 	void __iomem *base;
 	bool l2_wt_override = false;
-	struct resource res;
 
 #if defined(CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH)
 	l2_wt_override = true;
@@ -376,10 +375,7 @@ int __init feroceon_of_init(void)
 
 	node = of_find_matching_node(NULL, feroceon_ids);
 	if (node && of_device_is_compatible(node, "marvell,kirkwood-cache")) {
-		if (of_address_to_resource(node, 0, &res))
-			return -ENODEV;
-
-		base = ioremap(res.start, resource_size(&res));
+		base = of_iomap(node, 0);
 		if (!base)
 			return -ENOMEM;
 
-- 
1.9.1
