From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  9 May 2016 17:49:50 +0100
Subject: [PATCH 6/6] arm64: trap userspace "dc cvau" cache operation on
 errata-affected core
In-Reply-To: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462812590-4494-7-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM errata 819472, 826319, 827319 and 824069 for affected
Cortex-A53 cores demand to promote "dc cvau" instructions to
"dc civac". Since we allow userspace to also emit those instructions,
we should make sure that "dc cvau" gets promoted there too.
So lets grasp the nettle here and actually trap every userland cache
maintenance instruction once we detect at least one affected core in
the system.
We then emulate the instruction by executing it on behalf of userland,
promoting "dc cvau" to "dc civac" on the way and injecting access
fault back into userspace.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/include/asm/sysreg.h    |  2 +-
 arch/arm64/kernel/cpu_errata.c     |  2 ++
 arch/arm64/kernel/entry.S          | 12 ++++++-
 arch/arm64/kernel/traps.c          | 71 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index cef1cf3..ace0a96 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -192,5 +192,6 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 void cpu_enable_pan(void *__unused);
 void cpu_enable_uao(void *__unused);
+void cpu_enable_cache_maint_trap(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1287416..7e0b097 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -90,7 +90,7 @@
 #define SCTLR_EL1_CP15BEN	(0x1 << 5)
 #define SCTLR_EL1_SED		(0x1 << 8)
 #define SCTLR_EL1_SPAN		(0x1 << 23)
-
+#define SCTLR_EL1_UCI		(0x1 << 26)
 
 /* id_aa64isar0 */
 #define ID_AA64ISAR0_RDM_SHIFT		28
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 64cb71d..3f54d23 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -44,6 +44,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "ARM errata 826319, 827319, 824069",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
 		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
+		.enable = cpu_enable_cache_maint_trap,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_819472
@@ -52,6 +53,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "ARM errata 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
 		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x01),
+		.enable = cpu_enable_cache_maint_trap,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_832075
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 12e8d2b..86480b4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -451,7 +451,7 @@ el0_sync:
 	cmp	x24, #ESR_ELx_EC_FP_EXC64	// FP/ASIMD exception
 	b.eq	el0_fpsimd_exc
 	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
-	b.eq	el0_undef
+	b.eq	el0_sys
 	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
 	b.eq	el0_sp_pc
 	cmp	x24, #ESR_ELx_EC_PC_ALIGN	// pc alignment exception
@@ -579,6 +579,16 @@ el0_undef:
 	mov	x0, sp
 	bl	do_undefinstr
 	b	ret_to_user
+el0_sys:
+	/*
+	 * System instructions, for trapped cache maintenance instructions
+	 */
+	enable_dbg_and_irq
+	ct_user_exit
+	mov	x0, x25
+	mov	x1, sp
+	bl	do_sysinstr
+	b	ret_to_user
 el0_dbg:
 	/*
 	 * Debug exception handling
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 03755a4..c2a158e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -41,6 +41,7 @@
 #include <asm/stacktrace.h>
 #include <asm/exception.h>
 #include <asm/system_misc.h>
+#include <asm/sysreg.h>
 
 static const char *handler[]= {
 	"Synchronous Abort",
@@ -419,6 +420,76 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
+void cpu_enable_cache_maint_trap(void *__unused)
+{
+	config_sctlr_el1(SCTLR_EL1_UCI, 0);
+}
+
+#define __user_cache_maint(insn, address, res)			\
+	asm volatile (						\
+		"1:	" insn ", %1\n"				\
+		"	mov	%w0, #0\n"			\
+		"2:\n"						\
+		"	.pushsection .fixup,\"ax\"\n"		\
+		"	.align	2\n"				\
+		"3:	mov	%w0, %w2\n"			\
+		"	b	2b\n"				\
+		"	.popsection\n"				\
+		_ASM_EXTABLE(1b, 3b)				\
+		: "=r" (res)					\
+		: "r" (address), "i" (-EFAULT)			\
+		: "memory")
+
+asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
+{
+	unsigned long address;
+	int ret;
+
+	/* if this is a write with: Op0=1, Op2=1, Op1=3, CRn=7 */
+	if ((esr & 0x01fffc01) == 0x0012dc00) {
+		int rt = (esr >> 5) & 0x1f;
+		int crm = (esr >> 1) & 0x0f;
+
+		address = regs->regs[rt];
+
+		switch (crm) {
+		case 11:		/* DC CVAU, gets promoted */
+			__user_cache_maint("dc civac", address, ret);
+			break;
+		case 10:		/* DC CVAC, gets promoted */
+			__user_cache_maint("dc civac", address, ret);
+			break;
+		case 14:		/* DC CIVAC */
+			__user_cache_maint("dc civac", address, ret);
+			break;
+		case 5:			/* IC IVAU */
+			__user_cache_maint("ic ivau", address, ret);
+			break;
+		default:
+			force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+			return;
+		}
+	} else {
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+		return;
+	}
+
+	if (ret) {
+		int sig_code;
+
+		down_read(&current->mm->mmap_sem);
+		if (find_vma(current->mm, address) == NULL)
+			sig_code = SEGV_MAPERR;
+		else
+			sig_code = SEGV_ACCERR;
+		up_read(&current->mm->mmap_sem);
+
+		force_signal_inject(SIGSEGV, sig_code, regs, address);
+	} else {
+		regs->pc += 4;
+	}
+}
+
 long compat_arm_syscall(struct pt_regs *regs);
 
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
-- 
2.7.3
