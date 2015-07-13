From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:03 +0100
Subject: [PATCH 02/18] arm64: atomics: move ll/sc atomics into separate header
 file
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for the Large System Extension (LSE) atomic instructions
introduced by ARM v8.1, move the current exclusive load/store (LL/SC)
atomics into their own header file.

Reviewed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic.h       | 162 +--------------------------
 arch/arm64/include/asm/atomic_ll_sc.h | 205 ++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+), 160 deletions(-)
 create mode 100644 arch/arm64/include/asm/atomic_ll_sc.h

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 7047051ded40..9467450a5c03 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -30,6 +30,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/atomic_ll_sc.h>
+
 /*
  * On ARM, ordinary assignment (str instruction) doesn't clear the local
  * strex/ldrex monitor on some implementations. The reason we can use it for
@@ -38,79 +40,6 @@
 #define atomic_read(v)	ACCESS_ONCE((v)->counter)
 #define atomic_set(v,i)	(((v)->counter) = (i))
 
-/*
- * AArch64 UP and SMP safe atomic ops.  We use load exclusive and
- * store exclusive to ensure that these are atomic.  We may loop
- * to ensure that the update happens.
- */
-
-#define ATOMIC_OP(op, asm_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
-{									\
-	unsigned long tmp;						\
-	int result;							\
-									\
-	asm volatile("// atomic_" #op "\n"				\
-"1:	ldxr	%w0, %2\n"						\
-"	" #asm_op "	%w0, %w0, %w3\n"				\
-"	stxr	%w1, %w0, %2\n"						\
-"	cbnz	%w1, 1b"						\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i));							\
-}									\
-
-#define ATOMIC_OP_RETURN(op, asm_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned long tmp;						\
-	int result;							\
-									\
-	asm volatile("// atomic_" #op "_return\n"			\
-"1:	ldxr	%w0, %2\n"						\
-"	" #asm_op "	%w0, %w0, %w3\n"				\
-"	stlxr	%w1, %w0, %2\n"						\
-"	cbnz	%w1, 1b"						\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i)							\
-	: "memory");							\
-									\
-	smp_mb();							\
-	return result;							\
-}
-
-#define ATOMIC_OPS(op, asm_op)						\
-	ATOMIC_OP(op, asm_op)						\
-	ATOMIC_OP_RETURN(op, asm_op)
-
-ATOMIC_OPS(add, add)
-ATOMIC_OPS(sub, sub)
-
-#undef ATOMIC_OPS
-#undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
-
-static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
-{
-	unsigned long tmp;
-	int oldval;
-
-	smp_mb();
-
-	asm volatile("// atomic_cmpxchg\n"
-"1:	ldxr	%w1, %2\n"
-"	cmp	%w1, %w3\n"
-"	b.ne	2f\n"
-"	stxr	%w0, %w4, %2\n"
-"	cbnz	%w0, 1b\n"
-"2:"
-	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Ir" (old), "r" (new)
-	: "cc");
-
-	smp_mb();
-	return oldval;
-}
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int __atomic_add_unless(atomic_t *v, int a, int u)
@@ -142,95 +71,8 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 #define atomic64_read(v)	ACCESS_ONCE((v)->counter)
 #define atomic64_set(v,i)	(((v)->counter) = (i))
 
