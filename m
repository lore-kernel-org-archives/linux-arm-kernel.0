From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:49 +0100
Subject: [PATCH v4 5/8] ARM: reset: allow kernelspace mappings to be flat
	mapped during reset
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314136012-20533-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, switch_mm_for_reboot only takes out a 1:1 mapping from 0x0
to TASK_SIZE during reboot. For situations where we actually want to
turn off the MMU (e.g. kexec, hibernate, CPU hotplug) we want to map
as much memory as possible using the identity mapping so that we
increase the chance of mapping our reset code.

This patch extends setup_mm_for_reboot to take a set of page tables as
an optional parameter. If this is NULL then the behaviour is as before,
otherwise the new tables are used to remap all of memory apart from a
small window around the kernel image (TASK_SIZE - _end). The page
immediately below swapper_pg_dir is reserved during boot and can be used
as a temporary stack whilst the flat mapping is in place.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/idmap.h    |    6 +++++-
 arch/arm/kernel/machine_kexec.c |    4 ++--
 arch/arm/kernel/process.c       |    2 +-
 arch/arm/mm/idmap.c             |   38 ++++++++++++++++++++++++++++----------
 arch/arm/mm/mmu.c               |   13 +++++++++++--
 5 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index fe7ea86..c2c0576 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -2,10 +2,14 @@
 #define _ARM_IDMAP_H
 
 #include <asm/page.h>
+#include <asm/sections.h>
 
 void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end);
 void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end);
 
-void setup_mm_for_reboot(char mode);
+/* Page reserved below swapper. */
+#define RESERVE_STACK_PAGE	(unsigned long)swapper_pg_dir
+
+void setup_mm_for_reboot(char mode, pgd_t *pgd);
 
 #endif	/* _ARM_IDMAP_H */
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index e59bbd4..dfc1784 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -16,7 +16,7 @@
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
-extern void setup_mm_for_reboot(char mode);
+extern void setup_mm_for_reboot(char mode, pgd_t *pgd);
 
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
@@ -113,7 +113,7 @@ void machine_kexec(struct kimage *image)
 		kexec_reinit();
 	local_irq_disable();
 	local_fiq_disable();
-	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
+	setup_mm_for_reboot(0, NULL); /* mode is not used, so just pass 0*/
 	flush_cache_all();
 	outer_flush_all();
 	outer_disable();
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 89fe6ee..84228ec 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -102,7 +102,7 @@ void arm_machine_restart(char mode, const char *cmd)
 	 * we may need it to insert some 1:1 mappings so that
 	 * soft boot works.
 	 */
-	setup_mm_for_reboot(mode);
+	setup_mm_for_reboot(mode, NULL);
 
 	/* Clean and invalidate caches */
 	flush_cache_all();
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index e99dc38..3d83ce4 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -79,17 +79,35 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
 #endif
 
 /*
- * In order to soft-boot, we need to insert a 1:1 mapping in place of
- * the user-mode pages.  This will then ensure that we have predictable
- * results when turning the mmu off
+ * In order to soft-boot, we need to insert a 1:1 mapping of memory.
+ * This will then ensure that we have predictable results when turning
+ * the mmu off.
  */
-void setup_mm_for_reboot(char mode)
+void setup_mm_for_reboot(char mode, pgd_t *pgd)
 {
-	/*
-	 * We need to access to user-mode page tables here. For kernel threads
-	 * we don't have any user-mode mappings so we use the context that we
-	 * "borrowed".
-	 */
-	identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE);
+	unsigned long kernel_end;
+
+	/* If we don't have a pgd, hijack the current task. */
+	if (pgd == NULL) {
+		pgd = current->active_mm->pgd;
+		identity_mapping_add(pgd, 0, TASK_SIZE);
+	} else {
+		identity_mapping_add(pgd, 0, TASK_SIZE);
+		/*
+		 * Extend the flat mapping into kernelspace.
+		 * We leave room for the kernel image and the reserved
+		 * page below swapper.
+		 */
+		kernel_end = ALIGN((unsigned long)_end, PMD_SIZE);
+		identity_mapping_add(pgd, kernel_end, 0);
+	}
+
+	/* Clean and invalidate L1. */
+	flush_cache_all();
+
+	/* Switch exclusively to kernel mappings. */
+	cpu_switch_mm(pgd, &init_mm);
+
+	/* Flush the TLB. */
 	local_flush_tlb_all();
 }
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 594d677..e664cbd 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -894,18 +894,27 @@ static inline void prepare_page_table(void)
  */
 void __init arm_mm_memblock_reserve(void)
 {
+	phys_addr_t swapper_pa = __pa(swapper_pg_dir);
+
 	/*
 	 * Reserve the page tables.  These are already in use,
 	 * and can only be in node 0.
 	 */
-	memblock_reserve(__pa(swapper_pg_dir), PTRS_PER_PGD * sizeof(pgd_t));
+	memblock_reserve(swapper_pa, PTRS_PER_PGD * sizeof(pgd_t));
 
 #ifdef CONFIG_SA1111
 	/*
 	 * Because of the SA1111 DMA bug, we want to preserve our
 	 * precious DMA-able memory...
 	 */
-	memblock_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
+	memblock_reserve(PHYS_OFFSET, swapper_pa - PHYS_OFFSET);
+#else
+	/*
+	 * Reserve the page immediately below swapper to use as a
+	 * temporary stack and a holding area for secondary CPUs when we
+	 * are kexec'd.
+	 */
+	memblock_reserve(swapper_pa - PAGE_SIZE, PAGE_SIZE);
 #endif
 }
 
-- 
1.7.0.4
