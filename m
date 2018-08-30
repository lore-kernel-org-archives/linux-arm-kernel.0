From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Aug 2018 16:43:44 +0200
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
In-Reply-To: <20180830142920.GO24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
Message-ID: <20180830144344.GW24142@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 04:29:20PM +0200, Peter Zijlstra wrote:

> Also, once it all works, they should look at switching to _relaxed
> atomics for LL/SC.

A little something like so.. should save a few smp_mb().

---

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 4e0072730241..714b54c308b0 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -44,7 +44,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned int val;						\
 									\
@@ -69,8 +69,11 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	return val;							\
 }
 
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned int val, orig;						\
 									\
@@ -96,6 +99,14 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 	return orig;							\
 }
 
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+
 #else	/* !CONFIG_ARC_HAS_LLSC */
 
 #ifndef CONFIG_SMP
@@ -379,7 +390,7 @@ static inline void atomic64_##op(long long a, atomic64_t *v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline long long atomic64_##op##_return(long long a, atomic64_t *v)	\
+static inline long long atomic64_##op##_return_relaxed(long long a, atomic64_t *v)	\
 {									\
 	unsigned long long val;						\
 									\
@@ -401,8 +412,11 @@ static inline long long atomic64_##op##_return(long long a, atomic64_t *v)	\
 	return val;							\
 }
 
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+
 #define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
+static inline long long atomic64_fetch_##op##_relaxed(long long a, atomic64_t *v)	\
 {									\
 	unsigned long long val, orig;					\
 									\
@@ -424,6 +438,14 @@ static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
 	return orig;							\
 }
 
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+
 #define ATOMIC64_OPS(op, op1, op2)					\
 	ATOMIC64_OP(op, op1, op2)					\
 	ATOMIC64_OP_RETURN(op, op1, op2)				\
@@ -434,6 +456,12 @@ static inline long long atomic64_fetch_##op(long long a, atomic64_t *v)	\
 
 ATOMIC64_OPS(add, add.f, adc)
 ATOMIC64_OPS(sub, sub.f, sbc)
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, op1, op2)					\
+	ATOMIC64_OP(op, op1, op2)					\
+	ATOMIC64_FETCH_OP(op, op1, op2)
+
 ATOMIC64_OPS(and, and, and)
 ATOMIC64_OPS(andnot, bic, bic)
 ATOMIC64_OPS(or, or, or)
