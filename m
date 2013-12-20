From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 20 Dec 2013 10:47:40 +0100
Subject: [PATCH 2/8] ARM: Convert boot_lock to raw_lock [msm]
In-Reply-To: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
References: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1387532866-22601-3-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@am.sony.com>

The arm boot_lock is used by the secondary processor startup code.  The locking
task is the idle thread, which has idle->sched_class == &idle_sched_class.
idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
lock, the attempt to wake it when the lock becomes available will fail:

try_to_wake_up()
   ...
      activate_task()
         enqueue_task()
            p->sched_class->enqueue_task(rq, p, flags)

Fix by converting boot_lock to a raw spin lock.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: linux-arm-msm at vger.kernel.org
Cc: Frank Rowand <frank.rowand@sonymobile.com>
Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-msm/platsmp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 3f06edc..fc09a04 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -30,7 +30,7 @@
 
 extern void msm_secondary_startup(void);
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static inline int get_core_count(void)
 {
@@ -50,8 +50,8 @@ static void msm_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static void prepare_cold_cpu(unsigned int cpu)
@@ -88,7 +88,7 @@ static int msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -122,7 +122,7 @@ static int msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
-- 
1.8.5.1
