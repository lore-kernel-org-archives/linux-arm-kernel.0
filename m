From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 8 Feb 2012 05:44:52 +0400
Subject: [PATCH 4/4] ARM: Move leds idle start/stop calls to sched idle
 notifiers
In-Reply-To: <20120208013959.GA24535@panacea>
References: <20120208013959.GA24535@panacea>
Message-ID: <20120208014452.GD459@panacea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Todd Poynor <toddpoynor@google.com>

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/kernel/leds.c    |   25 ++++++++++++++++++++++++-
 arch/arm/kernel/process.c |    3 ---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/leds.c b/arch/arm/kernel/leds.c
index 1911dae..fbc30d4 100644
--- a/arch/arm/kernel/leds.c
+++ b/arch/arm/kernel/leds.c
@@ -9,6 +9,8 @@
  */
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
 #include <linux/device.h>
 #include <linux/syscore_ops.h>
 #include <linux/string.h>
@@ -103,6 +105,25 @@ static struct syscore_ops leds_syscore_ops = {
 	.resume		= leds_resume,
 };
 
+static int leds_idle_notifier(struct notifier_block *nb, unsigned long val,
+			      void *data)
+{
+	switch (val) {
+	case SCHED_IDLE_START:
+		leds_event(led_idle_start);
+		break;
+	case SCHED_IDLE_END:
+		leds_event(led_idle_end);
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block leds_idle_nb = {
+	.notifier_call = leds_idle_notifier,
+};
+
 static int __init leds_init(void)
 {
 	int ret;
@@ -111,8 +132,10 @@ static int __init leds_init(void)
 		ret = device_register(&leds_device);
 	if (ret == 0)
 		ret = device_create_file(&leds_device, &dev_attr_event);
-	if (ret == 0)
+	if (ret == 0) {
 		register_syscore_ops(&leds_syscore_ops);
+		sched_idle_notifier_register(&leds_idle_nb);
+	}
 	return ret;
 }
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f2bac2d..f4b53aa 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -33,7 +33,6 @@
 #include <linux/cpuidle.h>
 
 #include <asm/cacheflush.h>
-#include <asm/leds.h>
 #include <asm/processor.h>
 #include <asm/system.h>
 #include <asm/thread_notify.h>
@@ -207,7 +206,6 @@ void cpu_idle(void)
 	/* endless idle loop with no priority at all */
 	while (1) {
 		sched_idle_enter();
-		leds_event(led_idle_start);
 		while (!need_resched()) {
 #ifdef CONFIG_HOTPLUG_CPU
 			if (cpu_is_offline(smp_processor_id()))
@@ -235,7 +233,6 @@ void cpu_idle(void)
 				local_irq_enable();
 			}
 		}
-		leds_event(led_idle_end);
 		sched_idle_exit();
 		preempt_enable_no_resched();
 		schedule();
-- 
1.7.7.6
