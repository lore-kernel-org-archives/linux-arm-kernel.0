From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  8 Oct 2014 19:38:56 +0200
Subject: [RFC PATCH] arm64/efi: use stable virtual mappings for UEFI runtime
 services
Message-ID: <1412789936-4908-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow kexec under UEFI, we need to make sure that the
virtual mapping of the UEFI Runtime Services is chosen in such a
way that we can reuse it again after kexec. The reason for this is
that we can only install a virtual mapping once, which means we need
to choose wisely, i.e., the virtual mapping should be compatible with
any kind of kernel we choose to kexec next.

This patch chooses a mapping where all the UEFI memory regions are
rounded up to be a multiple of 64 KB in size (to be compatible with
64 KB granule kernels) and mapped adjacently into the lower, userland
half of the kernel virtual memory space starting at 0x4000_0000 (1 GB).

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Note that this patch is RFC quality; it may need to be split up, and the
declaration of __create_mapping() needs to be moved to a header file.
However, it should be sufficient to illustrate how we can use a virtual
mapping that is installed using SetVirtualAddressMap(), is stable across
kexec and is compatible with both 4 KB and 64 KB pagesize kernels.

I haven't tested this code under kexec myself, but I have confirmed that
the runtime services work as expected (rtc-efi and efivars). The comments
that Mark Salter and Will Deacon gave on the id mapping patch here

http://marc.info/?l=linux-arm-kernel&m=140681612407532&w=2

should apply equally to this patch: taking exceptions while the EFI pgd
is installed into TTBR0 appears to work correctly, but more testing is
needed.

 arch/arm64/include/asm/efi.h |  17 +++--
 arch/arm64/kernel/efi.c      | 163 +++++++++++++++++++++++++++++--------------
 arch/arm64/mm/mmu.c          |   2 +-
 3 files changed, 124 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index a34fd3b12e2b..38921c8592b5 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -12,23 +12,32 @@ extern void efi_idmap_init(void);
 #define efi_idmap_init()
 #endif
 
+void efi_load_rt_mapping(void);
+void efi_unload_rt_mapping(void);
+
 #define efi_call_virt(f, ...)						\
 ({									\
-	efi_##f##_t *__f = efi.systab->runtime->f;			\
+	efi_##f##_t *__f;						\
 	efi_status_t __s;						\
 									\
-	kernel_neon_begin();						\
+	kernel_neon_begin();	/* disables preemption */		\
+	efi_load_rt_mapping();						\
+	__f = efi.systab->runtime->f;					\
 	__s = __f(__VA_ARGS__);						\
+	efi_unload_rt_mapping();					\
 	kernel_neon_end();						\
 	__s;								\
 })
 
 #define __efi_call_virt(f, ...)						\
 ({									\
-	efi_##f##_t *__f = efi.systab->runtime->f;			\
+	efi_##f##_t *__f;						\
 									\
-	kernel_neon_begin();						\
+	kernel_neon_begin();	/* disables preemption */		\
+	efi_load_rt_mapping();						\
+	__f = efi.systab->runtime->f;					\
 	__f(__VA_ARGS__);						\
+	efi_unload_rt_mapping();					\
 	kernel_neon_end();						\
 })
 
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 95c49ebc660d..6b403263a58b 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -19,16 +19,21 @@
 #include <linux/of_fdt.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm_types.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
 
 #include <asm/cacheflush.h>
 #include <asm/efi.h>
 #include <asm/tlbflush.h>
+#include <asm/pgtable.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 
 struct efi_memory_map memmap;
 
-static efi_runtime_services_t *runtime;
-
 static u64 efi_system_table;
 
 static int uefi_debug __initdata;
@@ -320,46 +325,102 @@ void __init efi_init(void)
 	reserve_regions();
 }
 
