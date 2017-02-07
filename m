From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  7 Feb 2017 17:08:58 +0900
Subject: [PATCH v32 06/13] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
Message-ID: <20170207080904.5974-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
are meant to be called by kexec_load() in order to protect the memory
allocated for crash dump kernel once it's loaded.

Here, the protection is implemented by unmapping the relevant range
of memory, rather than making it read-only, to prevent any corruption
due to potential cache alias (with different attributes) problem.

To make the things work correctly, we have to
- use page-level mappings entirely
- have the mappings isolated from the other normal memory
- move copying kexec's control_code_page to machine_kexec_prepare()

Note that page-level mappings are required to allow shrinking the region,
through /sys/kernel/kexec_crash_size, to the size of any number of pages
and putting the freed memory back to buddy system.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 69 +++++++++++++++++++++---------
 arch/arm64/mm/mmu.c               | 89 ++++++++++++++++++++-------------------
 2 files changed, 93 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bc96c8a7fc79..36b569d7fb62 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -14,6 +14,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/mmu.h>
 #include <asm/mmu_context.h>
 
 #include "cpu-reset.h"
@@ -22,8 +23,6 @@
 extern const unsigned char arm64_relocate_new_kernel[];
 extern const unsigned long arm64_relocate_new_kernel_size;
 
-static unsigned long kimage_start;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -64,7 +63,7 @@ void machine_kexec_cleanup(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kimage_start = kimage->start;
+	void *reboot_code_buffer;
 
 	kexec_image_info(kimage);
 
@@ -73,6 +72,21 @@ int machine_kexec_prepare(struct kimage *kimage)
 		return -EBUSY;
 	}
 
+	reboot_code_buffer =
+			phys_to_virt(page_to_phys(kimage->control_code_page));
+
+	/*
+	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
+	 * after the kernel is shut down.
+	 */
+	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
+		arm64_relocate_new_kernel_size);
+
+	/* Flush the reboot_code_buffer in preparation for its execution. */
+	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+	flush_icache_range((uintptr_t)reboot_code_buffer,
+		arm64_relocate_new_kernel_size);
+
 	return 0;
 }
 
@@ -143,7 +157,6 @@ static void kexec_segment_flush(const struct kimage *kimage)
 void machine_kexec(struct kimage *kimage)
 {
 	phys_addr_t reboot_code_buffer_phys;
-	void *reboot_code_buffer;
 
 	/*
 	 * New cpus may have become stuck_in_kernel after we loaded the image.
@@ -151,7 +164,6 @@ void machine_kexec(struct kimage *kimage)
 	BUG_ON(cpus_are_stuck_in_kernel() || (num_online_cpus() > 1));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
-	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
 
 	kexec_image_info(kimage);
 
@@ -159,31 +171,17 @@ void machine_kexec(struct kimage *kimage)
 		kimage->control_code_page);
 	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
 		&reboot_code_buffer_phys);
-	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
-		reboot_code_buffer);
 	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
 		arm64_relocate_new_kernel);
 	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
 		__func__, __LINE__, arm64_relocate_new_kernel_size,
 		arm64_relocate_new_kernel_size);
 
-	/*
-	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
-	 * after the kernel is shut down.
-	 */
-	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
-		arm64_relocate_new_kernel_size);
-
-	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
-	flush_icache_range((uintptr_t)reboot_code_buffer,
-		arm64_relocate_new_kernel_size);
-
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);
 
 	/* Flush the new image if already in place. */
-	if (kimage->head & IND_DONE)
+	if ((kimage != kexec_crash_image) && (kimage->head & IND_DONE))
 		kexec_segment_flush(kimage);
 
 	pr_info("Bye!\n");
@@ -201,7 +199,7 @@ void machine_kexec(struct kimage *kimage)
 	 */
 
 	cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head,
-		kimage_start, 0);
+		kimage->start, 0);
 
 	BUG(); /* Should never get here. */
 }
@@ -210,3 +208,32 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* Empty routine needed to avoid build errors. */
 }
