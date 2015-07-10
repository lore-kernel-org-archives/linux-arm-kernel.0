From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 10 Jul 2015 14:48:50 +0100
Subject: [PATCH] arm64: alternative: Provide if/else/endif assembler macros
Message-ID: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing alternative_insn macro has some limitations that make it
hard to work with. In partiuclar the fact it takes instructions from it
own macro arguments means it doesn't play very nicely with C pre-processor
macros because the macro arguments look like a string to the C
pre-processor. Workarounds are (probably) possible but things start to
look ugly.

Introduce an alternative set of macros that allows instructions to be
presented to the assembler as normal and switch everything over to the
new macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    To be honest these if not/else/endif macros are simply more readable
    than the original macro and that might be enough to justify them on
    their own. However below is an example that is needlessly hard to
    write without them because ICC_PMR_EL1 is a C pre-processor macro.
    
     	.macro	disable_irq, tmp
     	mov	\tmp, #ICC_PMR_EL1_MASKED
    alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
    	msr	daifset, #2
    alternative_else
     	msr_s	ICC_PMR_EL1, \tmp
    alternative_endif
    	.endm
    
    The new macros have received a fair degree of testing because I have
    based my (not published since March) pseudo-NMI patch set on them.

 arch/arm64/include/asm/alternative.h | 18 ++++++++++++------
 arch/arm64/kernel/entry.S            | 29 +++++++++++++----------------
 arch/arm64/kvm/hyp.S                 | 12 ++++++++++--
 arch/arm64/mm/cache.S                |  7 ++++++-
 4 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index c385a0c4057f..8c8cdfac7251 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -65,13 +65,19 @@ void free_alternatives_memory(void);
 	.byte \alt_len
 .endm

-.macro alternative_insn insn1 insn2 cap
-661:	\insn1
-662:	.pushsection .altinstructions, "a"
-	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
+.macro alternative_if_not cap
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
 	.popsection
-	.pushsection .altinstr_replacement, "ax"
-663:	\insn2
+661:
+.endm
+
+.macro alternative_else
+662:	.pushsection .altinstr_replacement, "ax"
+663:
+.endm
+
+.macro alternative_endif
 664:	.popsection
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a7691a378668..be8a70d4028c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -122,26 +122,23 @@
 	ct_user_enter
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
-
 #ifdef CONFIG_ARM64_ERRATUM_845719
-
-#undef SEQUENCE_ORG
-#undef SEQUENCE_ALT
-
+alternative_if_not ARM64_WORKAROUND_845719
+	nop
+	nop
 #ifdef CONFIG_PID_IN_CONTEXTIDR
-
-#define SEQUENCE_ORG	"nop ; nop ; nop"
-#define SEQUENCE_ALT	"tbz x22, #4, 1f ; mrs x29, contextidr_el1; msr contextidr_el1, x29; 1:"
-
+	nop
+#endif
+alternative_else
+	tbz	x22, #4, 1f
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	mrs	x29, contextidr_el1
+	msr	contextidr_el1, x29
 #else
-
-#define SEQUENCE_ORG	"nop ; nop"
-#define SEQUENCE_ALT	"tbz x22, #4, 1f ; msr contextidr_el1, xzr; 1:"
-
+	msr contextidr_el1, xzr
 #endif
-
-	alternative_insn SEQUENCE_ORG, SEQUENCE_ALT, ARM64_WORKAROUND_845719
-
+1:
+alternative_endif
 #endif
 	.endif
 	msr	elr_el1, x21			// set up the return data
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 17a8fb14f428..10915aaf0b01 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -810,7 +810,11 @@
  * Call into the vgic backend for state saving
  */
 .macro save_vgic_state
-	alternative_insn "bl __save_vgic_v2_state", "bl __save_vgic_v3_state", ARM64_HAS_SYSREG_GIC_CPUIF
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	bl	__save_vgic_v2_state
+alternative_else
+	bl	__save_vgic_v3_state
+alternative_endif
 	mrs	x24, hcr_el2
 	mov	x25, #HCR_INT_OVERRIDE
 	neg	x25, x25
@@ -827,7 +831,11 @@
 	orr	x24, x24, #HCR_INT_OVERRIDE
 	orr	x24, x24, x25
 	msr	hcr_el2, x24
-	alternative_insn "bl __restore_vgic_v2_state", "bl __restore_vgic_v3_state", ARM64_HAS_SYSREG_GIC_CPUIF
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	bl	__restore_vgic_v2_state
+alternative_else
+	bl	__restore_vgic_v3_state
+alternative_endif
 .endm

 .macro save_timer_state
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index bdeb5d38c2dd..eb48d5df4a0f 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -143,7 +143,12 @@ __dma_clean_range:
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x0, x0, x3
-1:	alternative_insn "dc cvac, x0", "dc civac, x0", ARM64_WORKAROUND_CLEAN_CACHE
+1:
+alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
+	dc	cvac, x0
+alternative_else
+	dc	civac, x0
+alternative_endif
 	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	1b
--
2.4.3
