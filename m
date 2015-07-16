From: james.morse@arm.com (James Morse)
Date: Thu, 16 Jul 2015 17:01:59 +0100
Subject: [PATCH 5/5] arm64: kernel: Add support for Privileged Access Never
In-Reply-To: <1437062519-18883-1-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
Message-ID: <1437062519-18883-6-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'Privileged Access Never' is a new armv8.1 feature which prevents
privileged code from accessing any virtual address where read or write
access is also permitted at EL0.

This patch enables the PAN feature on all CPUs, and modifies {get,put}_user
helpers temporarily to permit access.

This will catch kernel bugs where user memory is accessed directly.
'Unprivileged loads and stores' using ldtrb et al are unaffected by PAN.

This has been tested for regressions on juno and an armv8.1
enabled model using ltp and a custom module intended to trip a pan-fault

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                  | 14 ++++++++++++++
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/include/asm/futex.h      |  8 ++++++++
 arch/arm64/include/asm/processor.h  |  2 ++
 arch/arm64/include/asm/sysreg.h     |  9 +++++++++
 arch/arm64/include/asm/uaccess.h    | 11 +++++++++++
 arch/arm64/kernel/cpufeature.c      | 22 ++++++++++++++++++++++
 arch/arm64/kernel/process.c         |  3 +++
 arch/arm64/lib/clear_user.S         |  8 ++++++++
 arch/arm64/lib/copy_from_user.S     |  8 ++++++++
 arch/arm64/lib/copy_in_user.S       |  8 ++++++++
 arch/arm64/lib/copy_to_user.S       |  8 ++++++++
 arch/arm64/mm/fault.c               | 23 +++++++++++++++++++++++
 13 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f62c24..c53a4b1d5968 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -597,6 +597,20 @@ config FORCE_MAX_ZONEORDER
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
 	default "11"
 
+config ARM64_PAN
+	bool "Enable support for Privileged Access Never (PAN)"
+	default y
+	help
+	 Privileged Access Never (PAN; part of the ARMv8.1 Extensions)
+	 prevents the kernel or hypervisor from accessing user-space (EL0)
+	 memory directly.
+
+	 Choosing this option will cause any unprotected (not using
+	 copy_to_user et al) memory access to fail with a permission fault.
+
+	 The feature is detected at runtime, and will remain as a 'nop'
+	 instruction if the cpu does not implement the feature.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 680a6a1f087e..27ff67d99af5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -25,8 +25,9 @@
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
 #define ARM64_WORKAROUND_845719			2
 #define ARM64_HAS_SYSREG_GIC_CPUIF		3
+#define ARM64_HAS_PAN				4
 
-#define ARM64_NCAPS				4
+#define ARM64_NCAPS				5
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 74069b3bd919..775e85b9d1f2 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -20,10 +20,16 @@
 
 #include <linux/futex.h>
 #include <linux/uaccess.h>
+
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/errno.h>
+#include <asm/sysreg.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)		\
 	asm volatile(							\
+	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,		\
+		    CONFIG_ARM64_PAN)					\
 "1:	ldxr	%w1, %2\n"						\
 	insn "\n"							\
 "2:	stlxr	%w3, %w0, %2\n"						\
@@ -39,6 +45,8 @@
 "	.align	3\n"							\
 "	.quad	1b, 4b, 2b, 4b\n"					\
 "	.popsection\n"							\
+	ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,		\
+		    CONFIG_ARM64_PAN)					\
 	: "=&r" (ret), "=&r" (oldval), "+Q" (*uaddr), "=&r" (tmp)	\
 	: "r" (oparg), "Ir" (-EFAULT)					\
 	: "memory")
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index e4c893e54f01..98f32355dc97 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -186,4 +186,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 #endif
 
+void cpu_enable_pan(void);
+
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7e419fabe75a..68aa1e399575 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,9 +20,18 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+#include <asm/opcodes.h>
+
 #define sys_reg(op0, op1, crn, crm, op2) \
 	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
 
+#define REG_PSTATE_PAN_IMM                     sys_reg(2, 0, 4, 0, 4)
+#define PSTATE_PAN                             (1 << 22)
+#define SCTLR_EL1_SPAN                         (1 << 23)
+
+#define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
+				     (!!x)<<8 | 0x1f)
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07e1ba449bf1..b2ede967fe7d 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -24,7 +24,10 @@
 #include <linux/string.h>
 #include <linux/thread_info.h>
 
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 #include <asm/errno.h>
 #include <asm/memory.h>
 #include <asm/compiler.h>
@@ -131,6 +134,8 @@ static inline void set_fs(mm_segment_t fs)
 do {									\
 	unsigned long __gu_val;						\
 	__chk_user_ptr(ptr);						\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
+			CONFIG_ARM64_PAN));				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__get_user_asm("ldrb", "%w", __gu_val, (ptr), (err));	\
@@ -148,6 +153,8 @@ do {									\
 		BUILD_BUG();						\
 	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
+			CONFIG_ARM64_PAN));				\
 } while (0)
 
 #define __get_user(x, ptr)						\
@@ -194,6 +201,8 @@ do {									\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	__chk_user_ptr(ptr);						\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
+			CONFIG_ARM64_PAN));				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__put_user_asm("strb", "%w", __pu_val, (ptr), (err));	\
@@ -210,6 +219,8 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
+			CONFIG_ARM64_PAN));				\
 } while (0)
 
 #define __put_user(x, ptr)						\
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f260affb825c..0464eaef6667 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/processor.h>
 
 static bool
 has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
