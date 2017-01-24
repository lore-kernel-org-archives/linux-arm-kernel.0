From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 17:49:59 +0900
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170124084638.3770-1-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
Message-ID: <20170124085004.3892-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To protect the memory reserved for crash dump kernel once after loaded,
arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
permissions of the corresponding kernel mappings.

We also have to
- put the region in an isolated mapping, and
- move copying kexec's control_code_page to machine_kexec_prepare()
so that the region will be completely read-only after loading.

Note that the region must reside in linear mapping and have corresponding
page structures in order to be potentially freed by shrinking it through
/sys/kernel/kexec_crash_size.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 68 +++++++++++++++++++++++++--------------
 arch/arm64/mm/mmu.c               | 34 ++++++++++++++++++++
 2 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bc96c8a7fc79..f7938fecf3ff 100644
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
 
@@ -159,32 +171,20 @@ void machine_kexec(struct kimage *kimage)
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
-	/* Flush the kimage list and its buffers. */
-	kexec_list_flush(kimage);
+	if (kimage != kexec_crash_image) {
+		/* Flush the kimage list and its buffers. */
+		kexec_list_flush(kimage);
 
-	/* Flush the new image if already in place. */
-	if (kimage->head & IND_DONE)
-		kexec_segment_flush(kimage);
+		/* Flush the new image if already in place. */
+		if (kimage->head & IND_DONE)
+			kexec_segment_flush(kimage);
+	}
 
 	pr_info("Bye!\n");
 
@@ -201,7 +201,7 @@ void machine_kexec(struct kimage *kimage)
 	 */
 
 	cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head,
-		kimage_start, 0);
+		kimage->start, 0);
 
 	BUG(); /* Should never get here. */
 }
@@ -210,3 +210,21 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* Empty routine needed to avoid build errors. */
 }
+
+void arch_kexec_protect_crashkres(void)
+{
+	kexec_segment_flush(kexec_crash_image);
+
+	create_mapping_late(crashk_res.start, __phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res), PAGE_KERNEL_INVALID);
+
+	flush_tlb_all();
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	create_mapping_late(crashk_res.start, __phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res), PAGE_KERNEL);
+
+	flush_tlb_all();
+}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9c7adcce8e4e..2d4a0b68a852 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -367,6 +368,39 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 	unsigned long kernel_start = __pa(_text);
 	unsigned long kernel_end = __pa(__init_begin);
 
+#ifdef CONFIG_KEXEC_CORE
+	/*
+	 * While crash dump kernel memory is contained in a single memblock
+	 * for now, it should appear in an isolated mapping so that we can
+	 * independently unmap the region later.
+	 */
+	if (crashk_res.end && crashk_res.start >= start &&
+	    crashk_res.end <= end) {
+		if (crashk_res.start != start)
+			__create_pgd_mapping(pgd, start, __phys_to_virt(start),
+					     crashk_res.start - start,
+					     PAGE_KERNEL,
+					     early_pgtable_alloc,
+					     debug_pagealloc_enabled());
+
+		/* before kexec_load(), the region can be read-writable. */
+		__create_pgd_mapping(pgd, crashk_res.start,
+				     __phys_to_virt(crashk_res.start),
+				     crashk_res.end - crashk_res.start + 1,
+				     PAGE_KERNEL, early_pgtable_alloc,
+				     debug_pagealloc_enabled());
+
+		if (crashk_res.end != end)
+			__create_pgd_mapping(pgd, crashk_res.end + 1,
+					     __phys_to_virt(crashk_res.end + 1),
+					     end - crashk_res.end - 1,
+					     PAGE_KERNEL,
+					     early_pgtable_alloc,
+					     debug_pagealloc_enabled());
+		return;
+	}
+#endif
+
 	/*
 	 * Take care not to create a writable alias for the
 	 * read-only text and rodata sections of the kernel image.
-- 
2.11.0
