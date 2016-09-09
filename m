From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:16:02 +0100
Subject: [PATCH 3/6] arm64: lse: convert lse alternatives NOP padding to use
 __nops
In-Reply-To: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
Message-ID: <1473419765-3437-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LSE atomics are implemented using alternative code sequences of
different lengths, and explicit NOP padding is used to ensure the
patching works correctly.

This patch converts the bulk of the LSE code over to using the __nops
macro, which makes it slightly clearer as to what is going on and also
consolidates all of the padding at the end of the various sequences.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/atomic_lse.h | 64 ++++++++++++++++---------------------
 arch/arm64/include/asm/cmpxchg.h    |  4 +--
 arch/arm64/include/asm/spinlock.h   | 27 +++++++---------
 3 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index b5890be8f257..7457ce082b5f 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -86,8 +86,8 @@ static inline int atomic_add_return##name(int i, atomic_t *v)		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC(add_return##name),				\
+	__LL_SC_ATOMIC(add_return##name)				\
+	__nops(1),							\
 	/* LSE atomics */						\
 	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
 	"	add	%w[i], %w[i], w30")				\
@@ -112,8 +112,8 @@ static inline void atomic_and(int i, atomic_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC(and),
+	__LL_SC_ATOMIC(and)
+	__nops(1),
 	/* LSE atomics */
 	"	mvn	%w[i], %w[i]\n"
 	"	stclr	%w[i], %[v]")
