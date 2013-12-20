From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 20 Dec 2013 10:47:46 +0100
Subject: [PATCH 8/8] ARM: Convert boot_lock to raw_lock [versatile]
In-Reply-To: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
References: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1387532866-22601-9-git-send-email-bigeasy@linutronix.de>
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

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Frank Rowand <frank.rowand@sonymobile.com>
Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/plat-versatile/platsmp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 39895d8..b2e0858 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -31,7 +31,7 @@ static void write_pen_release(int val)
 	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void versatile_secondary_init(unsigned int cpu)
 {
@@ -44,8 +44,8 @@ void versatile_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -56,7 +56,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * This is really belt and braces; we hold unintended secondary
@@ -86,7 +86,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
-- 
1.8.5.1
