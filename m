From: anton@samba.org (Anton Blanchard)
Date: Tue, 24 Feb 2015 14:30:31 +1100
Subject: [PATCH 4/7] x86: Use die_spin_lock_{irqsave,irqrestore}
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Message-ID: <1424748634-9153-5-git-send-email-anton@samba.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the x86 specific oops locking with the common one.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/x86/kernel/dumpstack.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b74ebc7..b635f73 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -15,6 +15,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 #include <linux/sysfs.h>
+#include <linux/die_lock.h>
 
 #include <asm/stacktrace.h>
 
@@ -196,28 +197,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	show_stack_log_lvl(task, NULL, sp, bp, "");
 }
 
-static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-static int die_owner = -1;
-static unsigned int die_nest_count;
-
 unsigned long oops_begin(void)
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
@@ -231,13 +216,8 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
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
 
 	if (!signr)
-- 
2.1.0
