From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 13:37:05 +0100
Subject: [PATCH net-next 12/13] ARM: net: bpf: always use odd/even register
 pair
In-Reply-To: <20180710123340.GK17271@n2100.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
Message-ID: <E1fcrtB-0005Va-8S@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always use an odd/even register pair for our 64-bit registers, so that
we're able to use the double-word load/store instructions in the future.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 926e81c15505..ca6534cabfa9 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -47,27 +47,27 @@
  * The callee saved registers depends on whether frame pointers are enabled.
  * With frame pointers (to be compliant with the ABI):
  *
- *                                high
- * original ARM_SP =>     +------------------+ \
- *                        |        pc        | |
- * current ARM_FP =>      +------------------+ } callee saved registers
- *                        |r4-r8,r10,fp,ip,lr| |
- *                        +------------------+ /
- *                                low
+ *                              high
+ * original ARM_SP =>     +--------------+ \
+ *                        |      pc      | |
+ * current ARM_FP =>      +--------------+ } callee saved registers
+ *                        |r4-r9,fp,ip,lr| |
+ *                        +--------------+ /
+ *                              low
  *
  * Without frame pointers:
  *
- *                                high
- * original ARM_SP =>     +------------------+
- *                        | r4-r8,r10,fp,lr  | callee saved registers
- * current ARM_FP =>      +------------------+
- *                                low
+ *                              high
+ * original ARM_SP =>     +--------------+
+ *                        |  r4-r9,fp,lr | callee saved registers
+ * current ARM_FP =>      +--------------+
+ *                              low
  *
  * When popping registers off the stack at the end of a BPF function, we
  * reference them via the current ARM_FP register.
  */
 #define CALLEE_MASK	(1 << ARM_R4 | 1 << ARM_R5 | 1 << ARM_R6 | \
-			 1 << ARM_R7 | 1 << ARM_R8 | 1 << ARM_R10 | \
+			 1 << ARM_R7 | 1 << ARM_R8 | 1 << ARM_R9 | \
 			 1 << ARM_FP)
 #define CALLEE_PUSH_MASK (CALLEE_MASK | 1 << ARM_LR)
 #define CALLEE_POP_MASK  (CALLEE_MASK | 1 << ARM_PC)
@@ -157,7 +157,7 @@ static const s8 bpf2a32[][2] = {
 	 * for constant blindings and others.
 	 */
 	[TMP_REG_1] = {ARM_R7, ARM_R6},
-	[TMP_REG_2] = {ARM_R10, ARM_R8},
+	[TMP_REG_2] = {ARM_R9, ARM_R8},
 	/* Tail call count. Stored on stack scratch space. */
 	[TCALL_CNT] = {STACK_OFFSET(BPF_TC_HI), STACK_OFFSET(BPF_TC_LO)},
 	/* temporary register for blinding constants.
-- 
2.7.4
