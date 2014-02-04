From: will.deacon@arm.com (Will Deacon)
Date: Tue,  4 Feb 2014 13:28:44 +0000
Subject: [PATCH 1/2] ARM: prefetch: add prefetchw invocations for barriered
 atomics
Message-ID: <1391520525-14903-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a bunch of benchmarking on the interaction between dmb and pldw,
it turns out that issuing the pldw *after* the dmb instruction can
give modest performance gains (~3% atomic_add_return improvement on a
dual A15).

This patch adds prefetchw invocations to our barriered atomic operations
including cmpxchg, test_and_xxx and futexes.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/atomic.h  | 9 +++++++++
 arch/arm/include/asm/cmpxchg.h | 6 ++++++
 arch/arm/include/asm/futex.h   | 3 +++
 arch/arm/lib/bitops.h          | 5 +++++
 4 files changed, 23 insertions(+)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 62d2cb53b069..6e410090896e 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -60,6 +60,7 @@ static inline int atomic_add_return(int i, atomic_t *v)
 	int result;
 
 	smp_mb();
+	prefetchw(&v->counter);
 
 	__asm__ __volatile__("@ atomic_add_return\n"
 "1:	ldrex	%0, [%3]\n"
@@ -99,6 +100,7 @@ static inline int atomic_sub_return(int i, atomic_t *v)
 	int result;
 
 	smp_mb();
+	prefetchw(&v->counter);
 
 	__asm__ __volatile__("@ atomic_sub_return\n"
 "1:	ldrex	%0, [%3]\n"
@@ -121,6 +123,7 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 	unsigned long res;
 
 	smp_mb();
+	prefetchw(&ptr->counter);
 
 	do {
 		__asm__ __volatile__("@ atomic_cmpxchg\n"
@@ -299,6 +302,7 @@ static inline long long atomic64_add_return(long long i, atomic64_t *v)
 	unsigned long tmp;
 
 	smp_mb();
+	prefetchw(&v->counter);
 
 	__asm__ __volatile__("@ atomic64_add_return\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
@@ -340,6 +344,7 @@ static inline long long atomic64_sub_return(long long i, atomic64_t *v)
 	unsigned long tmp;
 
 	smp_mb();
+	prefetchw(&v->counter);
 
 	__asm__ __volatile__("@ atomic64_sub_return\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
@@ -364,6 +369,7 @@ static inline long long atomic64_cmpxchg(atomic64_t *ptr, long long old,
 	unsigned long res;
 
 	smp_mb();
+	prefetchw(&ptr->counter);
 
 	do {
 		__asm__ __volatile__("@ atomic64_cmpxchg\n"
@@ -388,6 +394,7 @@ static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
 	unsigned long tmp;
 
 	smp_mb();
+	prefetchw(&ptr->counter);
 
 	__asm__ __volatile__("@ atomic64_xchg\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
@@ -409,6 +416,7 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 	unsigned long tmp;
 
 	smp_mb();
+	prefetchw(&v->counter);
 
 	__asm__ __volatile__("@ atomic64_dec_if_positive\n"
 "1:	ldrexd	%0, %H0, [%3]\n"
@@ -436,6 +444,7 @@ static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 	int ret = 1;
 
 	smp_mb();
+	prefetchw(&v->counter);
 
 	__asm__ __volatile__("@ atomic64_add_unless\n"
 "1:	ldrexd	%0, %H0, [%4]\n"
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index df2fbba7efc8..abb2c3769b01 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -2,6 +2,7 @@
 #define __ASM_ARM_CMPXCHG_H
 
 #include <linux/irqflags.h>
+#include <linux/prefetch.h>
 #include <asm/barrier.h>
 
 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
@@ -35,6 +36,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 #endif
 
 	smp_mb();
+	prefetchw((const void *)ptr);
 
 	switch (size) {
 #if __LINUX_ARM_ARCH__ >= 6
@@ -138,6 +140,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 {
 	unsigned long oldval, res;
 
+	prefetchw((const void *)ptr);
+
 	switch (size) {
 #ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
 	case 1:
@@ -230,6 +234,8 @@ static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 	unsigned long long oldval;
 	unsigned long res;
 
+	prefetchw(ptr);
+
 	__asm__ __volatile__(
 "1:	ldrexd		%1, %H1, [%3]\n"
 "	teq		%1, %4\n"
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 2aff798fbef4..53e69dae796f 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -23,6 +23,7 @@
 
 #define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
 	smp_mb();						\
+	prefetchw(uaddr);					\
 	__asm__ __volatile__(					\
 	"1:	ldrex	%1, [%3]\n"				\
 	"	" insn "\n"					\
@@ -46,6 +47,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		return -EFAULT;
 
 	smp_mb();
+	/* Prefetching cannot fault */
+	prefetchw(uaddr);
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
 	"1:	ldrex	%1, [%4]\n"
 	"	teq	%1, %2\n"
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 52886b89706c..9f12ed1eea86 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -37,6 +37,11 @@ UNWIND(	.fnstart	)
 	add	r1, r1, r0, lsl #2	@ Get word offset
 	mov	r3, r2, lsl r3		@ create mask
 	smp_dmb
+#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
+	.arch_extension	mp
+	ALT_SMP(W(pldw)	[r1])
+	ALT_UP(W(nop))
+#endif
 1:	ldrex	r2, [r1]
 	ands	r0, r2, r3		@ save old value of bit
 	\instr	r2, r2, r3		@ toggle bit
-- 
1.8.2.2
