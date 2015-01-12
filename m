From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 16:45:16 +0000
Subject: [PATCHv2 3/7] arm64: decode ESR_ELx.EC when reporting exceptions
In-Reply-To: <1421081120-7694-1-git-send-email-mark.rutland@arm.com>
References: <1421081120-7694-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421081120-7694-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid the developer when something triggers an unexpected exception,
decode the ESR_ELx.EC field when logging an ESR_ELx value. This doesn't
tell the developer the specifics of the exception encoded in the
remaining IL and ISS bits, but it can be helpful to distinguish between
exception classes (e.g. SError and a data abort) without having to
manually decode the field, which can be tiresome.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h |  6 ++++++
 arch/arm64/kernel/traps.c    | 50 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 0fd1b0e..c315543 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -133,4 +133,10 @@
 #define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
 #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
 
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+
+const char *esr_get_class_string(u32 esr);
+#endif /* __ASSEMBLY */
+
 #endif /* __ASM_ESR_H */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0a801e3..1ef2940 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -33,6 +33,7 @@
 
 #include <asm/atomic.h>
 #include <asm/debug-monitors.h>
+#include <asm/esr.h>
 #include <asm/traps.h>
 #include <asm/stacktrace.h>
 #include <asm/exception.h>
@@ -373,6 +374,51 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 	return sys_ni_syscall();
 }
 
+static const char *esr_class_str[] = {
+	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
+	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
+	[ESR_ELx_EC_WFx]		= "WFI/WFE",
+	[ESR_ELx_EC_CP15_32]		= "CP15 MCR/MRC",
+	[ESR_ELx_EC_CP15_64]		= "CP15 MCRR/MRRC",
+	[ESR_ELx_EC_CP14_MR]		= "CP14 MCR/MRC",
+	[ESR_ELx_EC_CP14_LS]		= "CP14 LDC/STC",
+	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
+	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
+	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
+	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
+	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
+	[ESR_ELx_EC_HVC32]		= "HVC (AArch32)",
+	[ESR_ELx_EC_SMC32]		= "SMC (AArch32)",
+	[ESR_ELx_EC_SVC64]		= "SVC (AArch64)",
+	[ESR_ELx_EC_HVC64]		= "HVC (AArch64)",
+	[ESR_ELx_EC_SMC64]		= "SMC (AArch64)",
+	[ESR_ELx_EC_SYS64]		= "MSR/MRS (AArch64)",
+	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
+	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
+	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
+	[ESR_ELx_EC_PC_ALIGN]		= "PC Alignment",
+	[ESR_ELx_EC_DABT_LOW]		= "DABT (lower EL)",
+	[ESR_ELx_EC_DABT_CUR]		= "DABT (current EL)",
+	[ESR_ELx_EC_SP_ALIGN]		= "SP Alignment",
+	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
+	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
+	[ESR_ELx_EC_SERROR]		= "SError",
+	[ESR_ELx_EC_BREAKPT_LOW]	= "Breakpoint (lower EL)",
+	[ESR_ELx_EC_BREAKPT_CUR]	= "Breakpoint (current EL)",
+	[ESR_ELx_EC_SOFTSTP_LOW]	= "Software Step (lower EL)",
+	[ESR_ELx_EC_SOFTSTP_CUR]	= "Software Step (current EL)",
+	[ESR_ELx_EC_WATCHPT_LOW]	= "Watchpoint (lower EL)",
+	[ESR_ELx_EC_WATCHPT_CUR]	= "Watchpoint (current EL)",
+	[ESR_ELx_EC_BKPT32]		= "BKPT (AArch32)",
+	[ESR_ELx_EC_VECTOR32]		= "Vector catch (AArch32)",
+	[ESR_ELx_EC_BRK64]		= "BRK (AArch64)",
+};
+
+const char *esr_get_class_string(u32 esr)
+{
+	return esr_class_str[esr >> ESR_ELx_EC_SHIFT];
+}
+
 /*
  * bad_mode handles the impossible case in the exception vector.
  */
@@ -382,8 +428,8 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 	void __user *pc = (void __user *)instruction_pointer(regs);
 	console_verbose();
 
-	pr_crit("Bad mode in %s handler detected, code 0x%08x\n",
-		handler[reason], esr);
+	pr_crit("Bad mode in %s handler detected, code 0x%08x -- %s\n",
+		handler[reason], esr, esr_get_class_string(esr));
 	__show_regs(regs);
 
 	info.si_signo = SIGILL;
-- 
1.9.1