-#define ATOMIC64_OP(op, asm_op)						\
-static inline void atomic64_##op(long i, atomic64_t *v)			\
-{									\
-	long result;							\
-	unsigned long tmp;						\
-									\
-	asm volatile("// atomic64_" #op "\n"				\
-"1:	ldxr	%0, %2\n"						\
-"	" #asm_op "	%0, %0, %3\n"					\
-"	stxr	%w1, %0, %2\n"						\
-"	cbnz	%w1, 1b"						\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i));							\
-}									\
-
-#define ATOMIC64_OP_RETURN(op, asm_op)					\
-static inline long atomic64_##op##_return(long i, atomic64_t *v)	\
-{									\
-	long result;							\
-	unsigned long tmp;						\
-									\
-	asm volatile("// atomic64_" #op "_return\n"			\
-"1:	ldxr	%0, %2\n"						\
-"	" #asm_op "	%0, %0, %3\n"					\
-"	stlxr	%w1, %0, %2\n"						\
-"	cbnz	%w1, 1b"						\
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
-	: "Ir" (i)							\
-	: "memory");							\
-									\
-	smp_mb();							\
-	return result;							\
-}
-
-#define ATOMIC64_OPS(op, asm_op)					\
-	ATOMIC64_OP(op, asm_op)						\
-	ATOMIC64_OP_RETURN(op, asm_op)
-
-ATOMIC64_OPS(add, add)
-ATOMIC64_OPS(sub, sub)
-
-#undef ATOMIC64_OPS
-#undef ATOMIC64_OP_RETURN
-#undef ATOMIC64_OP
-
-static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
-{
-	long oldval;
-	unsigned long res;
-
-	smp_mb();
-
-	asm volatile("// atomic64_cmpxchg\n"
-"1:	ldxr	%1, %2\n"
-"	cmp	%1, %3\n"
-"	b.ne	2f\n"
-"	stxr	%w0, %4, %2\n"
-"	cbnz	%w0, 1b\n"
-"2:"
-	: "=&r" (res), "=&r" (oldval), "+Q" (ptr->counter)
-	: "Ir" (old), "r" (new)
-	: "cc");
-
-	smp_mb();
-	return oldval;
-}
-
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static inline long atomic64_dec_if_positive(atomic64_t *v)
-{
-	long result;
-	unsigned long tmp;
-
-	asm volatile("// atomic64_dec_if_positive\n"
-"1:	ldxr	%0, %2\n"
-"	subs	%0, %0, #1\n"
-"	b.mi	2f\n"
-"	stlxr	%w1, %0, %2\n"
-"	cbnz	%w1, 1b\n"
-"	dmb	ish\n"
-"2:"
-	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
-	:
-	: "cc", "memory");
-
-	return result;
-}
-
 static inline int atomic64_add_unless(atomic64_t *v, long a, long u)
 {
 	long c, old;
diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
new file mode 100644
index 000000000000..aef70f2d4cb8
--- /dev/null
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -0,0 +1,205 @@
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
+#ifndef __ASM_ATOMIC_LL_SC_H
+#define __ASM_ATOMIC_LL_SC_H
+
+/*
+ * AArch64 UP and SMP safe atomic ops.  We use load exclusive and
+ * store exclusive to ensure that these are atomic.  We may loop
+ * to ensure that the update happens.
+ *
+ * NOTE: these functions do *not* follow the PCS and must explicitly
+ * save any clobbered registers other than x0 (regardless of return
+ * value).  This is achieved through -fcall-saved-* compiler flags for
+ * this file, which unfortunately don't work on a per-function basis
+ * (the optimize attribute silently ignores these options).
+ */
+
+#ifndef __LL_SC_INLINE
+#define __LL_SC_INLINE		static inline
+#endif
+
+#ifndef __LL_SC_PREFIX
+#define __LL_SC_PREFIX(x)	x
+#endif
+
+#define ATOMIC_OP(op, asm_op)						\
+__LL_SC_INLINE void							\
+__LL_SC_PREFIX(atomic_##op(int i, atomic_t *v))				\
+{									\
+	unsigned long tmp;						\
+	int result;							\
+									\
+	asm volatile("// atomic_" #op "\n"				\
+"1:	ldxr	%w0, %2\n"						\
+"	" #asm_op "	%w0, %w0, %w3\n"				\
+"	stxr	%w1, %w0, %2\n"						\
+"	cbnz	%w1, 1b"						\
+	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
+	: "Ir" (i));							\
+}									\
+
+#define ATOMIC_OP_RETURN(op, asm_op)					\
+__LL_SC_INLINE int							\
+__LL_SC_PREFIX(atomic_##op##_return(int i, atomic_t *v))		\
+{									\
+	unsigned long tmp;						\
+	int result;							\
+									\
+	asm volatile("// atomic_" #op "_return\n"			\
+"1:	ldxr	%w0, %2\n"						\
+"	" #asm_op "	%w0, %w0, %w3\n"				\
+"	stlxr	%w1, %w0, %2\n"						\
+"	cbnz	%w1, 1b"						\
+	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
+	: "Ir" (i)							\
+	: "memory");							\
+									\
+	smp_mb();							\
+	return result;							\
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
+__LL_SC_INLINE int
+__LL_SC_PREFIX(atomic_cmpxchg(atomic_t *ptr, int old, int new))
+{
+	unsigned long tmp;
+	int oldval;
+
+	smp_mb();
+
+	asm volatile("// atomic_cmpxchg\n"
+"1:	ldxr	%w1, %2\n"
+"	cmp	%w1, %w3\n"
+"	b.ne	2f\n"
+"	stxr	%w0, %w4, %2\n"
+"	cbnz	%w0, 1b\n"
+"2:"
+	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
+	: "Ir" (old), "r" (new)
+	: "cc");
+
+	smp_mb();
+	return oldval;
+}
+
+#define ATOMIC64_OP(op, asm_op)						\
+__LL_SC_INLINE void							\
+__LL_SC_PREFIX(atomic64_##op(long i, atomic64_t *v))			\
+{									\
+	long result;							\
+	unsigned long tmp;						\
+									\
+	asm volatile("// atomic64_" #op "\n"				\
+"1:	ldxr	%0, %2\n"						\
+"	" #asm_op "	%0, %0, %3\n"					\
+"	stxr	%w1, %0, %2\n"						\
+"	cbnz	%w1, 1b"						\
+	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
+	: "Ir" (i));							\
+}									\
+
+#define ATOMIC64_OP_RETURN(op, asm_op)					\
+__LL_SC_INLINE long							\
+__LL_SC_PREFIX(atomic64_##op##_return(long i, atomic64_t *v))		\
+{									\
+	long result;							\
+	unsigned long tmp;						\
+									\
+	asm volatile("// atomic64_" #op "_return\n"			\
+"1:	ldxr	%0, %2\n"						\
+"	" #asm_op "	%0, %0, %3\n"					\
+"	stlxr	%w1, %0, %2\n"						\
+"	cbnz	%w1, 1b"						\
+	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)		\
+	: "Ir" (i)							\
+	: "memory");							\
+									\
+	smp_mb();							\
+	return result;							\
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
+__LL_SC_INLINE long
+__LL_SC_PREFIX(atomic64_cmpxchg(atomic64_t *ptr, long old, long new))
+{
+	long oldval;
+	unsigned long res;
+
+	smp_mb();
+
+	asm volatile("// atomic64_cmpxchg\n"
+"1:	ldxr	%1, %2\n"
+"	cmp	%1, %3\n"
+"	b.ne	2f\n"
+"	stxr	%w0, %4, %2\n"
+"	cbnz	%w0, 1b\n"
+"2:"
+	: "=&r" (res), "=&r" (oldval), "+Q" (ptr->counter)
+	: "Ir" (old), "r" (new)
+	: "cc");
+
+	smp_mb();
+	return oldval;
+}
+
+__LL_SC_INLINE long
+__LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
+{
+	long result;
+	unsigned long tmp;
+
+	asm volatile("// atomic64_dec_if_positive\n"
+"1:	ldxr	%0, %2\n"
+"	subs	%0, %0, #1\n"
+"	b.mi	2f\n"
+"	stlxr	%w1, %0, %2\n"
+"	cbnz	%w1, 1b\n"
+"	dmb	ish\n"
+"2:"
+	: "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
+	:
+	: "cc", "memory");
+
+	return result;
+}
+
+#endif	/* __ASM_ATOMIC_LL_SC_H */
-- 
2.1.4
