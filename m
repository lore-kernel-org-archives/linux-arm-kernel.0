From: james.morse@arm.com (James Morse)
Date: Tue,  2 Feb 2016 17:03:29 +0000
Subject: [PATCH v1 3/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <1454432611-21333-1-git-send-email-james.morse@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
Message-ID: <1454432611-21333-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'User Access Override' is a new ARMv8.2 feature which allows the
unprivileged load and store instructions to be overridden to behave in
the normal way.

This patch converts {get,put}_user() and friends to use ldtr*/sttr*
instructions - so that they can only access EL0 memory, then enables
UAO when fs==KERNEL_DS so that these functions can access kernel memory.

This allows user space's read/write permissions to be checked against the
page tables, instead of testing addr<USER_DS, then using the kernel's
read/write permissions.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig                   | 21 +++++++++++
 arch/arm64/include/asm/alternative.h | 72 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h  |  3 +-
 arch/arm64/include/asm/processor.h   |  1 +
 arch/arm64/include/asm/sysreg.h      |  6 +++
 arch/arm64/include/asm/thread_info.h |  6 +++
 arch/arm64/include/asm/uaccess.h     | 44 ++++++++++++++++------
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kernel/cpufeature.c       | 25 +++++++++++++
 arch/arm64/kernel/process.c          | 20 ++++++++++
 arch/arm64/lib/clear_user.S          |  8 ++--
 arch/arm64/lib/copy_from_user.S      |  8 ++--
 arch/arm64/lib/copy_in_user.S        | 16 ++++----
 arch/arm64/lib/copy_to_user.S        |  8 ++--
 arch/arm64/mm/fault.c                | 18 ++++++---
 15 files changed, 218 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc62289a63e..63f2cca9e0ea 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -752,6 +752,27 @@ config ARM64_LSE_ATOMICS
 
 endmenu
 
+config ARM64_UAO
+	bool "Enable support for User Access Override (UAO)"
+	default y
+	help
+	 User Access Override (UAO; part of the ARMv8.2 Extensions)
+	 causes the 'unprivileged' variant of the load/store instructions to
+	 be overriden to be privileged.
+
+	 This option changes get_user() and friends to use the 'unprivileged'
+	 variant of the load/store instructions. This ensures that user-space
+	 really did have access to the supplied memory. When addr_limit is
+	 set to kernel memory the UAO bit will be set, allowing privileged
+	 access to kernel memory.
+
+	 Choosing this option will cause copy_to_user() et al to use user-space
+	 memory permissions.
+
+	 The feature is detected at runtime, the kernel will use the
+	 regular load/store instructions if the cpu does not implement the
+	 feature.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index e4962f04201e..a9fc24ec1aa9 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_ALTERNATIVE_H
 #define __ASM_ALTERNATIVE_H
 
+#include <asm/cpufeature.h>
+
 #ifndef __ASSEMBLY__
 
 #include <linux/init.h>
@@ -63,6 +65,8 @@ void apply_alternatives(void *start, size_t length);
 
 #else
 
+#include <asm/assembler.h>
+
 .macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
 	.word \orig_offset - .
 	.word \alt_offset - .
@@ -136,6 +140,74 @@ void apply_alternatives(void *start, size_t length);
 	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
 
 
+/*
+ * Generate the assembly for UAO alternatives with exception table entries.
+ * This is complicated as there is no post-increment or pair versions of the
+ * unprivileged instructions, and USER() only works for single instructions.
+ */
+#ifdef CONFIG_ARM64_UAO
+	.macro uao_ldp l, reg1, reg2, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			ldp	\reg1, \reg2, [\addr], \post_inc;
+8889:			nop;
+			nop;
+		alternative_else
+			ldtr	\reg1, [\addr];
+			ldtr	\reg2, [\addr, #8];
+			add	\addr, \addr, \post_inc;
+		alternative_endif
+
+		.section __ex_table,"a";
+		.align	3;
+		.quad	8888b,\l;
+		.quad	8889b,\l;
+		.previous;
+	.endm
+
+	.macro uao_stp l, reg1, reg2, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			stp	\reg1, \reg2, [\addr], \post_inc;
+8889:			nop;
+			nop;
+		alternative_else
+			sttr	\reg1, [\addr];
+			sttr	\reg2, [\addr, #8];
+			add	\addr, \addr, \post_inc;
+		alternative_endif
+
+		.section __ex_table,"a";
+		.align	3;
+		.quad	8888b,\l;
+		.quad	8889b,\l;
+		.previous
+	.endm
+
+	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			\inst	\reg, [\addr], \post_inc;
+			nop;
+		alternative_else
+			\alt_inst	\reg, [\addr];
+			add		\addr, \addr, \post_inc;
+		alternative_endif
+
+		.section __ex_table,"a";
+		.align	3;
+		.quad	8888b,\l;
+		.previous
+	.endm
+#else
+	.macro uao_ldp l, reg1, reg2, addr, post_inc
+		USER(\l, ldp \reg1, \reg2, [\addr], \post_inc)
+	.endm
+	.macro uao_stp l, reg1, reg2, addr, post_inc
+		USER(\l, stp \reg1, \reg2, [\addr], \post_inc)
+	.endm
+	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
+		USER(\l, \inst \reg, [\addr], \post_inc)
+	.endm
+#endif
+
 #endif  /*  __ASSEMBLY__  */
 
 /*
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index d28e8b27ee59..349e8203d16e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,8 +30,9 @@
 #define ARM64_HAS_LSE_ATOMICS			5
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
+#define ARM64_HAS_UAO				8
 
-#define ARM64_NCAPS				8
+#define ARM64_NCAPS				9
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 4acb7ca94fcd..611ee4e5c89d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -187,5 +187,6 @@ static inline void spin_lock_prefetch(const void *x)
 #endif
 
 void cpu_enable_pan(void *__unused);
+void cpu_enable_uao(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6d2cec2fcfd5..11378a92e50b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -79,9 +79,12 @@
 #define SYS_DCZID_EL0			sys_reg(3, 3, 0, 0, 7)
 
 #define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
+#define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
 
 #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
+#define SET_PSTATE_UAO(x) __inst_arm(0xd5000000 | REG_PSTATE_UAO_IMM |\
+				     (!!x)<<8 | 0x1f)
 
 /* SCTLR_EL1 */
 #define SCTLR_EL1_CP15BEN	(0x1 << 5)
@@ -138,6 +141,9 @@
 #define ID_AA64MMFR1_VMIDBITS_SHIFT	4
 #define ID_AA64MMFR1_HADBS_SHIFT	0
 
+/* id_aa64mmfr2 */
+#define ID_AA64MMFR2_UAO_SHIFT		4
+
 /* id_aa64dfr0 */
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
 #define ID_AA64DFR0_WRPS_SHIFT		20
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index abd64bd1f6d9..eba8db6838af 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -85,6 +85,12 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)sp_el0;
 }
 
+/* Access struct thread_info of another thread */
+static inline struct thread_info *get_thread_info(unsigned long thread_stack)
+{
+	return (struct thread_info *)(thread_stack & ~(THREAD_SIZE - 1));
+}
+
 #define thread_saved_pc(tsk)	\
 	((unsigned long)(tsk->thread.cpu_context.pc))
 #define thread_saved_sp(tsk)	\
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index b2ede967fe7d..f973bdce8410 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -64,6 +64,16 @@ extern int fixup_exception(struct pt_regs *regs);
 static inline void set_fs(mm_segment_t fs)
 {
 	current_thread_info()->addr_limit = fs;
+
+	/*
+	 * Enable/disable UAO so that copy_to_user() etc can access
+	 * kernel memory with the unprivileged instructions.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_UAO) && fs == KERNEL_DS)
+		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(1), ARM64_HAS_UAO));
+	else
+		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(0), ARM64_HAS_UAO,
+				CONFIG_ARM64_UAO));
 }
 
 #define segment_eq(a, b)	((a) == (b))
@@ -113,9 +123,10 @@ static inline void set_fs(mm_segment_t fs)
  * The "__xxx_error" versions set the third argument to -EFAULT if an error
  * occurs, and leave it unchanged on success.
  */
-#define __get_user_asm(instr, reg, x, addr, err)			\
+#define __get_user_asm(instr, alt_instr, reg, x, addr, err, feature)	\
 	asm volatile(							\
-	"1:	" instr "	" reg "1, [%2]\n"			\
+	"1:"ALTERNATIVE(instr "     " reg "1, [%2]\n",			\
+			alt_instr " " reg "1, [%2]\n", feature)		\
 	"2:\n"								\
 	"	.section .fixup, \"ax\"\n"				\
 	"	.align	2\n"						\
@@ -138,16 +149,20 @@ do {									\
 			CONFIG_ARM64_PAN));				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__get_user_asm("ldrb", "%w", __gu_val, (ptr), (err));	\
+		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 2:								\
-		__get_user_asm("ldrh", "%w", __gu_val, (ptr), (err));	\
+		__get_user_asm("ldrh", "ldtrh", "%w", __gu_val, (ptr),  \
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 4:								\
-		__get_user_asm("ldr", "%w", __gu_val, (ptr), (err));	\
+		__get_user_asm("ldr", "ldtr", "%w", __gu_val, (ptr),	\
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__get_user_asm("ldr", "%",  __gu_val, (ptr), (err));	\
+		__get_user_asm("ldr", "ldtr", "%",  __gu_val, (ptr),	\
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -181,9 +196,10 @@ do {									\
 		((x) = 0, -EFAULT);					\
 })
 
-#define __put_user_asm(instr, reg, x, addr, err)			\
+#define __put_user_asm(instr, alt_instr, reg, x, addr, err, feature)	\
 	asm volatile(							\
-	"1:	" instr "	" reg "1, [%2]\n"			\
+	"1:"ALTERNATIVE(instr "     " reg "1, [%2]\n",			\
+			alt_instr " " reg "1, [%2]\n", feature)		\
 	"2:\n"								\
 	"	.section .fixup,\"ax\"\n"				\
 	"	.align	2\n"						\
@@ -205,16 +221,20 @@ do {									\
 			CONFIG_ARM64_PAN));				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__put_user_asm("strb", "%w", __pu_val, (ptr), (err));	\
+		__put_user_asm("strb", "sttrb", "%w", __pu_val, (ptr),	\
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 2:								\
-		__put_user_asm("strh", "%w", __pu_val, (ptr), (err));	\
+		__put_user_asm("strh", "sttrh", "%w", __pu_val, (ptr),	\
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 4:								\
-		__put_user_asm("str",  "%w", __pu_val, (ptr), (err));	\
+		__put_user_asm("str", "sttr", "%w", __pu_val, (ptr),	\
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__put_user_asm("str",  "%", __pu_val, (ptr), (err));	\
+		__put_user_asm("str", "sttr", "%", __pu_val, (ptr),	\
+			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 208db3df135a..b5c3933ed441 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -45,6 +45,7 @@
 #define PSR_A_BIT	0x00000100
 #define PSR_D_BIT	0x00000200
 #define PSR_PAN_BIT	0x00400000
+#define PSR_UAO_BIT	0x00800000
 #define PSR_Q_BIT	0x08000000
 #define PSR_V_BIT	0x10000000
 #define PSR_C_BIT	0x20000000
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a4f665f95f9f..b25c6a2c5e0f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -124,6 +124,7 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 };
 
 static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -659,6 +660,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+#ifdef CONFIG_ARM64_UAO
+	{
+		.desc = "User Access Override",
+		.capability = ARM64_HAS_UAO,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
+		.min_field_value = 1,
+		.enable = cpu_enable_uao,
+	},
+#endif /* CONFIG_ARM64_UAO */
 	{},
 };
 
@@ -937,3 +949,16 @@ void __init setup_cpu_features(void)
 		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
 			L1_CACHE_BYTES, cls);
 }
+
+#ifdef CONFIG_ARM64_UAO
+/*
+ * Kernel threads have fs=KERNEL_DS by default, and don't need to call
+ * set_fs(), devtmpfs in particular relies on this behaviour.
+ * We need to enable the feature@runtime (instead of adding it to
+ * PSR_MODE_EL1h) as the feature may not be implemented by the cpu.
+ */
+void cpu_enable_uao(void *__unused)
+{
+	asm(SET_PSTATE_UAO(1));
+}
+#endif /* CONFIG_ARM64_UAO */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 88d742ba19d5..8fcf582c18d7 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -46,6 +46,7 @@
 #include <linux/notifier.h>
 #include <trace/events/power.h>
 
+#include <asm/alternative.h>
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/fpsimd.h>
@@ -280,6 +281,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
+		if (IS_ENABLED(CONFIG_ARM64_UAO) &&
+		    cpus_have_cap(ARM64_HAS_UAO))
+			childregs->pstate |= PSR_UAO_BIT;
 		p->thread.cpu_context.x19 = stack_start;
 		p->thread.cpu_context.x20 = stk_sz;
 	}
@@ -308,6 +312,20 @@ static void tls_thread_switch(struct task_struct *next)
 	: : "r" (tpidr), "r" (tpidrro));
 }
 
+/* Restore the UAO state depending on next's addr_limit */
+static void uao_thread_switch(struct task_struct *next)
+{
+	unsigned long next_sp = next->thread.cpu_context.sp;
+
+	if (IS_ENABLED(CONFIG_ARM64_UAO) &&
+	    get_thread_info(next_sp)->addr_limit == KERNEL_DS)
+		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(1), ARM64_HAS_UAO,
+			        CONFIG_ARM64_UAO));
+	else
+		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(0), ARM64_HAS_UAO,
+				CONFIG_ARM64_UAO));
+}
+
 /*
  * Thread switching.
  */
