From: yaojun8558363@gmail.com (Jun Yao)
Date: Mon,  2 Jul 2018 19:16:56 +0800
Subject: [PATCH v3 2/5] arm64/mm: Make __enable_mmu() take the ttbr1 page as
 an argument
In-Reply-To: <20180702111659.25570-1-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
Message-ID: <20180702111659.25570-3-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make __enable_mmu() take the physical address of the ttbr1 page as
an argument.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/head.S  | 5 ++++-
 arch/arm64/kernel/sleep.S | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3f99c59ba193..a1c7a4d3b9f3 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -718,6 +718,7 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
+	adrp	x26, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -760,6 +761,7 @@ ENDPROC(__secondary_switched)
  * Enable the MMU.
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
+ *  x26 = TTBR1_EL1 value for turning on the MMU.
  *
  * Returns to the caller via x30/lr. This requires the caller to be covered
  * by the .idmap.text section.
@@ -774,7 +776,7 @@ ENTRY(__enable_mmu)
 	b.ne	__no_granule_support
 	update_early_cpu_boot_status 0, x1, x2
 	adrp	x1, idmap_pg_dir
-	adrp	x2, swapper_pg_dir
+	mov	x2, x26
 	phys_to_ttbr x3, x1
 	phys_to_ttbr x4, x2
 	msr	ttbr0_el1, x3			// load TTBR0
@@ -835,6 +837,7 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
+	adrp	x26, swapper_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index bebec8ef9372..3f2c7bf67a2c 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -101,6 +101,7 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
+	adrp	x26, swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-- 
2.17.1
