From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 15:27:55 +0100
Subject: dma_alloc_writecombine() and MAX_ORDER
In-Reply-To: <4DBAB41D.7030705@linuxtv.org>
References: <4DBAB41D.7030705@linuxtv.org>
Message-ID: <20110429142755.GS5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 02:50:37PM +0200, Michael Hunold wrote:
> Now I have a new panel with a higher resolution and more bits-per-pixel.
> I want to use double-buffering with DirectFB and so my framebuffer size
> exceeds 4Mb.

You could try this patch.  It steals the memory for the coherent and
writecombine memory at boot time, so MAX_ORDER no longer comes into the
problem.  You may need to define CONSISTENT_WC_SIZE and CONSISTENT_DMA_SIZE
appropriately to gain sufficient memory.  Note that the sum of those two
must be a multiple of 2MB, and individually must be a multiple of 1MB.

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c568da7..489c197 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -230,8 +230,7 @@ int dma_mmap_coherent(struct device *, struct vm_area_struct *,
 extern void *dma_alloc_writecombine(struct device *, size_t, dma_addr_t *,
 		gfp_t);
 
-#define dma_free_writecombine(dev,size,cpu_addr,handle) \
-	dma_free_coherent(dev,size,cpu_addr,handle)
+extern void dma_free_writecombine(struct device *, size_t, void *, dma_addr_t);
 
 int dma_mmap_writecombine(struct device *, struct vm_area_struct *,
 		void *, dma_addr_t, size_t);
diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index d2fedb5..3845215 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -29,6 +29,8 @@ struct map_desc {
 #define MT_MEMORY_NONCACHED	11
 #define MT_MEMORY_DTCM		12
 #define MT_MEMORY_ITCM		13
+#define MT_DMA_COHERENT		14
+#define MT_WC_COHERENT		15
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..fa54ecf 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -88,6 +88,13 @@
 #define CONSISTENT_END		(0xffe00000UL)
 #define CONSISTENT_BASE		(CONSISTENT_END - CONSISTENT_DMA_SIZE)
 
+#ifndef CONSISTENT_WC_SIZE
+#define CONSISTENT_WC_SIZE	SZ_2M
+#endif
+
+#define CONSISTENT_WC_END	CONSISTENT_BASE
+#define CONSISTENT_WC_BASE	(CONSISTENT_WC_END - CONSISTENT_WC_SIZE)
+
 #else /* CONFIG_MMU */
 
 /*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ccc303..240a9d3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -18,12 +18,16 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
+#include <linux/memblock.h>
 
 #include <asm/memory.h>
 #include <asm/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/sizes.h>
+#include <asm/mach/map.h>
+
+#include "mm.h"
 
 static u64 get_coherent_dma_mask(struct device *dev)
 {
@@ -115,93 +119,127 @@ static void __dma_free_buffer(struct page *page, size_t size)
 }
 
 #ifdef CONFIG_MMU
-/* Sanity check size */
-#if (CONSISTENT_DMA_SIZE % SZ_2M)
-#error "CONSISTENT_DMA_SIZE must be multiple of 2MiB"
+/* Sanity check sizes */
+#if CONSISTENT_DMA_SIZE % SECTION_SIZE
+#error "CONSISTENT_DMA_SIZE must be a multiple of the section size"
+#endif
+#if CONSISTENT_WC_SIZE % SECTION_SIZE
+#error "CONSISTENT_WC_SIZE must be a multiple of the section size"
+#endif
+#if ((CONSISTENT_DMA_SIZE + CONSISTENT_WC_SIZE) % SZ_2M)
+#error "Sum of CONSISTENT_DMA_SIZE and CONSISTENT_WC_SIZE must be multiple of 2MiB"
 #endif
 
-#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-#define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) - CONSISTENT_BASE) >> PGDIR_SHIFT)
-#define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)
+#include "vmregion.h"
 
-/*
- * These are the page tables (2MB each) covering uncached, DMA consistent allocations
- */
-static pte_t *consistent_pte[NUM_CONSISTENT_PTES];
+struct dma_coherent_area {
+	struct arm_vmregion_head vm;
+	unsigned long pfn;
+	unsigned int type;
+	const char *name;
+};
 
-#include "vmregion.h"
+static struct dma_coherent_area coherent_wc_head = {
+	.vm = {
+		.vm_start	= CONSISTENT_WC_BASE,
+		.vm_end		= CONSISTENT_WC_END,
+	},
+	.type = MT_WC_COHERENT,
+	.name = "WC ",
+};
 
-static struct arm_vmregion_head consistent_head = {
-	.vm_lock	= __SPIN_LOCK_UNLOCKED(&consistent_head.vm_lock),
-	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
-	.vm_start	= CONSISTENT_BASE,
-	.vm_end		= CONSISTENT_END,
+static struct dma_coherent_area coherent_dma_head = {
+	.vm = {
+		.vm_start	= CONSISTENT_BASE,
+		.vm_end		= CONSISTENT_END,
+	},
+	.type = MT_DMA_COHERENT,
+	.name = "DMA coherent ",
 };
 
-#ifdef CONFIG_HUGETLB_PAGE
-#error ARM Coherent DMA allocator does not (yet) support huge TLB
-#endif
+static struct dma_coherent_area *coherent_areas[2] __initdata =
+	{ &coherent_wc_head, &coherent_dma_head };
 
-/*
- * Initialise the consistent memory allocation.
- */
-static int __init consistent_init(void)
+static struct dma_coherent_area *coherent_map[2];
+#define coherent_wc_area coherent_map[0]
+#define coherent_dma_area coherent_map[1]
+
+void dma_coherent_reserve(void)
 {
-	int ret = 0;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i = 0;
-	u32 base = CONSISTENT_BASE;
+	phys_addr_t base, max_addr;
+	unsigned long size;
+	int can_share, i;
 
-	do {
-		pgd = pgd_offset(&init_mm, base);
+	if (arch_is_coherent())
+		return;
 
-		pud = pud_alloc(&init_mm, pgd, base);
-		if (!pud) {
-			printk(KERN_ERR "%s: no pud tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
+#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
+	/* ARMv6: only when DMA_MEM_BUFFERABLE is enabled */
+	can_share = cpu_architecture() >= CPU_ARCH_ARMv6;
+#else
+	/* ARMv7+: WC and DMA areas have the same properties, so can share */
+	can_share = cpu_architecture() >= CPU_ARCH_ARMv7;
+#endif
+	if (can_share) {
+		coherent_wc_head.name = "DMA coherent/WC ";
+		coherent_wc_head.vm.vm_end = coherent_dma_head.vm.vm_end;
+		coherent_dma_head.vm.vm_start = coherent_dma_head.vm.vm_end;
+		coherent_dma_area = coherent_wc_area = &coherent_wc_head;
+	} else {
+		memcpy(coherent_map, coherent_areas, sizeof(coherent_map));
+	}
 
-		pmd = pmd_alloc(&init_mm, pud, base);
-		if (!pmd) {
-			printk(KERN_ERR "%s: no pmd tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-		WARN_ON(!pmd_none(*pmd));
+	max_addr = MEMBLOCK_ALLOC_ANYWHERE;
+	if (ISA_DMA_THRESHOLD != 0xffffffffULL)
+		max_addr = ISA_DMA_THRESHOLD;
 
-		pte = pte_alloc_kernel(pmd, base);
-		if (!pte) {
-			printk(KERN_ERR "%s: no pte tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
+	for (i = 0; i < ARRAY_SIZE(coherent_areas); i++) {
+		struct dma_coherent_area *area = coherent_areas[i];
+
+		size = area->vm.vm_end - area->vm.vm_start;
+		if (!size)
+			continue;
 
-		consistent_pte[i++] = pte;
-		base += (1 << PGDIR_SHIFT);
-	} while (base < CONSISTENT_END);
+		spin_lock_init(&area->vm.vm_lock);
+		INIT_LIST_HEAD(&area->vm.vm_list);
 
-	return ret;
+		base = memblock_alloc_base(size, SZ_1M, max_addr);
+		memblock_free(base, size);
+		memblock_remove(base, size);
+
+		area->pfn = __phys_to_pfn(base);
+
+		pr_info("DMA: %luMiB %smemory allocated at 0x%08llx phys\n",
+			size / 1048576, area->name, (unsigned long long)base);
+	}
 }
 
-core_initcall(consistent_init);
+void __init dma_coherent_mapping(void)
+{
+	struct map_desc map[ARRAY_SIZE(coherent_areas)];
+	int nr;
 
-static void *
-__dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
+	for (nr = 0; nr < ARRAY_SIZE(map); nr++) {
+		struct dma_coherent_area *area = coherent_areas[nr];
+
+		map[nr].pfn = area->pfn;
+		map[nr].virtual = area->vm.vm_start;
+		map[nr].length = area->vm.vm_end - area->vm.vm_start;
+		map[nr].type = area->type;
+		if (map[nr].length == 0)
+			break;
+	}
+
+	iotable_init(map, nr);
+}
+
+static void *dma_alloc_area(size_t size, unsigned long *pfn, gfp_t gfp,
+	struct dma_coherent_area *area)
 {
 	struct arm_vmregion *c;
 	size_t align;
 	int bit;
 
-	if (!consistent_pte[0]) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
-		dump_stack();
-		return NULL;
-	}
-
 	/*
 	 * Align the virtual region allocation - maximum alignment is
 	 * a section size, minimum is a page size.  This helps reduce
@@ -216,45 +254,21 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 	/*
 	 * Allocate a virtual address in the consistent mapping region.
 	 */
-	c = arm_vmregion_alloc(&consistent_head, align, size,
+	c = arm_vmregion_alloc(&area->vm, align, size,
 			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
-	if (c) {
-		pte_t *pte;
-		int idx = CONSISTENT_PTE_INDEX(c->vm_start);
-		u32 off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);
-
-		pte = consistent_pte[idx] + off;
-		c->vm_pages = page;
-
-		do {
-			BUG_ON(!pte_none(*pte));
-
-			set_pte_ext(pte, mk_pte(page, prot), 0);
-			page++;
-			pte++;
-			off++;
-			if (off >= PTRS_PER_PTE) {
-				off = 0;
-				pte = consistent_pte[++idx];
-			}
-		} while (size -= PAGE_SIZE);
-
-		dsb();
+	if (!c)
+		return NULL;
 
-		return (void *)c->vm_start;
-	}
-	return NULL;
+	memset((void *)c->vm_start, 0, size);
+	*pfn = area->pfn + ((c->vm_start - area->vm.vm_start) >> PAGE_SHIFT);
+	return (void *)c->vm_start;
 }
 
-static void __dma_free_remap(void *cpu_addr, size_t size)
+static void dma_free_area(void *cpu_addr, size_t size, struct dma_coherent_area *area)
 {
 	struct arm_vmregion *c;
-	unsigned long addr;
-	pte_t *ptep;
-	int idx;
-	u32 off;
 
-	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
+	c = arm_vmregion_find_remove(&area->vm, (unsigned long)cpu_addr);
 	if (!c) {
 		printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
 		       __func__, cpu_addr);
@@ -269,61 +283,62 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 		size = c->vm_end - c->vm_start;
 	}
 
-	idx = CONSISTENT_PTE_INDEX(c->vm_start);
-	off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);
-	ptep = consistent_pte[idx] + off;
-	addr = c->vm_start;
-	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-
-		ptep++;
-		addr += PAGE_SIZE;
-		off++;
-		if (off >= PTRS_PER_PTE) {
-			off = 0;
-			ptep = consistent_pte[++idx];
-		}
+	arm_vmregion_free(&area->vm, c);
+}
 
-		if (pte_none(pte) || !pte_present(pte))
-			printk(KERN_CRIT "%s: bad page in kernel page table\n",
-			       __func__);
-	} while (size -= PAGE_SIZE);
+#define nommu() (0)
 
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
+#else	/* !CONFIG_MMU */
 
-	arm_vmregion_free(&consistent_head, c);
-}
+#define dma_alloc_area(size, pfn, gfp, area)	({ *(pfn) = 0; NULL })
+#define dma_free_area(addr, size, area)		do { } while (0)
 
-#else	/* !CONFIG_MMU */
+#define nommu()	(1)
+#define coherent_wc_area NULL
+#define coherent_dma_area NULL
 
-#define __dma_alloc_remap(page, size, gfp, prot)	page_address(page)
-#define __dma_free_remap(addr, size)			do { } while (0)
+void dma_coherent_reserve(void)
+{
+}
 
 #endif	/* CONFIG_MMU */
 
 static void *
 __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
-	    pgprot_t prot)
+	    struct dma_coherent_area *area)
 {
-	struct page *page;
-	void *addr;
+	unsigned long pfn;
+	void *ret;
 
 	*handle = ~0;
 	size = PAGE_ALIGN(size);
 
-	page = __dma_alloc_buffer(dev, size, gfp);
-	if (!page)
-		return NULL;
+	if (arch_is_coherent() || nommu()) {
+		struct page *page = __dma_alloc_buffer(dev, size, gfp);
+		if (!page)
+			return NULL;
+		pfn = page_to_pfn(page);
+		ret = page_address(page);
+	} else {
+		ret = dma_alloc_area(size, &pfn, gfp, area);
+	}
 
-	if (!arch_is_coherent())
-		addr = __dma_alloc_remap(page, size, gfp, prot);
-	else
-		addr = page_address(page);
+	if (ret)
+		*handle = pfn_to_dma(dev, pfn);
 
-	if (addr)
-		*handle = pfn_to_dma(dev, page_to_pfn(page));
+	return ret;
+}
+
+static void __dma_free(struct device *dev, size_t size, void *cpu_addr,
+	dma_addr_t handle, struct dma_coherent_area *area)
+{
+	size = PAGE_ALIGN(size);
 
-	return addr;
+	if (arch_is_coherent() || nommu()) {
+		__dma_free_buffer(pfn_to_page(dma_to_pfn(dev, handle)), size);
+	} else {
+		dma_free_area(cpu_addr, size, area);
+	}
 }
 
 /*
@@ -338,8 +353,7 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gf
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp,
-			   pgprot_dmacoherent(pgprot_kernel));
+	return __dma_alloc(dev, size, handle, gfp, coherent_dma_area);
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
@@ -350,13 +364,13 @@ EXPORT_SYMBOL(dma_alloc_coherent);
 void *
 dma_alloc_writecombine(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
 {
-	return __dma_alloc(dev, size, handle, gfp,
-			   pgprot_writecombine(pgprot_kernel));
+	return __dma_alloc(dev, size, handle, gfp, coherent_wc_area);
 }
 EXPORT_SYMBOL(dma_alloc_writecombine);
 
 static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
+		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		    struct dma_coherent_area *area)
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
@@ -365,7 +379,7 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
-	c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
+	c = arm_vmregion_find(&area->vm, (unsigned long)cpu_addr);
 	if (c) {
 		unsigned long off = vma->vm_pgoff;
 
@@ -388,7 +402,7 @@ int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 		      void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
-	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
+	return dma_mmap(dev, vma, cpu_addr, dma_addr, size, coherent_dma_area);
 }
 EXPORT_SYMBOL(dma_mmap_coherent);
 
@@ -396,7 +410,7 @@ int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
 			  void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
+	return dma_mmap(dev, vma, cpu_addr, dma_addr, size, coherent_wc_area);
 }
 EXPORT_SYMBOL(dma_mmap_writecombine);
 
@@ -411,14 +425,18 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
 		return;
 
-	size = PAGE_ALIGN(size);
+	__dma_free(dev, size, cpu_addr, handle, coherent_dma_area);
+}
+EXPORT_SYMBOL(dma_free_coherent);
 
-	if (!arch_is_coherent())
-		__dma_free_remap(cpu_addr, size);
+void dma_free_writecombine(struct device *dev, size_t size, void *cpu_addr,
+	dma_addr_t handle)
+{
+	WARN_ON(irqs_disabled());
 
-	__dma_free_buffer(pfn_to_page(dma_to_pfn(dev, handle)), size);
+	__dma_free(dev, size, cpu_addr, handle, coherent_wc_area);
 }
-EXPORT_SYMBOL(dma_free_coherent);
+EXPORT_SYMBOL(dma_free_writecombine);
 
 /*
  * Make an area consistent for devices.
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5164069..95c826c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -313,6 +313,7 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 #endif
 
 	arm_mm_memblock_reserve();
+	dma_coherent_reserve();
 
 	/* reserve any platform specific memblock areas */
 	if (mdesc->reserve)
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index d238410..e672882 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -30,3 +30,5 @@ extern void __flush_dcache_page(struct address_space *mapping, struct page *page
 
 void __init bootmem_init(void);
 void arm_mm_memblock_reserve(void);
+void dma_coherent_reserve(void);
+void dma_coherent_mapping(void);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e94888b..1fec2bf 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -275,6 +275,16 @@ static struct mem_type mem_types[] = {
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_DMA_COHERENT] = {
+		.prot_sect	= PMD_TYPE_SECT | PMD_SECT_AP_WRITE |
+				  PMD_SECT_S,
+		.domain		= DOMAIN_IO,
+	},
+	[MT_WC_COHERENT] = {
+		.prot_sect	= PMD_TYPE_SECT | PMD_SECT_AP_WRITE |
+				  PMD_SECT_S,
+		.domain		= DOMAIN_IO,
+	},
 };
 
 const struct mem_type *get_mem_type(unsigned int type)
@@ -355,6 +365,7 @@ static void __init build_mem_type_table(void)
 			mem_types[MT_DEVICE_NONSHARED].prot_sect |= PMD_SECT_XN;
 			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_XN;
 			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_XN;
+			mem_types[MT_DMA_COHERENT].prot_sect |= PMD_SECT_XN;
 		}
 		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
 			/*
@@ -459,13 +470,24 @@ static void __init build_mem_type_table(void)
 			/* Non-cacheable Normal is XCB = 001 */
 			mem_types[MT_MEMORY_NONCACHED].prot_sect |=
 				PMD_SECT_BUFFERED;
+			mem_types[MT_WC_COHERENT].prot_sect |=
+				PMD_SECT_BUFFERED;
+			mem_types[MT_DMA_COHERENT].prot_sect |=
+				PMD_SECT_BUFFERED;
 		} else {
 			/* For both ARMv6 and non-TEX-remapping ARMv7 */
 			mem_types[MT_MEMORY_NONCACHED].prot_sect |=
 				PMD_SECT_TEX(1);
+			mem_types[MT_WC_COHERENT].prot_sect |=
+				PMD_SECT_TEX(1);
+#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
+			mem_types[MT_DMA_COHERENT].prot_sect |=
+				PMD_SECT_TEX(1);
+#endif
 		}
 	} else {
 		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_BUFFERABLE;
+		mem_types[MT_WC_COHERENT].prot_sect |= PMD_SECT_BUFFERED;
 	}
 
 	for (i = 0; i < 16; i++) {
@@ -977,6 +999,8 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 		create_mapping(&map);
 	}
 
+	dma_coherent_mapping();
+
 	/*
 	 * Ask the machine support to map in the statically mapped devices.
 	 */