@@ -130,8 +130,8 @@ static inline int atomic_fetch_and##name(int i, atomic_t *v)		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC(fetch_and##name),				\
+	__LL_SC_ATOMIC(fetch_and##name)					\
+	__nops(1),							\
 	/* LSE atomics */						\
 	"	mvn	%w[i], %w[i]\n"					\
 	"	ldclr" #mb "	%w[i], %w[i], %[v]")			\
@@ -156,8 +156,8 @@ static inline void atomic_sub(int i, atomic_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC(sub),
+	__LL_SC_ATOMIC(sub)
+	__nops(1),
 	/* LSE atomics */
 	"	neg	%w[i], %w[i]\n"
 	"	stadd	%w[i], %[v]")
@@ -174,9 +174,8 @@ static inline int atomic_sub_return##name(int i, atomic_t *v)		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
 	__LL_SC_ATOMIC(sub_return##name)				\
-	"	nop",							\
+	__nops(2),							\
 	/* LSE atomics */						\
 	"	neg	%w[i], %w[i]\n"					\
 	"	ldadd" #mb "	%w[i], w30, %[v]\n"			\
@@ -203,8 +202,8 @@ static inline int atomic_fetch_sub##name(int i, atomic_t *v)		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC(fetch_sub##name),				\
+	__LL_SC_ATOMIC(fetch_sub##name)					\
+	__nops(1),							\
 	/* LSE atomics */						\
 	"	neg	%w[i], %w[i]\n"					\
 	"	ldadd" #mb "	%w[i], %w[i], %[v]")			\
@@ -284,8 +283,8 @@ static inline long atomic64_add_return##name(long i, atomic64_t *v)	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC64(add_return##name),				\
+	__LL_SC_ATOMIC64(add_return##name)				\
+	__nops(1),							\
 	/* LSE atomics */						\
 	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
 	"	add	%[i], %[i], x30")				\
@@ -310,8 +309,8 @@ static inline void atomic64_and(long i, atomic64_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC64(and),
+	__LL_SC_ATOMIC64(and)
+	__nops(1),
 	/* LSE atomics */
 	"	mvn	%[i], %[i]\n"
 	"	stclr	%[i], %[v]")
@@ -328,8 +327,8 @@ static inline long atomic64_fetch_and##name(long i, atomic64_t *v)	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC64(fetch_and##name),				\
+	__LL_SC_ATOMIC64(fetch_and##name)				\
+	__nops(1),							\
 	/* LSE atomics */						\
 	"	mvn	%[i], %[i]\n"					\
 	"	ldclr" #mb "	%[i], %[i], %[v]")			\
@@ -354,8 +353,8 @@ static inline void atomic64_sub(long i, atomic64_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
-	__LL_SC_ATOMIC64(sub),
+	__LL_SC_ATOMIC64(sub)
+	__nops(1),
 	/* LSE atomics */
 	"	neg	%[i], %[i]\n"
 	"	stadd	%[i], %[v]")
@@ -372,9 +371,8 @@ static inline long atomic64_sub_return##name(long i, atomic64_t *v)	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
 	__LL_SC_ATOMIC64(sub_return##name)				\
-	"	nop",							\
+	__nops(2),							\
 	/* LSE atomics */						\
 	"	neg	%[i], %[i]\n"					\
 	"	ldadd" #mb "	%[i], x30, %[v]\n"			\
@@ -401,8 +399,8 @@ static inline long atomic64_fetch_sub##name(long i, atomic64_t *v)	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	__LL_SC_ATOMIC64(fetch_sub##name),				\
+	__LL_SC_ATOMIC64(fetch_sub##name)				\
+	__nops(1),							\
 	/* LSE atomics */						\
 	"	neg	%[i], %[i]\n"					\
 	"	ldadd" #mb "	%[i], %[i], %[v]")			\
@@ -426,13 +424,8 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
 
 	asm volatile(ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
-	"	nop\n"
 	__LL_SC_ATOMIC64(dec_if_positive)
-	"	nop\n"
-	"	nop\n"
-	"	nop\n"
-	"	nop\n"
-	"	nop",
+	__nops(6),
 	/* LSE atomics */
 	"1:	ldr	x30, %[v]\n"
 	"	subs	%[ret], x30, #1\n"
@@ -464,9 +457,8 @@ static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,	\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-		__LL_SC_CMPXCHG(name)					\
-	"	nop",							\
+	__LL_SC_CMPXCHG(name)						\
+	__nops(2),							\
 	/* LSE atomics */						\
 	"	mov	" #w "30, %" #w "[old]\n"			\
 	"	cas" #mb #sz "\t" #w "30, %" #w "[new], %[v]\n"		\
@@ -517,10 +509,8 @@ static inline long __cmpxchg_double##name(unsigned long old1,		\
 									\
 	asm volatile(ARM64_LSE_ATOMIC_INSN(				\
 	/* LL/SC */							\
-	"	nop\n"							\
-	"	nop\n"							\
-	"	nop\n"							\
-	__LL_SC_CMPXCHG_DBL(name),					\
+	__LL_SC_CMPXCHG_DBL(name)					\
+	__nops(3),							\
 	/* LSE atomics */						\
 	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
 	"	eor	%[old1], %[old1], %[oldval1]\n"			\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index bd86a79491bc..91b26d26af8a 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -43,10 +43,8 @@ static inline unsigned long __xchg_case_##name(unsigned long x,		\
 	"	cbnz	%w1, 1b\n"					\
 	"	" #mb,							\
 	/* LSE atomics */						\
-	"	nop\n"							\
-	"	nop\n"							\
 	"	swp" #acq_lse #rel #sz "\t%" #w "3, %" #w "0, %2\n"	\
-	"	nop\n"							\
+		__nops(3)						\
 	"	" #nop_lse)						\
 	: "=&r" (ret), "=&r" (tmp), "+Q" (*(u8 *)ptr)			\
 	: "r" (x)							\
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index e875a5a551d7..28f8c2174f8a 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -66,8 +66,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 	ARM64_LSE_ATOMIC_INSN(
 	/* LL/SC */
 "	stxr	%w1, %w0, %2\n"
-"	nop\n"
-"	nop\n",
+	__nops(2),
 	/* LSE atomics */
 "	mov	%w1, %w0\n"
 "	cas	%w0, %w0, %2\n"
@@ -99,9 +98,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	/* LSE atomics */
 "	mov	%w2, %w5\n"
 "	ldadda	%w2, %w0, %3\n"
-"	nop\n"
-"	nop\n"
-"	nop\n"
+	__nops(3)
 	)
 
 	/* Did we get the lock? */
@@ -165,8 +162,8 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	"	stlrh	%w1, %0",
 	/* LSE atomics */
 	"	mov	%w1, #1\n"
-	"	nop\n"
-	"	staddlh	%w1, %0")
+	"	staddlh	%w1, %0\n"
+	__nops(1))
 	: "=Q" (lock->owner), "=&r" (tmp)
 	:
 	: "memory");
@@ -212,7 +209,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 	"	cbnz	%w0, 1b\n"
 	"	stxr	%w0, %w2, %1\n"
 	"	cbnz	%w0, 2b\n"
-	"	nop",
+	__nops(1),
 	/* LSE atomics */
 	"1:	mov	%w0, wzr\n"
 	"2:	casa	%w0, %w2, %1\n"
@@ -241,8 +238,7 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 	/* LSE atomics */
 	"	mov	%w0, wzr\n"
 	"	casa	%w0, %w2, %1\n"
-	"	nop\n"
-	"	nop")
+	__nops(2))
 	: "=&r" (tmp), "+Q" (rw->lock)
 	: "r" (0x80000000)
 	: "memory");
@@ -290,8 +286,8 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 	"	add	%w0, %w0, #1\n"
 	"	tbnz	%w0, #31, 1b\n"
 	"	stxr	%w1, %w0, %2\n"
-	"	nop\n"
-	"	cbnz	%w1, 2b",
+	"	cbnz	%w1, 2b\n"
+	__nops(1),
 	/* LSE atomics */
 	"1:	wfe\n"
 	"2:	ldxr	%w0, %2\n"
@@ -317,9 +313,8 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 	"	cbnz	%w1, 1b",
 	/* LSE atomics */
 	"	movn	%w0, #0\n"
-	"	nop\n"
-	"	nop\n"
-	"	staddl	%w0, %2")
+	"	staddl	%w0, %2\n"
+	__nops(2))
 	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
 	: "memory");
@@ -344,7 +339,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 	"	tbnz	%w1, #31, 1f\n"
 	"	casa	%w0, %w1, %2\n"
 	"	sbc	%w1, %w1, %w0\n"
-	"	nop\n"
+	__nops(1)
 	"1:")
 	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
-- 
2.1.4
