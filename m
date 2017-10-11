From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:26 +0800
Subject: [PATCH 10/11] Change mapping of kasan_zero_page int readonly
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-11-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Because the kasan_zero_page(which is used as the shadow
 region for some memory that KASan doesn't need to track.) won't be writen
 after kasan_init, so change the mapping of kasan_zero_page into readonly.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/mm/kasan_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 7cfdc39..c11826a 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -200,6 +200,7 @@ void __init kasan_init(void)
 {
 	struct memblock_region *reg;
 	u64 orig_ttbr0;
+	int i;
 
 	orig_ttbr0 = cpu_get_ttbr(0);
 
@@ -243,6 +244,17 @@ void __init kasan_init(void)
 	create_mapping((unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR),
 		(unsigned long)kasan_mem_to_shadow((void *)(PKMAP_BASE+PMD_SIZE)),
 		NUMA_NO_NODE);
+
+	/*
+	 * KAsan may reuse the contents of kasan_zero_pte directly, so we
+	 * should make sure that it maps the zero page read-only.
+	 */
+	for (i = 0; i < PTRS_PER_PTE; i++)
+                set_pte_at(&init_mm, KASAN_SHADOW_START + i*PAGE_SIZE,
+                        &kasan_zero_pte[i], pfn_pte(
+                                virt_to_pfn(kasan_zero_page),
+                                __pgprot(_L_PTE_DEFAULT | L_PTE_DIRTY | L_PTE_XN | L_PTE_RDONLY)));
+	memset(kasan_zero_page, 0, PAGE_SIZE);
 	cpu_set_ttbr0(orig_ttbr0);
 	flush_cache_all();
 	local_flush_bp_all();
-- 
2.9.0
