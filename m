From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:24 +0800
Subject: [PATCH 02/29] arm64: mm: Move ASID from TTBR0 to TTBR1
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-3-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 7655abb95386 upstream.

In preparation for mapping kernelspace and userspace with different
ASIDs, move the ASID to TTBR1 and update switch_mm to context-switch
TTBR0 via an invalid mapping (the zero page).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no pre_ttbr0_update_workaround in arch/arm64/mm/proc.S
---
 arch/arm64/include/asm/mmu_context.h   | 7 +++++++
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/include/asm/proc-fns.h      | 6 ------
 arch/arm64/mm/proc.S                   | 9 ++++++---
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index a501853..b96c4799 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -50,6 +50,13 @@ static inline void cpu_set_reserved_ttbr0(void)
 	isb();
 }
 
+static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
+{
+	BUG_ON(pgd == swapper_pg_dir);
+	cpu_set_reserved_ttbr0();
+	cpu_do_switch_mm(virt_to_phys(pgd),mm);
+}
+
 /*
  * TCR.T0SZ value to use when the ID map is active. Usually equals
  * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd..8df4cb6 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -272,6 +272,7 @@
 #define TCR_TG1_4K		(UL(2) << TCR_TG1_SHIFT)
 #define TCR_TG1_64K		(UL(3) << TCR_TG1_SHIFT)
 
+#define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 #define TCR_HA			(UL(1) << 39)
diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 14ad6e4..16cef2e 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -35,12 +35,6 @@ extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
-#define cpu_switch_mm(pgd,mm)				\
-do {							\
-	BUG_ON(pgd == swapper_pg_dir);			\
-	cpu_do_switch_mm(virt_to_phys(pgd),mm);		\
-} while (0)
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_PROCFNS_H */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 352c73b..3378f3e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -132,9 +132,12 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
+	mrs	x2, ttbr1_el1
 	mmid	x1, x1				// get mm->context.id
-	bfi	x0, x1, #48, #16		// set the ASID
-	msr	ttbr0_el1, x0			// set TTBR0
+	bfi	x2, x1, #48, #16		// set the ASID
+	msr	ttbr1_el1, x2			// in TTBR1 (since TCR.A1 is set)
+	isb
+	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
 alternative_if ARM64_WORKAROUND_CAVIUM_27456
 	ic	iallu
@@ -222,7 +225,7 @@ ENTRY(__cpu_setup)
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
+			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-- 
2.7.4
