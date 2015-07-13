From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jul 2015 10:25:08 +0100
Subject: [PATCH 07/18] arm64: locks: patch in lse instructions when supported
 by the CPU
In-Reply-To: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436779519-2232-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
it makes sense to use them in preference to ll/sc sequences.

This patch introduces runtime patching of our locking functions so that
LSE atomic instructions are used for spinlocks and rwlocks.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 132 +++++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cee128732435..7a1e852263be 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#include <asm/lse.h>
 #include <asm/spinlock_types.h>
 #include <asm/processor.h>
 
@@ -38,11 +39,21 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 
 	asm volatile(
 	/* Atomically increment the next ticket. */
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
 "	prfm	pstl1strm, %3\n"
 "1:	ldaxr	%w0, %3\n"
 "	add	%w1, %w0, %w5\n"
 "	stxr	%w2, %w1, %3\n"
-"	cbnz	%w2, 1b\n"
+"	cbnz	%w2, 1b\n",
+	/* LSE atomics */
+"	mov	%w2, %w5\n"
+"	ldadda	%w2, %w0, %3\n"
+"	nop\n"
+"	nop\n"
+"	nop\n"
+	)
+
 	/* Did we get the lock? */
 "	eor	%w1, %w0, %w0, ror #16\n"
 "	cbz	%w1, 3f\n"
@@ -67,15 +78,25 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 	unsigned int tmp;
 	arch_spinlock_t lockval;
 
-	asm volatile(
-"	prfm	pstl1strm, %2\n"
-"1:	ldaxr	%w0, %2\n"
-"	eor	%w1, %w0, %w0, ror #16\n"
-"	cbnz	%w1, 2f\n"
-"	add	%w0, %w0, %3\n"
-"	stxr	%w1, %w0, %2\n"
-"	cbnz	%w1, 1b\n"
-"2:"
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldaxr	%w0, %2\n"
+	"	eor	%w1, %w0, %w0, ror #16\n"
+	"	cbnz	%w1, 2f\n"
+	"	add	%w0, %w0, %3\n"
+	"	stxr	%w1, %w0, %2\n"
+	"	cbnz	%w1, 1b\n"
+	"2:",
+	/* LSE atomics */
+	"	ldar	%w0, %2\n"
+	"	eor	%w1, %w0, %w0, ror #16\n"
+	"	cbnz	%w1, 1f\n"
+	"	add	%w1, %w0, %3\n"
+	"	casa	%w0, %w1, %2\n"
+	"	and	%w1, %w1, #0xffff\n"
+	"	eor	%w1, %w1, %w0, lsr #16\n"
+	"1:")
 	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
 	: "I" (1 << TICKET_SHIFT)
 	: "memory");
@@ -85,10 +106,19 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	asm volatile(
-"	stlrh	%w1, %0\n"
-	: "=Q" (lock->owner)
-	: "r" (lock->owner + 1)
+	unsigned long tmp;
+
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	ldr	%w1, %0\n"
+	"	add	%w1, %w1, #1\n"
+	"	stlrh	%w1, %0",
+	/* LSE atomics */
+	"	mov	%w1, #1\n"
+	"	nop\n"
+	"	staddlh	%w1, %0")
+	: "=Q" (lock->owner), "=&r" (tmp)
+	:
 	: "memory");
 }
 
@@ -125,11 +155,19 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 
 	asm volatile(
 	"	sevl\n"
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
 	"1:	wfe\n"
 	"2:	ldaxr	%w0, %1\n"
 	"	cbnz	%w0, 1b\n"
 	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 2b\n"
+	"	cbnz	%w0, 2b",
+	/* LSE atomics */
+	"1:	wfe\n"
+	"	mov	%w0, wzr\n"
+	"	casa	%w0, %w2, %1\n"
+	"	nop\n"
+	"	cbnz	%w0, 1b")
 	: "=&r" (tmp), "+Q" (rw->lock)
 	: "r" (0x80000000)
 	: "memory");
