From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 15 Mar 2017 18:59:35 +0900
Subject: [PATCH v33 06/14] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
Message-ID: <20170315095941.25119-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
are meant to be called by kexec_load() in order to protect the memory
allocated for crash dump kernel once the image is loaded.

The protection is implemented by unmapping the relevant segments in crash
dump kernel memory, rather than making it read-only as other archs do,
to prevent any corruption due to potential cache alias (with different
attributes) problem.

Page-level mappings are consistently used here so that we can change
the attributes of segments in page granularity as well as shrink the region
also in page granularity through /sys/kernel/kexec_crash_size and putting
the freed memory back to buddy system.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 35 ++++++++++++---
 arch/arm64/mm/mmu.c               | 90 ++++++++++++++++++++-------------------
 2 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bc96c8a7fc79..02e4f929db3b 100644
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
@@ -64,8 +63,6 @@ void machine_kexec_cleanup(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kimage_start = kimage->start;
-
 	kexec_image_info(kimage);
 
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
@@ -183,7 +180,7 @@ void machine_kexec(struct kimage *kimage)
 	kexec_list_flush(kimage);
 
 	/* Flush the new image if already in place. */
-	if (kimage->head & IND_DONE)
+	if ((kimage != kexec_crash_image) && (kimage->head & IND_DONE))
 		kexec_segment_flush(kimage);
 
 	pr_info("Bye!\n");
@@ -201,7 +198,7 @@ void machine_kexec(struct kimage *kimage)
 	 */
 
 	cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head,
-		kimage_start, 0);
+		kimage->start, 0);
 
 	BUG(); /* Should never get here. */
 }
@@ -210,3 +207,29 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* Empty routine needed to avoid build errors. */
 }
+
+void arch_kexec_protect_crashkres(void)
+{
+	int i;
+
+	kexec_segment_flush(kexec_crash_image);
+
+	for (i = 0; i < kexec_crash_image->nr_segments; i++)
+		create_pgd_mapping(&init_mm, kexec_crash_image->segment[i].mem,
+			__phys_to_virt(kexec_crash_image->segment[i].mem),
+			kexec_crash_image->segment[i].memsz,
+			PAGE_KERNEL_INVALID, true);
+
+
+	flush_tlb_all();
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	int i;
+
+	for (i = 0; i < kexec_crash_image->nr_segments; i++)
+		create_pgd_mapping(&init_mm, kexec_crash_image->segment[i].mem,
+			__phys_to_virt(kexec_crash_image->segment[i].mem),
+			kexec_crash_image->segment[i].memsz, PAGE_KERNEL, true);
+}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cb359a3927ef..51aca31cd9b7 100644
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
@@ -337,56 +339,31 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
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
 	phys_addr_t kernel_start = __pa_symbol(_text);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
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
@@ -398,8 +375,33 @@ static void __init map_mem(pgd_t *pgd)
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
+	 * User page-level mappings here so that we can shrink the region
+	 * in page granularity and put back unused memory to buddy system
+	 * through /sys/kernel/kexec_crash_size interface.
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
