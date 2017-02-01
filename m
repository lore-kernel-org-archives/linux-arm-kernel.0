From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  1 Feb 2017 21:46:24 +0900
Subject: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170201124218.5823-1-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
Message-ID: <20170201124630.6016-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
are meant to be called around kexec_load() in order to protect
the memory allocated for crash dump kernel once after it's loaded.

The protection is implemented here by unmapping the region rather than
making it read-only.
To make the things work correctly, we also have to
- put the region in an isolated, page-level mapping initially, and
- move copying kexec's control_code_page to machine_kexec_prepare()

Note that page-level mapping is also required to allow for shrinking
the size of memory, through /sys/kernel/kexec_crash_size, by any number
of multiple pages.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 65 ++++++++++++++++++++++++++-------------
 arch/arm64/mm/mmu.c               | 35 +++++++++++++++++++++
 2 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bc96c8a7fc79..016f2dd693aa 100644
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
@@ -210,3 +208,28 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* Empty routine needed to avoid build errors. */
 }
+
+void arch_kexec_protect_crashkres(void)
+{
+	kexec_segment_flush(kexec_crash_image);
+
+	remove_pgd_mapping(&init_mm, __phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res));
+
+	flush_tlb_all();
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	/*
+	 * We don't have to make page-level mappings here because
+	 * the crash dump kernel memory is not allowed to be shrunk
+	 * once the kernel is loaded.
+	 */
+	create_pgd_mapping(&init_mm, crashk_res.start,
+			__phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res), PAGE_KERNEL,
+			debug_pagealloc_enabled());
+
+	flush_tlb_all();
+}
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9d3cea1db3b4..87861e62316a 100644
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
@@ -538,6 +540,24 @@ static void __init map_mem(pgd_t *pgd)
 		if (memblock_is_nomap(reg))
 			continue;
 
+#ifdef CONFIG_KEXEC_CORE
+		/*
+		 * While crash dump kernel memory is contained in a single
+		 * memblock for now, it should appear in an isolated mapping
+		 * so that we can independently unmap the region later.
+		 */
+		if (crashk_res.end &&
+		    (start <= crashk_res.start) &&
+		    ((crashk_res.end + 1) < end)) {
+			if (crashk_res.start != start)
+				__map_memblock(pgd, start, crashk_res.start);
+
+			if ((crashk_res.end + 1) < end)
+				__map_memblock(pgd, crashk_res.end + 1, end);
+
+			continue;
+		}
+#endif
 		__map_memblock(pgd, start, end);
 	}
 }
@@ -623,6 +643,21 @@ static void __init map_kernel(pgd_t *pgd)
 	kasan_copy_shadow(pgd);
 }
 
+#ifdef CONFIG_KEXEC_CORE
+static int __init map_crashkernel(void)
+{
+	/* page-level mapping only to allow for shrinking */
+	if (crashk_res.end)
+		create_pgd_mapping(&init_mm, crashk_res.start,
+				   __phys_to_virt(crashk_res.start),
+				   resource_size(&crashk_res), PAGE_KERNEL,
+				   true);
+
+	return 0;
+}
+subsys_initcall(map_crashkernel);
+#endif
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps and sets up the zero page.
-- 
2.11.0
