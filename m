From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:28:55 +0000
Subject: [PATCH v2 4/6] ARM: idmap: use idmap_pgd when setting up mm for reboot
In-Reply-To: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322504937-24718-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For soft-rebooting a system, it is necessary to map the MMU-off code
with an identity mapping so that execution can continue safely once the
MMU has been switched off.

Currently, switch_mm_for_reboot takes out a 1:1 mapping from 0x0 to
TASK_SIZE during reboot in the hope that the reset code lives at a
physical address corresponding to a userspace virtual address.

This patch modifies the code so that we switch to the idmap_pgd tables,
which contain a 1:1 mapping of the cpu_reset code. This has the
advantage of only remapping the code that we need and also means we
don't need to worry about allocating a pgd from an atomic context in the
case that the physical address of the cpu_reset code aliases with the
virtual space used by the kernel.

Acked-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/idmap.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index cda5ea3..b01760e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -100,17 +100,18 @@ static int __init init_static_idmap(void)
 arch_initcall(init_static_idmap);
 
 /*
- * In order to soft-boot, we need to insert a 1:1 mapping in place of
- * the user-mode pages.  This will then ensure that we have predictable
- * results when turning the mmu off
+ * In order to soft-boot, we need to switch to a 1:1 mapping for the
+ * cpu_reset functions. This will then ensure that we have predictable
+ * results when turning off the mmu.
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
+	/* Switch to the identity mapping. */
+	cpu_switch_mm(idmap_pgd, &init_mm);
+
+	/* Flush the TLB. */
 	local_flush_tlb_all();
 }
-- 
1.7.4.1