@@ -32,6 +33,16 @@ has_id_aa64pfr0_feature(const struct arm64_cpu_capabilities *entry)
 		(val & entry->register_mask) <= entry->max_register_value);
 }
 
+static bool __maybe_unused
+has_id_aa64mmfr1_feature(const struct arm64_cpu_capabilities *entry)
+{
+	u64 val;
+
+	val = read_cpuid(id_aa64mmfr1_el1);
+	return ((val & entry->register_mask) >= entry->min_register_value &&
+		(val & entry->register_mask) <= entry->max_register_value);
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -41,6 +52,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_register_value = (1 << 24),
 		.max_register_value = (1 << 24),
 	},
+#ifdef CONFIG_ARM64_PAN
+	{
+		.desc = "Privileged Access Never",
+		.capability = ARM64_HAS_PAN,
+		.matches = has_id_aa64mmfr1_feature,
+		.register_mask = (0xf << 20),
+		.min_register_value = (1 << 20),
+		.max_register_value = (2 << 20),
+		.enable = cpu_enable_pan,
+	},
+#endif /* CONFIG_ARM64_PAN */
 	{},
 };
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 223b093c9440..cea69aae4997 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -277,6 +277,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
+		if (IS_ENABLED(CONFIG_ARM64_PAN) &&
+		    cpus_have_cap(ARM64_HAS_PAN))
+			childregs->pstate |= PSTATE_PAN;
 		p->thread.cpu_context.x19 = stack_start;
 		p->thread.cpu_context.x20 = stk_sz;
 	}
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index c17967fdf5f6..a9723c71c52b 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -16,7 +16,11 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/linkage.h>
+
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cpufeature.h>
+#include <asm/sysreg.h>
 
 	.text
 
@@ -29,6 +33,8 @@
  * Alignment fixed up by hardware.
  */
 ENTRY(__clear_user)
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
 	b.mi	2f
@@ -48,6 +54,8 @@ USER(9f, strh	wzr, [x0], #2	)
 	b.mi	5f
 USER(9f, strb	wzr, [x0]	)
 5:	mov	x0, #0
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__clear_user)
 
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 5e27add9d362..882c1544a73e 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -15,7 +15,11 @@
  */
 
 #include <linux/linkage.h>
+
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cpufeature.h>
+#include <asm/sysreg.h>
 
 /*
  * Copy from user space to a kernel buffer (alignment handled by the hardware)
@@ -28,6 +32,8 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_from_user)
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	add	x4, x1, x2			// upper user buffer boundary
 	subs	x2, x2, #8
 	b.mi	2f
@@ -51,6 +57,8 @@ USER(9f, ldrh	w3, [x1], #2	)
 USER(9f, ldrb	w3, [x1]	)
 	strb	w3, [x0]
 5:	mov	x0, #0
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__copy_from_user)
 
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 84b6c9bb9b93..97063c4cba75 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -17,7 +17,11 @@
  */
 
 #include <linux/linkage.h>
+
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cpufeature.h>
+#include <asm/sysreg.h>
 
 /*
  * Copy from user space to user space (alignment handled by the hardware)
@@ -30,6 +34,8 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_in_user)
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	add	x4, x0, x2			// upper user buffer boundary
 	subs	x2, x2, #8
 	b.mi	2f
@@ -53,6 +59,8 @@ USER(9f, strh	w3, [x0], #2	)
 USER(9f, ldrb	w3, [x1]	)
 USER(9f, strb	w3, [x0]	)
 5:	mov	x0, #0
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__copy_in_user)
 
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index a0aeeb9b7a28..c782aaf5494d 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -15,7 +15,11 @@
  */
 
 #include <linux/linkage.h>
+
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cpufeature.h>
+#include <asm/sysreg.h>
 
 /*
  * Copy to user space from a kernel buffer (alignment handled by the hardware)
@@ -28,6 +32,8 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_to_user)
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	add	x4, x0, x2			// upper user buffer boundary
 	subs	x2, x2, #8
 	b.mi	2f
@@ -51,6 +57,8 @@ USER(9f, strh	w3, [x0], #2	)
 	ldrb	w3, [x1]
 USER(9f, strb	w3, [x0]	)
 5:	mov	x0, #0
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__copy_to_user)
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 94d98cd1aad8..3c10dcf1537b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -30,9 +30,11 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 
+#include <asm/cpufeature.h>
 #include <asm/exception.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
+#include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -147,6 +149,13 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		__do_kernel_fault(mm, addr, esr, regs);
 }
 
+static bool pan_enabled(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_ARM64_PAN))
+		return ((regs->pstate & PSTATE_PAN) != 0);
+	return false;
+}
+
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
@@ -224,6 +233,13 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	}
 
 	/*
+	 * PAN bit set implies the fault happened in kernel space, but not
+	 * in the arch's user access functions.
+	 */
+	if (pan_enabled(regs))
+		goto no_context;
+
+	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
 	 * we can bug out early if this is from code which shouldn't.
@@ -536,3 +552,10 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 
 	return 0;
 }
+
+#ifdef CONFIG_ARM64_PAN
+void cpu_enable_pan(void)
+{
+	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+}
+#endif /* CONFIG_ARM64_PAN */
-- 
2.1.4