+#define EFI_RT_VIRTUAL_BASE	0x40000000
+
+static pgd_t efi_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+
+static struct mm_struct efi_mm = {
+	.mm_rb			= RB_ROOT,
+	.pgd			= efi_pg_dir,
+	.mm_users		= ATOMIC_INIT(2),
+	.mm_count		= ATOMIC_INIT(1),
+	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
+	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
+	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
+	INIT_MM_CONTEXT(efi_mm)
+};
+
+static void efi_set_pgd(struct mm_struct *mm)
+{
+	cpu_switch_mm(mm->pgd, mm);
+	flush_tlb_all();
+	if (icache_is_aivivt())
+		__flush_icache_all();
+}
+
+void efi_load_rt_mapping(void)
+{
+	efi_set_pgd(&efi_mm);
+}
+
+void efi_unload_rt_mapping(void)
+{
+	efi_set_pgd(current->active_mm);
+}
+
+extern void __create_mapping(pgd_t *pgd, phys_addr_t phys, unsigned long virt,
+			     phys_addr_t size, int map_io);
+
+#define PAGE_SHIFT_64K		16
+#define PAGE_SIZE_64K		(1UL << PAGE_SHIFT_64K)
+#define PAGE_MASK_64K		(~(PAGE_SIZE_64K - 1))
+#define PFN_64K_UP(x)		(((x) + PAGE_SIZE_64K - 1) >> PAGE_SHIFT_64K)
+#define PFN_64K_DOWN(x)		((x) >> PAGE_SHIFT_64K)
+
+static void memrange_efi_to_64k(u64 *addr, u64 *npages)
+{
+	*npages = PFN_64K_UP(*addr + (*npages << EFI_PAGE_SHIFT)) -
+		  PFN_64K_DOWN(*addr);
+	*addr &= PAGE_MASK_64K;
+}
+
 void __init efi_idmap_init(void)
 {
+	u64 efi_virtual_base = EFI_RT_VIRTUAL_BASE;
+	efi_memory_desc_t *md;
+
 	if (!efi_enabled(EFI_BOOT))
 		return;
 
 	/* boot time idmap_pg_dir is incomplete, so fill in missing parts */
 	efi_setup_idmap();
-}
 
-static int __init remap_region(efi_memory_desc_t *md, void **new)
-{
-	u64 paddr, vaddr, npages, size;
+	/* populate efi_pg_dir early so we can use __create_mapping() */
+	for_each_efi_memory_desc(&memmap, md) {
+		u64 paddr, npages, size;
 
-	paddr = md->phys_addr;
-	npages = md->num_pages;
-	memrange_efi_to_native(&paddr, &npages);
-	size = npages << PAGE_SHIFT;
+		if (!(md->attribute & EFI_MEMORY_RUNTIME))
+			continue;
 
-	if (is_normal_ram(md))
-		vaddr = (__force u64)ioremap_cache(paddr, size);
-	else
-		vaddr = (__force u64)ioremap(paddr, size);
+		/*
+		 * Make the low mapping compatible with 64k pages: this allows
+		 * a 4k page size kernel to kexec a 64k page size kernel and
+		 * vice versa.
+		 */
+		paddr = md->phys_addr;
+		npages = md->num_pages;
+		memrange_efi_to_64k(&paddr, &npages);
+		size = npages << PAGE_SHIFT_64K;
 
-	if (!vaddr) {
-		pr_err("Unable to remap 0x%llx pages @ %p\n",
-		       npages, (void *)paddr);
-		return 0;
-	}
+		md->virt_addr = efi_virtual_base;
+		efi_virtual_base += size;
+
+		__create_mapping(&efi_pg_dir[pgd_index(md->virt_addr)], paddr,
+				 md->virt_addr, size, !is_normal_ram(md));
 
-	/* adjust for any rounding when EFI and system pagesize differs */
-	md->virt_addr = vaddr + (md->phys_addr - paddr);
+		md->virt_addr += md->phys_addr - paddr;
+	}
+}
 
