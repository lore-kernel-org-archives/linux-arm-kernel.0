From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 25 Mar 2013 13:11:12 +0900
Subject: [RFC PATCH 4/6] ARM,
 mm: don't do arm_bootmem_init() if CONFIG_NO_BOOTMEM
In-Reply-To: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1364184674-13798-5-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_bootmem_init() initialize a bitmap for bootmem and
it is not needed for CONFIG_NO_BOOTMEM.
So skip it when CONFIG_NO_BOOTMEM.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ad722f1..049414a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -149,6 +149,12 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
 }
 
+#ifdef CONFIG_NO_BOOTMEM
+static inline void __init arm_bootmem_init(unsigned long start_pfn,
+	unsigned long end_pfn)
+{
+}
+#else
 static void __init arm_bootmem_init(unsigned long start_pfn,
 	unsigned long end_pfn)
 {
@@ -169,7 +175,6 @@ static void __init arm_bootmem_init(unsigned long start_pfn,
 	 * Initialise the bootmem allocator, handing the
 	 * memory banks over to bootmem.
 	 */
-	node_set_online(0);
 	pgdat = NODE_DATA(0);
 	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
 
@@ -200,6 +205,7 @@ static void __init arm_bootmem_init(unsigned long start_pfn,
 			        (end - start) << PAGE_SHIFT, BOOTMEM_DEFAULT);
 	}
 }
+#endif
 
 #ifdef CONFIG_ZONE_DMA
 
@@ -392,6 +398,7 @@ void __init bootmem_init(void)
 
 	find_limits(&min, &max_low, &max_high);
 
+	node_set_online(0);
 	arm_bootmem_init(min, max_low);
 
 	/*
-- 
1.7.9.5
