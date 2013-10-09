From: will.deacon@arm.com (Will Deacon)
Date: Wed,  9 Oct 2013 15:54:26 +0100
Subject: [PATCH 1/3] arm64: locks: introduce ticket-based spinlock
 implementation
In-Reply-To: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
References: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
Message-ID: <1381330468-32625-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a ticket lock implementation for arm64, along the
same lines as the implementation for arch/arm/.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h       | 79 ++++++++++++++++++++++-----------
 arch/arm64/include/asm/spinlock_types.h | 10 ++---
 2 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 0defa07..525dd53 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -22,17 +22,10 @@
 /*
  * Spinlock implementation.
  *
- * The old value is read exclusively and the new one, if unlocked, is written
- * exclusively. In case of failure, the loop is restarted.
- *
  * The memory barriers are implicit with the load-acquire and store-release
  * instructions.
- *
- * Unlocked value: 0
- * Locked value: 1
  */
 
-#define arch_spin_is_locked(x)		((x)->lock != 0)
 #define arch_spin_unlock_wait(lock) \
 	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
 
@@ -41,32 +34,51 @@
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	unsigned int tmp;
+	arch_spinlock_t lockval, newval;
 
 	asm volatile(
-	"	sevl\n"
-	"1:	wfe\n"
-	"2:	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1b\n"
-	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 2b\n"
-	: "=&r" (tmp), "+Q" (lock->lock)
-	: "r" (1)
-	: "cc", "memory");
+	/* Atomically increment the next ticket. */
+"	prfm	pstl1strm, %3\n"
+"1:	ldaxr	%w0, %3\n"
+"	add	%w1, %w0, %w5\n"
+"	stxr	%w2, %w1, %3\n"
+"	cbnz	%w2, 1b\n"
+	/* Did we get the lock? */
+"	eor	%w1, %w0, %w0, ror #16\n"
+"	cbz	%w1, 3f\n"
+	/*
+	 * No: spin on the owner. Send a local event to avoid missing an
+	 * unlock before the exclusive load.
+	 */
+"	sevl\n"
+"2:	wfe\n"
+"	ldaxrh	%w2, %4\n"
+"	eor	%w1, %w2, %w0, lsr #16\n"
+"	cbnz	%w1, 2b\n"
+	/* We got the lock. Critical section starts here. */
+"3:"
+	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
+	: "Q" (lock->owner), "I" (1 << TICKET_SHIFT)
+	: "memory");
 }
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	unsigned int tmp;
+	arch_spinlock_t lockval;
 
 	asm volatile(
-	"2:	ldaxr	%w0, %1\n"
-	"	cbnz	%w0, 1f\n"
-	"	stxr	%w0, %w2, %1\n"
-	"	cbnz	%w0, 2b\n"
-	"1:\n"
-	: "=&r" (tmp), "+Q" (lock->lock)
-	: "r" (1)
-	: "cc", "memory");
+"	prfm	pstl1strm, %2\n"
+"1:	ldaxr	%w0, %2\n"
+"	eor	%w1, %w0, %w0, ror #16\n"
+"	cbnz	%w1, 2f\n"
+"	add	%w0, %w0, %3\n"
+"	stxr	%w1, %w0, %2\n"
+"	cbnz	%w1, 1b\n"
+"2:"
+	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
+	: "I" (1 << TICKET_SHIFT)
+	: "memory");
 
 	return !tmp;
 }
@@ -74,9 +86,24 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	asm volatile(
-	"	stlr	%w1, %0\n"
-	: "=Q" (lock->lock) : "r" (0) : "memory");
+"	stlrh	%w1, %0\n"
+	: "=Q" (lock->owner)
+	: "r" (lock->owner + 1)
+	: "memory");
+}
+
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	arch_spinlock_t lockval = ACCESS_ONCE(*lock);
+	return lockval.owner != lockval.next;
+}
+
+static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	arch_spinlock_t lockval = ACCESS_ONCE(*lock);
+	return (lockval.next - lockval.owner) > 1;
 }
+#define arch_spin_is_contended	arch_spin_is_contended
 
 /*
  * Write lock implementation.
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 9a49434..8769275 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -20,14 +20,14 @@
 # error "please don't include this file directly"
 #endif
 
-/* We only require natural alignment for exclusive accesses. */
-#define __lock_aligned
+#define TICKET_SHIFT	16
 
 typedef struct {
-	volatile unsigned int lock;
-} arch_spinlock_t;
+	u16 owner;
+	u16 next;
+} __aligned(4) arch_spinlock_t;
 
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
 
 typedef struct {
 	volatile unsigned int lock;
-- 
1.8.2.2
