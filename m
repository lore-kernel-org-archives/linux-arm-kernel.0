From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 20 Dec 2013 10:47:43 +0100
Subject: [PATCH 5/8] ARM: Convert boot_lock to raw_lock [spear]
In-Reply-To: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
References: <1387532866-22601-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1387532866-22601-6-git-send-email-bigeasy@linutronix.de>
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

Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: spear-devel at list.st.com
Cc: Frank Rowand <frank.rowand@sonymobile.com>
Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Link: http://lkml.kernel.org/r/4E77B952.3010606 at am.sony.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-spear/platsmp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 5c4a198..33dc270 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -20,7 +20,7 @@
 #include <mach/spear.h>
 #include "generic.h"
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
 
@@ -36,8 +36,8 @@ static void spear13xx_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -48,7 +48,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * The secondary processor is waiting to be released from
@@ -75,7 +75,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
-- 
1.8.5.1
