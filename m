From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 13:36:08 +0100
Subject: [PATCH net-next 01/13] ARM: net: bpf: enumerate the JIT scratch stack
 layout
In-Reply-To: <20180710123340.GK17271@n2100.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
Message-ID: <E1fcrsG-0005UK-Un@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enumerate the contents of the JIT scratch stack layout used for storing
some of the JITs 64-bit registers, tail call counter and AX register.

XXX: what about the skb_copy_bits buffer - this appears to overlap with
the first word of the JITs accessible stack.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 59 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f6a62ae44a65..f2e6ffe57788 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -72,7 +72,38 @@
 #define CALLEE_PUSH_MASK (CALLEE_MASK | 1 << ARM_LR)
 #define CALLEE_POP_MASK  (CALLEE_MASK | 1 << ARM_PC)
 
-#define STACK_OFFSET(k)	(k)
+enum {
+	/* Stack layout - these are offsets from (top of stack - 4) */
+	BPF_R2_HI,
+	BPF_R2_LO,
+	BPF_R3_HI,
+	BPF_R3_LO,
+	BPF_R4_HI,
+	BPF_R4_LO,
+	BPF_R5_HI,
+	BPF_R5_LO,
+	BPF_R7_HI,
+	BPF_R7_LO,
+	BPF_R8_HI,
+	BPF_R8_LO,
+	BPF_R9_HI,
+	BPF_R9_LO,
+	BPF_FP_HI,
+	BPF_FP_LO,
+	BPF_TC_HI,
+	BPF_TC_LO,
+	BPF_AX_HI,
+	BPF_AX_LO,
+	/* Stack space for BPF_REG_2, BPF_REG_3, BPF_REG_4,
+	 * BPF_REG_5, BPF_REG_7, BPF_REG_8, BPF_REG_9,
+	 * BPF_REG_FP and Tail call counts.
+	 */
+	BPF_JIT_SCRATCH_REGS,
+};
+
+#define STACK_OFFSET(k)	((k) * 4)
+#define SCRATCH_SIZE	(BPF_JIT_SCRATCH_REGS * 4)
+
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)	/* TEMP Register 1 */
 #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)	/* TEMP Register 2 */
 #define TCALL_CNT	(MAX_BPF_JIT_REG + 2)	/* Tail Call Count */
@@ -100,29 +131,29 @@ static const u8 bpf2a32[][2] = {
 	/* arguments from eBPF program to in-kernel function */
 	[BPF_REG_1] = {ARM_R3, ARM_R2},
 	/* Stored on stack scratch space */
-	[BPF_REG_2] = {STACK_OFFSET(0), STACK_OFFSET(4)},
-	[BPF_REG_3] = {STACK_OFFSET(8), STACK_OFFSET(12)},
-	[BPF_REG_4] = {STACK_OFFSET(16), STACK_OFFSET(20)},
-	[BPF_REG_5] = {STACK_OFFSET(24), STACK_OFFSET(28)},
+	[BPF_REG_2] = {STACK_OFFSET(BPF_R2_HI), STACK_OFFSET(BPF_R2_LO)},
+	[BPF_REG_3] = {STACK_OFFSET(BPF_R3_HI), STACK_OFFSET(BPF_R3_LO)},
+	[BPF_REG_4] = {STACK_OFFSET(BPF_R4_HI), STACK_OFFSET(BPF_R4_LO)},
+	[BPF_REG_5] = {STACK_OFFSET(BPF_R5_HI), STACK_OFFSET(BPF_R5_LO)},
 	/* callee saved registers that in-kernel function will preserve */
 	[BPF_REG_6] = {ARM_R5, ARM_R4},
 	/* Stored on stack scratch space */
-	[BPF_REG_7] = {STACK_OFFSET(32), STACK_OFFSET(36)},
-	[BPF_REG_8] = {STACK_OFFSET(40), STACK_OFFSET(44)},
-	[BPF_REG_9] = {STACK_OFFSET(48), STACK_OFFSET(52)},
+	[BPF_REG_7] = {STACK_OFFSET(BPF_R7_HI), STACK_OFFSET(BPF_R7_LO)},
+	[BPF_REG_8] = {STACK_OFFSET(BPF_R8_HI), STACK_OFFSET(BPF_R8_LO)},
+	[BPF_REG_9] = {STACK_OFFSET(BPF_R9_HI), STACK_OFFSET(BPF_R9_LO)},
 	/* Read only Frame Pointer to access Stack */
-	[BPF_REG_FP] = {STACK_OFFSET(56), STACK_OFFSET(60)},
+	[BPF_REG_FP] = {STACK_OFFSET(BPF_FP_HI), STACK_OFFSET(BPF_FP_LO)},
 	/* Temporary Register for internal BPF JIT, can be used
 	 * for constant blindings and others.
 	 */
 	[TMP_REG_1] = {ARM_R7, ARM_R6},
 	[TMP_REG_2] = {ARM_R10, ARM_R8},
 	/* Tail call count. Stored on stack scratch space. */
-	[TCALL_CNT] = {STACK_OFFSET(64), STACK_OFFSET(68)},
+	[TCALL_CNT] = {STACK_OFFSET(BPF_TC_HI), STACK_OFFSET(BPF_TC_LO)},
 	/* temporary register for blinding constants.
 	 * Stored on stack scratch space.
 	 */
-	[BPF_REG_AX] = {STACK_OFFSET(72), STACK_OFFSET(76)},
+	[BPF_REG_AX] = {STACK_OFFSET(BPF_AX_HI), STACK_OFFSET(BPF_AX_LO)},
 };
 
 #define	dst_lo	dst[1]
@@ -227,12 +258,6 @@ static void jit_fill_hole(void *area, unsigned int size)
 #define STACK_ALIGNMENT	4
 #endif
 
-/* Stack space for BPF_REG_2, BPF_REG_3, BPF_REG_4,
- * BPF_REG_5, BPF_REG_7, BPF_REG_8, BPF_REG_9,
- * BPF_REG_FP and Tail call counts.
- */
-#define SCRATCH_SIZE 80
-
 /* total stack size used in JITed code */
 #define _STACK_SIZE	(ctx->prog->aux->stack_depth + SCRATCH_SIZE)
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
-- 
2.7.4
