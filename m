From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jul 2013 18:57:14 +0100
Subject: [PATCH 1/2] ARM: locks: use early clobber in arch_spin_trylock
Message-ID: <1375207035-8072-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The res variable is written before we've finished with the input
operands (namely the lock address), so ensure that we mark it as `early
clobber' to avoid unintended register sharing.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index f8b8965..7ed43f68 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -107,7 +107,7 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 		"	subs	%1, %0, %0, ror #16\n"
 		"	addeq	%0, %0, %4\n"
 		"	strexeq	%2, %0, [%3]"
-		: "=&r" (slock), "=&r" (contended), "=r" (res)
+		: "=&r" (slock), "=&r" (contended), "=&r" (res)
 		: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
 		: "cc");
 	} while (res);
-- 
1.8.2.2
