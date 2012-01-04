From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Jan 2012 17:55:47 +0100
Subject: [PATCH 2/2][RFC] at91 : move cpuidle driver to drivers/cpuidle
 directory
In-Reply-To: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
References: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1325696147-14058-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch follows the discussion [1] about moving the cpuidle code which
is located in the architecture specific to the drivers directory.

[1] http://www.spinics.net/lists/arm-kernel/msg154109.html

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/Kconfig   |    5 ++
 arch/arm/mach-at91/Makefile  |    1 -
 arch/arm/mach-at91/cpuidle.c |  100 ------------------------------------------
 drivers/cpuidle/Makefile     |    1 +
 drivers/cpuidle/at91_idle.c  |  100 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 101 deletions(-)
 delete mode 100644 arch/arm/mach-at91/cpuidle.c
 create mode 100644 drivers/cpuidle/at91_idle.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 4f991f2..ddeaf0e 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -18,6 +18,11 @@ config HAVE_AT91_USART4
 config HAVE_AT91_USART5
 	bool
 
+config AT91_IDLE
+	bool
+	default y
+	depends on CPU_IDLE
+
 menu "Atmel AT91 System-on-Chip"
 
 choice
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 242174f..ce0cd4c 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -91,7 +91,6 @@ obj-y				+= leds.o
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
-obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
deleted file mode 100644
index f658154..0000000
--- a/arch/arm/mach-at91/cpuidle.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * based on arch/arm/mach-kirkwood/cpuidle.c
- *
- * CPU idle support for AT91 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * The cpu idle uses wait-for-interrupt and RAM self refresh in order
- * to implement two idle states -
- * #1 wait-for-interrupt
- * #2 wait-for-interrupt and RAM self refresh
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/cpuidle.h>
-#include <asm/proc-fns.h>
-#include <linux/io.h>
-#include <linux/export.h>
-
-#include <mach/pm.h>
-
-#define AT91_MAX_STATES	2
-
-static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
-
-static struct cpuidle_driver at91_idle_driver = {
-	.name =         "at91_idle",
-	.owner =        THIS_MODULE,
-};
-
-/* Actual code that puts the SoC in different idle states */
-static int at91_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			       int index)
-{
-	struct timeval before, after;
-	int idle_time;
-	u32 saved_lpr;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-	if (index == 0)
-		/* Wait for interrupt state */
-		cpu_do_idle();
-	else if (index == 1) {
-		asm("b 1f; .align 5; 1:");
-		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
-		saved_lpr = sdram_selfrefresh_enable();
-		cpu_do_idle();
-		sdram_selfrefresh_disable(saved_lpr);
-	}
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-			(after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
-	return index;
-}
-
-/* Initialize CPU idle by registering the idle states */
-static int at91_init_cpuidle(void)
-{
-	struct cpuidle_device *device;
-	struct cpuidle_driver *driver = &at91_idle_driver;
-
-	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
-	device->state_count = AT91_MAX_STATES;
-	driver->state_count = AT91_MAX_STATES;
-
-	/* Wait for interrupt state */
-	driver->states[0].enter = at91_enter_idle;
-	driver->states[0].exit_latency = 1;
-	driver->states[0].target_residency = 10000;
-	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[0].name, "WFI");
-	strcpy(driver->states[0].desc, "Wait for interrupt");
-
-	/* Wait for interrupt and RAM self refresh state */
-	driver->states[1].enter = at91_enter_idle;
-	driver->states[1].exit_latency = 10;
-	driver->states[1].target_residency = 10000;
-	driver->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
-	strcpy(driver->states[1].name, "RAM_SR");
-	strcpy(driver->states[1].desc, "WFI and RAM Self Refresh");
-
-	cpuidle_register_driver(&at91_idle_driver);
-
-	if (cpuidle_register_device(device)) {
-		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
-}
-
-device_initcall(at91_init_cpuidle);
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 5634f88..31c9b5f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
+obj-$(CONFIG_AT91_IDLE) += at91_idle.o
diff --git a/drivers/cpuidle/at91_idle.c b/drivers/cpuidle/at91_idle.c
new file mode 100644
index 0000000..f658154
--- /dev/null
+++ b/drivers/cpuidle/at91_idle.c
@@ -0,0 +1,100 @@
+/*
+ * based on arch/arm/mach-kirkwood/cpuidle.c
+ *
+ * CPU idle support for AT91 SoC
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The cpu idle uses wait-for-interrupt and RAM self refresh in order
+ * to implement two idle states -
+ * #1 wait-for-interrupt
+ * #2 wait-for-interrupt and RAM self refresh
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <linux/io.h>
+#include <linux/export.h>
+
+#include <mach/pm.h>
+
+#define AT91_MAX_STATES	2
+
+static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
+
+static struct cpuidle_driver at91_idle_driver = {
+	.name =         "at91_idle",
+	.owner =        THIS_MODULE,
+};
+
+/* Actual code that puts the SoC in different idle states */
+static int at91_enter_idle(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			       int index)
+{
+	struct timeval before, after;
+	int idle_time;
+	u32 saved_lpr;
+
+	local_irq_disable();
+	do_gettimeofday(&before);
+	if (index == 0)
+		/* Wait for interrupt state */
+		cpu_do_idle();
+	else if (index == 1) {
+		asm("b 1f; .align 5; 1:");
+		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
+		saved_lpr = sdram_selfrefresh_enable();
+		cpu_do_idle();
+		sdram_selfrefresh_disable(saved_lpr);
+	}
+	do_gettimeofday(&after);
+	local_irq_enable();
+	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
+			(after.tv_usec - before.tv_usec);
+
+	dev->last_residency = idle_time;
+	return index;
+}
+
+/* Initialize CPU idle by registering the idle states */
+static int at91_init_cpuidle(void)
+{
+	struct cpuidle_device *device;
+	struct cpuidle_driver *driver = &at91_idle_driver;
+
+	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
+	device->state_count = AT91_MAX_STATES;
+	driver->state_count = AT91_MAX_STATES;
+
+	/* Wait for interrupt state */
+	driver->states[0].enter = at91_enter_idle;
+	driver->states[0].exit_latency = 1;
+	driver->states[0].target_residency = 10000;
+	driver->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
+	strcpy(driver->states[0].name, "WFI");
+	strcpy(driver->states[0].desc, "Wait for interrupt");
+
+	/* Wait for interrupt and RAM self refresh state */
+	driver->states[1].enter = at91_enter_idle;
+	driver->states[1].exit_latency = 10;
+	driver->states[1].target_residency = 10000;
+	driver->states[1].flags = CPUIDLE_FLAG_TIME_VALID;
+	strcpy(driver->states[1].name, "RAM_SR");
+	strcpy(driver->states[1].desc, "WFI and RAM Self Refresh");
+
+	cpuidle_register_driver(&at91_idle_driver);
+
+	if (cpuidle_register_device(device)) {
+		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+device_initcall(at91_init_cpuidle);
-- 
1.7.4.1
