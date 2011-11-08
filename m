From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 15:52:59 +0000
Subject: [PATCH v5 4/8] ARM: reset: allow kernelspace mappings to be flat
 mapped during reset
In-Reply-To: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
References: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
Message-ID: <1320767583-21162-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, switch_mm_for_reboot only takes out a 1:1 mapping from 0x0
to TASK_SIZE during reboot. For situations where we actually want to
turn off the MMU (e.g. kexec, hibernate, CPU hotplug) we want to map
as much memory as possible using the identity mapping so that we
increase the chance of mapping our reset code.

This patch modifies setup_mm_for_reboot to change to the static identity
map page tables that are setup during booting, therefore remapping all
of memory apart from a small window containing the kernel image.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/idmap.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 24f6cf3..cdd4d08 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -92,17 +92,18 @@ static int __init init_static_idmap(void)
 arch_initcall(init_static_idmap);
 
 /*
- * In order to soft-boot, we need to insert a 1:1 mapping in place of
- * the user-mode pages.  This will then ensure that we have predictable
- * results when turning the mmu off
+ * In order to soft-boot, we need to insert a 1:1 mapping of memory.
+ * This will then ensure that we have predictable results when turning
+ * the mmu off
  */
 void setup_mm_for_reboot(void)
 {
-	/*
-	 * We need to access to user-mode page tables here. For kernel threads
-	 * we don't have any user-mode mappings so we use the context that we
-	 * "borrowed".
-	 */
-	identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE);
+	/* Clean and invalidate L1. */
+	flush_cache_all();
+
+	/* Switch exclusively to kernel mappings. */
+	cpu_switch_mm(idmap_pgd, &init_mm);
+
+	/* Flush the TLB. */
 	local_flush_tlb_all();
 }
-- 
1.7.4.1
