From: anton@samba.org (Anton Blanchard)
Date: Tue, 24 Feb 2015 14:30:30 +1100
Subject: [PATCH 3/7] arm: Use die_spin_lock_{irqsave,irqrestore}
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Message-ID: <1424748634-9153-4-git-send-email-anton@samba.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the ARM specific oops locking with the common one.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/arm/kernel/traps.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 788e23f..3e3469d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/irq.h>
+#include <linux/die_lock.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -263,28 +264,12 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	return 0;
 }
 
-static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-static int die_owner = -1;
-static unsigned int die_nest_count;
-
 static unsigned long oops_begin(void)
 {
-	int cpu;
 	unsigned long flags;
 
 	oops_enter();
-
-	/* racy, but better than risking deadlock. */
-	raw_local_irq_save(flags);
-	cpu = smp_processor_id();
-	if (!arch_spin_trylock(&die_lock)) {
-		if (cpu == die_owner)
-			/* nested oops. should stop eventually */;
-		else
-			arch_spin_lock(&die_lock);
-	}
-	die_nest_count++;
-	die_owner = cpu;
+	die_spin_lock_irqsave(flags);
 	console_verbose();
 	bust_spinlocks(1);
 	return flags;
@@ -296,13 +281,8 @@ static void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 		crash_kexec(regs);
 
 	bust_spinlocks(0);
-	die_owner = -1;
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	die_nest_count--;
-	if (!die_nest_count)
-		/* Nest count reaches zero, release the lock. */
-		arch_spin_unlock(&die_lock);
-	raw_local_irq_restore(flags);
+	die_spin_unlock_irqrestore(flags);
 	oops_exit();
 
 	if (in_interrupt())
-- 
2.1.0
