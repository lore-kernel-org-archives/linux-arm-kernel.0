From: will.deacon@arm.com (Will Deacon)
Date: Thu,  9 Jun 2011 16:58:58 +0100
Subject: [PATCH v2 06/10] ARM: reset: allow kernelspace mappings to be flat
	mapped during reset
In-Reply-To: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
References: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307635142-11312-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, switch_mm_for_reboot only takes out a 1:1 mapping from 0x0
to TASK_SIZE during reboot. For situations where we actually want to
turn off the MMU (e.g. kexec, hibernate, CPU hotplug) we want to map
as much memory as possible using the identity mapping so that we
increase the chance of mapping our reset code.

This patch introduces a new reboot mode, 'k', which remaps all of memory
apart from the kernel (PAGE_OFFSET - _end) and an additional page
immediately following it, which can be used as a temporary stack if
valid memory is available there. Note that this change makes it
necessary to manipulate and switch to the swapper page tables rather
than hijack the current task.

Reviewed-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/idmap.h |    7 +++++++
 arch/arm/mm/idmap.c          |   30 +++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index ea9517e..ae0697d 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -2,6 +2,7 @@
 #define _ARM_IDMAP_H
 
 #include <asm/page.h>
+#include <asm/sections.h>
 
 void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end);
 
@@ -11,6 +12,12 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end);
 void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end) {};
 #endif
 
+/* Modes understood from arm_machine_{restart,reset}. */
+#define MODE_REMAP_KERNEL	'k'
+
+/* Page reserved after the kernel image. */
+#define RESERVE_STACK_PAGE	ALIGN((unsigned long)_end + PAGE_SIZE, SZ_1M)
+
 void setup_mm_for_reboot(char mode);
 
 #endif	/* _ARM_IDMAP_H */
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 4ae0f09..e4ae3c5 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -75,17 +75,29 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
 #endif
 
 /*
- * In order to soft-boot, we need to insert a 1:1 mapping in place of
- * the user-mode pages.  This will then ensure that we have predictable
- * results when turning the mmu off
+ * In order to soft-boot, we need to insert a 1:1 mapping of memory.
+ * This will then ensure that we have predictable results when turning
+ * the mmu off.
  */
 void setup_mm_for_reboot(char mode)
 {
-	/*
-	 * We need to access to user-mode page tables here. For kernel threads
-	 * we don't have any user-mode mappings so we use the context that we
-	 * "borrowed".
-	 */
-	identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE);
+
+	identity_mapping_add(swapper_pg_dir, 0, TASK_SIZE);
+	if (mode == MODE_REMAP_KERNEL) {
+		/*
+		 * Extend the flat mapping into kernelspace.
+		 * We leave room for the kernel image and a `reboot stack'.
+		 */
+		identity_mapping_add(swapper_pg_dir, TASK_SIZE, PAGE_OFFSET);
+		identity_mapping_add(swapper_pg_dir, RESERVE_STACK_PAGE, 0);
+	}
+
+	/* Clean and invalidate L1. */
+	flush_cache_all();
+
+	/* Switch exclusively to kernel mappings. */
+	cpu_switch_mm(swapper_pg_dir, &init_mm);
+
+	/* Flush the TLB. */
 	local_flush_tlb_all();
 }
-- 
1.7.0.4
