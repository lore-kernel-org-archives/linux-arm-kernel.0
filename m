From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:07 +0100
Subject: [PATCH 06/18] arm64: atomics: patch in lse instructions when
 supported by the CPU
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
it makes sense to use them in preference to ll/sc sequences.

This patch introduces runtime patching of atomic_t and atomic64_t
routines so that the call-site for the out-of-line ll/sc sequences is
patched with an LSE atomic instruction when we detect that
the CPU supports it.

If binutils is not recent enough to assemble the LSE instructions, then
the ll/sc sequences are inlined as though CONFIG_ARM64_LSE_ATOMICS=n.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile                   |  13 +-
 arch/arm64/include/asm/atomic.h       |   4 +-
 arch/arm64/include/asm/atomic_ll_sc.h |  12 --
 arch/arm64/include/asm/atomic_lse.h   | 274 ++++++++++++++++++++--------------
 arch/arm64/include/asm/lse.h          |  36 +++++
 arch/arm64/kernel/setup.c             |   3 +
 6 files changed, 214 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm64/include/asm/lse.h

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4d2a925998f9..fa23c0dc3e77 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -17,7 +17,18 @@ GZFLAGS		:=-9
 
 KBUILD_DEFCONFIG := defconfig
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only
+# Check for binutils support for specific extensions
+lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
+
+ifeq ($(CONFIG_ARM64_LSE_ATOMICS), y)
+  ifeq ($(lseinstr),)
+$(warning LSE atomics not supported by binutils)
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
+KBUILD_AFLAGS	+= $(lseinstr)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 955cc14f3ce4..cb53efa23f62 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -21,11 +21,11 @@
 #define __ASM_ATOMIC_H
 
 #include <linux/compiler.h>
-#include <linux/stringify.h>
 #include <linux/types.h>
 
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
+#include <asm/lse.h>
 
 #define ATOMIC_INIT(i)	{ (i) }
 
@@ -33,7 +33,7 @@
 
 #define __ARM64_IN_ATOMIC_IMPL
 
-#ifdef CONFIG_ARM64_LSE_ATOMICS
+#if defined(CONFIG_ARM64_LSE_ATOMICS) && defined(CONFIG_AS_LSE)
 #include <asm/atomic_lse.h>
 #else
 #include <asm/atomic_ll_sc.h>
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 024b892dbc6a..9cf298914ac3 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -37,18 +37,6 @@
  * (the optimize attribute silently ignores these options).
  */
 
-#ifndef __LL_SC_INLINE
-#define __LL_SC_INLINE		static inline
-#endif
-
-#ifndef __LL_SC_PREFIX
-#define __LL_SC_PREFIX(x)	x
-#endif
-
-#ifndef __LL_SC_EXPORT
-#define __LL_SC_EXPORT(x)
-#endif
-
 #define ATOMIC_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
 __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 68ff1a8a7492..d59780350514 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -25,138 +25,172 @@
 #error "please don't include this file directly"
 #endif
 
