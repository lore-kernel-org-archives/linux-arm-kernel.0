From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Jan 2018 15:08:30 +0000
Subject: [PATCH 06/11] arm64: Move post_ttbr_update_workaround to C code
In-Reply-To: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
Message-ID: <1515078515-13723-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We will soon need to invoke a CPU-specific function pointer after changing
page tables, so move post_ttbr_update_workaround out into C code to make
this possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 13 -------------
 arch/arm64/kernel/entry.S          |  2 +-
 arch/arm64/mm/context.c            |  9 +++++++++
 arch/arm64/mm/proc.S               |  3 +--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index c45bc94f15d0..cee60ce0da52 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -476,17 +476,4 @@ alternative_endif
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
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b9feb587294d..6aa112baf601 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -277,7 +277,7 @@ alternative_else_nop_endif
 	 * Cavium erratum 27456 (broadcast TLBI instructions may cause I-cache
 	 * corruption).
 	 */
-	post_ttbr_update_workaround
+	bl	post_ttbr_update_workaround
 	.endif
 1:
 	.if	\el != 0
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 1cb3bc92ae5c..c1e3b6479c8f 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -239,6 +239,15 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+/* Errata workaround post TTBRx_EL1 update. */
+asmlinkage void post_ttbr_update_workaround(void)
+{
+	asm volatile(ALTERNATIVE("nop; nop; nop",
+				 "ic iallu; dsb nsh; isb",
+				 ARM64_WORKAROUND_CAVIUM_27456,
+				 CONFIG_CAVIUM_ERRATUM_27456));
+}
+
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 3146dc96f05b..6affb68a9a14 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -145,8 +145,7 @@ ENTRY(cpu_do_switch_mm)
 	isb
 	msr	ttbr0_el1, x0			// now update TTBR0
 	isb
-	post_ttbr_update_workaround
-	ret
+	b	post_ttbr_update_workaround	// Back to C code...
 ENDPROC(cpu_do_switch_mm)
 
 	.pushsection ".idmap.text", "ax"
-- 
2.1.4
