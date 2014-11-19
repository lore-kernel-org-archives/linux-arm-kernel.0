From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 19 Nov 2014 16:53:43 +0000
Subject: [PATCH V5] arm64: percpu: Implement this_cpu operations
In-Reply-To: <20141119154920.GA25504@linaro.org>
References: <20141119154920.GA25504@linaro.org>
Message-ID: <1416416023-27216-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic this_cpu operations disable interrupts to ensure that the
requested operation is protected from pre-emption. For arm64, this is
overkill and can hurt throughput and latency.

This patch provides arm64 specific implementations for the this_cpu
operations. Rather than disable interrupts, we use the exclusive
monitor or atomic operations as appropriate.

The following operations are implemented: add, add_return, and, or,
read, write, xchg. We also wire up a cmpxchg implementation from
cmpxchg.h.

Testing was performed using the percpu_test module and hackbench on a
Juno board running 3.18-rc4.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
Changed in V5: spacing and parantheses sanetised for read/write
accessors.

Changed in V4: rebased to allow for merge in Will's for-next branch.
(I had erroneously changed my cmpxchg_double patch).

Changed the read/write accessors to use ACCESS_ONCE rather than asm.

Changed in V3: use cmpxchg_local rather than cmpxchg for
this_cpu_cmpxchg.

Changed in V2: corrected address constraint for __percpu_read and
__percpu_write.
---
 arch/arm64/include/asm/cmpxchg.h |   6 +-
 arch/arm64/include/asm/percpu.h  | 215 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 89e397b..cb95930 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -246,8 +246,10 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 	__ret; \
 })
 