-/* Move the ll/sc atomics out-of-line */
-#define __LL_SC_INLINE
-#define __LL_SC_PREFIX(x)	__ll_sc_##x
-#define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
-
-/* Macros for constructing calls to out-of-line ll/sc atomics */
-#define __LL_SC_SAVE_LR(r)	"mov\t" #r ", x30\n"
-#define __LL_SC_RESTORE_LR(r)	"mov\tx30, " #r "\n"
-#define __LL_SC_CALL(op)						\
-	"bl\t" __stringify(__LL_SC_PREFIX(atomic_##op)) "\n"
-#define __LL_SC_CALL64(op)						\
-	"bl\t" __stringify(__LL_SC_PREFIX(atomic64_##op)) "\n"
-
-#define ATOMIC_OP(op, asm_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long lr;						\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
-									\
-	asm volatile(							\
-	__LL_SC_SAVE_LR(%0)						\
-	__LL_SC_CALL(op)						\
-	__LL_SC_RESTORE_LR(%0)						\
-	: "=&r" (lr), "+r" (w0), "+Q" (v->counter)			\
-	: "r" (x1));							\
-}									\
-
-#define ATOMIC_OP_RETURN(op, asm_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned long lr;						\
-	register int w0 asm ("w0") = i;					\
-	register atomic_t *x1 asm ("x1") = v;				\
-									\
-	asm volatile(							\
-	__LL_SC_SAVE_LR(%0)						\
-	__LL_SC_CALL(op##_return)					\
-	__LL_SC_RESTORE_LR(%0)						\
-	: "=&r" (lr), "+r" (w0)						\
-	: "r" (x1)							\
-	: "memory");							\
-									\
-	return w0;							\
+#define __LL_SC_ATOMIC(op, tmp)						\
+	__LL_SC_SAVE_LR(tmp)						\
+	__LL_SC_CALL(atomic_##op)					\
+	__LL_SC_RESTORE_LR(tmp)
+
+static inline void atomic_add(int i, atomic_t *v)
+{
+	unsigned long tmp;
+	register int w0 asm ("w0") = i;
+	register atomic_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(add, %[tmp]),
+	"	nop\n"
+	"	stadd	%w[i], %[v]\n"
+	"	nop")
+	: [tmp] "=&r" (tmp), [i] "+r" (w0), [v] "+Q" (v->counter)
+	: "r" (x1));
 }
 
-#define ATOMIC_OPS(op, asm_op)						\
-	ATOMIC_OP(op, asm_op)						\
-	ATOMIC_OP_RETURN(op, asm_op)
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	unsigned long tmp;
+	register int w0 asm ("w0") = i;
+	register atomic_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(add_return, %[tmp]),
+	"	nop\n"
+	"	ldaddal	%w[i], %w[tmp], %[v]\n"
+	"	add	%w[i], %w[i], %w[tmp]")
+	: [tmp] "=&r" (tmp), [i] "+r" (w0), [v] "+Q" (v->counter)
+	: "r" (x1)
+	: "memory");
+
+	return w0;
+}
 
-ATOMIC_OPS(add, add)
-ATOMIC_OPS(sub, sub)
+static inline void atomic_sub(int i, atomic_t *v)
+{
+	unsigned long tmp;
+	register int w0 asm ("w0") = i;
+	register atomic_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(sub, %[tmp]),
+	"	neg	%w[i], %w[i]\n"
+	"	stadd	%w[i], %[v]\n"
+	"	nop")
+	: [tmp] "=&r" (tmp), [i] "+r" (w0), [v] "+Q" (v->counter)
+	: "r" (x1));
+}
 
-#undef ATOMIC_OPS
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	unsigned long tmp;
+	register int w0 asm ("w0") = i;
+	register atomic_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(sub_return, %[tmp]),
+	"	neg	%w[i], %w[i]\n"
+	"	ldaddal	%w[i], %w[tmp], %[v]\n"
+	"	add	%w[i], %w[i], %w[tmp]")
+	: [tmp] "=&r" (tmp), [i] "+r" (w0), [v] "+Q" (v->counter)
+	: "r" (x1)
+	: "memory");
+
+	return w0;
+}
 
 static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 {
-	unsigned long lr;
+	unsigned long tmp;
 	register unsigned long x0 asm ("x0") = (unsigned long)ptr;
 	register int w1 asm ("w1") = old;
 	register int w2 asm ("w2") = new;
 
-	asm volatile(
-	__LL_SC_SAVE_LR(%0)
-	__LL_SC_CALL(cmpxchg)
-	__LL_SC_RESTORE_LR(%0)
-	: "=&r" (lr), "+r" (x0)
-	: "r" (w1), "r" (w2)
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(cmpxchg, %[tmp]),
+	"	mov	%w[tmp], %w[old]\n"
+	"	casal	%w[tmp], %w[new], %[v]\n"
+	"	mov	%w[ret], %w[tmp]")
+	: [tmp] "=&r" (tmp), [ret] "+r" (x0), [v] "+Q" (ptr->counter)
+	: [old] "r" (w1), [new] "r" (w2)
 	: "cc", "memory");
 
 	return x0;
 }
 
