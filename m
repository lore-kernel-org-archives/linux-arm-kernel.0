From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:37 -0700
Subject: [PATCH 33/46] davinci: add generic CPUFreq driver for DaVinci
In-Reply-To: <1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Adds a basic CPUFreq driver for DaVinci devices registering with the
kernel CPUFreq infrastructure.

Support is added for both frequency and voltage regulation.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig                |    1 +
 arch/arm/mach-davinci/Makefile               |    3 +
 arch/arm/mach-davinci/cpufreq.c              |  219 ++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/cpufreq.h |   25 +++
 4 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/cpufreq.c
 create mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 7b6dddf..6c81b6c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -32,6 +32,7 @@ config ARCH_DAVINCI_DA830
         bool "DA830/OMAP-L137 based system"
 	select CP_INTC
 	select ARCH_DAVINCI_DA8XX
+	select ARCH_HAS_CPUFREQ
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138 based system"
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 2e11e84..be629c5 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -29,3 +29,6 @@ obj-$(CONFIG_MACH_DAVINCI_DM6467_EVM)	+= board-dm646x-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)	+= board-dm365-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)	+= board-da830-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
+
+# Power Management
+obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
new file mode 100644
index 0000000..8c8c07b
--- /dev/null
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -0,0 +1,219 @@
+/*
+ * CPU frequency scaling for DaVinci
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Based on linux/arch/arm/plat-omap/cpu-omap.c. Original Copyright follows:
+ *
+ *  Copyright (C) 2005 Nokia Corporation
+ *  Written by Tony Lindgren <tony@atomide.com>
+ *
+ *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Updated to support OMAP3
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+#include <mach/cpufreq.h>
+#include <mach/common.h>
+
+#include "clock.h"
+
+struct davinci_cpufreq {
+	struct device *dev;
+	struct clk *armclk;
+};
+static struct davinci_cpufreq cpufreq;
+
+static int davinci_verify_speed(struct cpufreq_policy *policy)
+{
+	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
+	struct cpufreq_frequency_table *freq_table = pdata->freq_table;
+	struct clk *armclk = cpufreq.armclk;
+
+	if (freq_table)
+		return cpufreq_frequency_table_verify(policy, freq_table);
+
+	if (policy->cpu)
+		return -EINVAL;
+
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     policy->cpuinfo.max_freq);
+
+	policy->min = clk_round_rate(armclk, policy->min * 1000) / 1000;
+	policy->max = clk_round_rate(armclk, policy->max * 1000) / 1000;
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+						policy->cpuinfo.max_freq);
+	return 0;
+}
+
+static unsigned int davinci_getspeed(unsigned int cpu)
+{
+	if (cpu)
+		return 0;
+
+	return clk_get_rate(cpufreq.armclk) / 1000;
+}
+
+static int davinci_target(struct cpufreq_policy *policy,
+				unsigned int target_freq, unsigned int relation)
+{
+	int ret = 0;
+	unsigned int idx;
+	struct cpufreq_freqs freqs;
+	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
+	struct clk *armclk = cpufreq.armclk;
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
+	freqs.old = davinci_getspeed(0);
+	freqs.new = clk_round_rate(armclk, target_freq * 1000) / 1000;
+	freqs.cpu = 0;
+
+	if (freqs.old == freqs.new)
+		return ret;
+
+	cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER,
+			dev_driver_string(cpufreq.dev),
+			"transition: %u --> %u\n", freqs.old, freqs.new);
+
+	ret = cpufreq_frequency_table_target(policy, pdata->freq_table,
+						freqs.new, relation, &idx);
+	if (ret)
+		return -EINVAL;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	/* if moving to higher frequency, up the voltage beforehand */
+	if (pdata->set_voltage && freqs.new > freqs.old)
+		pdata->set_voltage(idx);
+
+	ret = clk_set_rate(armclk, idx);
+
+	/* if moving to lower freq, lower the voltage after lowering freq */
+	if (pdata->set_voltage && freqs.new < freqs.old)
+		pdata->set_voltage(idx);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return ret;
+}
+
+static int __init davinci_cpu_init(struct cpufreq_policy *policy)
+{
+	int result = 0;
+	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
+	struct cpufreq_frequency_table *freq_table = pdata->freq_table;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	policy->cur = policy->min = policy->max = davinci_getspeed(0);
+
+	if (freq_table) {
+		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+		if (!result)
+			cpufreq_frequency_table_get_attr(freq_table,
+							policy->cpu);
+	} else {
+		policy->cpuinfo.min_freq = policy->min;
+		policy->cpuinfo.max_freq = policy->max;
+	}
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+	policy->cur = davinci_getspeed(0);
+
+	/*
+	 * Time measurement across the target() function yields ~1500-1800us
+	 * time taken with no drivers on notification list.
+	 * Setting the latency to 2000 us to accomodate addition of drivers
+	 * to pre/post change notification list.
+	 */
+	policy->cpuinfo.transition_latency = 2000 * 1000;
+	return 0;
+}
+
+static int davinci_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static struct freq_attr *davinci_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver davinci_driver = {
+	.flags		= CPUFREQ_STICKY,
+	.verify		= davinci_verify_speed,
+	.target		= davinci_target,
+	.get		= davinci_getspeed,
+	.init		= davinci_cpu_init,
+	.exit		= davinci_cpu_exit,
+	.name		= "davinci",
+	.attr		= davinci_cpufreq_attr,
+};
+
+static int __init davinci_cpufreq_probe(struct platform_device *pdev)
+{
+	struct davinci_cpufreq_config *pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+	if (!pdata->freq_table)
+		return -EINVAL;
+
+	cpufreq.dev = &pdev->dev;
+
+	cpufreq.armclk = clk_get(NULL, "arm");
+	if (IS_ERR(cpufreq.armclk)) {
+		dev_err(cpufreq.dev, "Unable to get ARM clock\n");
+		return PTR_ERR(cpufreq.armclk);
+	}
+
+	return cpufreq_register_driver(&davinci_driver);
+}
+
+static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
+{
+	clk_put(cpufreq.armclk);
+
+	return cpufreq_unregister_driver(&davinci_driver);
+}
+
+static struct platform_driver davinci_cpufreq_driver = {
+	.driver = {
+		.name	 = "cpufreq-davinci",
+		.owner	 = THIS_MODULE,
+	},
+	.remove = __exit_p(davinci_cpufreq_remove),
+};
+
+static int __init davinci_cpufreq_init(void)
+{
+	return platform_driver_probe(&davinci_cpufreq_driver,
+							davinci_cpufreq_probe);
+}
+late_initcall(davinci_cpufreq_init);
+
diff --git a/arch/arm/mach-davinci/include/mach/cpufreq.h b/arch/arm/mach-davinci/include/mach/cpufreq.h
new file mode 100644
index 0000000..442bdea
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/cpufreq.h
@@ -0,0 +1,25 @@
+/*
+ * TI DaVinci CPUFreq platform support.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _MACH_DAVINCI_CPUFREQ_H
+#define _MACH_DAVINCI_CPUFREQ_H
+
+#include <linux/cpufreq.h>
+
+struct davinci_cpufreq_config {
+	struct cpufreq_frequency_table *freq_table;
+	int (*set_voltage) (unsigned int index);
+};
+
+#endif
-- 
1.6.4.3
