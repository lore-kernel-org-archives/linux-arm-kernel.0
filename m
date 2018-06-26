From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2018 12:00:11 +0100
Subject: [PATCH 2/3] arm64: locking: Replace ticket lock implementation with
 qspinlock
In-Reply-To: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
References: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
Message-ID: <1530010812-17161-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's fair to say that our ticket lock has served us well over time, but
it's time to bite the bullet and start using the generic qspinlock code
so we can make use of explicit MCS queuing and potentially better PV
performance in future.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                      |   1 +
 arch/arm64/include/asm/Kbuild           |   1 +
 arch/arm64/include/asm/spinlock.h       | 117 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |  17 +----
 4 files changed, 4 insertions(+), 132 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..facd19625563 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -44,6 +44,7 @@ config ARM64
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 3a9b84d39d71..6cd5d77b6b44 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += mm-arch-hooks.h
 generic-y += msi.h
 generic-y += preempt.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += serial.h
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 26c5bd7d88d8..38116008d18b 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -16,123 +16,8 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
-#include <asm/lse.h>
-#include <asm/spinlock_types.h>
-#include <asm/processor.h>
-
-/*
- * Spinlock implementation.
- *
- * The memory barriers are implicit with the load-acquire and store-release
- * instructions.
- */
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	unsigned int tmp;
-	arch_spinlock_t lockval, newval;
-
-	asm volatile(
-	/* Atomically increment the next ticket. */
-	ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-"	prfm	pstl1strm, %3\n"
-"1:	ldaxr	%w0, %3\n"
-"	add	%w1, %w0, %w5\n"
-"	stxr	%w2, %w1, %3\n"
-"	cbnz	%w2, 1b\n",
-	/* LSE atomics */
-"	mov	%w2, %w5\n"
-"	ldadda	%w2, %w0, %3\n"
-	__nops(3)
-	)
-
-	/* Did we get the lock? */
-"	eor	%w1, %w0, %w0, ror #16\n"
-"	cbz	%w1, 3f\n"
-	/*
-	 * No: spin on the owner. Send a local event to avoid missing an
-	 * unlock before the exclusive load.
-	 */
-"	sevl\n"
-"2:	wfe\n"
-"	ldaxrh	%w2, %4\n"
-"	eor	%w1, %w2, %w0, lsr #16\n"
-"	cbnz	%w1, 2b\n"
-	/* We got the lock. Critical section starts here. */
-"3:"
-	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
-	: "Q" (lock->owner), "I" (1 << TICKET_SHIFT)
-	: "memory");
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	unsigned int tmp;
-	arch_spinlock_t lockval;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	prfm	pstl1strm, %2\n"
-	"1:	ldaxr	%w0, %2\n"
-	"	eor	%w1, %w0, %w0, ror #16\n"
-	"	cbnz	%w1, 2f\n"
-	"	add	%w0, %w0, %3\n"
-	"	stxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 1b\n"
-	"2:",
-	/* LSE atomics */
-	"	ldr	%w0, %2\n"
-	"	eor	%w1, %w0, %w0, ror #16\n"
-	"	cbnz	%w1, 1f\n"
-	"	add	%w1, %w0, %3\n"
-	"	casa	%w0, %w1, %2\n"
-	"	sub	%w1, %w1, %3\n"
-	"	eor	%w1, %w1, %w0\n"
-	"1:")
-	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
-	: "I" (1 << TICKET_SHIFT)
-	: "memory");
-
-	return !tmp;
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	unsigned long tmp;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	ldrh	%w1, %0\n"
-	"	add	%w1, %w1, #1\n"
-	"	stlrh	%w1, %0",
-	/* LSE atomics */
-	"	mov	%w1, #1\n"
-	"	staddlh	%w1, %0\n"
-	__nops(1))
-	: "=Q" (lock->owner), "=&r" (tmp)
-	:
-	: "memory");
-}
-
-static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
-{
-	return lock.owner == lock.next;
-}
-
-static inline int arch_spin_is_locked(arch_spinlock_t *lock)
-{
-	return !arch_spin_value_unlocked(READ_ONCE(*lock));
-}
-
-static inline int arch_spin_is_contended(arch_spinlock_t *lock)
-{
-	arch_spinlock_t lockval = READ_ONCE(*lock);
-	return (lockval.next - lockval.owner) > 1;
-}
-#define arch_spin_is_contended	arch_spin_is_contended
-
 #include <asm/qrwlock.h>
+#include <asm/qspinlock.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 6b856012c51b..a157ff465e27 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -20,22 +20,7 @@
 # error "please don't include this file directly"
 #endif
 
-#include <linux/types.h>
-
-#define TICKET_SHIFT	16
-
-typedef struct {
-#ifdef __AARCH64EB__
-	u16 next;
-	u16 owner;
-#else
-	u16 owner;
-	u16 next;
-#endif
-} __aligned(4) arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
-
+#include <asm-generic/qspinlock_types.h>
 #include <asm-generic/qrwlock_types.h>
 
 #endif
-- 
2.1.4
