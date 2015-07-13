From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:06 +0100
Subject: [PATCH 05/18] arm64: introduce CONFIG_ARM64_LSE_ATOMICS as fallback
 to ll/sc atomics
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to patch in the new atomic instructions at runtime, we need to
generate wrappers around the out-of-line exclusive load/store atomics.

This patch adds a new Kconfig option, CONFIG_ARM64_LSE_ATOMICS. which
causes our atomic functions to branch to the out-of-line ll/sc
implementations. To avoid the register spill overhead of the PCS, the
out-of-line functions are compiled with specific compiler flags to
force out-of-line save/restore of any registers that are usually
caller-saved.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                    |  12 +++
 arch/arm64/include/asm/atomic.h       |   9 ++
 arch/arm64/include/asm/atomic_ll_sc.h |  19 +++-
 arch/arm64/include/asm/atomic_lse.h   | 181 ++++++++++++++++++++++++++++++++++
 arch/arm64/lib/Makefile               |  13 +++
 arch/arm64/lib/atomic_ll_sc.c         |   3 +
 6 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/atomic_lse.h
 create mode 100644 arch/arm64/lib/atomic_ll_sc.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb14b7e4..682782ab6936 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -664,6 +664,18 @@ config SETEND_EMULATION
 	  If unsure, say Y
 endif
 
+config ARM64_LSE_ATOMICS
+	bool "ARMv8.1 atomic instructions"
+	help
+	  As part of the Large System Extensions, ARMv8.1 introduces new
+	  atomic instructions that are designed specifically to scale in
+	  very large systems.
+
+	  Say Y here to make use of these instructions for the in-kernel
+	  atomic routines. This incurs a small overhead on CPUs that do
+	  not support these instructions and requires the kernel to be
+	  built with binutils >= 2.25.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 9467450a5c03..955cc14f3ce4 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -21,6 +21,7 @@
 #define __ASM_ATOMIC_H
 
 #include <linux/compiler.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 
 #include <asm/barrier.h>
@@ -30,7 +31,15 @@
 
 #ifdef __KERNEL__
 
+#define __ARM64_IN_ATOMIC_IMPL
+
+#ifdef CONFIG_ARM64_LSE_ATOMICS
+#include <asm/atomic_lse.h>
+#else
 #include <asm/atomic_ll_sc.h>
