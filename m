From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 18 Jul 2018 18:17:23 +0800
Subject: [RESEND PATCH v4 2/6] arm64/mm: Make __enable_mmu() take the
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
Message-ID: <20180718101727.10787-3-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make __enable_mmu() take the physical address of the ttbr1 page as
an argument.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/head.S  | 21 ++++++++++++---------
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c83a8c47e3f..c3e4b1886cde 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -714,6 +714,7 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
+	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -756,6 +757,7 @@ ENDPROC(__secondary_switched)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
+ *  x1  = TTBR1_EL1 value for turning on the MMU.
  *
  * Returns to the caller via x30/lr. This requires the caller to be covered
  * by the .idmap.text section.
@@ -764,15 +766,15 @@ ENDPROC(__secondary_switched)
  * If it isn't, park the CPU
  */
 ENTRY(__enable_mmu)
-	mrs	x1, ID_AA64MMFR0_EL1
-	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
+	mrs	x5, ID_AA64MMFR0_EL1
+	ubfx	x6, x5, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp	x6, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
-	update_early_cpu_boot_status 0, x1, x2
-	adrp	x1, idmap_pg_dir
-	adrp	x2, swapper_pg_dir
-	phys_to_ttbr x3, x1
-	phys_to_ttbr x4, x2
+	update_early_cpu_boot_status 0, x5, x6
+	adrp	x5, idmap_pg_dir
+	mov	x6, x1
+	phys_to_ttbr x3, x5
+	phys_to_ttbr x4, x6
 	msr	ttbr0_el1, x3			// load TTBR0
 	msr	ttbr1_el1, x4			// load TTBR1
 	isb
@@ -791,7 +793,7 @@ ENDPROC(__enable_mmu)
 
 __no_granule_support:
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
-	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x1, x2
+	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x5, x6
 1:
 	wfe
 	wfi
@@ -831,6 +833,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
+	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index bebec8ef9372..3e53ffa07994 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -101,6 +101,7 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
+	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-- 
2.17.1
