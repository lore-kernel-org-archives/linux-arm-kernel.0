From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 16:55:38 +0100
Subject: [PATCH v2 4/6] ARM: locks: prefetch the destination word for write
 prior to strex
In-Reply-To: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
References: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374767740-2068-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cost of changing a cacheline from shared to exclusive state can be
significant, especially when this is triggered by an exclusive store,
since it may result in having to retry the transaction.

This patch prefixes our {spin,read,write}_[try]lock implementations with
pldw instructions (on CPUs which support them) to try and grab the line
in exclusive state from the start. arch_rwlock_t is changed to avoid
using a volatile member, since this generates compiler warnings when
falling back on the __builtin_prefetch intrinsic which expects a const
void * argument.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h       | 13 ++++++++++---
 arch/arm/include/asm/spinlock_types.h |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 0de7bec..3c8c532 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -5,7 +5,7 @@
 #error SMP not supported on pre-ARMv6 CPUs
 #endif
 
-#include <asm/processor.h>
+#include <linux/prefetch.h>
 
 /*
  * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
@@ -70,6 +70,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	u32 newval;
 	arch_spinlock_t lockval;
 
+	prefetchw(&lock->slock);
 	__asm__ __volatile__(
 "1:	ldrex	%0, [%3]\n"
 "	add	%1, %0, %4\n"
@@ -93,6 +94,7 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 	unsigned long contended, res;
 	u32 slock;
 
+	prefetchw(&lock->slock);
 	do {
 		__asm__ __volatile__(
 		"	ldrex	%0, [%3]\n"
@@ -145,6 +147,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 {
 	unsigned long tmp;
 
+	prefetchw(&rw->lock);
 	__asm__ __volatile__(
 "1:	ldrex	%0, [%1]\n"
 "	teq	%0, #0\n"
@@ -163,6 +166,7 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned long tmp;
 
+	prefetchw(&rw->lock);
 	__asm__ __volatile__(
 "	ldrex	%0, [%1]\n"
 "	teq	%0, #0\n"
@@ -193,7 +197,7 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 }
 
 /* write_can_lock - would write_trylock() succeed? */
-#define arch_write_can_lock(x)		((x)->lock == 0)
+#define arch_write_can_lock(x)		(ACCESS_ONCE((x)->lock) == 0)
 
 /*
  * Read locks are a bit more hairy:
@@ -211,6 +215,7 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
 {
 	unsigned long tmp, tmp2;
 
+	prefetchw(&rw->lock);
 	__asm__ __volatile__(
 "1:	ldrex	%0, [%2]\n"
 "	adds	%0, %0, #1\n"
@@ -231,6 +236,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 
 	smp_mb();
 
+	prefetchw(&rw->lock);
 	__asm__ __volatile__(
 "1:	ldrex	%0, [%2]\n"
 "	sub	%0, %0, #1\n"
@@ -249,6 +255,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 {
 	unsigned long tmp, tmp2 = 1;
 
+	prefetchw(&rw->lock);
 	__asm__ __volatile__(
 "	ldrex	%0, [%2]\n"
 "	adds	%0, %0, #1\n"
@@ -262,7 +269,7 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 }
 
 /* read_can_lock - would read_trylock() succeed? */
-#define arch_read_can_lock(x)		((x)->lock < 0x80000000)
+#define arch_read_can_lock(x)		(ACCESS_ONCE((x)->lock) < 0x80000000)
 
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spinlock_types.h
index b262d2f..47663fc 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -25,7 +25,7 @@ typedef struct {
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
 
 typedef struct {
-	volatile unsigned int lock;
+	u32 lock;
 } arch_rwlock_t;
 
 #define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
-- 
1.8.2.2