-#define this_cpu_cmpxchg_8(ptr, o, n) \
-	cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
+#define this_cpu_cmpxchg_1(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
+#define this_cpu_cmpxchg_2(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
+#define this_cpu_cmpxchg_4(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
+#define this_cpu_cmpxchg_8(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
 
 #define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2) \
 	cmpxchg_double_local(raw_cpu_ptr(&(ptr1)), raw_cpu_ptr(&(ptr2)), \
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 5279e57..09da25b 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -44,6 +44,221 @@ static inline unsigned long __my_cpu_offset(void)
 
 #endif /* CONFIG_SMP */
 
+#define PERCPU_OP(op, asm_op)						\
+static inline unsigned long __percpu_##op(void *ptr,			\
+			unsigned long val, int size)			\
+{									\
+	unsigned long loop, ret;					\
+									\
+	switch (size) {							\
+	case 1:								\
+		do {							\
+			asm ("//__per_cpu_" #op "_1\n"			\
+			"ldxrb	  %w[ret], %[ptr]\n"			\
+			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
+			"stxrb	  %w[loop], %w[ret], %[ptr]\n"		\
+			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
+			  [ptr] "+Q"(*(u8 *)ptr)			\
+			: [val] "Ir" (val));				\
+		} while (loop);						\
+		break;							\
+	case 2:								\
+		do {							\
+			asm ("//__per_cpu_" #op "_2\n"			\
+			"ldxrh	  %w[ret], %[ptr]\n"			\
+			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
+			"stxrh	  %w[loop], %w[ret], %[ptr]\n"		\
+			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
+			  [ptr]  "+Q"(*(u16 *)ptr)			\
+			: [val] "Ir" (val));				\
+		} while (loop);						\
+		break;							\
+	case 4:								\
+		do {							\
+			asm ("//__per_cpu_" #op "_4\n"			\
+			"ldxr	  %w[ret], %[ptr]\n"			\
+			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
+			"stxr	  %w[loop], %w[ret], %[ptr]\n"		\
+			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
+			  [ptr] "+Q"(*(u32 *)ptr)			\
+			: [val] "Ir" (val));				\
+		} while (loop);						\
+		break;							\
+	case 8:								\
+		do {							\
+			asm ("//__per_cpu_" #op "_8\n"			\
+			"ldxr	  %[ret], %[ptr]\n"			\
+			#asm_op " %[ret], %[ret], %[val]\n"		\
+			"stxr	  %w[loop], %[ret], %[ptr]\n"		\
+			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
+			  [ptr] "+Q"(*(u64 *)ptr)			\
+			: [val] "Ir" (val));				\
+		} while (loop);						\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+									\
+	return ret;							\
+}
+
+PERCPU_OP(add, add)
+PERCPU_OP(and, and)
+PERCPU_OP(or, orr)
+#undef PERCPU_OP
+
+static inline unsigned long __percpu_read(void *ptr, int size)
+{
+	unsigned long ret;
+
+	switch (size) {
+	case 1:
+		ret = ACCESS_ONCE(*(u8 *)ptr);
+		break;
+	case 2:
+		ret = ACCESS_ONCE(*(u16 *)ptr);
+		break;
+	case 4:
+		ret = ACCESS_ONCE(*(u32 *)ptr);
+		break;
+	case 8:
+		ret = ACCESS_ONCE(*(u64 *)ptr);
+		break;
+	default:
+		BUILD_BUG();
+	}
+
+	return ret;
+}
+
+static inline void __percpu_write(void *ptr, unsigned long val, int size)
+{
+	switch (size) {
+	case 1:
+		ACCESS_ONCE(*(u8 *)ptr) = (u8)val;
+		break;
+	case 2:
+		ACCESS_ONCE(*(u16 *)ptr) = (u16)val;
+		break;
+	case 4:
+		ACCESS_ONCE(*(u32 *)ptr) = (u32)val;
+		break;
+	case 8:
+		ACCESS_ONCE(*(u64 *)ptr) = (u64)val;
+		break;
+	default:
+		BUILD_BUG();
+	}
+}
+
+static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
+						int size)
+{
+	unsigned long ret, loop;
+
+	switch (size) {
+	case 1:
+		do {
+			asm ("//__percpu_xchg_1\n"
+			"ldxrb %w[ret], %[ptr]\n"
+			"stxrb %w[loop], %w[val], %[ptr]\n"
+			: [loop] "=&r"(loop), [ret] "=&r"(ret),
+			  [ptr] "+Q"(*(u8 *)ptr)
+			: [val] "r" (val));
+		} while (loop);
+		break;
+	case 2:
+		do {
+			asm ("//__percpu_xchg_2\n"
+			"ldxrh %w[ret], %[ptr]\n"
+			"stxrh %w[loop], %w[val], %[ptr]\n"
+			: [loop] "=&r"(loop), [ret] "=&r"(ret),
+			  [ptr] "+Q"(*(u16 *)ptr)
+			: [val] "r" (val));
+		} while (loop);
+		break;
+	case 4:
+		do {
+			asm ("//__percpu_xchg_4\n"
+			"ldxr %w[ret], %[ptr]\n"
+			"stxr %w[loop], %w[val], %[ptr]\n"
+			: [loop] "=&r"(loop), [ret] "=&r"(ret),
+			  [ptr] "+Q"(*(u32 *)ptr)
+			: [val] "r" (val));
+		} while (loop);
+		break;
+	case 8:
+		do {
+			asm ("//__percpu_xchg_8\n"
+			"ldxr %[ret], %[ptr]\n"
+			"stxr %w[loop], %[val], %[ptr]\n"
+			: [loop] "=&r"(loop), [ret] "=&r"(ret),
+			  [ptr] "+Q"(*(u64 *)ptr)
+			: [val] "r" (val));
+		} while (loop);
+		break;
+	default:
+		BUILD_BUG();
+	}
+
+	return ret;
+}
+
+#define _percpu_add(pcp, val) \
+	__percpu_add(raw_cpu_ptr(&(pcp)), val, sizeof(pcp))
+
+#define _percpu_add_return(pcp, val) (typeof(pcp)) (_percpu_add(pcp, val))
+
+#define _percpu_and(pcp, val) \
+	__percpu_and(raw_cpu_ptr(&(pcp)), val, sizeof(pcp))
+
+#define _percpu_or(pcp, val) \
+	__percpu_or(raw_cpu_ptr(&(pcp)), val, sizeof(pcp))
+
+#define _percpu_read(pcp) (typeof(pcp))	\
+	(__percpu_read(raw_cpu_ptr(&(pcp)), sizeof(pcp)))
+
+#define _percpu_write(pcp, val) \
+	__percpu_write(raw_cpu_ptr(&(pcp)), (unsigned long)(val), sizeof(pcp))
+
+#define _percpu_xchg(pcp, val) (typeof(pcp)) \
+	(__percpu_xchg(raw_cpu_ptr(&(pcp)), (unsigned long)(val), sizeof(pcp)))
+
+#define this_cpu_add_1(pcp, val) _percpu_add(pcp, val)
+#define this_cpu_add_2(pcp, val) _percpu_add(pcp, val)
+#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
+#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
+
+#define this_cpu_add_return_1(pcp, val) _percpu_add_return(pcp, val)
+#define this_cpu_add_return_2(pcp, val) _percpu_add_return(pcp, val)
+#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
+#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
+
+#define this_cpu_and_1(pcp, val) _percpu_and(pcp, val)
+#define this_cpu_and_2(pcp, val) _percpu_and(pcp, val)
+#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
+#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
+
+#define this_cpu_or_1(pcp, val) _percpu_or(pcp, val)
+#define this_cpu_or_2(pcp, val) _percpu_or(pcp, val)
+#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
+#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
+
+#define this_cpu_read_1(pcp) _percpu_read(pcp)
+#define this_cpu_read_2(pcp) _percpu_read(pcp)
+#define this_cpu_read_4(pcp) _percpu_read(pcp)
+#define this_cpu_read_8(pcp) _percpu_read(pcp)
+
+#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
+
+#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ASM_PERCPU_H */
-- 
1.9.3
