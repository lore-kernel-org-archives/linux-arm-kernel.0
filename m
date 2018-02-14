From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Feb 2018 15:51:40 +0000
Subject: [PATCH] arm64: Move post_ttbr_update_workaround to C code
In-Reply-To: <20180214154033.GA2745@kroah.com>
References: <20180214154033.GA2745@kroah.com>
Message-ID: <20180214155140.27162-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Commit 95e3de3590e3 upstream.

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 13 -------------
 arch/arm64/kernel/entry.S          |  2 +-
 arch/arm64/mm/context.c            |  9 +++++++++
 arch/arm64/mm/proc.S               |  3 +--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6d951a82e656..463619dcadd4 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -481,19 +481,6 @@ alternative_endif
 	mrs	\rd, sp_el0
 	.endm
 
-/*
- * Errata workaround post TTBRx_EL1 update.
- */
-	.macro	post_ttbr_update_workaround
-#ifdef CONFIG_CAVIUM_ERRATUM_27456
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
-#endif
-	.endm
-
 /**
  * Errata workaround prior to disable MMU. Insert an ISB immediately prior
  * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f786e8d3d5be..185c87a53fe3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -275,7 +275,7 @@ alternative_else_nop_endif
 	 * Cavium erratum 27456 (broadcast TLBI instructions may cause I-cache
 	 * corruption).
 	 */
-	post_ttbr_update_workaround
+	bl	post_ttbr_update_workaround
 	.endif
 1:
 	.if	\el != 0
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index db28958d9e4f..23498d032c82 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -235,6 +235,15 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+/* Errata workaround post TTBRx_EL1 update. */
+asmlinkage void post_ttbr_update_workaround(void)
+{
+	asm(ALTERNATIVE("nop; nop; nop",
+			"ic iallu; dsb nsh; isb",
+			ARM64_WORKAROUND_CAVIUM_27456,
+			CONFIG_CAVIUM_ERRATUM_27456));
+}
+
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c25e58bc2910..27058f3fd132 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -148,8 +148,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr_update_workaround
-	ret
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "awx"
-- 
2.11.0