+
+void arch_kexec_protect_crashkres(void)
+{
+	kexec_segment_flush(kexec_crash_image);
+
+	/*
+	 * Page_mappings_only is true as it is required to ensure that
+	 * a section mapping will not be created over an existing
+	 * directory entry.
+	 */
+	create_pgd_mapping(&init_mm, crashk_res.start,
+			__phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res), PAGE_KERNEL_INVALID, true);
+
+	flush_tlb_all();
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	/*
+	 * Since /sys/kernel/kexec_crash_size interface enables us to
+	 * shrink the region or entirely free it later, we consistently
+	 * use page-level mappings here so unused memory can be reclaimed
+	 * and put back to buddy system.
+	 */
+	create_pgd_mapping(&init_mm, crashk_res.start,
+			__phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res), PAGE_KERNEL, true);
+}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3c674831f856..7ade55fa96b6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -363,56 +365,31 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 			     NULL, debug_pagealloc_enabled());
 }
 
-static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
+static void __init __map_memblock(pgd_t *pgd, phys_addr_t start,
+				  phys_addr_t end, pgprot_t prot,
+				  bool page_mappings_only)
+{
+	__create_pgd_mapping(pgd, start, __phys_to_virt(start), end - start,
+			     prot, early_pgtable_alloc,
+			     page_mappings_only);
+}
+
+static void __init map_mem(pgd_t *pgd)
 {
 	unsigned long kernel_start = __pa(_text);
 	unsigned long kernel_end = __pa(__init_begin);
+	struct memblock_region *reg;
 
 	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
+	 * Temporarily marked as NOMAP to skip mapping in the next for-loop
 	 */
+	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
-	/* No overlap with the kernel text/rodata */
-	if (end < kernel_start || start >= kernel_end) {
-		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
-				     end - start, PAGE_KERNEL,
-				     early_pgtable_alloc,
-				     debug_pagealloc_enabled());
-		return;
-	}
-
-	/*
-	 * This block overlaps the kernel text/rodata mappings.
-	 * Map the portion(s) which don't overlap.
-	 */
-	if (start < kernel_start)
-		__create_pgd_mapping(pgd, start,
-				     __phys_to_virt(start),
-				     kernel_start - start, PAGE_KERNEL,
-				     early_pgtable_alloc,
-				     debug_pagealloc_enabled());
-	if (kernel_end < end)
-		__create_pgd_mapping(pgd, kernel_end,
-				     __phys_to_virt(kernel_end),
-				     end - kernel_end, PAGE_KERNEL,
-				     early_pgtable_alloc,
-				     debug_pagealloc_enabled());
-
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval as
-	 * read-only/non-executable. This makes the contents of the
-	 * region accessible to subsystems such as hibernate, but
-	 * protects it from inadvertent modification or execution.
-	 */
-	__create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
-			     kernel_end - kernel_start, PAGE_KERNEL_RO,
-			     early_pgtable_alloc, debug_pagealloc_enabled());
-}
-
-static void __init map_mem(pgd_t *pgd)
-{
-	struct memblock_region *reg;
+#ifdef CONFIG_KEXEC_CORE
+	if (crashk_res.end)
+		memblock_mark_nomap(crashk_res.start,
+				    resource_size(&crashk_res));
+#endif
 
 	/* map all the memory banks */
 	for_each_memblock(memory, reg) {
@@ -424,8 +401,32 @@ static void __init map_mem(pgd_t *pgd)
 		if (memblock_is_nomap(reg))
 			continue;
 
-		__map_memblock(pgd, start, end);
+		__map_memblock(pgd, start, end,
+			       PAGE_KERNEL, debug_pagealloc_enabled());
+	}
+
+	/*
+	 * Map the linear alias of the [_text, __init_begin) interval as
+	 * read-only/non-executable. This makes the contents of the
+	 * region accessible to subsystems such as hibernate, but
+	 * protects it from inadvertent modification or execution.
+	 */
+	__map_memblock(pgd, kernel_start, kernel_end,
+		       PAGE_KERNEL_RO, debug_pagealloc_enabled());
+	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
+
+#ifdef CONFIG_KEXEC_CORE
+	/*
+	 * 'Page mappings only' allows freeing a portion of the region
+	 * and putting it back to buddy system when it gets shrunk later.
+	 */
+	if (crashk_res.end) {
+		__map_memblock(pgd, crashk_res.start, crashk_res.end + 1,
+			       PAGE_KERNEL, true);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
 	}
+#endif
 }
 
 void mark_rodata_ro(void)
-- 
2.11.1
