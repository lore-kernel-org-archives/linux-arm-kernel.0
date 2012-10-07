From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  7 Oct 2012 09:27:15 +0200
Subject: [PATCH 1/6] pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121006161429.GD12462@game.jcrosoft.org>
References: <20121006161429.GD12462@game.jcrosoft.org>
Message-ID: <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today when we go to suspend we can not knwon at drivers level if we go in
STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
suspend_standby.

If a bus does not need to care about this distinction we fallback to
suspend. This will allow to do not update the current bus or drivers.

This is needed as example by at91 OHCI and atmel serial

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-pm at vger.kernel.org
---
 drivers/base/power/main.c |   12 ++++++++++++
 include/linux/pm.h        |    9 +++++++++
 kernel/power/suspend.c    |   16 ++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a3c1404..581e135 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -218,9 +218,21 @@ static void dpm_wait_for_children(struct device *dev, bool async)
  */
 static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
 {
+	pm_callback_t callback = NULL;
+
 	switch (state.event) {
 #ifdef CONFIG_SUSPEND
 	case PM_EVENT_SUSPEND:
+		switch (state.param) {
+		case PM_SUSPEND_MEM:
+			callback = ops->suspend_mem;
+			break;
+		case PM_SUSPEND_STANDBY:
+			callback = ops->suspend_standby;
+			break;
+		}
+		if (callback)
+			return callback;
 		return ops->suspend;
 	case PM_EVENT_RESUME:
 		return ops->resume;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 007e687..aff344b 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -49,6 +49,7 @@ extern const char power_group_name[];		/* = "power" */
 
 typedef struct pm_message {
 	int event;
+	int param;
 } pm_message_t;
 
 /**
@@ -265,6 +266,8 @@ struct dev_pm_ops {
 	int (*prepare)(struct device *dev);
 	void (*complete)(struct device *dev);
 	int (*suspend)(struct device *dev);
+	int (*suspend_mem)(struct device *dev);
+	int (*suspend_standby)(struct device *dev);
 	int (*resume)(struct device *dev);
 	int (*freeze)(struct device *dev);
 	int (*thaw)(struct device *dev);
@@ -295,8 +298,12 @@ struct dev_pm_ops {
 	.thaw = resume_fn, \
 	.poweroff = suspend_fn, \
 	.restore = resume_fn,
+#define SET_SYSTEM_SLEEP_STANDBY_MEM_PM_OPS(suspend_standby_fn, suspend_mem_fn) \
+	.suspend_standby = suspend_standby_fn, \
+	.suspend_mem = suspend_mem_fn,
 #else
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
+#define SET_SYSTEM_SLEEP_STANDBY_MEM_PM_OPS(suspend_standby_fn, suspend_mem_fn)
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
@@ -414,6 +421,8 @@ const struct dev_pm_ops name = { \
 #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
 #define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
 #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
+#define PMSG_SUSPEND_MEM	((struct pm_message){ .event = PM_EVENT_SUSPEND, .param = PM_SUSPEND_MEM, })
+#define PMSG_SUSPEND_STANDBY	((struct pm_message){ .event = PM_EVENT_SUSPEND, .param = PM_SUSPEND_STANDBY, })
 #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
 #define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
 #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index c8b7446..9505b55 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -126,6 +126,18 @@ void __attribute__ ((weak)) arch_suspend_enable_irqs(void)
 	local_irq_enable();
 }
 
+static pm_message_t suspend_state_to_pm_state(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		return PMSG_SUSPEND_STANDBY;
+	case PM_SUSPEND_MEM:
+		return PMSG_SUSPEND_MEM;
+	default:
+		return PMSG_SUSPEND;
+	}
+}
+
 /**
  * suspend_enter - Make the system enter the given sleep state.
  * @state: System sleep state to enter.
@@ -143,7 +155,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 			goto Platform_finish;
 	}
 
-	error = dpm_suspend_end(PMSG_SUSPEND);
+	error = dpm_suspend_end(suspend_state_to_pm_state(state));
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Platform_finish;
@@ -215,7 +227,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_console();
 	ftrace_stop();
 	suspend_test_start();
-	error = dpm_suspend_start(PMSG_SUSPEND);
+	error = dpm_suspend_start(suspend_state_to_pm_state(state));
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to suspend\n");
 		goto Recover_platform;
-- 
1.7.10.4
