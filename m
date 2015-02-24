From: anton@samba.org (Anton Blanchard)
Date: Tue, 24 Feb 2015 14:30:32 +1100
Subject: [PATCH 5/7] watchdog: Serialise soft lockup errors with
 die_spin_lock_{irqsave, irqrestore}
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Message-ID: <1424748634-9153-6-git-send-email-anton@samba.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A simple kernel module was used to create concurrent soft and
hard lockups:

http://ozlabs.org/~anton/junkcode/badguy.tar.gz

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 kernel/watchdog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 70bf118..dd161e3 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -19,6 +19,7 @@
 #include <linux/sysctl.h>
 #include <linux/smpboot.h>
 #include <linux/sched/rt.h>
+#include <linux/die_lock.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -313,6 +314,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
+	unsigned long flags;
 
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
@@ -384,6 +386,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			}
 		}
 
+		die_spin_lock_irqsave(flags);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -394,6 +397,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			show_regs(regs);
 		else
 			dump_stack();
+		die_spin_unlock_irqrestore(flags);
 
 		if (softlockup_all_cpu_backtrace) {
 			/* Avoid generating two back traces for current
-- 
2.1.0
