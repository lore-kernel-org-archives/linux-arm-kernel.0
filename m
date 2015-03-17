From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 11:11:12 +0100
Subject: [PATCH 1/3] arm64: merge __enable_mmu and __turn_mmu_on
In-Reply-To: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426587074-22390-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426587074-22390-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling of the MMU is split into two functions, with an align and
a branch in the middle. On arm64, the entire kernel Image is ID mapped
so this is really not necessary, and we can just merge it into a
single function.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 65c7de889c8c..fb912314d5e1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -615,8 +615,13 @@ ENDPROC(__secondary_switched)
 #endif	/* CONFIG_SMP */
 
 /*
- * Setup common bits before finally enabling the MMU. Essentially this is just
- * loading the page table pointer and vector base registers.
+ * Enable the MMU. This completely changes the structure of the visible memory
+ * space. You will not be able to trace execution through this.
+ *
+ *  x0  = system control register
+ *  x27 = *virtual* address to jump to upon completion
+ *
+ * other registers depend on the function called upon completion
  *
  * On entry to this code, x0 must contain the SCTLR_EL1 value for turning on
  * the MMU.
@@ -627,29 +632,10 @@ __enable_mmu:
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
