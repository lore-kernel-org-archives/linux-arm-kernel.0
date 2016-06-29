From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:12 +0800
Subject: [PATCH RFC 4/7] PM: add SYSTEM_SUSPEND system_state
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467208335-29876-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

During the late system suspend phase, the arch irq is disabled
and sleeping is not allowed.
Let's add SYSTEM_SUSPEND to represent this state. The reset of
the system can then check this flag to do the correct work.

[ Aisheng: back ported from rt tree and did comments change ]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/linux/kernel.h   | 1 +
 kernel/power/hibernate.c | 7 +++++++
 kernel/power/suspend.c   | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 94aa10ffe156..92a42312b749 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -491,6 +491,7 @@ extern enum system_states {
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
+	SYSTEM_SUSPEND,
 } system_state;
 
 #define TAINT_PROPRIETARY_MODULE	0
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254280ee..36f420e54848 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -285,6 +285,8 @@ static int create_image(int platform_mode)
 
 	local_irq_disable();
 
+	system_state = SYSTEM_SUSPEND;
+
 	error = syscore_suspend();
 	if (error) {
 		printk(KERN_ERR "PM: Some system devices failed to power down, "
@@ -314,6 +316,7 @@ static int create_image(int platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
@@ -438,6 +441,7 @@ static int resume_target_kernel(bool platform_mode)
 		goto Enable_cpus;
 
 	local_irq_disable();
+	system_state = SYSTEM_SUSPEND;
 
 	error = syscore_suspend();
 	if (error)
@@ -471,6 +475,7 @@ static int resume_target_kernel(bool platform_mode)
 	syscore_resume();
 
  Enable_irqs:
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
@@ -556,6 +561,7 @@ int hibernation_platform_enter(void)
 		goto Enable_cpus;
 
 	local_irq_disable();
+	system_state = SYSTEM_SUSPEND;
 	syscore_suspend();
 	if (pm_wakeup_pending()) {
 		error = -EAGAIN;
@@ -568,6 +574,7 @@ int hibernation_platform_enter(void)
 
  Power_up:
 	syscore_resume();
+	system_state = SYSTEM_RUNNING;
 	local_irq_enable();
 
  Enable_cpus:
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5b70d64b871e..1258d093ae48 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -359,6 +359,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
+	system_state = SYSTEM_SUSPEND;
+
 	error = syscore_suspend();
 	if (!error) {
 		*wakeup = pm_wakeup_pending();
@@ -375,6 +377,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 		syscore_resume();
 	}
 
+	system_state = SYSTEM_RUNNING;
+
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
-- 
1.9.1