+#endif
+
+#undef __ARM64_IN_ATOMIC_IMPL
 
 /*
  * On ARM, ordinary assignment (str instruction) doesn't clear the local
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index aef70f2d4cb8..024b892dbc6a 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -21,6 +21,10 @@
 #ifndef __ASM_ATOMIC_LL_SC_H
 #define __ASM_ATOMIC_LL_SC_H
 
+#ifndef __ARM64_IN_ATOMIC_IMPL
+#error "please don't include this file directly"
+#endif
+
 /*
  * AArch64 UP and SMP safe atomic ops.  We use load exclusive and
  * store exclusive to ensure that these are atomic.  We may loop
@@ -41,6 +45,10 @@
 #define __LL_SC_PREFIX(x)	x
 #endif
 
+#ifndef __LL_SC_EXPORT
+#define __LL_SC_EXPORT(x)
+#endif
+
 #define ATOMIC_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
 __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
@@ -56,6 +64,7 @@ __LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
 	: "Ir" (i));							\
 }									\
+__LL_SC_EXPORT(atomic_##op);
 
 #define ATOMIC_OP_RETURN(op, asm_op)					\
 __LL_SC_INLINE int							\
@@ -75,7 +84,8 @@ __LL_SC_PREFIX(atomic_##op##_return(int i, atomic_t *v))		\
 									\
 	smp_mb();							\
 	return result;							\
-}
+}									\
+__LL_SC_EXPORT(atomic_##op##_return);
 
 #define ATOMIC_OPS(op, asm_op)						\
 	ATOMIC_OP(op, asm_op)						\
@@ -110,6 +120,7 @@ __LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
 	smp_mb();
 	return oldval;
 }
+__LL_SC_EXPORT(atomic_cmpxchg);
 
 #define ATOMIC64_OP(op, asm_op)						\
 __LL_SC_INLINE void							\
@@ -126,6 +137,7 @@ __LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
 	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
 	: "Ir" (i));							\
 }									\
+__LL_SC_EXPORT(atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
 __LL_SC_INLINE long							\
@@ -145,7 +157,8 @@ __LL_SC_PREFIX(atomic64_##op##_return(long i, atomic64_t *v))		\
 									\
 	smp_mb();							\
 	return result;							\
-}
+}									\
+__LL_SC_EXPORT(atomic64_##op##_return);
 
 #define ATOMIC64_OPS(op, asm_op)					\
 	ATOMIC64_OP(op, asm_op)						\
@@ -180,6 +193,7 @@ __LL_SC_PREFIX(atomic64_cmpxchg(atomic64_t *ptr, long old, long new))
 	smp_mb();
 	return oldval;
 }
+__LL_SC_EXPORT(atomic64_cmpxchg);
 
 __LL_SC_INLINE long
 __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
@@ -201,5 +215,6 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
 
 	return result;
 }
+__LL_SC_EXPORT(atomic64_dec_if_positive);
 
 #endif	/* __ASM_ATOMIC_LL_SC_H */
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
new file mode 100644
index 000000000000..68ff1a8a7492
--- /dev/null
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -0,0 +1,181 @@
+/*
+ * Based on arch/arm/include/asm/atomic.h
+ *
+ * Copyright (C) 1996 Russell King.
+ * Copyright (C) 2002 Deep Blue Solutions Ltd.
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_ATOMIC_LSE_H
+#define __ASM_ATOMIC_LSE_H
+
+#ifndef __ARM64_IN_ATOMIC_IMPL
+#error "please don't include this file directly"
+#endif
+
+/* Move the ll/sc atomics out-of-line */
+#define __LL_SC_INLINE
+#define __LL_SC_PREFIX(x)	__ll_sc_##x
+#define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
+
+/* Macros for constructing calls to out-of-line ll/sc atomics */
+#define __LL_SC_SAVE_LR(r)	"mov\t" #r ", x30\n"
+#define __LL_SC_RESTORE_LR(r)	"mov\tx30, " #r "\n"
+#define __LL_SC_CALL(op)						\
+	"bl\t" __stringify(__LL_SC_PREFIX(atomic_##op)) "\n"
+#define __LL_SC_CALL64(op)						\
+	"bl\t" __stringify(__LL_SC_PREFIX(atomic64_##op)) "\n"
+
+#define ATOMIC_OP(op, asm_op)						\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long lr;						\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(							\
+	__LL_SC_SAVE_LR(%0)						\
+	__LL_SC_CALL(op)						\
+	__LL_SC_RESTORE_LR(%0)						\
+	: "=&r" (lr), "+r" (w0), "+Q" (v->counter)			\
+	: "r" (x1));							\
+}									\
+
+#define ATOMIC_OP_RETURN(op, asm_op)					\
+static inline int atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	unsigned long lr;						\
+	register int w0 asm ("w0") = i;					\
+	register atomic_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(							\
+	__LL_SC_SAVE_LR(%0)						\
+	__LL_SC_CALL(op##_return)					\
+	__LL_SC_RESTORE_LR(%0)						\
+	: "=&r" (lr), "+r" (w0)						\
+	: "r" (x1)							\
+	: "memory");							\
+									\
+	return w0;							\
+}
+
+#define ATOMIC_OPS(op, asm_op)						\
+	ATOMIC_OP(op, asm_op)						\
+	ATOMIC_OP_RETURN(op, asm_op)
+
+ATOMIC_OPS(add, add)
+ATOMIC_OPS(sub, sub)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+{
+	unsigned long lr;
+	register unsigned long x0 asm ("x0") = (unsigned long)ptr;
+	register int w1 asm ("w1") = old;
+	register int w2 asm ("w2") = new;
+
+	asm volatile(
+	__LL_SC_SAVE_LR(%0)
+	__LL_SC_CALL(cmpxchg)
+	__LL_SC_RESTORE_LR(%0)
+	: "=&r" (lr), "+r" (x0)
+	: "r" (w1), "r" (w2)
+	: "cc", "memory");
+
+	return x0;
+}
+
+#define ATOMIC64_OP(op, asm_op)						\
+static inline void atomic64_##op(long i, atomic64_t *v)			\
+{									\
+	unsigned long lr;						\
+	register long x0 asm ("x0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(							\
+	__LL_SC_SAVE_LR(%0)						\
+	__LL_SC_CALL64(op)						\
+	__LL_SC_RESTORE_LR(%0)						\
+	: "=&r" (lr), "+r" (x0), "+Q" (v->counter)			\
+	: "r" (x1));							\
+}									\
+
+#define ATOMIC64_OP_RETURN(op, asm_op)					\
+static inline long atomic64_##op##_return(long i, atomic64_t *v)	\
+{									\
+	unsigned long lr;						\
+	register long x0 asm ("x0") = i;				\
+	register atomic64_t *x1 asm ("x1") = v;				\
+									\
+	asm volatile(							\
+	__LL_SC_SAVE_LR(%0)						\
+	__LL_SC_CALL64(op##_return)					\
+	__LL_SC_RESTORE_LR(%0)						\
+	: "=&r" (lr), "+r" (x0)						\
+	: "r" (x1)							\
+	: "memory");							\
+									\
+	return x0;							\
+}
+
+#define ATOMIC64_OPS(op, asm_op)					\
+	ATOMIC64_OP(op, asm_op)						\
+	ATOMIC64_OP_RETURN(op, asm_op)
+
+ATOMIC64_OPS(add, add)
+ATOMIC64_OPS(sub, sub)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_OP_RETURN
+#undef ATOMIC64_OP
+
+static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
+{
+	unsigned long lr;
+	register unsigned long x0 asm ("x0") = (unsigned long)ptr;
+	register long x1 asm ("x1") = old;
+	register long x2 asm ("x2") = new;
+
+	asm volatile(
+	__LL_SC_SAVE_LR(%0)
+	__LL_SC_CALL64(cmpxchg)
+	__LL_SC_RESTORE_LR(%0)
+	: "=&r" (lr), "+r" (x0)
+	: "r" (x1), "r" (x2)
+	: "cc", "memory");
+
+	return x0;
+}
+
+static inline long atomic64_dec_if_positive(atomic64_t *v)
+{
+	unsigned long lr;
+	register unsigned long x0 asm ("x0") = (unsigned long)v;
+
+	asm volatile(
+	__LL_SC_SAVE_LR(%0)
+	__LL_SC_CALL64(dec_if_positive)
+	__LL_SC_RESTORE_LR(%0)
+	: "=&r" (lr), "+r" (x0)
+	:
+	: "cc", "memory");
+
+	return x0;
+}
+
+#endif	/* __ASM_ATOMIC_LSE_H */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index d98d3e39879e..1a811ecf71da 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -3,3 +3,16 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o
+
+# Tell the compiler to treat all general purpose registers as
+# callee-saved, which allows for efficient runtime patching of the bl
+# instruction in the caller with an atomic instruction when supported by
+# the CPU. Result and argument registers are handled correctly, based on
+# the function prototype.
+lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
+CFLAGS_atomic_ll_sc.o	:= -fcall-used-x0 -ffixed-x1 -ffixed-x2		\
+		   -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6		\
+		   -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9		\
+		   -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12	\
+		   -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15	\
+		   -fcall-saved-x16 -fcall-saved-x17 -fcall-saved-x18
diff --git a/arch/arm64/lib/atomic_ll_sc.c b/arch/arm64/lib/atomic_ll_sc.c
new file mode 100644
index 000000000000..b0c538b0da28
--- /dev/null
+++ b/arch/arm64/lib/atomic_ll_sc.c
@@ -0,0 +1,3 @@
+#include <asm/atomic.h>
+#define __ARM64_IN_ATOMIC_IMPL
+#include <asm/atomic_ll_sc.h>
-- 
2.1.4