@@ -139,11 +177,16 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned int tmp;
 
-	asm volatile(
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
 	"	ldaxr	%w0, %1\n"
 	"	cbnz	%w0, 1f\n"
 	"	stxr	%w0, %w2, %1\n"
-	"1:\n"
+	"1:",
+	/* LSE atomics */
+	"	mov	%w0, wzr\n"
+	"	casa	%w0, %w2, %1\n"
+	"	nop")
 	: "=&r" (tmp), "+Q" (rw->lock)
 	: "r" (0x80000000)
 	: "memory");
@@ -153,9 +196,10 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 
 static inline void arch_write_unlock(arch_rwlock_t *rw)
 {
-	asm volatile(
-	"	stlr	%w1, %0\n"
-	: "=Q" (rw->lock) : "r" (0) : "memory");
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	"	stlr	wzr, %0",
+	"	swpl	wzr, wzr, %0")
+	: "=Q" (rw->lock) :: "memory");
 }
 
 /* write_can_lock - would write_trylock() succeed? */
@@ -172,6 +216,10 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
  *
  * The memory barriers are implicit with the load-acquire and store-release
  * instructions.
+ *
+ * Note that in UNDEFINED cases, such as unlocking a lock twice, the LL/SC
+ * and LSE implementations may exhibit different behaviour (although this
+ * will have no effect on lockdep).
  */
 static inline void arch_read_lock(arch_rwlock_t *rw)
 {
@@ -179,26 +227,43 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 
 	asm volatile(
 	"	sevl\n"
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
 	"1:	wfe\n"
 	"2:	ldaxr	%w0, %2\n"
 	"	add	%w0, %w0, #1\n"
 	"	tbnz	%w0, #31, 1b\n"
 	"	stxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 2b\n"
+	"	nop\n"
+	"	cbnz	%w1, 2b",
+	/* LSE atomics */
+	"1:	wfe\n"
+	"2:	ldr	%w0, %2\n"
+	"	adds	%w1, %w0, #1\n"
+	"	tbnz	%w1, #31, 1b\n"
+	"	casa	%w0, %w1, %2\n"
+	"	sbc	%w0, %w1, %w0\n"
+	"	cbnz	%w0, 2b")
 	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
-	: "memory");
+	: "cc", "memory");
 }
 
 static inline void arch_read_unlock(arch_rwlock_t *rw)
 {
 	unsigned int tmp, tmp2;
 
-	asm volatile(
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
 	"1:	ldxr	%w0, %2\n"
 	"	sub	%w0, %w0, #1\n"
 	"	stlxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 1b\n"
+	"	cbnz	%w1, 1b",
+	/* LSE atomics */
+	"	movn	%w0, #0\n"
+	"	nop\n"
+	"	nop\n"
+	"	staddl	%w0, %2")
 	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
 	: "memory");
@@ -206,17 +271,26 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
 {
-	unsigned int tmp, tmp2 = 1;
+	unsigned int tmp, tmp2;
 
-	asm volatile(
+	asm volatile(ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	mov	%w1, #1\n"
 	"	ldaxr	%w0, %2\n"
 	"	add	%w0, %w0, #1\n"
 	"	tbnz	%w0, #31, 1f\n"
 	"	stxr	%w1, %w0, %2\n"
-	"1:\n"
-	: "=&r" (tmp), "+r" (tmp2), "+Q" (rw->lock)
+	"1:",
+	/* LSE atomics */
+	"	ldr	%w0, %2\n"
+	"	adds	%w1, %w0, #1\n"
+	"	tbnz	%w1, #31, 1f\n"
+	"	casa	%w0, %w1, %2\n"
+	"	sbc	%w1, %w1, %w0\n"
+	"1:")
+	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
 	:
-	: "memory");
+	: "cc", "memory");
 
 	return !tmp2;
 }
-- 
2.1.4
