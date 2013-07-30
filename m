From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jul 2013 18:57:15 +0100
Subject: [PATCH 2/2] ARM: rwlocks: retry trylock operation if strex fails on
 free lock
In-Reply-To: <1375207035-8072-1-git-send-email-will.deacon@arm.com>
References: <1375207035-8072-1-git-send-email-will.deacon@arm.com>
Message-ID: <1375207035-8072-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 15e7e5c1ebf5 ("ARM: 7749/1: spinlock: retry trylock operation if
strex fails on free lock") modifying our arch_spin_trylock to retry the
acquisition if the lock appeared uncontended, but the strex failed.

This patch does the same for rwlocks, which were missed by the original
patch.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h | 49 +++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 7ed43f68..b07c09e 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -168,17 +168,20 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 
 static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
-	unsigned long tmp;
+	unsigned long contended, res;
 
-	__asm__ __volatile__(
-"	ldrex	%0, [%1]\n"
-"	teq	%0, #0\n"
-"	strexeq	%0, %2, [%1]"
-	: "=&r" (tmp)
-	: "r" (&rw->lock), "r" (0x80000000)
-	: "cc");
+	do {
+		__asm__ __volatile__(
+		"	ldrex	%0, [%2]\n"
+		"	mov	%1, #0\n"
+		"	teq	%0, #0\n"
+		"	strexeq	%1, %3, [%2]"
+		: "=&r" (contended), "=&r" (res)
+		: "r" (&rw->lock), "r" (0x80000000)
+		: "cc");
+	} while (res);
 
-	if (tmp == 0) {
+	if (!contended) {
 		smp_mb();
 		return 1;
 	} else {
@@ -254,18 +257,26 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
 
 static inline int arch_read_trylock(arch_rwlock_t *rw)
 {
-	unsigned long tmp, tmp2 = 1;
+	unsigned long contended, res;
 
-	__asm__ __volatile__(
-"	ldrex	%0, [%2]\n"
-"	adds	%0, %0, #1\n"
-"	strexpl	%1, %0, [%2]\n"
-	: "=&r" (tmp), "+r" (tmp2)
-	: "r" (&rw->lock)
-	: "cc");
+	do {
+		__asm__ __volatile__(
+		"	ldrex	%0, [%2]\n"
+		"	mov	%1, #0\n"
+		"	adds	%0, %0, #1\n"
+		"	strexpl	%1, %0, [%2]"
+		: "=&r" (contended), "=&r" (res)
+		: "r" (&rw->lock)
+		: "cc");
+	} while (res);
 
-	smp_mb();
-	return tmp2 == 0;
+	/* If the lock is negative, then it is already held for write. */
+	if (contended < 0x80000000) {
+		smp_mb();
+		return 1;
+	} else {
+		return 0;
+	}
 }
 
 /* read_can_lock - would read_trylock() succeed? */
-- 
1.8.2.2
