From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2009 18:13:57 +0000
Subject: [PATCH] ARM: Add atomic64 routines for ARMv6k and above.
Message-ID: <1260555237-18825-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for perf-events support, ARM needs to support atomic64_t
operations. v6k and above support the ldrexd and strexd instructions to do
just that.

This patch adds atomic64 support to the ARM architecture. v6k and above
make use of new instructions whilst older cores fall back on the generic
solution using spinlocks. If and when v7-M cores are supported by Linux, they
will need to fall back on the spinlock implementation too.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jamie Iles <jamie.iles@picochip.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/include/asm/atomic.h |  228 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..5fdc032 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select GENERIC_ATOMIC64 if (!CPU_32v6K)
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index d0daeab..e8ddec2 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -235,6 +235,234 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#ifndef CONFIG_GENERIC_ATOMIC64
+typedef struct {
+	u64 __aligned(8) counter;
+} atomic64_t;
+
+#define ATOMIC64_INIT(i) { (i) }
+
+static inline u64 atomic64_read(atomic64_t *v)
+{
+	u64 result;
+
+	__asm__ __volatile__("@ atomic64_read\n"
+"	ldrexd	%0, %H0, [%1]"
+	: "=&r" (result)
+	: "r" (&v->counter)
+	);
+
+	return result;
+}
+
+static inline void atomic64_set(atomic64_t *v, u64 i)
+{
+	u64 tmp;
+
+	__asm__ __volatile__("@ atomic64_set\n"
+"1:	ldrexd	%0, %H0, [%1]\n"
+"	strexd	%0, %2, %H2, [%1]\n"
+"	teq	%0, #0\n"
+"	bne	1b"
+	: "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+}
+
+static inline void atomic64_add(u64 i, atomic64_t *v)
+{
+	u64 result;
+	unsigned long tmp;
+
+	__asm__ __volatile__("@ atomic64_add\n"
+"1:	ldrexd	%0, %H0, [%2]\n"
+"	adds	%0, %0, %3\n"
+"	adc	%H0, %H0, %H3\n"
+"	strexd	%1, %0, %H0, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+}
+
+static inline u64 atomic64_add_return(u64 i, atomic64_t *v)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ atomic64_add_return\n"
+"1:	ldrexd	%0, %H0, [%2]\n"
+"	adds	%0, %0, %3\n"
+"	adc	%H0, %H0, %H3\n"
+"	strexd	%1, %0, %H0, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+
+	smp_mb();
+
+	return result;
+}
+
+static inline void atomic64_sub(u64 i, atomic64_t *v)
+{
+	u64 result;
+	unsigned long tmp;
+
+	__asm__ __volatile__("@ atomic64_sub\n"
+"1:	ldrexd	%0, %H0, [%2]\n"
+"	subs	%0, %0, %3\n"
+"	sbc	%H0, %H0, %H3\n"
+"	strexd	%1, %0, %H0, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+}
+
+static inline u64 atomic64_sub_return(u64 i, atomic64_t *v)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ atomic64_sub_return\n"
+"1:	ldrexd	%0, %H0, [%2]\n"
+"	subs	%0, %0, %3\n"
+"	sbc	%H0, %H0, %H3\n"
+"	strexd	%1, %0, %H0, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+
+	smp_mb();
+
+	return result;
+}
+
+static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
+{
+	u64 oldval;
+	unsigned long res;
+
+	smp_mb();
+
+	do {
+		__asm__ __volatile__("@ atomic64_cmpxchg\n"
+		"ldrexd		%1, %H1, [%2]\n"
+		"mov		%0, #0\n"
+		"teq		%1, %3\n"
+		"teqeq		%H1, %H3\n"
+		"strexdeq	%0, %4, %H4, [%2]"
+		: "=&r" (res), "=&r" (oldval)
+		: "r" (&ptr->counter), "r" (old), "r" (new)
+		: "cc");
+	} while (res);
+
+	smp_mb();
+
+	return oldval;
+}
+
+static inline u64 atomic64_xchg(atomic64_t *ptr, u64 new)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ atomic64_xchg\n"
+"1:	ldrexd	%0, %H0, [%2]\n"
+"	strexd	%1, %3, %H3, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp)
+	: "r" (&ptr->counter), "r" (new)
+	: "cc");
+
+	smp_mb();
+
+	return result;
+}
+
+static inline u64 atomic64_dec_if_positive(atomic64_t *v)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ atomic64_dec_if_positive\n"
+"1:	ldrexd	%0, %H0, [%2]\n"
+"	subs	%0, %0, #1\n"
+"	sbc	%H0, %H0, #0\n"
+"	teq	%H0, #0\n"
+"	bmi	2f\n"
+"	strexd	%1, %0, %H0, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b\n"
+"2:"
+	: "=&r" (result), "=&r" (tmp)
+	: "r" (&v->counter)
+	: "cc");
+
+	smp_mb();
+
+	return result;
+}
+
+static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
+{
+	u64 val;
+	unsigned long tmp;
+	int ret = 1;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ atomic64_add_unless\n"
+"1:	ldrexd	%0, %H0, [%3]\n"
+"	teq	%0, %4\n"
+"	teqeq	%H0, %H4\n"
+"	moveq	%1, #0\n"
+"	beq	2f\n"
+"	adds	%0, %0, %5\n"
+"	adc	%H0, %H0, %H5\n"
+"	strexd	%2, %0, %H0, [%3]\n"
+"	teq	%2, #0\n"
+"	bne	1b\n"
+"2:"
+	: "=&r" (val), "=&r" (ret), "=&r" (tmp)
+	: "r" (&v->counter), "r" (u), "r" (a)
+	: "cc");
+
+	if (ret)
+		smp_mb();
+
+	return ret;
+}
+
+#define atomic64_add_negative(a, v)	(atomic64_add_return((a), (v)) < 0)
+#define atomic64_inc(v)			atomic64_add(1LL, (v))
+#define atomic64_inc_return(v)		atomic64_add_return(1LL, (v))
+#define atomic64_inc_and_test(v)	(atomic64_inc_return(v) == 0)
+#define atomic64_sub_and_test(a, v)	(atomic64_sub_return((a), (v)) == 0)
+#define atomic64_dec(v)			atomic64_sub(1LL, (v))
+#define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
+#define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
+#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
+
+#else /* !CONFIG_GENERIC_ATOMIC64 */
+#include <asm-generic/atomic64.h>
+#endif
 #include <asm-generic/atomic-long.h>
 #endif
 #endif
-- 
1.6.5.2
