From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 24 Jun 2013 23:13:38 +0800
Subject: [Question] race between spin_lock and spin_unlock
Message-ID: <CACVXFVMBL5E5SGwDatn_ay0sPOhqPKTwouCbzjwrhPuRKHNDcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When reading the code of arch_spin_lock(), I think there might be
a race between arch_spin_lock() and arch_spin_unlock():

- arch_spin_unlock() happened just between StoreExcl(lock->next)
and comparing lockval.tickets.next with lockval.tickets.owner inside
arch_spin_lock()

- arch_spin_lock() can't notice the change on lock->owner, so call
wfe(), then just waiting for being waken up, but there isn't corresponding
unlock to send wake event any more.

Maybe the below change may make the race to happen difficultly,
but it still can't avoid it completely.

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 6220e9f..e1b239c 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -87,10 +87,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
 	: "cc");

-	while (lockval.tickets.next != lockval.tickets.owner) {
+	while (lockval.tickets.next != ACCESS_ONCE(lock->tickets.owner))
 		wfe();
-		lockval.tickets.owner = ACCESS_ONCE(lock->tickets.owner);
-	}

 	smp_mb();
 }

Any comments on the problem?

Thanks,
-- 
Ming Lei
