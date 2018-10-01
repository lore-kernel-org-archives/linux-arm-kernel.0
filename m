From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  1 Oct 2018 12:19:43 +0100
Subject: [PATCH v3] arm64: Trap WFI executed in userspace
Message-ID: <20181001111943.233042-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It recently came to light that userspace can execute WFI, and that
the arm64 kernel doesn't trap this event. This sounds rather benign,
but the kernel should decide when it wants to wait for an interrupt,
and not userspace.

Let's trap WFI and immediately return after having skipped the
instruction. This effectively makes WFI a rather expensive NOP.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v2:
  - Fixed commit message typo
  - Added ESR_ELx_WFx_ISS_TI to match the ESR_ELx register description

 arch/arm64/include/asm/esr.h    |  5 +++++
 arch/arm64/include/asm/sysreg.h |  4 ++--
 arch/arm64/kernel/entry.S       |  1 +
 arch/arm64/kernel/traps.c       | 11 +++++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ce70c3ffb993..22ebae91cad9 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -137,6 +137,8 @@
 #define ESR_ELx_CV		(UL(1) << 24)
 #define ESR_ELx_COND_SHIFT	(20)
 #define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
+#define ESR_ELx_WFx_ISS_TI	(UL(1) << 0)
+#define ESR_ELx_WFx_ISS_WFI	(UL(0) << 0)
 #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
 #define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
 
@@ -148,6 +150,9 @@
 #define DISR_EL1_ESR_MASK	(ESR_ELx_AET | ESR_ELx_EA | ESR_ELx_FSC)
 
 /* ESR value templates for specific events */
+#define ESR_ELx_WFx_MASK	(ESR_ELx_EC_MASK | ESR_ELx_WFx_ISS_TI)
+#define ESR_ELx_WFx_WFI_VAL	((ESR_ELx_EC_WFx << ESR_ELx_EC_SHIFT) |	\
+				 ESR_ELx_WFx_ISS_WFI)
 
 /* BRK instruction trap from AArch64 state */
 #define ESR_ELx_VAL_BRK64(imm)					\
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c1470931b897..5fbc0712a342 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -489,12 +489,12 @@
 
 #define SCTLR_EL1_SET	(SCTLR_ELx_M    | SCTLR_ELx_C    | SCTLR_ELx_SA   |\
 			 SCTLR_EL1_SA0  | SCTLR_EL1_SED  | SCTLR_ELx_I    |\
-			 SCTLR_EL1_DZE  | SCTLR_EL1_UCT  | SCTLR_EL1_NTWI |\
+			 SCTLR_EL1_DZE  | SCTLR_EL1_UCT  |		   \
 			 SCTLR_EL1_NTWE | SCTLR_ELx_IESB | SCTLR_EL1_SPAN |\
 			 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
 #define SCTLR_EL1_CLEAR	(SCTLR_ELx_A   | SCTLR_EL1_CP15BEN | SCTLR_EL1_ITD    |\
 			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
-			 SCTLR_EL1_RES0)
+			 SCTLR_EL1_NTWI | SCTLR_EL1_RES0)
 
 #if (SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != 0xffffffffffffffff
 #error "Inconsistent SCTLR_EL1 set/clear bits"
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 09dbea221a27..6c8e5dc695d2 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -665,6 +665,7 @@ el0_sync:
 	cmp	x24, #ESR_ELx_EC_FP_EXC64	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
 	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
+	ccmp	x24, #ESR_ELx_EC_WFx, #4, ne
 	b.eq	el0_sys
 	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el0_sp_pc
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 039e9ff379cc..9d6b655529a1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -496,6 +496,11 @@ static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
 
+static void wfi_handler(unsigned int esr, struct pt_regs *regs)
+{
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+}
+
 struct sys64_hook {
 	unsigned int esr_mask;
 	unsigned int esr_val;
@@ -526,6 +531,12 @@ static struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTFRQ,
 		.handler = cntfrq_read_handler,
 	},
+	{
+		/* Trap WFI instructions executed in userspace */
+		.esr_mask = ESR_ELx_WFx_MASK,
+		.esr_val = ESR_ELx_WFx_WFI_VAL,
+		.handler = wfi_handler,
+	},
 	{},
 };
 
-- 
2.19.0