-#define ATOMIC64_OP(op, asm_op)						\
-static inline void atomic64_##op(long i, atomic64_t *v)			\
-{									\
-	unsigned long lr;						\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
-									\
-	asm volatile(							\
-	__LL_SC_SAVE_LR(%0)						\
-	__LL_SC_CALL64(op)						\
-	__LL_SC_RESTORE_LR(%0)						\
-	: "=&r" (lr), "+r" (x0), "+Q" (v->counter)			\
-	: "r" (x1));							\
-}									\
-
-#define ATOMIC64_OP_RETURN(op, asm_op)					\
-static inline long atomic64_##op##_return(long i, atomic64_t *v)	\
-{									\
-	unsigned long lr;						\
-	register long x0 asm ("x0") = i;				\
-	register atomic64_t *x1 asm ("x1") = v;				\
-									\
-	asm volatile(							\
-	__LL_SC_SAVE_LR(%0)						\
-	__LL_SC_CALL64(op##_return)					\
-	__LL_SC_RESTORE_LR(%0)						\
-	: "=&r" (lr), "+r" (x0)						\
-	: "r" (x1)							\
-	: "memory");							\
-									\
-	return x0;							\
+#undef __LL_SC_ATOMIC
+
+#define __LL_SC_ATOMIC64(op, tmp)					\
+	__LL_SC_SAVE_LR(tmp)						\
+	__LL_SC_CALL(atomic64_##op)					\
+	__LL_SC_RESTORE_LR(tmp)
+
+static inline void atomic64_add(long i, atomic64_t *v)
+{
+	unsigned long tmp;
+	register long x0 asm ("x0") = i;
+	register atomic64_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(add, %[tmp]),
+	"	nop\n"
+	"	stadd	%[i], %[v]\n"
+	"	nop")
+	: [tmp] "=&r" (tmp), [i] "+r" (x0), [v] "+Q" (v->counter)
+	: "r" (x1));
 }
 
-#define ATOMIC64_OPS(op, asm_op)					\
-	ATOMIC64_OP(op, asm_op)						\
-	ATOMIC64_OP_RETURN(op, asm_op)
+static inline long atomic64_add_return(long i, atomic64_t *v)
+{
+	unsigned long tmp;
+	register long x0 asm ("x0") = i;
+	register atomic64_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(add_return, %[tmp]),
+	"	nop\n"
+	"	ldaddal	%[i], %[tmp], %[v]\n"
+	"	add	%[i], %[i], %[tmp]")
+	: [tmp] "=&r" (tmp), [i] "+r" (x0), [v] "+Q" (v->counter)
+	: "r" (x1)
+	: "memory");
 
-ATOMIC64_OPS(add, add)
-ATOMIC64_OPS(sub, sub)
+	return x0;
+}
+
+static inline void atomic64_sub(long i, atomic64_t *v)
+{
+	unsigned long tmp;
+	register long x0 asm ("x0") = i;
+	register atomic64_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(sub, %[tmp]),
+	"	neg	%[i], %[i]\n"
+	"	stadd	%[i], %[v]\n"
+	"	nop")
+	: [tmp] "=&r" (tmp), [i] "+r" (x0), [v] "+Q" (v->counter)
+	: "r" (x1));
+}
 
-#undef ATOMIC64_OPS
-#undef ATOMIC64_OP_RETURN
-#undef ATOMIC64_OP
+static inline long atomic64_sub_return(long i, atomic64_t *v)
+{
+	unsigned long tmp;
+	register long x0 asm ("x0") = i;
+	register atomic64_t *x1 asm ("x1") = v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(sub_return, %[tmp]),
+	"	neg	%[i], %[i]\n"
+	"	ldaddal	%[i], %[tmp], %[v]\n"
+	"	add	%[i], %[i], %[tmp]")
+	: [tmp] "=&r" (tmp), [i] "+r" (x0), [v] "+Q" (v->counter)
+	: "r" (x1)
+	: "memory");
 