+static void __init remap_region(efi_memory_desc_t *md, void **new)
+{
 	if (uefi_debug)
 		pr_info("  EFI remap 0x%012llx => %p\n",
 			md->phys_addr, (void *)md->virt_addr);
 
+	/* use the low virtual mapping for SetVirtualAddressMap */
 	memcpy(*new, md, memmap.desc_size);
 	*new += memmap.desc_size;
-
-	return 1;
 }
 
 /*
@@ -367,10 +428,11 @@ static int __init remap_region(efi_memory_desc_t *md, void **new)
  */
 static int __init arm64_enter_virtual_mode(void)
 {
+	efi_set_virtual_address_map_t *set_virtual_address_map;
 	efi_memory_desc_t *md;
 	phys_addr_t virtmap_phys;
 	void *virtmap, *virt_md;
-	efi_status_t status;
+	efi_status_t status = EFI_SUCCESS;
 	u64 mapsize;
 	int count = 0;
 	unsigned long flags;
@@ -408,36 +470,41 @@ static int __init arm64_enter_virtual_mode(void)
 	for_each_efi_memory_desc(&memmap, md) {
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (!remap_region(md, &virt_md))
-			goto err_unmap;
+		remap_region(md, &virt_md);
 		++count;
 	}
 
-	efi.systab = (__force void *)efi_lookup_mapped_addr(efi_system_table);
+	efi.systab = (__force void *)ioremap_cache(efi_system_table,
+						   sizeof(efi_system_table_t));
 	if (!efi.systab) {
-		/*
-		 * If we have no virtual mapping for the System Table at this
-		 * point, the memory map doesn't cover the physical offset where
-		 * it resides. This means the System Table will be inaccessible
-		 * to Runtime Services themselves once the virtual mapping is
-		 * installed.
-		 */
-		pr_err("Failed to remap EFI System Table -- buggy firmware?\n");
-		goto err_unmap;
+		pr_err("Failed to remap EFI System Table\n");
+		kfree(virtmap);
+		return -1;
 	}
 	set_bit(EFI_SYSTEM_TABLES, &efi.flags);
 
 	local_irq_save(flags);
 	cpu_switch_mm(idmap_pg_dir, &init_mm);
 
-	/* Call SetVirtualAddressMap with the physical address of the map */
-	runtime = efi.systab->runtime;
-	efi.set_virtual_address_map = runtime->set_virtual_address_map;
+	set_virtual_address_map = efi.systab->runtime->set_virtual_address_map;
+	if (set_virtual_address_map) {
+		/*
+		 * SetVirtualAddressMap() may only be called once, so let's
+		 * clear the function pointer to indicate that it must not be
+		 * called again after this call.
+		 */
+		efi.systab->runtime->set_virtual_address_map = NULL;
+
+		/*
+		 * Call SetVirtualAddressMap with the physical address
+		 * of the map
+		 */
+		status = set_virtual_address_map(count * memmap.desc_size,
+						 memmap.desc_size,
+						 memmap.desc_version,
+						 (efi_memory_desc_t *)virtmap_phys);
+	}
 
-	status = efi.set_virtual_address_map(count * memmap.desc_size,
-					     memmap.desc_size,
-					     memmap.desc_version,
-					     (efi_memory_desc_t *)virtmap_phys);
 	cpu_set_reserved_ttbr0();
 	flush_tlb_all();
 	local_irq_restore(flags);
@@ -453,21 +520,11 @@ static int __init arm64_enter_virtual_mode(void)
 	}
 
 	/* Set up runtime services function pointers */
-	runtime = efi.systab->runtime;
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 
 	efi.runtime_version = efi.systab->hdr.revision;
 
 	return 0;
-
-err_unmap:
-	/* unmap all mappings that succeeded: there are 'count' of those */
-	for (virt_md = virtmap; count--; virt_md += memmap.desc_size) {
-		md = virt_md;
-		iounmap((__force void __iomem *)md->virt_addr);
-	}
-	kfree(virtmap);
-	return -1;
 }
 early_initcall(arm64_enter_virtual_mode);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6894ef3e6234..8ecf2264334e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -249,7 +249,7 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
  * Create the page directory entries and any necessary page tables for the
  * mapping specified by 'md'.
  */
-static void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
+void __init __create_mapping(pgd_t *pgd, phys_addr_t phys,
 				    unsigned long virt, phys_addr_t size,
 				    int map_io)
 {
-- 
1.8.3.2
