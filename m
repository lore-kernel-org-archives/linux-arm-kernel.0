From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 31 Mar 2011 10:54:07 +0200
Subject: [PATCH 7/9] mach-ux500: create a PM subdirectory
Message-ID: <1301561647-23781-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Create a PM (Power Management) subdirectory in mach-ux500 and
move the cpufreq driver there as a beginning. We will add more
PM files there like CPUidle, suspend, resume and runtime PM
support when as we work on this machine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Kconfig      |    1 +
 arch/arm/mach-ux500/Makefile     |    2 +-
 arch/arm/mach-ux500/cpufreq.c    |  211 --------------------------------------
 arch/arm/mach-ux500/pm/Kconfig   |    6 +
 arch/arm/mach-ux500/pm/Makefile  |    4 +
 arch/arm/mach-ux500/pm/cpufreq.c |  211 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 223 insertions(+), 212 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/cpufreq.c
 create mode 100644 arch/arm/mach-ux500/pm/Kconfig
 create mode 100644 arch/arm/mach-ux500/pm/Makefile
 create mode 100644 arch/arm/mach-ux500/pm/cpufreq.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 969e751..76c9275 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -67,4 +67,5 @@ config U5500_MBOX
 	help
 	  Add support for U5500 mailbox communication with modem side
 
+source "arch/arm/mach-ux500/pm/Kconfig"
 endif
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 6dd384d..dccd91d 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,6 +4,7 @@
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o \
 				   id.o usb.o
+obj-y				+= pm/
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu-db8500.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
@@ -20,4 +21,3 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
 obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
-obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
diff --git a/arch/arm/mach-ux500/cpufreq.c b/arch/arm/mach-ux500/cpufreq.c
deleted file mode 100644
index 5c5b747..0000000
--- a/arch/arm/mach-ux500/cpufreq.c
+++ /dev/null
@@ -1,211 +0,0 @@
-/*
- * CPU frequency scaling for u8500
- * Inspired by linux/arch/arm/mach-davinci/cpufreq.c
- *
- * Copyright (C) STMicroelectronics 2009
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License Terms: GNU General Public License v2
- *
- * Author: Sundar Iyer <sundar.iyer@stericsson.com>
- * Author: Martin Persson <martin.persson@stericsson.com>
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/kernel.h>
-#include <linux/cpufreq.h>
-#include <linux/delay.h>
-
-#include <mach/hardware.h>
-#include <mach/prcmu.h>
-#include <mach/prcmu-defs.h>
-
-#define DRIVER_NAME "cpufreq-u8500"
-#define CPUFREQ_NAME "u8500"
-
-static struct device *dev;
-
-static struct cpufreq_frequency_table freq_table[] = {
-	[0] = {
-		.index = 0,
-		.frequency = 200000,
-	},
-	[1] = {
-		.index = 1,
-		.frequency = 300000,
-	},
-	[2] = {
-		.index = 2,
-		.frequency = 600000,
-	},
-	[3] = {
-		/* Used for CPU_OPP_MAX, if available */
-		.index = 3,
-		.frequency = CPUFREQ_TABLE_END,
-	},
-	[4] = {
-		.index = 4,
-		.frequency = CPUFREQ_TABLE_END,
-	},
-};
-
-static enum prcmu_cpu_opp index2opp[] = {
-	CPU_OPP_EXT_CLK,
-	CPU_OPP_50,
-	CPU_OPP_100,
-	CPU_OPP_MAX
-};
-
-static int u8500_cpufreq_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
-static int u8500_cpufreq_target(struct cpufreq_policy *policy,
-				unsigned int target_freq,
-				unsigned int relation)
-{
-	struct cpufreq_freqs freqs;
-	unsigned int index;
-	int ret = 0;
-
-	/*
-	 * Ensure desired rate is within allowed range.  Some govenors
-	 * (ondemand) will just pass target_freq=0 to get the minimum.
-	 */
-	if (target_freq < policy->cpuinfo.min_freq)
-		target_freq = policy->cpuinfo.min_freq;
-	if (target_freq > policy->cpuinfo.max_freq)
-		target_freq = policy->cpuinfo.max_freq;
-
-	ret = cpufreq_frequency_table_target(policy, freq_table,
-					     target_freq, relation, &index);
-	if (ret < 0) {
-		dev_err(dev, "Could not look up next frequency\n");
-		return ret;
-	}
-
-	freqs.old = policy->cur;
-	freqs.new = freq_table[index].frequency;
-	freqs.cpu = policy->cpu;
-
-	if (freqs.old == freqs.new) {
-		dev_dbg(dev, "Current and target frequencies are equal\n");
-		return 0;
-	}
-
-	dev_dbg(dev, "transition: %u --> %u\n", freqs.old, freqs.new);
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-
-	ret = prcmu_set_cpu_opp(index2opp[index]);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set OPP level\n");
-		return ret;
-	}
-
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-
-	return ret;
-}
-
-static unsigned int u8500_cpufreq_getspeed(unsigned int cpu)
-{
-	int i;
-
-	for (i = 0; prcmu_get_cpu_opp() != index2opp[i]; i++)
-		;
-	return freq_table[i].frequency;
-}
-
-static int __cpuinit u8500_cpu_init(struct cpufreq_policy *policy)
-{
-	int res;
-
-	BUILD_BUG_ON(ARRAY_SIZE(index2opp) + 1 != ARRAY_SIZE(freq_table));
-
-	if (cpu_is_u8500v2()) {
-		freq_table[1].frequency = 400000;
-		freq_table[2].frequency = 800000;
-		if (prcmu_has_arm_maxopp())
-			freq_table[3].frequency = 1000000;
-	}
-
-	/* get policy fields based on the table */
-	res = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	if (!res)
-		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-	else {
-		dev_err(dev, "u8500-cpufreq : Failed to read policy table\n");
-		return res;
-	}
-
-	policy->min = policy->cpuinfo.min_freq;
-	policy->max = policy->cpuinfo.max_freq;
-	policy->cur = u8500_cpufreq_getspeed(policy->cpu);
-	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
-
-	/*
-	 * FIXME : Need to take time measurement across the target()
-	 *	   function with no/some/all drivers in the notification
-	 *	   list.
-	 */
-	policy->cpuinfo.transition_latency = 200 * 1000; /* in ns */
-
-	/* policy sharing between dual CPUs */
-	cpumask_copy(policy->cpus, &cpu_present_map);
-
-	policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-
-	return res;
-}
-
-static struct freq_attr *u8500_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-static int u8500_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct cpufreq_driver u8500_driver = {
-	.owner = THIS_MODULE,
-	.flags = CPUFREQ_STICKY,
-	.verify = u8500_cpufreq_verify_speed,
-	.target = u8500_cpufreq_target,
-	.get = u8500_cpufreq_getspeed,
-	.init = u8500_cpu_init,
-	.exit = u8500_cpu_exit,
-	.name = CPUFREQ_NAME,
-	.attr = u8500_cpufreq_attr,
-};
-
-static int __init u8500_cpufreq_probe(struct platform_device *pdev)
-{
-	dev = &pdev->dev;
-	return cpufreq_register_driver(&u8500_driver);
-}
-
-static int __exit u8500_cpufreq_remove(struct platform_device *pdev)
-{
-	return cpufreq_unregister_driver(&u8500_driver);
-}
-
-static struct platform_driver u8500_cpufreq_driver = {
-	.driver = {
-		.name	 = DRIVER_NAME,
-		.owner	 = THIS_MODULE,
-	},
-	.remove = __exit_p(u8500_cpufreq_remove),
-};
-
-static int __init u8500_cpufreq_init(void)
-{
-	return platform_driver_probe(&u8500_cpufreq_driver,
-				     &u8500_cpufreq_probe);
-}
-
-device_initcall(u8500_cpufreq_init);
diff --git a/arch/arm/mach-ux500/pm/Kconfig b/arch/arm/mach-ux500/pm/Kconfig
new file mode 100644
index 0000000..22171f8
--- /dev/null
+++ b/arch/arm/mach-ux500/pm/Kconfig
@@ -0,0 +1,6 @@
+config U8500_CPUFREQ
+	tristate "CPUFreq support"
+	depends on UX500_SOC_DB8500 && CPU_FREQ
+	default y
+	help
+	  Add support for CPU Frequency scaling for U8500.
diff --git a/arch/arm/mach-ux500/pm/Makefile b/arch/arm/mach-ux500/pm/Makefile
new file mode 100644
index 0000000..1e84340
--- /dev/null
+++ b/arch/arm/mach-ux500/pm/Makefile
@@ -0,0 +1,4 @@
+#
+# Power save related files
+#
+obj-$(CONFIG_U8500_CPUFREQ) 		+= cpufreq.o
diff --git a/arch/arm/mach-ux500/pm/cpufreq.c b/arch/arm/mach-ux500/pm/cpufreq.c
new file mode 100644
index 0000000..5c5b747
--- /dev/null
+++ b/arch/arm/mach-ux500/pm/cpufreq.c
@@ -0,0 +1,211 @@
+/*
+ * CPU frequency scaling for u8500
+ * Inspired by linux/arch/arm/mach-davinci/cpufreq.c
+ *
+ * Copyright (C) STMicroelectronics 2009
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Author: Sundar Iyer <sundar.iyer@stericsson.com>
+ * Author: Martin Persson <martin.persson@stericsson.com>
+ * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+
+#include <mach/hardware.h>
+#include <mach/prcmu.h>
+#include <mach/prcmu-defs.h>
+
+#define DRIVER_NAME "cpufreq-u8500"
+#define CPUFREQ_NAME "u8500"
+
+static struct device *dev;
+
+static struct cpufreq_frequency_table freq_table[] = {
+	[0] = {
+		.index = 0,
+		.frequency = 200000,
+	},
+	[1] = {
+		.index = 1,
+		.frequency = 300000,
+	},
+	[2] = {
+		.index = 2,
+		.frequency = 600000,
+	},
+	[3] = {
+		/* Used for CPU_OPP_MAX, if available */
+		.index = 3,
+		.frequency = CPUFREQ_TABLE_END,
+	},
+	[4] = {
+		.index = 4,
+		.frequency = CPUFREQ_TABLE_END,
+	},
+};
+
+static enum prcmu_cpu_opp index2opp[] = {
+	CPU_OPP_EXT_CLK,
+	CPU_OPP_50,
+	CPU_OPP_100,
+	CPU_OPP_MAX
+};
+
+static int u8500_cpufreq_verify_speed(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, freq_table);
+}
+
+static int u8500_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int target_freq,
+				unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	unsigned int index;
+	int ret = 0;
+
+	/*
+	 * Ensure desired rate is within allowed range.  Some govenors
+	 * (ondemand) will just pass target_freq=0 to get the minimum.
+	 */
+	if (target_freq < policy->cpuinfo.min_freq)
+		target_freq = policy->cpuinfo.min_freq;
+	if (target_freq > policy->cpuinfo.max_freq)
+		target_freq = policy->cpuinfo.max_freq;
+
+	ret = cpufreq_frequency_table_target(policy, freq_table,
+					     target_freq, relation, &index);
+	if (ret < 0) {
+		dev_err(dev, "Could not look up next frequency\n");
+		return ret;
+	}
+
+	freqs.old = policy->cur;
+	freqs.new = freq_table[index].frequency;
+	freqs.cpu = policy->cpu;
+
+	if (freqs.old == freqs.new) {
+		dev_dbg(dev, "Current and target frequencies are equal\n");
+		return 0;
+	}
+
+	dev_dbg(dev, "transition: %u --> %u\n", freqs.old, freqs.new);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	ret = prcmu_set_cpu_opp(index2opp[index]);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set OPP level\n");
+		return ret;
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return ret;
+}
+
+static unsigned int u8500_cpufreq_getspeed(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; prcmu_get_cpu_opp() != index2opp[i]; i++)
+		;
+	return freq_table[i].frequency;
+}
+
+static int __cpuinit u8500_cpu_init(struct cpufreq_policy *policy)
+{
+	int res;
+
+	BUILD_BUG_ON(ARRAY_SIZE(index2opp) + 1 != ARRAY_SIZE(freq_table));
+
+	if (cpu_is_u8500v2()) {
+		freq_table[1].frequency = 400000;
+		freq_table[2].frequency = 800000;
+		if (prcmu_has_arm_maxopp())
+			freq_table[3].frequency = 1000000;
+	}
+
+	/* get policy fields based on the table */
+	res = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	if (!res)
+		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+	else {
+		dev_err(dev, "u8500-cpufreq : Failed to read policy table\n");
+		return res;
+	}
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+	policy->cur = u8500_cpufreq_getspeed(policy->cpu);
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+
+	/*
+	 * FIXME : Need to take time measurement across the target()
+	 *	   function with no/some/all drivers in the notification
+	 *	   list.
+	 */
+	policy->cpuinfo.transition_latency = 200 * 1000; /* in ns */
+
+	/* policy sharing between dual CPUs */
+	cpumask_copy(policy->cpus, &cpu_present_map);
+
+	policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+
+	return res;
+}
+
+static struct freq_attr *u8500_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+static int u8500_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static struct cpufreq_driver u8500_driver = {
+	.owner = THIS_MODULE,
+	.flags = CPUFREQ_STICKY,
+	.verify = u8500_cpufreq_verify_speed,
+	.target = u8500_cpufreq_target,
+	.get = u8500_cpufreq_getspeed,
+	.init = u8500_cpu_init,
+	.exit = u8500_cpu_exit,
+	.name = CPUFREQ_NAME,
+	.attr = u8500_cpufreq_attr,
+};
+
+static int __init u8500_cpufreq_probe(struct platform_device *pdev)
+{
+	dev = &pdev->dev;
+	return cpufreq_register_driver(&u8500_driver);
+}
+
+static int __exit u8500_cpufreq_remove(struct platform_device *pdev)
+{
+	return cpufreq_unregister_driver(&u8500_driver);
+}
+
+static struct platform_driver u8500_cpufreq_driver = {
+	.driver = {
+		.name	 = DRIVER_NAME,
+		.owner	 = THIS_MODULE,
+	},
+	.remove = __exit_p(u8500_cpufreq_remove),
+};
+
+static int __init u8500_cpufreq_init(void)
+{
+	return platform_driver_probe(&u8500_cpufreq_driver,
+				     &u8500_cpufreq_probe);
+}
+
+device_initcall(u8500_cpufreq_init);
-- 
1.7.3.2
