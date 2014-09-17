From: houpengyang@huawei.com (Hou Pengyang)
Date: Wed, 17 Sep 2014 02:03:18 +0000
Subject: [RFC] ARM: support 1g hugepage
Message-ID: <1410919398-65526-1-git-send-email-houpengyang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    ARMv7 supports Gigabyte page table entry for mapping 1GB hugepage,
    this patch allow kernel supports it. When the feature is enabled,
    you can map the 1G hugepage by means of hugetlbfs.

    You should reserve 1G hugepage at boot parameter by using
    "hugepage_1g_phys=XXX", kernel would reserve 1G physical region
    from address hugepage_1g_phys. Don't forget to use "hugepagesz=1G
    hugepages=1" to register the above region.

    For 32-bit system, considering alignment, only 0x40000000 (virtual
    address) can be used to map the 1G hugepage, however if the program
    is compiled and linked dynamically, virtual space 0x40000000-0x8000000
    would be splitted by ld-2.*.so, the dynamic linker. so your program
    should be compiled and linked staticaly.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 arch/arm/Kconfig            |  7 +++++++
 arch/arm/include/asm/page.h |  6 ++++++
 arch/arm/mm/hugetlbpage.c   | 21 +++++++++++++++++++++
 arch/arm/mm/init.c          | 17 +++++++++++++++++
 fs/hugetlbfs/inode.c        |  7 +++++++
 mm/hugetlb.c                | 10 ++++++++++
 6 files changed, 68 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 290f02ee..7381bdc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1752,6 +1752,13 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARCH_SUPPORTS_1G_HUGEPAGE
+	bool "1G hugepage support"
+	depends on HUGETLBFS && VMSPLIT_3G && HIGHMEM
+	help
+	  ARMv7 supports 1G hugepage in addtion to 2M hugepage, this option 
+	  allows making use of 1G hugepage by means of hugetlbfs.
+
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0e..8daa3c2 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -152,6 +152,12 @@ extern void copy_page(void *to, const void *from);
 #include <asm/pgtable-2level-types.h>
 #endif
 
+#ifdef CONFIG_ARCH_SUPPORTS_1G_HUGEPAGE
+#define HUGE_MAX_HSTATE 2
+#else
+#define HUGE_MAX_HSTATE 1
+#endif
+
 #endif /* CONFIG_MMU */
 
 typedef struct page *pgtable_t;
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index 66781bf..9662605 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -44,7 +44,11 @@ struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 
 int pud_huge(pud_t pud)
 {
+#ifdef CONFIG_ARCH_SUPPORTS_1G_HUGEPAGE
+	return pud_val(pud) && !(pud_val(pud) & PMD_TABLE_BIT); 
+#else
 	return 0;
+#endif
 }
 
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
@@ -56,3 +60,20 @@ int pmd_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
 }
+
+static __init int setup_hugepagesz(char *opt)
+{
+	unsigned long ps = memparse(opt,&opt);
+	if (ps == PMD_SIZE) {
+		hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
+	} else if (ps == PGDIR_SIZE) {
+		hugetlb_add_hstate(PGDIR_SHIFT - PAGE_SHIFT);
+	} else {
+		printk(KERN_ERR "hugepagesz: Unsupported page size %lu M\n",
+			ps >> 20);
+		return 0;
+	}
+	return 1;
+}
+__setup("hugepagesz=",setup_hugepagesz);
+
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 659c75d..9e1b85e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -48,6 +48,19 @@ unsigned long __init __clear_cr(unsigned long mask)
 static phys_addr_t phys_initrd_start __initdata = 0;
 static unsigned long phys_initrd_size __initdata = 0;
 
+#ifdef CONFIG_ARCH_SUPPORTS_1G_HUGEPAGE
+phys_addr_t hugepage_1g_phys = 0;
+
+EXPORT_SYMBOL(hugepage_1g_phys);
+
+static int __init reserve_hugepage_1g(char *opt)
+{
+	hugepage_1g_phys = memparse(opt,&opt);
+	return 0;
+}
+early_param("hugepage_1g_phys",reserve_hugepage_1g);
+#endif
+
 static int __init early_initrd(char *p)
 {
 	phys_addr_t start;
@@ -312,6 +325,10 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 
 	arm_mm_memblock_reserve();
 
+#ifdef CONFIG_ARCH_SUPPORTS_1G_HUGEPAGE
+	memblock_reserve(hugepage_1g_phys,0x40000000);
+#endif
+
 	/* reserve any platform specific memblock areas */
 	if (mdesc->reserve)
 		mdesc->reserve();
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1e2872b..9b7d3d7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -179,7 +179,14 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = TASK_SIZE;
+#ifdef CONFIG_ARCH_SUPPORTS_1G_HUGEPAGE
+	if (h->order == 18)
+		info.align_mask = 0;
+	else
+		info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+#else
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+#endif
 	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7a0a73d..25931a6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1501,14 +1501,24 @@ static void __init gather_bootmem_prealloc(void)
 	}
 }
 
+extern phys_addr_t hugepage_1g_phys;
+
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+#ifdef CONFIG_ARCH_SUPPORTS_1G_HUGEPAGE
+			struct huge_bootmem_page *m;
+			m = alloc_bootmem(sizeof(struct huge_bootmem_page));
+			m->phys = hugepage_1g_phys;
+			list_add(&m->list,&huge_boot_pages);
+			m->hstate = h;
+#else
 			if (!alloc_bootmem_huge_page(h))
 				break;
+#endif
 		} else if (!alloc_fresh_huge_page(h,
 					 &node_states[N_MEMORY]))
 			break;
-- 
1.8.3.4
