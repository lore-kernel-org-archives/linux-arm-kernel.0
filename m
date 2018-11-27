From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:44:46 +0000
Subject: [PATCH 3/4] arm64: percpu: Rewrite per-cpu ops to allow use of LSE
 atomics
In-Reply-To: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
Message-ID: <1543347887-21101-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our percpu code is a bit of an inconsistent mess:

  * It rolls its own xchg(), but reuses cmpxchg_local()
  * It uses various different flavours of preempt_{enable,disable}()
  * It returns values even for the non-returning RmW operations
  * It makes no use of LSE atomics outside of the cmpxchg() ops
  * There are individual macros for different sizes of access, but these
    are all funneled through a switch statement rather than dispatched
    directly to the relevant case

This patch rewrites the per-cpu operations to address these shortcomings.
Whilst the new code is a lot cleaner, the big advantage is that we can
use the non-returning ST- atomic instructions when we have LSE.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/percpu.h | 390 +++++++++++++++++-----------------------
 1 file changed, 160 insertions(+), 230 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 21a81b59a0cc..f7b1bbbb6f12 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -48,263 +48,193 @@ static inline unsigned long __my_cpu_offset(void)
 }
 #define __my_cpu_offset __my_cpu_offset()
 
-#define PERCPU_OP(op, asm_op)						\
-static inline unsigned long __percpu_##op(void *ptr,			\
-			unsigned long val, int size)			\
+#define PERCPU_RW_OPS(sz)						\
+static inline unsigned long __percpu_read_##sz(void *ptr)		\
 {									\
-	unsigned long loop, ret;					\
+	return READ_ONCE(*(u##sz *)ptr);				\
+}									\
 									\
-	switch (size) {							\
-	case 1:								\
-		asm ("//__per_cpu_" #op "_1\n"				\
-		"1:	ldxrb	  %w[ret], %[ptr]\n"			\
-			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
-		"	stxrb	  %w[loop], %w[ret], %[ptr]\n"		\
-		"	cbnz	  %w[loop], 1b"				\
-		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
-		  [ptr] "+Q"(*(u8 *)ptr)				\
-		: [val] "Ir" (val));					\
-		break;							\
-	case 2:								\
-		asm ("//__per_cpu_" #op "_2\n"				\
-		"1:	ldxrh	  %w[ret], %[ptr]\n"			\
-			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
-		"	stxrh	  %w[loop], %w[ret], %[ptr]\n"		\
-		"	cbnz	  %w[loop], 1b"				\
-		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
-		  [ptr]  "+Q"(*(u16 *)ptr)				\
-		: [val] "Ir" (val));					\
-		break;							\
-	case 4:								\
-		asm ("//__per_cpu_" #op "_4\n"				\
-		"1:	ldxr	  %w[ret], %[ptr]\n"			\
-			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
-		"	stxr	  %w[loop], %w[ret], %[ptr]\n"		\
-		"	cbnz	  %w[loop], 1b"				\
-		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
-		  [ptr] "+Q"(*(u32 *)ptr)				\
-		: [val] "Ir" (val));					\
-		break;							\
-	case 8:								\
-		asm ("//__per_cpu_" #op "_8\n"				\
-		"1:	ldxr	  %[ret], %[ptr]\n"			\
-			#asm_op " %[ret], %[ret], %[val]\n"		\
-		"	stxr	  %w[loop], %[ret], %[ptr]\n"		\
-		"	cbnz	  %w[loop], 1b"				\
-		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
-		  [ptr] "+Q"(*(u64 *)ptr)				\
-		: [val] "Ir" (val));					\
-		break;							\
-	default:							\
-		ret = 0;						\
-		BUILD_BUG();						\
-	}								\
-									\
-	return ret;							\
-}
-
-PERCPU_OP(add, add)
-PERCPU_OP(and, and)
-PERCPU_OP(or, orr)
-#undef PERCPU_OP
-
-static inline unsigned long __percpu_read(void *ptr, int size)
-{
-	unsigned long ret;
-
-	switch (size) {
-	case 1:
-		ret = READ_ONCE(*(u8 *)ptr);
-		break;
-	case 2:
-		ret = READ_ONCE(*(u16 *)ptr);
-		break;
-	case 4:
-		ret = READ_ONCE(*(u32 *)ptr);
-		break;
-	case 8:
-		ret = READ_ONCE(*(u64 *)ptr);
-		break;
-	default:
-		ret = 0;
-		BUILD_BUG();
-	}
-
-	return ret;
+static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
+{									\
+	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
 }
 
-static inline void __percpu_write(void *ptr, unsigned long val, int size)
-{
-	switch (size) {
-	case 1:
-		WRITE_ONCE(*(u8 *)ptr, (u8)val);
-		break;
-	case 2:
-		WRITE_ONCE(*(u16 *)ptr, (u16)val);
-		break;
-	case 4:
-		WRITE_ONCE(*(u32 *)ptr, (u32)val);
-		break;
-	case 8:
-		WRITE_ONCE(*(u64 *)ptr, (u64)val);
-		break;
-	default:
-		BUILD_BUG();
-	}
+#define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
+static inline void							\
+__percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
+{									\
+	unsigned int loop;						\
+	u##sz tmp;							\
+									\
+	asm volatile (ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"1:	ldxr" #sfx "\t%" #w "[tmp], %[ptr]\n"			\
+		#op_llsc "\t%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
+	"	cbnz	%w[loop], 1b",					\
+	/* LSE atomics */						\
+		#op_lse "\t%" #w "[val], %[ptr]\n"			\
+		__nops(3))						\
+	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
+	  [ptr] "+Q"(*(u##sz *)ptr)					\
+	: [val] "r" ((u##sz)(val)));					\
 }
 
-static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
-						int size)
-{
-	unsigned long ret, loop;
-
-	switch (size) {
-	case 1:
-		asm ("//__percpu_xchg_1\n"
-		"1:	ldxrb	%w[ret], %[ptr]\n"
-		"	stxrb	%w[loop], %w[val], %[ptr]\n"
-		"	cbnz	%w[loop], 1b"
-		: [loop] "=&r"(loop), [ret] "=&r"(ret),
-		  [ptr] "+Q"(*(u8 *)ptr)
-		: [val] "r" (val));
-		break;
-	case 2:
-		asm ("//__percpu_xchg_2\n"
-		"1:	ldxrh	%w[ret], %[ptr]\n"
-		"	stxrh	%w[loop], %w[val], %[ptr]\n"
-		"	cbnz	%w[loop], 1b"
-		: [loop] "=&r"(loop), [ret] "=&r"(ret),
-		  [ptr] "+Q"(*(u16 *)ptr)
-		: [val] "r" (val));
-		break;
-	case 4:
-		asm ("//__percpu_xchg_4\n"
-		"1:	ldxr	%w[ret], %[ptr]\n"
-		"	stxr	%w[loop], %w[val], %[ptr]\n"
-		"	cbnz	%w[loop], 1b"
-		: [loop] "=&r"(loop), [ret] "=&r"(ret),
-		  [ptr] "+Q"(*(u32 *)ptr)
-		: [val] "r" (val));
-		break;
-	case 8:
-		asm ("//__percpu_xchg_8\n"
-		"1:	ldxr	%[ret], %[ptr]\n"
-		"	stxr	%w[loop], %[val], %[ptr]\n"
-		"	cbnz	%w[loop], 1b"
-		: [loop] "=&r"(loop), [ret] "=&r"(ret),
-		  [ptr] "+Q"(*(u64 *)ptr)
-		: [val] "r" (val));
-		break;
-	default:
-		ret = 0;
-		BUILD_BUG();
-	}
-
-	return ret;
+#define __PERCPU_RET_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
+static inline u##sz							\
+__percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
+{									\
+	unsigned int loop;						\
+	u##sz ret;							\
+									\
+	asm volatile (ARM64_LSE_ATOMIC_INSN(				\
+	/* LL/SC */							\
+	"1:	ldxr" #sfx "\t%" #w "[ret], %[ptr]\n"			\
+		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
+	"	stxr" #sfx "\t%w[loop], %" #w "[ret], %[ptr]\n"		\
+	"	cbnz	%w[loop], 1b",					\
+	/* LSE atomics */						\
+		#op_lse "\t%" #w "[ret], %" #w "[val], %[ptr]\n"	\
+		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\
+		__nops(2))						\
+	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\
+	  [ptr] "+Q"(*(u##sz *)ptr)					\
+	: [val] "r" ((u##sz)(val)));					\
+									\
+	return ret;							\
 }
 
-/* this_cpu_cmpxchg */
-#define _protect_cmpxchg_local(pcp, o, n)			\
-({								\
-	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
-	preempt_disable();					\
-	__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n);	\
-	preempt_enable();					\
-	__ret;							\
-})
-
-#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
-#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
-#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
-#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define PERCPU_OP(name, op_llsc, op_lse)				\
+	__PERCPU_OP_CASE(w, b, name,  8, op_llsc, op_lse)		\
+	__PERCPU_OP_CASE(w, h, name, 16, op_llsc, op_lse)		\
+	__PERCPU_OP_CASE(w,  , name, 32, op_llsc, op_lse)		\
+	__PERCPU_OP_CASE( ,  , name, 64, op_llsc, op_lse)
+
+#define PERCPU_RET_OP(name, op_llsc, op_lse)				\
+	__PERCPU_RET_OP_CASE(w, b, name,  8, op_llsc, op_lse)		\
+	__PERCPU_RET_OP_CASE(w, h, name, 16, op_llsc, op_lse)		\
+	__PERCPU_RET_OP_CASE(w,  , name, 32, op_llsc, op_lse)		\
+	__PERCPU_RET_OP_CASE( ,  , name, 64, op_llsc, op_lse)
+
+PERCPU_RW_OPS(8)
+PERCPU_RW_OPS(16)
+PERCPU_RW_OPS(32)
+PERCPU_RW_OPS(64)
+PERCPU_OP(add, add, stadd)
+PERCPU_OP(andnot, bic, stclr)
+PERCPU_OP(or, orr, stset)
+PERCPU_RET_OP(add, add, ldadd)
+
+#undef PERCPU_RW_OPS
+#undef __PERCPU_OP_CASE
+#undef __PERCPU_RET_OP_CASE
+#undef PERCPU_OP
+#undef PERCPU_RET_OP
 
+/*
+ * It would be nice to avoid the conditional call into the scheduler when
+ * re-enabling preemption for preemptible kernels, but doing that in a way
+ * which builds inside a module would mean messing directly with the preempt
+ * count. If you do this, peterz and tglx will hunt you down.
+ */
 #define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2)		\
 ({									\
 	int __ret;							\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	__ret = cmpxchg_double_local(	raw_cpu_ptr(&(ptr1)),		\
 					raw_cpu_ptr(&(ptr2)),		\
 					o1, o2, n1, n2);		\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	__ret;								\
 })
 
-#define _percpu_read(pcp)						\
+#define _pcp_protect(op, pcp, ...)					\
 ({									\
-	typeof(pcp) __retval;						\
 	preempt_disable_notrace();					\
-	__retval = (typeof(pcp))__percpu_read(raw_cpu_ptr(&(pcp)), 	\
-					      sizeof(pcp));		\
+	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
 	preempt_enable_notrace();					\
-	__retval;							\
 })
 
-#define _percpu_write(pcp, val)						\
-do {									\
+#define _pcp_protect_return(op, pcp, args...)				\
+({									\
+	typeof(pcp) __retval;						\
 	preempt_disable_notrace();					\
-	__percpu_write(raw_cpu_ptr(&(pcp)), (unsigned long)(val), 	\
-				sizeof(pcp));				\
+	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
 	preempt_enable_notrace();					\
-} while(0)								\
-
-#define _pcp_protect(operation, pcp, val)			\
-({								\
-	typeof(pcp) __retval;					\
-	preempt_disable();					\
-	__retval = (typeof(pcp))operation(raw_cpu_ptr(&(pcp)),	\
-					  (val), sizeof(pcp));	\
-	preempt_enable();					\
-	__retval;						\
+	__retval;							\
 })
 
-#define _percpu_add(pcp, val) \
-	_pcp_protect(__percpu_add, pcp, val)
-
-#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
-
-#define _percpu_and(pcp, val) \
-	_pcp_protect(__percpu_and, pcp, val)
-
-#define _percpu_or(pcp, val) \
-	_pcp_protect(__percpu_or, pcp, val)
-
-#define _percpu_xchg(pcp, val) (typeof(pcp)) \
-	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val))
-
-#define this_cpu_add_1(pcp, val) _percpu_add(pcp, val)
-#define this_cpu_add_2(pcp, val) _percpu_add(pcp, val)
-#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
-#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
-
-#define this_cpu_add_return_1(pcp, val) _percpu_add_return(pcp, val)
-#define this_cpu_add_return_2(pcp, val) _percpu_add_return(pcp, val)
-#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
-#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
-
-#define this_cpu_and_1(pcp, val) _percpu_and(pcp, val)
-#define this_cpu_and_2(pcp, val) _percpu_and(pcp, val)
-#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
-#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
-
-#define this_cpu_or_1(pcp, val) _percpu_or(pcp, val)
-#define this_cpu_or_2(pcp, val) _percpu_or(pcp, val)
-#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
-#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
-
-#define this_cpu_read_1(pcp) _percpu_read(pcp)
-#define this_cpu_read_2(pcp) _percpu_read(pcp)
-#define this_cpu_read_4(pcp) _percpu_read(pcp)
-#define this_cpu_read_8(pcp) _percpu_read(pcp)
-
-#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
-#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
-#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
-#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
-
-#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
-#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
-#define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
-#define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_read_1(pcp)		\
+	_pcp_protect_return(__percpu_read_8, pcp)
+#define this_cpu_read_2(pcp)		\
+	_pcp_protect_return(__percpu_read_16, pcp)
+#define this_cpu_read_4(pcp)		\
+	_pcp_protect_return(__percpu_read_32, pcp)
+#define this_cpu_read_8(pcp)		\
+	_pcp_protect_return(__percpu_read_64, pcp)
+
+#define this_cpu_write_1(pcp, val)	\
+	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
+#define this_cpu_write_2(pcp, val)	\
+	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
+#define this_cpu_write_4(pcp, val)	\
+	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
+#define this_cpu_write_8(pcp, val)	\
+	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
+
+#define this_cpu_add_1(pcp, val)	\
+	_pcp_protect(__percpu_add_case_8, pcp, val)
+#define this_cpu_add_2(pcp, val)	\
+	_pcp_protect(__percpu_add_case_16, pcp, val)
+#define this_cpu_add_4(pcp, val)	\
+	_pcp_protect(__percpu_add_case_32, pcp, val)
+#define this_cpu_add_8(pcp, val)	\
+	_pcp_protect(__percpu_add_case_64, pcp, val)
+
+#define this_cpu_add_return_1(pcp, val)	\
+	_pcp_protect_return(__percpu_add_return_case_8, pcp, val)
+#define this_cpu_add_return_2(pcp, val)	\
+	_pcp_protect_return(__percpu_add_return_case_16, pcp, val)
+#define this_cpu_add_return_4(pcp, val)	\
+	_pcp_protect_return(__percpu_add_return_case_32, pcp, val)
+#define this_cpu_add_return_8(pcp, val)	\
+	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
+
+#define this_cpu_and_1(pcp, val)	\
+	_pcp_protect(__percpu_andnot_case_8, pcp, ~val)
+#define this_cpu_and_2(pcp, val)	\
+	_pcp_protect(__percpu_andnot_case_16, pcp, ~val)
+#define this_cpu_and_4(pcp, val)	\
+	_pcp_protect(__percpu_andnot_case_32, pcp, ~val)
+#define this_cpu_and_8(pcp, val)	\
+	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
+
+#define this_cpu_or_1(pcp, val)		\
+	_pcp_protect(__percpu_or_case_8, pcp, val)
+#define this_cpu_or_2(pcp, val)		\
+	_pcp_protect(__percpu_or_case_16, pcp, val)
+#define this_cpu_or_4(pcp, val)		\
+	_pcp_protect(__percpu_or_case_32, pcp, val)
+#define this_cpu_or_8(pcp, val)		\
+	_pcp_protect(__percpu_or_case_64, pcp, val)
+
+#define this_cpu_xchg_1(pcp, val)	\
+	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_2(pcp, val)	\
+	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	\
+	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_8(pcp, val)	\
+	_pcp_protect_return(xchg_relaxed, pcp, val)
+
+#define this_cpu_cmpxchg_1(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_2(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_4(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_8(pcp, o, n)	\
+	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
 
 #include <asm-generic/percpu.h>
 
-- 
2.1.4
