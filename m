From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Oct 2017 13:54:55 +0100
Subject: [PATCH 4/6] arm64: locking: Move rwlock implementation over to
 qrwlocks
In-Reply-To: <1507208097-825-1-git-send-email-will.deacon@arm.com>
References: <1507208097-825-1-git-send-email-will.deacon@arm.com>
Message-ID: <1507208097-825-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the qrwlock can make use of WFE, remove our homebrew rwlock
code in favour of the generic queued implementation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                      |  17 ++++
 arch/arm64/include/asm/Kbuild           |   1 +
 arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |   6 +-
 4 files changed, 20 insertions(+), 168 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..6d32c9b0d4bb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,7 +22,24 @@ config ARM64
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
+	select ARCH_INLINE_READ_LOCK if !PREEMPT
+	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
+	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPT
+	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPT
+	select ARCH_INLINE_READ_UNLOCK if !PREEMPT
+	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPT
+	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPT
+	select ARCH_INLINE_READ_UNLOCK_IRQSAVE if !PREEMPT
+	select ARCH_INLINE_WRITE_LOCK if !PREEMPT
+	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPT
+	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPT
+	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPT
+	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPT
+	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPT
+	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPT
+	select ARCH_INLINE_WRITE_UNLOCK_IRQSAVE if !PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 2326e39d5892..e63d0a8312de 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += msi.h
 generic-y += preempt.h
+generic-y += qrwlock.h
 generic-y += rwsem.h
 generic-y += segment.h
 generic-y += serial.h
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index aa51a38e46e4..fdb827c7832f 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -137,169 +137,7 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
-/*
- * Write lock implementation.
- *
- * Write locks set bit 31. Unlocking, is done by writing 0 since the lock is
- * exclusively held.
- *
- * The memory barriers are implicit with the load-acquire and store-release
- * instructions.
- */
-
-static inline void arch_write_lock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	sevl\n"
-	"1:	wfe\n"
-	"2:	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1b\n"
-	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 2b\n"
-	__nops(1),
-	/* LSE atomics */
-	"1:	mov	%w0, wzr\n"
-	"2:	casa	%w0, %w2, %1\n"
-	"	cbz	%w0, 3f\n"
-	"	ldxr	%w0, %1\n"
-	"	cbz	%w0, 2b\n"
-	"	wfe\n"
-	"	b	1b\n"
-	"3:")
-	: "=&r" (tmp), "+Q" (rw->lock)
-	: "r" (0x80000000)
-	: "memory");
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *rw)
-{
-	unsigned int tmp;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"1:	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 2f\n"
-	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 1b\n"
-	"2:",
-	/* LSE atomics */
-	"	mov	%w0, wzr\n"
-	"	casa	%w0, %w2, %1\n"
-	__nops(2))
-	: "=&r" (tmp), "+Q" (rw->lock)
-	: "r" (0x80000000)
-	: "memory");
-
-	return !tmp;
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *rw)
-{
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	"	stlr	wzr, %0",
-	"	swpl	wzr, wzr, %0")
-	: "=Q" (rw->lock) :: "memory");
-}
-
-/* write_can_lock - would write_trylock() succeed? */
-#define arch_write_can_lock(x)		((x)->lock == 0)
-
-/*
- * Read lock implementation.
- *
- * It exclusively loads the lock value, increments it and stores the new value
- * back if positive and the CPU still exclusively owns the location. If the
- * value is negative, the lock is already held.
- *
- * During unlocking there may be multiple active read locks but no write lock.
- *
- * The memory barriers are implicit with the load-acquire and store-release
- * instructions.
- *
- * Note that in UNDEFINED cases, such as unlocking a lock twice, the LL/SC
- * and LSE implementations may exhibit different behaviour (although this
- * will have no effect on lockdep).
- */
-static inline void arch_read_lock(arch_rwlock_t *rw)
-{
-	unsigned int tmp, tmp2;
-
-	asm volatile(
-	"	sevl\n"
-	ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"1:	wfe\n"
-	"2:	ldaxr	%w0, %2\n"
-	"	add	%w0, %w0, #1\n"
-	"	tbnz	%w0, #31, 1b\n"
-	"	stxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 2b\n"
-	__nops(1),
-	/* LSE atomics */
-	"1:	wfe\n"
-	"2:	ldxr	%w0, %2\n"
-	"	adds	%w1, %w0, #1\n"
-	"	tbnz	%w1, #31, 1b\n"
-	"	casa	%w0, %w1, %2\n"
-	"	sbc	%w0, %w1, %w0\n"
-	"	cbnz	%w0, 2b")
-	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
-	:
-	: "cc", "memory");
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *rw)
-{
-	unsigned int tmp, tmp2;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"1:	ldxr	%w0, %2\n"
-	"	sub	%w0, %w0, #1\n"
-	"	stlxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 1b",
-	/* LSE atomics */
-	"	movn	%w0, #0\n"
-	"	staddl	%w0, %2\n"
-	__nops(2))
-	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
-	:
-	: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *rw)
-{
-	unsigned int tmp, tmp2;
-
-	asm volatile(ARM64_LSE_ATOMIC_INSN(
-	/* LL/SC */
-	"	mov	%w1, #1\n"
-	"1:	ldaxr	%w0, %2\n"
-	"	add	%w0, %w0, #1\n"
-	"	tbnz	%w0, #31, 2f\n"
-	"	stxr	%w1, %w0, %2\n"
-	"	cbnz	%w1, 1b\n"
-	"2:",
-	/* LSE atomics */
-	"	ldr	%w0, %2\n"
-	"	adds	%w1, %w0, #1\n"
-	"	tbnz	%w1, #31, 1f\n"
-	"	casa	%w0, %w1, %2\n"
-	"	sbc	%w1, %w1, %w0\n"
-	__nops(1)
-	"1:")
-	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
-	:
-	: "cc", "memory");
-
-	return !tmp2;
-}
-
-/* read_can_lock - would read_trylock() succeed? */
-#define arch_read_can_lock(x)		((x)->lock < 0x80000000)
+#include <asm/qrwlock.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 55be59a35e3f..6b856012c51b 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -36,10 +36,6 @@ typedef struct {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
 
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+#include <asm-generic/qrwlock_types.h>
 
 #endif
-- 
2.1.4
