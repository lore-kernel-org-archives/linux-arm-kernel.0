From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:15:45 +0100
Subject: [PATCH 1/2] ARM: spinlock: use ticket algorithm for ARMv6+ locking
 implementation
In-Reply-To: <1340378146-17560-1-git-send-email-will.deacon@arm.com>
References: <1340378146-17560-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340378146-17560-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ticket spinlocks ensure locking fairness by reducing the thundering herd
effect when acquiring a lock. This is especially important on systems
where memory-access times are not necessarily uniform when accessing
the lock structure (for example, on a multi-cluster platform where the
lock is allocated into L1 when a CPU releases it).

This patch implements the ticket spinlock algorithm for ARM, replacing
the simpler implementation for ARMv6+ processors.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h       |   73 ++++++++++++++++++++++-----------
 arch/arm/include/asm/spinlock_types.h |   17 +++++++-
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 65fa3c8..dcca638 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -59,18 +59,13 @@ static inline void dsb_sev(void)
 }
 
 /*
- * ARMv6 Spin-locking.
+ * ARMv6 ticket-based spin-locking.
  *
- * We exclusively read the old value.  If it is zero, we may have
- * won the lock, so we try exclusively storing it.  A memory barrier
- * is required after we get a lock, and before we release it, because
- * V6 CPUs are assumed to have weakly ordered memory.
- *
- * Unlocked value: 0
- * Locked value: 1
+ * A memory barrier is required after we get a lock, and before we
+ * release it, because V6 CPUs are assumed to have weakly ordered
+ * memory.
  */
 
-#define arch_spin_is_locked(x)		((x)->lock != 0)
 #define arch_spin_unlock_wait(lock) \
 	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
 
@@ -79,31 +74,40 @@ static inline void dsb_sev(void)
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
+	u32 newval;
+	arch_spinlock_t lockval;
 
 	__asm__ __volatile__(
-"1:	ldrex	%0, [%1]\n"
-"	teq	%0, #0\n"
-	WFE("ne")
-"	strexeq	%0, %2, [%1]\n"
-"	teqeq	%0, #0\n"
+"1:	ldrex	%0, [%3]\n"
+"	add	%1, %0, %4\n"
+"	strex	%2, %1, [%3]\n"
+"	teq	%2, #0\n"
 "	bne	1b"
-	: "=&r" (tmp)
-	: "r" (&lock->lock), "r" (1)
+	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp)
+	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
 	: "cc");
 
+	while (lockval.tickets.next != lockval.tickets.owner) {
+		wfe();
+		lockval.tickets.owner = ACCESS_ONCE(lock->tickets.owner);
+	}
+
 	smp_mb();
 }
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
+	u32 slock;
 
 	__asm__ __volatile__(
-"	ldrex	%0, [%1]\n"
-"	teq	%0, #0\n"
-"	strexeq	%0, %2, [%1]"
-	: "=&r" (tmp)
-	: "r" (&lock->lock), "r" (1)
+"	ldrex	%0, [%2]\n"
+"	cmp	%0, %0, ror #16\n"
+"	movne	%1, #1\n"
+"	addeq	%0, %0, %3\n"
+"	strexeq	%1, %0, [%2]"
+	: "=&r" (slock), "=&r" (tmp)
+	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
 	: "cc");
 
 	if (tmp == 0) {
@@ -116,17 +120,38 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
+	unsigned long tmp;
+	u32 slock;
+
 	smp_mb();
 
 	__asm__ __volatile__(
-"	str	%1, [%0]\n"
-	:
-	: "r" (&lock->lock), "r" (0)
+"	mov	%1, #1\n"
+"1:	ldrex	%0, [%2]\n"
+"	uadd16	%0, %0, %1\n"
+"	strex	%1, %0, [%2]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (slock), "=&r" (tmp)
+	: "r" (&lock->slock)
 	: "cc");
 
 	dsb_sev();
 }
 
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	struct __raw_tickets tickets = ACCESS_ONCE(lock->tickets);
+	return tickets.owner != tickets.next;
+}
+
+static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	struct __raw_tickets tickets = ACCESS_ONCE(lock->tickets);
+	return (tickets.next - tickets.owner) > 1;
+}
+#define arch_spin_is_contended	arch_spin_is_contended
+
 /*
  * RWLOCKS
  *
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spinlock_types.h
index d14d197..b262d2f 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -5,11 +5,24 @@
 # error "please don't include this file directly"
 #endif
 
+#define TICKET_SHIFT	16
+
 typedef struct {
-	volatile unsigned int lock;
+	union {
+		u32 slock;
+		struct __raw_tickets {
+#ifdef __ARMEB__
+			u16 next;
+			u16 owner;
+#else
+			u16 owner;
+			u16 next;
+#endif
+		} tickets;
+	};
 } arch_spinlock_t;
 
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
 
 typedef struct {
 	volatile unsigned int lock;
-- 
1.7.4.1
