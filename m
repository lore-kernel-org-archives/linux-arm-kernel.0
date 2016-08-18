From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 18 Aug 2016 14:10:31 +0100
Subject: [PATCH 7/8] arm64: Refactor sysinstr exception handling
In-Reply-To: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1471525832-21209-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we trap some of the user space data cache operations
based on a few Errata (ARM 819472, 826319, 827319 and 824069).
We need to trap userspace access to CTR_EL0, if we detect mismatched
cache line size. Since both these traps share the EC, refactor
the handler a little bit to make it a bit more reader friendly.

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/esr.h | 48 +++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c    | 73 ++++++++++++++++++++++++++++----------------
 2 files changed, 95 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index f772e15..2a8f6c3 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -109,6 +109,54 @@
 	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
 	 ((imm) & 0xffff))
 
+/* ISS field definitions for System instruction traps */
+#define ESR_ELx_SYS64_ISS_RES0_SHIFT	22
+#define ESR_ELx_SYS64_ISS_RES0_MASK	(UL(0x7) << ESR_ELx_SYS64_ISS_RES0_SHIFT)
+#define ESR_ELx_SYS64_ISS_DIR_MASK	0x1
+#define ESR_ELx_SYS64_ISS_DIR_READ	0x1
+#define ESR_ELx_SYS64_ISS_DIR_WRITE	0x0
+
+#define ESR_ELx_SYS64_ISS_RT_SHIFT	5
+#define ESR_ELx_SYS64_ISS_RT_MASK	(UL(0x1f) << ESR_ELx_SYS64_ISS_RT_SHIFT)
+#define ESR_ELx_SYS64_ISS_CRm_SHIFT	1
+#define ESR_ELx_SYS64_ISS_CRm_MASK	(UL(0xf) << ESR_ELx_SYS64_ISS_CRm_SHIFT)
+#define ESR_ELx_SYS64_ISS_CRn_SHIFT	10
+#define ESR_ELx_SYS64_ISS_CRn_MASK	(UL(0xf) << ESR_ELx_SYS64_ISS_CRn_SHIFT)
+#define ESR_ELx_SYS64_ISS_Op1_SHIFT	14
+#define ESR_ELx_SYS64_ISS_Op1_MASK	(UL(0x7) << ESR_ELx_SYS64_ISS_Op1_SHIFT)
+#define ESR_ELx_SYS64_ISS_Op2_SHIFT	17
+#define ESR_ELx_SYS64_ISS_Op2_MASK	(UL(0x7) << ESR_ELx_SYS64_ISS_Op2_SHIFT)
+#define ESR_ELx_SYS64_ISS_Op0_SHIFT	20
+#define ESR_ELx_SYS64_ISS_Op0_MASK	(UL(0x3) << ESR_ELx_SYS64_ISS_Op0_SHIFT)
+#define ESR_ELx_SYS64_ISS_SYS_MASK	(ESR_ELx_SYS64_ISS_Op0_MASK | \
+					 ESR_ELx_SYS64_ISS_Op1_MASK | \
+					 ESR_ELx_SYS64_ISS_Op2_MASK | \
+					 ESR_ELx_SYS64_ISS_CRn_MASK | \
+					 ESR_ELx_SYS64_ISS_CRm_MASK)
+#define ESR_ELx_SYS64_ISS_SYS_VAL(Op0, Op1, Op2, CRn, CRm) \
+					(((Op0) << ESR_ELx_SYS64_ISS_Op0_SHIFT) | \
+					 ((Op1) << ESR_ELx_SYS64_ISS_Op1_SHIFT) | \
+					 ((Op2) << ESR_ELx_SYS64_ISS_Op2_SHIFT) | \
+					 ((CRn) << ESR_ELx_SYS64_ISS_CRn_SHIFT) | \
+					 ((CRm) << ESR_ELx_SYS64_ISS_CRm_SHIFT))
+/*
+ * User space cache operations have the following sysreg encoding
+ * in System instructions.
+ * Op0=1, Op1=3, Op2=1, CRn=7, CRm={ 5, 10, 11, 14 }, WRITE (L=0)
+ */
+#define ESR_ELx_SYS64_ISS_CRm_DC_CIVAC	14
+#define ESR_ELx_SYS64_ISS_CRm_DC_CVAU	11
+#define ESR_ELx_SYS64_ISS_CRm_DC_CVAC	10
+#define ESR_ELx_SYS64_ISS_CRm_IC_IVAU	5
+
+#define ESR_ELx_SYS64_ISS_U_CACHE_OP_MASK	(ESR_ELx_SYS64_ISS_Op0_MASK | \
+						 ESR_ELx_SYS64_ISS_Op1_MASK | \
+						 ESR_ELx_SYS64_ISS_Op2_MASK | \
+						 ESR_ELx_SYS64_ISS_CRn_MASK | \
+						 ESR_ELx_SYS64_ISS_DIR_MASK)
+#define ESR_ELx_SYS64_ISS_U_CACHE_OP_VAL \
+				(ESR_ELx_SYS64_ISS_SYS_VAL(1, 3, 1, 7, 0) | \
+				 ESR_ELx_SYS64_ISS_DIR_WRITE)
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e04f838..93c5287 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -447,36 +447,29 @@ void cpu_enable_cache_maint_trap(void *__unused)
 		: "=r" (res)					\
 		: "r" (address), "i" (-EFAULT) )
 
-asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
+static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 {
 	unsigned long address;
-	int ret;
+	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	int crm = (esr & ESR_ELx_SYS64_ISS_CRm_MASK) >> ESR_ELx_SYS64_ISS_CRm_SHIFT;
+	int ret = 0;
 
-	/* if this is a write with: Op0=1, Op2=1, Op1=3, CRn=7 */
-	if ((esr & 0x01fffc01) == 0x0012dc00) {
-		int rt = (esr >> 5) & 0x1f;
-		int crm = (esr >> 1) & 0x0f;
+	address = (rt == 31) ? 0 : regs->regs[rt];
 
-		address = (rt == 31) ? 0 : regs->regs[rt];
-
-		switch (crm) {
-		case 11:		/* DC CVAU, gets promoted */
-			__user_cache_maint("dc civac", address, ret);
-			break;
-		case 10:		/* DC CVAC, gets promoted */
-			__user_cache_maint("dc civac", address, ret);
-			break;
-		case 14:		/* DC CIVAC */
-			__user_cache_maint("dc civac", address, ret);
-			break;
-		case 5:			/* IC IVAU */
-			__user_cache_maint("ic ivau", address, ret);
-			break;
-		default:
-			force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
-			return;
-		}
-	} else {
+	switch (crm) {
+	case ESR_ELx_SYS64_ISS_CRm_DC_CVAU:	/* DC CVAU, gets promoted */
+		__user_cache_maint("dc civac", address, ret);
+		break;
+	case ESR_ELx_SYS64_ISS_CRm_DC_CVAC:	/* DC CVAC, gets promoted */
+		__user_cache_maint("dc civac", address, ret);
+		break;
+	case ESR_ELx_SYS64_ISS_CRm_DC_CIVAC:	/* DC CIVAC */
+		__user_cache_maint("dc civac", address, ret);
+		break;
+	case ESR_ELx_SYS64_ISS_CRm_IC_IVAU:	/* IC IVAU */
+		__user_cache_maint("ic ivau", address, ret);
+		break;
+	default:
 		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 		return;
 	}
@@ -487,6 +480,34 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 		regs->pc += 4;
 }
 
+struct sys64_hook {
+	unsigned int esr_mask;
+	unsigned int esr_val;
+	void (*handler)(unsigned int esr, struct pt_regs *regs);
+};
+
+static struct sys64_hook sys64_hooks[] = {
+	{
+		.esr_mask = ESR_ELx_SYS64_ISS_U_CACHE_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_U_CACHE_OP_VAL,
+		.handler = user_cache_maint_handler,
+	},
+	{},
+};
+
+asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
+{
+	struct sys64_hook *hook;
+
+	for (hook = sys64_hooks; hook->handler; hook++)
+		if ((hook->esr_mask & esr) == hook->esr_val) {
+			hook->handler(esr, regs);
+			return;
+		}
+
+	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+}
+
 long compat_arm_syscall(struct pt_regs *regs);
 
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
-- 
2.7.4
