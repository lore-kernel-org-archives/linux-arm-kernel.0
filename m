From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Jun 2013 17:52:55 +0100
Subject: [PATCH] ARM: spinlock: retry trylock operation if strex fails on free
 lock
Message-ID: <1370278375-13171-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An exclusive store instruction may fail for reasons other than lock
contention (e.g. a cache eviction during the critical section) so, in
line with other architectures using similar exclusive instructions
(alpha, mips, powerpc), retry the trylock operation if the lock appears
to be free but the strex reported failure.

Reported-by: Tony Thompson <anthony.thompson@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 6220e9f..f8b8965 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -97,19 +97,22 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 
 static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
-	unsigned long tmp;
+	unsigned long contended, res;
 	u32 slock;
 
-	__asm__ __volatile__(
-"	ldrex	%0, [%2]\n"
-"	subs	%1, %0, %0, ror #16\n"
-"	addeq	%0, %0, %3\n"
-"	strexeq	%1, %0, [%2]"
-	: "=&r" (slock), "=&r" (tmp)
-	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
-	: "cc");
-
-	if (tmp == 0) {
+	do {
+		__asm__ __volatile__(
+		"	ldrex	%0, [%3]\n"
+		"	mov	%2, #0\n"
+		"	subs	%1, %0, %0, ror #16\n"
+		"	addeq	%0, %0, %4\n"
+		"	strexeq	%2, %0, [%3]"
+		: "=&r" (slock), "=&r" (contended), "=r" (res)
+		: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
+		: "cc");
+	} while (res);
+
+	if (!contended) {
 		smp_mb();
 		return 1;
 	} else {
-- 
1.8.2.2