+	return x0;
+}
 static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
 {
-	unsigned long lr;
+	unsigned long tmp;
 	register unsigned long x0 asm ("x0") = (unsigned long)ptr;
 	register long x1 asm ("x1") = old;
 	register long x2 asm ("x2") = new;
 
-	asm volatile(
-	__LL_SC_SAVE_LR(%0)
-	__LL_SC_CALL64(cmpxchg)
-	__LL_SC_RESTORE_LR(%0)
-	: "=&r" (lr), "+r" (x0)
-	: "r" (x1), "r" (x2)
+	asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC64(cmpxchg, %[tmp]),
+	"	mov	%[tmp], %[old]\n"
+	"	casal	%[tmp], %[new], %[v]\n"
+	"	mov	%[ret], %[tmp]")
+	: [tmp] "=&r" (tmp), [ret] "+r" (x0), [v] "+Q" (ptr->counter)
+	: [old] "r" (x1), [new] "r" (x2)
 	: "cc", "memory");
 
 	return x0;
@@ -164,18 +198,32 @@ static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
 
 static inline long atomic64_dec_if_positive(atomic64_t *v)
 {
-	unsigned long lr;
-	register unsigned long x0 asm ("x0") = (unsigned long)v;
-
-	asm volatile(
-	__LL_SC_SAVE_LR(%0)
-	__LL_SC_CALL64(dec_if_positive)
-	__LL_SC_RESTORE_LR(%0)
-	: "=&r" (lr), "+r" (x0)
+	unsigned long tmp;
+	register long x0 asm ("x0") = (long)v;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	nop\n"
+	__LL_SC_ATOMIC64(dec_if_positive, %[tmp])
+	"	nop\n"
+	"	nop\n"
+	"	nop",
+	/* LSE atomics */
+	"1:	ldr	%[tmp], %[v]\n"
+	"	subs	%[ret], %[tmp], #1\n"
+	"	b.mi	2f\n"
+	"	casal	%[tmp], %[ret], %[v]\n"
+	"	sub	%[tmp], %[tmp], #1\n"
+	"	sub	%[tmp], %[tmp], %[ret]\n"
+	"	cbnz	%[tmp], 1b\n"
+	"2:")
+	: [ret] "+&r" (x0), [tmp] "=&r" (tmp), [v] "+Q" (v->counter)
 	:
 	: "cc", "memory");
 
 	return x0;
 }
 
+#undef __LL_SC_ATOMIC64
+
 #endif	/* __ASM_ATOMIC_LSE_H */
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
new file mode 100644
index 000000000000..c4e88334c07d
--- /dev/null
+++ b/arch/arm64/include/asm/lse.h
@@ -0,0 +1,36 @@
+#ifndef __ASM_LSE_H
+#define __ASM_LSE_H
+
+#if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
+
+#include <linux/stringify.h>
+
+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
+
+__asm__(".arch_extension	lse");
+
+/* Move the ll/sc atomics out-of-line */
+#define __LL_SC_INLINE
+#define __LL_SC_PREFIX(x)	__ll_sc_##x
+#define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
+
+/* Macros for constructing calls to out-of-line ll/sc atomics */
+#define __LL_SC_SAVE_LR(r)	"mov\t" #r ", x30\n"
+#define __LL_SC_RESTORE_LR(r)	"mov\tx30, " #r "\n"
+#define __LL_SC_CALL(op)	"bl\t" __stringify(__LL_SC_PREFIX(op)) "\n"
+
+/* In-line patching at runtime */
+#define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
+	ALTERNATIVE(llsc, lse, ARM64_CPU_FEAT_LSE_ATOMICS)
+
+#else
+
+#define __LL_SC_INLINE		static inline
+#define __LL_SC_PREFIX(x)	x
+#define __LL_SC_EXPORT(x)
+
+#define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
+
+#endif	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+#endif	/* __ASM_LSE_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 5b170df96aaf..930a353b868c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -287,6 +287,9 @@ static void __init setup_processor(void)
 		case 2:
 			elf_hwcap |= HWCAP_ATOMICS;
 			cpus_set_cap(ARM64_CPU_FEAT_LSE_ATOMICS);
+			if (IS_ENABLED(CONFIG_AS_LSE) &&
+			    IS_ENABLED(CONFIG_ARM64_LSE_ATOMICS))
+				pr_info("LSE atomics supported\n");
 		case 1:
 			/* RESERVED */
 		case 0:
-- 
2.1.4
