From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Jul 2013 14:27:59 +0100
Subject: [PATCH] ARM: locks: remove opencoded #16 for ticket shift
Message-ID: <1373894879-30559-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ticket width of our spinlocks is defined by TICKET_SHIFT, so remove
the opencoded #16 from the trylock implementation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index f8b8965..fa3ccce 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -104,11 +104,11 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 		__asm__ __volatile__(
 		"	ldrex	%0, [%3]\n"
 		"	mov	%2, #0\n"
-		"	subs	%1, %0, %0, ror #16\n"
-		"	addeq	%0, %0, %4\n"
+		"	subs	%1, %0, %0, ror %4\n"
+		"	addeq	%0, %0, %5\n"
 		"	strexeq	%2, %0, [%3]"
 		: "=&r" (slock), "=&r" (contended), "=r" (res)
-		: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
+		: "r" (&lock->slock), "I" (TICKET_SHIFT), "I" (1 << TICKET_SHIFT)
 		: "cc");
 	} while (res);
 
-- 
1.8.2.2
