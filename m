From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 25 Mar 2013 13:11:13 +0900
Subject: [RFC PATCH 5/6] ARM,
 mm: change meaning of max_low_pfn to maximum pfn for nobootmem
In-Reply-To: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1364184674-13798-6-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nobootmem use max_low_pfn for computing boundary in free_all_bootmem()
So we need proper value to max_low_pfn.

But, there is some difficulty related to max_low_pfn. max_low_pfn is used
for two meanings in various architectures. One is for number of pages
in lowmem and the other is for maximum lowmem pfn. Now, in ARM, it is used
as number of pages in lowmem. You can get more information in below link.
http://lwn.net/Articles/543408/
http://lwn.net/Articles/543424/

As I investigated, architectures which use max_low_pfn as maximum pfn are
more than others, so to change meaning of max_low_pfn to maximum pfn
is preferable solution to me. This patch change max_low_pfn as maximum
lowmem pfn in ARM. In addition, min_low_pfn, max_pfn is assigned according
to this criteria.

There is no real user for max_low_pfn except block/blk-setting.c and
blk-setting.c assume that max_low_pfn is maximum lowmem pfn,
so this patch may not harm anything.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 049414a..873f4ca 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -423,12 +423,10 @@ void __init bootmem_init(void)
 	 * This doesn't seem to be used by the Linux memory manager any
 	 * more, but is used by ll_rw_block.  If we can get rid of it, we
 	 * also get rid of some of the stuff above as well.
-	 *
-	 * Note: max_low_pfn and max_pfn reflect the number of _pages_ in
-	 * the system, not the maximum PFN.
 	 */
-	max_low_pfn = max_low - PHYS_PFN_OFFSET;
-	max_pfn = max_high - PHYS_PFN_OFFSET;
+	min_low_pfn = min;
+	max_low_pfn = max_low;
+	max_pfn = max_high;
 }
 
 static inline int free_area(unsigned long pfn, unsigned long end, char *s)
@@ -544,7 +542,7 @@ static void __init free_unused_memmap(struct meminfo *mi)
 static void __init free_highpages(void)
 {
 #ifdef CONFIG_HIGHMEM
-	unsigned long max_low = max_low_pfn + PHYS_PFN_OFFSET;
+	unsigned long max_low = max_low_pfn;
 	struct memblock_region *mem, *res;
 
 	/* set highmem page free */
-- 
1.7.9.5