@@ -327,6 +345,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	dsb(ish);
 
+	uao_thread_switch(next);
+
 	/* the actual thread switch */
 	last = cpu_switch_to(prev, next);
 
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index a9723c71c52b..3f950b677c07 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -39,20 +39,20 @@ ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	subs	x1, x1, #8
 	b.mi	2f
 1:
-USER(9f, str	xzr, [x0], #8	)
+uao_user_alternative 9f, str, sttr, xzr, x0, 8
 	subs	x1, x1, #8
 	b.pl	1b
 2:	adds	x1, x1, #4
 	b.mi	3f
-USER(9f, str	wzr, [x0], #4	)
+uao_user_alternative 9f, str, sttr, wzr, x0, 4
 	sub	x1, x1, #4
 3:	adds	x1, x1, #2
 	b.mi	4f
-USER(9f, strh	wzr, [x0], #2	)
+uao_user_alternative 9f, strh, sttrh, wzr, x0, 2
 	sub	x1, x1, #2
 4:	adds	x1, x1, #1
 	b.mi	5f
-USER(9f, strb	wzr, [x0]	)
+uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
 5:	mov	x0, #0
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 4699cd74f87e..1d982d64f1a7 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -34,7 +34,7 @@
  */
 
 	.macro ldrb1 ptr, regB, val
-	USER(9998f, ldrb  \ptr, [\regB], \val)
+	uao_user_alternative 9998f, ldrb, ldtrb, \ptr, \regB, \val
 	.endm
 
 	.macro strb1 ptr, regB, val
@@ -42,7 +42,7 @@
 	.endm
 
 	.macro ldrh1 ptr, regB, val
-	USER(9998f, ldrh  \ptr, [\regB], \val)
+	uao_user_alternative 9998f, ldrh, ldtrh, \ptr, \regB, \val
 	.endm
 
 	.macro strh1 ptr, regB, val
@@ -50,7 +50,7 @@
 	.endm
 
 	.macro ldr1 ptr, regB, val
-	USER(9998f, ldr \ptr, [\regB], \val)
+	uao_user_alternative 9998f, ldr, ldtr, \ptr, \regB, \val
 	.endm
 
 	.macro str1 ptr, regB, val
@@ -58,7 +58,7 @@
 	.endm
 
 	.macro ldp1 ptr, regB, regC, val
-	USER(9998f, ldp \ptr, \regB, [\regC], \val)
+	uao_ldp 9998f, \ptr, \regB, \regC, \val
 	.endm
 
 	.macro stp1 ptr, regB, regC, val
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 81c8fc93c100..feaad1520dc1 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -35,35 +35,35 @@
  *	x0 - bytes not copied
  */
 	.macro ldrb1 ptr, regB, val
-	USER(9998f, ldrb  \ptr, [\regB], \val)
+	uao_user_alternative 9998f, ldrb, ldtrb, \ptr, \regB, \val
 	.endm
 
 	.macro strb1 ptr, regB, val
-	USER(9998f, strb \ptr, [\regB], \val)
+	uao_user_alternative 9998f, strb, sttrb, \ptr, \regB, \val
 	.endm
 
 	.macro ldrh1 ptr, regB, val
-	USER(9998f, ldrh  \ptr, [\regB], \val)
+	uao_user_alternative 9998f, ldrh, ldtrh, \ptr, \regB, \val
 	.endm
 
 	.macro strh1 ptr, regB, val
-	USER(9998f, strh \ptr, [\regB], \val)
+	uao_user_alternative 9998f, strh, sttrh, \ptr, \regB, \val
 	.endm
 
 	.macro ldr1 ptr, regB, val
-	USER(9998f, ldr \ptr, [\regB], \val)
+	uao_user_alternative 9998f, ldr, ldtr, \ptr, \regB, \val
 	.endm
 
 	.macro str1 ptr, regB, val
-	USER(9998f, str \ptr, [\regB], \val)
+	uao_user_alternative 9998f, str, sttr, \ptr, \regB, \val
 	.endm
 
 	.macro ldp1 ptr, regB, regC, val
-	USER(9998f, ldp \ptr, \regB, [\regC], \val)
+	uao_ldp 9998f, \ptr, \regB, \regC, \val
 	.endm
 
 	.macro stp1 ptr, regB, regC, val
-	USER(9998f, stp \ptr, \regB, [\regC], \val)
+	uao_stp 9998f, \ptr, \regB, \regC, \val
 	.endm
 
 end	.req	x5
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 7512bbbc07ac..2dae2cd2c481 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -37,7 +37,7 @@
 	.endm
 
 	.macro strb1 ptr, regB, val
-	USER(9998f, strb \ptr, [\regB], \val)
+	uao_user_alternative 9998f, strb, sttrb, \ptr, \regB, \val
 	.endm
 
 	.macro ldrh1 ptr, regB, val
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro strh1 ptr, regB, val
-	USER(9998f, strh \ptr, [\regB], \val)
+	uao_user_alternative 9998f, strh, sttrh, \ptr, \regB, \val
 	.endm
 
 	.macro ldr1 ptr, regB, val
@@ -53,7 +53,7 @@
 	.endm
 
 	.macro str1 ptr, regB, val
-	USER(9998f, str \ptr, [\regB], \val)
+	uao_user_alternative 9998f, str, sttr, \ptr, \regB, \val
 	.endm
 
 	.macro ldp1 ptr, regB, regC, val
@@ -61,7 +61,7 @@
 	.endm
 
 	.macro stp1 ptr, regB, regC, val
-	USER(9998f, stp \ptr, \regB, [\regC], \val)
+	uao_stp 9998f, \ptr, \regB, \regC, \val
 	.endm
 
 end	.req	x5
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 92ddac1e8ca2..5ce2656b04df 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -192,6 +192,14 @@ out:
 	return fault;
 }
 
+static inline int permission_fault(unsigned int esr)
+{
+	unsigned int ec       = (esr & ESR_ELx_EC_MASK)>>ESR_ELx_EC_SHIFT;
+	unsigned int fsc_type = esr & ESR_ELx_FSC_TYPE;
+
+	return (ec == ESR_ELx_EC_DABT_CUR && fsc_type == ESR_ELx_FSC_PERM);
+}
+
 static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				   struct pt_regs *regs)
 {
@@ -225,12 +233,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
 
-	/*
-	 * PAN bit set implies the fault happened in kernel space, but not
-	 * in the arch's user access functions.
-	 */
-	if (IS_ENABLED(CONFIG_ARM64_PAN) && (regs->pstate & PSR_PAN_BIT))
-		goto no_context;
+	if (permission_fault(esr) && (addr < USER_DS)) {
+		if (!search_exception_tables(regs->pc))
+			panic("Accessing user space memory outside uaccess.h routines");
+	}
 
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
-- 
2.6.2
