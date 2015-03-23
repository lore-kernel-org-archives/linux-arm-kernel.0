From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 10:07:24 +0100
Subject: [PATCH v2 1/3] arm64: remove soft_restart() and friends
In-Reply-To: <1427101646-465-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427101646-465-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427101646-465-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of soft_restart() and its subordinate functions
setup_mm_for_reboot(), cpu_soft_restart() and cpu_reset() have
non-trivial dependencies on the state of the caches and the MMU,
making them fragile from a maintenance pov. However, soft_restart()
isn't actually called anywhere, so just remove the whole bunch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/mmu.h         |  1 -
 arch/arm64/include/asm/proc-fns.h    |  3 ---
 arch/arm64/include/asm/system_misc.h |  1 -
 arch/arm64/kernel/process.c          | 12 +-----------
 arch/arm64/mm/mmu.c                  | 11 -----------
 arch/arm64/mm/proc.S                 | 33 ---------------------------------
 6 files changed, 1 insertion(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 3d311761e3c2..99064c075fc6 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -28,7 +28,6 @@ typedef struct {
 #define ASID(mm)	((mm)->context.id & 0xffff)
 
 extern void paging_init(void);
-extern void setup_mm_for_reboot(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 4d9ede7b6361..ab334467c6a4 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -31,9 +31,6 @@ struct cpu_suspend_ctx;
 extern void cpu_cache_off(void);
 extern void cpu_do_idle(void);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
-extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
-void cpu_soft_restart(phys_addr_t cpu_reset,
-		unsigned long addr) __attribute__((noreturn));
 extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
 extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 7a18fabbe0f6..659fbf5925de 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -41,7 +41,6 @@ struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 
-void soft_restart(unsigned long);
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
 #define UDBG_UNDEFINED	(1 << 0)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b96f45..c506bee6b613 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -58,14 +58,6 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
-void soft_restart(unsigned long addr)
-{
-	setup_mm_for_reboot();
-	cpu_soft_restart(virt_to_phys(cpu_reset), addr);
-	/* Should never get here */
-	BUG();
-}
-
 /*
  * Function pointers to optional machine specific functions
  */
@@ -136,9 +128,7 @@ void machine_power_off(void)
 
 /*
  * Restart requires that the secondary CPUs stop performing any activity
- * while the primary CPU resets the system. Systems with a single CPU can
- * use soft_restart() as their machine descriptor's .restart hook, since that
- * will cause the only available CPU to reset. Systems with multiple CPUs must
+ * while the primary CPU resets the system. Systems with multiple CPUs must
  * provide a HW restart implementation, to ensure that all CPUs reset@once.
  * This is required so that any code running after reset on the primary CPU
  * doesn't have to co-ordinate with other CPUs to ensure they aren't still
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 428aaf86c95b..15ac396229d5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -460,17 +460,6 @@ void __init paging_init(void)
 }
 
 /*
- * Enable the identity mapping to allow the MMU disabling.
- */
-void setup_mm_for_reboot(void)
-{
-	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
-	cpu_set_idmap_tcr_t0sz();
-	cpu_switch_mm(idmap_pg_dir, &init_mm);
-}
-
-/*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
 int kern_addr_valid(unsigned long addr)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index cdd754e19b9b..a2059ec61463 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -59,39 +59,6 @@ ENTRY(cpu_cache_off)
 ENDPROC(cpu_cache_off)
 
 /*
- *	cpu_reset(loc)
- *
- *	Perform a soft reset of the system.  Put the CPU into the same state
- *	as it would be if it had been reset, and branch to what would be the
- *	reset vector. It must be executed with the flat identity mapping.
- *
- *	- loc   - location to jump to for soft reset
- */
-	.align	5
-ENTRY(cpu_reset)
-	mrs	x1, sctlr_el1
-	bic	x1, x1, #1
-	msr	sctlr_el1, x1			// disable the MMU
-	isb
-	ret	x0
-ENDPROC(cpu_reset)
-
-ENTRY(cpu_soft_restart)
-	/* Save address of cpu_reset() and reset address */
-	mov	x19, x0
-	mov	x20, x1
-
-	/* Turn D-cache off */
-	bl	cpu_cache_off
-
-	/* Push out all dirty data, and ensure cache is empty */
-	bl	flush_cache_all
-
-	mov	x0, x20
-	ret	x19
-ENDPROC(cpu_soft_restart)
-
-/*
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
-- 
1.8.3.2
