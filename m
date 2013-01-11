From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:07:51 +0000
Subject: [PATCH] ARM: spinlock: avoid exclusive accesses on unlock() path
Message-ID: <1357916871-19920-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When unlocking a spinlock, all we need to do is increment the owner
field of the lock. Since only one CPU can be performing an unlock()
operation for a given lock, this doesn't need to be exclusive.

This patch simplifies arch_spin_unlock to use non-exclusive accesses
when updating the owner field of the lock.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index b4ca707..6220e9f 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -119,22 +119,8 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	unsigned long tmp;
-	u32 slock;
-
 	smp_mb();
-
-	__asm__ __volatile__(
-"	mov	%1, #1\n"
-"1:	ldrex	%0, [%2]\n"
-"	uadd16	%0, %0, %1\n"
-"	strex	%1, %0, [%2]\n"
-"	teq	%1, #0\n"
-"	bne	1b"
-	: "=&r" (slock), "=&r" (tmp)
-	: "r" (&lock->slock)
-	: "cc");
-
+	lock->tickets.owner++;
 	dsb_sev();
 }
 
-- 
1.8.0
