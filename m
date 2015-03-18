From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 15:55:25 +0100
Subject: [PATCH v5 6/8] arm64: merge __enable_mmu and __turn_mmu_on
In-Reply-To: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426690527-14258-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling of the MMU is split into two functions, with an align and
a branch in the middle. On arm64, the entire kernel Image is ID mapped
so this is really not necessary, and we can just merge it into a
single function.

Also replaces an open coded adrp/add reference to __enable_mmu with
adr_l.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 65c7de889c8c..9a2554558e5b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -255,8 +255,7 @@ ENTRY(stext)
 	 */
 	ldr	x27, =__mmap_switched		// address to jump to after
 						// MMU has been enabled
-	adrp	lr, __enable_mmu		// return (PIC) address
-	add	lr, lr, #:lo12:__enable_mmu
+	adr_l	lr, __enable_mmu		// return (PIC) address
 	b	__cpu_setup			// initialise processor
 ENDPROC(stext)
 
@@ -615,11 +614,12 @@ ENDPROC(__secondary_switched)
 #endif	/* CONFIG_SMP */
 
 /*
- * Setup common bits before finally enabling the MMU. Essentially this is just
- * loading the page table pointer and vector base registers.
+ * Enable the MMU.
  *
- * On entry to this code, x0 must contain the SCTLR_EL1 value for turning on
- * the MMU.
+ *  x0  = SCTLR_EL1 value for turning on the MMU.
+ *  x27 = *virtual* address to jump to upon completion
+ *
+ * other registers depend on the function called upon completion
  */
 __enable_mmu:
 	ldr	x5, =vectors
@@ -627,29 +627,10 @@ __enable_mmu:
 	msr	ttbr0_el1, x25			// load TTBR0
 	msr	ttbr1_el1, x26			// load TTBR1
 	isb
-	b	__turn_mmu_on
-ENDPROC(__enable_mmu)
-
-/*
- * Enable the MMU. This completely changes the structure of the visible memory
- * space. You will not be able to trace execution through this.
- *
- *  x0  = system control register
- *  x27 = *virtual* address to jump to upon completion
- *
- * other registers depend on the function called upon completion
- *
- * We align the entire function to the smallest power of two larger than it to
- * ensure it fits within a single block map entry. Otherwise were PHYS_OFFSET
- * close to the end of a 512MB or 1GB block we might require an additional
- * table to map the entire function.
- */
-	.align	4
-__turn_mmu_on:
 	msr	sctlr_el1, x0
 	isb
 	br	x27
-ENDPROC(__turn_mmu_on)
+ENDPROC(__enable_mmu)
 
 /*
  * Calculate the start of physical memory.
-- 
1.8.3.2
