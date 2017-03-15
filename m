From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 15 Mar 2017 18:59:36 +0900
Subject: [PATCH v33 07/14] arm64: hibernate: preserve kdump image around
 hibernation
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
Message-ID: <20170315095941.25119-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since arch_kexec_protect_crashkres() removes a mapping for crash dump
kernel image, the loaded data won't be preserved around hibernation.

In this patch, helper functions, kexec_prepare_suspend()/
kexec_post_resume(), are additionally called before/after hibernation so
that the relevant memory segments will be mapped again and preserved just
as the others are.

In addition, to minimize the size of hibernation image,
kexec_is_chraskres_nosave() is added to pfn_is_nosave() in order to
recoginize only the pages that hold loaded crash dump kernel image as
saveable. Hibernation excludes any pages that are marked as Reserved and
yet "nosave."

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/kexec.h    | 10 ++++++
 arch/arm64/kernel/hibernate.c     | 10 +++++-
 arch/arm64/kernel/machine_kexec.c | 73 ++++++++++++++++++++++++++++++++++++++-
 arch/arm64/mm/init.c              | 27 +++++++++++++++
 4 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 04744dc5fb61..b9b31fc781b9 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -43,6 +43,16 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	/* Empty routine needed to avoid build errors. */
 }
 
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_HIBERNATION)
+extern bool kexec_is_crashkres_nosave(unsigned long pfn);
+extern void kexec_prepare_suspend(void);
+extern void kexec_post_resume(void);
+#else
+static inline bool kexec_is_crashkres_nosave(unsigned long pfn) {return false; }
+static inline void kexec_prepare_suspend(void) {}
+static inline void kexec_post_resume(void) {}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 97a7384100f3..1e10fafa59bd 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -28,6 +28,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/irqflags.h>
+#include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
@@ -102,7 +103,8 @@ int pfn_is_nosave(unsigned long pfn)
 	unsigned long nosave_begin_pfn = sym_to_pfn(&__nosave_begin);
 	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
 
-	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
+	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn)) ||
+		kexec_is_crashkres_nosave(pfn);
 }
 
 void notrace save_processor_state(void)
@@ -286,6 +288,9 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+		/* make the crash dump kernel image visible/saveable */
+		kexec_prepare_suspend();
+
 		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
@@ -297,6 +302,9 @@ int swsusp_arch_suspend(void)
 		if (el2_reset_needed())
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 
+		/* make the crash dump kernel image protected again */
+		kexec_post_resume();
+
 		/*
 		 * Tell the hibernation core that we've just restored
 		 * the memory
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 02e4f929db3b..82f48db589cf 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/kexec.h>
+#include <linux/page-flags.h>
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
@@ -220,7 +221,6 @@ void arch_kexec_protect_crashkres(void)
 			kexec_crash_image->segment[i].memsz,
 			PAGE_KERNEL_INVALID, true);
 
-
 	flush_tlb_all();
 }
 
@@ -233,3 +233,74 @@ void arch_kexec_unprotect_crashkres(void)
 			__phys_to_virt(kexec_crash_image->segment[i].mem),
 			kexec_crash_image->segment[i].memsz, PAGE_KERNEL, true);
 }
+
+#ifdef CONFIG_HIBERNATION
+/*
+ * To preserve the crash dump kernel image, the relevant memory segments
+ * should be mapped again around the hibernation.
+ */
+void kexec_prepare_suspend(void)
+{
+	if (kexec_crash_image)
+		arch_kexec_unprotect_crashkres();
+}
+
+void kexec_post_resume(void)
+{
+	if (kexec_crash_image)
+		arch_kexec_protect_crashkres();
+}
+
+/*
+ * kexec_is_crashres_nosave
+ *
+ * Return true only if a page is part of reserved memory for crash dump kernel,
+ * but does not hold any data of loaded kernel image.
+ *
+ * Note that all the pages in crash dump kernel memory have been initially
+ * marked as Reserved in kexec_reserve_crashkres_pages().
+ *
+ * In hibernation, the pages which are Reserved and yet "nosave"
+ * are excluded from the hibernation iamge. kexec_is_crashkres_nosave()
+ * does this check for crash dump kernel and will reduce the total size
+ * of hibernation image.
+ */
+
+bool kexec_is_crashkres_nosave(unsigned long pfn)
+{
+	int i;
+	phys_addr_t addr;
+
+	/* in reserved memory? */
+	if (!crashk_res.end)
+		return false;
+
+	addr = __pfn_to_phys(pfn);
+	if ((addr < crashk_res.start) || (crashk_res.end < addr))
+		return false;
+
+	/* not part of loaded kernel image? */
+	if (!kexec_crash_image)
+		return true;
+
+	for (i = 0; i < kexec_crash_image->nr_segments; i++)
+		if (addr >= kexec_crash_image->segment[i].mem &&
+				addr < (kexec_crash_image->segment[i].mem +
+					kexec_crash_image->segment[i].memsz))
+			return false;
+
+	return true;
+}
+
+void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
+{
+	unsigned long addr;
+	struct page *page;
+
+	for (addr = begin; addr < end; addr += PAGE_SIZE) {
+		page = phys_to_page(addr);
+		ClearPageReserved(page);
+		free_reserved_page(page);
+	}
+}
+#endif /* CONFIG_HIBERNATION */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 09d19207362d..89ba3cd0fe44 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -134,10 +134,35 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
+
+static void __init kexec_reserve_crashkres_pages(void)
+{
+#ifdef CONFIG_HIBERNATION
+	phys_addr_t addr;
+	struct page *page;
+
+	if (!crashk_res.end)
+		return;
+
+	/*
+	 * To reduce the size of hibernation image, all the pages are
+	 * marked as Reserved initially.
+	 */
+	for (addr = crashk_res.start; addr < (crashk_res.end + 1);
+			addr += PAGE_SIZE) {
+		page = phys_to_page(addr);
+		SetPageReserved(page);
+	}
+#endif
+}
 #else
 static void __init reserve_crashkernel(void)
 {
 }
+
+static void __init kexec_reserve_crashkres_pages(void)
+{
+}
 #endif /* CONFIG_KEXEC_CORE */
 
 /*
@@ -517,6 +542,8 @@ void __init mem_init(void)
 	/* this will put all unused low memory onto the freelists */
 	free_all_bootmem();
 
+	kexec_reserve_crashkres_pages();
+
 	mem_init_print_info(NULL);
 
 #define MLK(b, t) b, t, ((t) - (b)) >> 10
-- 
2.11.1
