From: leif.lindholm@arm.com (Leif Lindholm)
Date: Thu, 08 Dec 2011 17:31:59 +0000
Subject: [PATCH 2/4] Use generic ARM instruction set condition code checks for
 nwfpe.
In-Reply-To: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
Message-ID: <20111208173148.7572.10039.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the nwfpe implementation to use the new generic
ARM instruction set condition code checks, rather than a local
implementation. It also removes the existing condition code checking,
which has been used for the generic support (in kernel/opcodes.{ch}).

Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
---

This code has not been tested beyond building, linking and booting.

 arch/arm/nwfpe/entry.S    |    8 +++++---
 arch/arm/nwfpe/fpopcode.c |   26 --------------------------
 arch/arm/nwfpe/fpopcode.h |    3 ---
 3 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/arm/nwfpe/entry.S b/arch/arm/nwfpe/entry.S
index cafa183..d18dde9 100644
--- a/arch/arm/nwfpe/entry.S
+++ b/arch/arm/nwfpe/entry.S
@@ -20,6 +20,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+#include <asm/opcodes.h>
+
 /* This is the kernel's entry point into the floating point emulator.
 It is called from the kernel with code similar to this:
 
@@ -81,11 +83,11 @@ nwfpe_enter:
 	mov	r6, r0			@ save the opcode
 emulate:
 	ldr	r1, [sp, #S_PSR]	@ fetch the PSR
-	bl	checkCondition		@ check the condition
-	cmp	r0, #0			@ r0 = 0 ==> condition failed
+	bl	arm_check_condition	@ check the condition
+	cmp	r0, #ARM_OPCODE_CONDTEST_PASS	@ condition passed?
 
 	@ if condition code failed to match, next insn
-	beq	next			@ get the next instruction;
+	bne	next			@ get the next instruction;
 
 	mov	r0, r6			@ prepare for EmulateAll()
 	bl	EmulateAll		@ emulate the instruction
diff --git a/arch/arm/nwfpe/fpopcode.c b/arch/arm/nwfpe/fpopcode.c
index 922b811..ff98346 100644
--- a/arch/arm/nwfpe/fpopcode.c
+++ b/arch/arm/nwfpe/fpopcode.c
@@ -61,29 +61,3 @@ const float32 float32Constant[] = {
 	0x41200000		/* single 10.0 */
 };
 
-/* condition code lookup table
- index into the table is test code: EQ, NE, ... LT, GT, AL, NV
- bit position in short is condition code: NZCV */
-static const unsigned short aCC[16] = {
-	0xF0F0,			// EQ == Z set
-	0x0F0F,			// NE
-	0xCCCC,			// CS == C set
-	0x3333,			// CC
-	0xFF00,			// MI == N set
-	0x00FF,			// PL
-	0xAAAA,			// VS == V set
-	0x5555,			// VC
-	0x0C0C,			// HI == C set && Z clear
-	0xF3F3,			// LS == C clear || Z set
-	0xAA55,			// GE == (N==V)
-	0x55AA,			// LT == (N!=V)
-	0x0A05,			// GT == (!Z && (N==V))
-	0xF5FA,			// LE == (Z || (N!=V))
-	0xFFFF,			// AL always
-	0			// NV
-};
-
-unsigned int checkCondition(const unsigned int opcode, const unsigned int ccodes)
-{
-	return (aCC[opcode >> 28] >> (ccodes >> 28)) & 1;
-}
diff --git a/arch/arm/nwfpe/fpopcode.h b/arch/arm/nwfpe/fpopcode.h
index 786e4c9..78f02db 100644
--- a/arch/arm/nwfpe/fpopcode.h
+++ b/arch/arm/nwfpe/fpopcode.h
@@ -475,9 +475,6 @@ static inline unsigned int getDestinationSize(const unsigned int opcode)
 	return (nRc);
 }
 
-extern unsigned int checkCondition(const unsigned int opcode,
-				   const unsigned int ccodes);
-
 extern const float64 float64Constant[];
 extern const float32 float32Constant[];
 
