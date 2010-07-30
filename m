From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:30 -0700
Subject: [PATCH 9/9] [ARM] tegra: Add cpufreq support
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-10-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

Implement cpufreq support for the Tegra SOC.  DVFS is handled by the
core virtual cpu clock.  The frequencies of the two cores are tied
together, the highest frequency requested by either core determines
the actual frequency.

CC: cpufreq at vger.kernel.org
Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-tegra/Makefile    |    1 +
 arch/arm/mach-tegra/cpu-tegra.c |  185 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/cpu-tegra.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1341628..1ccf0d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -569,6 +569,7 @@ config ARCH_TEGRA
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
+	select ARCH_HAS_CPUFREQ
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 3642e58..2a37621 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_dvfs.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
+obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
 
 obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
new file mode 100644
index 0000000..fea5719
--- /dev/null
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -0,0 +1,185 @@
+/*
+ * arch/arm/mach-tegra/cpu-tegra.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Based on arch/arm/plat-omap/cpu-omap.c, (C) 2005 Nokia Corporation
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/system.h>
+
+#include <mach/hardware.h>
+#include <mach/clk.h>
+
+/* Frequency table index must be sequential starting at 0 */
+static struct cpufreq_frequency_table freq_table[] = {
+	{ 0, 312000 },
+	{ 1, 456000 },
+	{ 2, 608000 },
+	{ 3, 760000 },
+	{ 4, 816000 },
+	{ 5, 912000 },
+	{ 6, 1000000 },
+	{ 7, CPUFREQ_TABLE_END },
+};
+
+#define NUM_CPUS	2
+
+static struct clk *cpu_clk;
+
+static unsigned long target_cpu_speed[NUM_CPUS];
+
+int tegra_verify_speed(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, freq_table);
+}
+
+unsigned int tegra_getspeed(unsigned int cpu)
+{
+	unsigned long rate;
+
+	if (cpu >= NUM_CPUS)
+		return 0;
+
+	rate = clk_get_rate(cpu_clk) / 1000;
+	return rate;
+}
+
+static int tegra_update_cpu_speed(void)
+{
+	int i;
+	unsigned long rate = 0;
+	int ret = 0;
+	struct cpufreq_freqs freqs;
+
+	for_each_online_cpu(i)
+		rate = max(rate, target_cpu_speed[i]);
+
+	freqs.old = tegra_getspeed(0);
+	freqs.new = rate;
+
+	if (freqs.old == freqs.new)
+		return ret;
+
+	for_each_online_cpu(freqs.cpu)
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+#ifdef CONFIG_CPU_FREQ_DEBUG
+	printk(KERN_DEBUG "cpufreq-tegra: transition: %u --> %u\n",
+	       freqs.old, freqs.new);
+#endif
+
+	ret = clk_set_rate_cansleep(cpu_clk, freqs.new * 1000);
+	if (ret) {
+		pr_err("cpu-tegra: Failed to set cpu frequency to %d kHz\n",
+			freqs.new);
+		return ret;
+	}
+
+	for_each_online_cpu(freqs.cpu)
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
+}
+
+static int tegra_target(struct cpufreq_policy *policy,
+		       unsigned int target_freq,
+		       unsigned int relation)
+{
+	int idx;
+	unsigned int freq;
+
+	cpufreq_frequency_table_target(policy, freq_table, target_freq,
+		relation, &idx);
+
+	freq = freq_table[idx].frequency;
+
+	target_cpu_speed[policy->cpu] = freq;
+
+	return tegra_update_cpu_speed();
+}
+
+static int tegra_cpu_init(struct cpufreq_policy *policy)
+{
+	if (policy->cpu >= NUM_CPUS)
+		return -EINVAL;
+
+	cpu_clk = clk_get_sys(NULL, "cpu");
+	if (IS_ERR(cpu_clk))
+		return PTR_ERR(cpu_clk);
+
+	cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+	policy->cur = tegra_getspeed(policy->cpu);
+	target_cpu_speed[policy->cpu] = policy->cur;
+
+	/* FIXME: what's the actual transition time? */
+	policy->cpuinfo.transition_latency = 300 * 1000;
+
+	policy->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+	cpumask_copy(policy->related_cpus, cpu_possible_mask);
+
+	return 0;
+}
+
+static int tegra_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	clk_put(cpu_clk);
+	return 0;
+}
+
+static struct freq_attr *tegra_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver tegra_cpufreq_driver = {
+	.verify		= tegra_verify_speed,
+	.target		= tegra_target,
+	.get		= tegra_getspeed,
+	.init		= tegra_cpu_init,
+	.exit		= tegra_cpu_exit,
+	.name		= "tegra",
+	.attr		= tegra_cpufreq_attr,
+};
+
+static int __init tegra_cpufreq_init(void)
+{
+	return cpufreq_register_driver(&tegra_cpufreq_driver);
+}
+
+static void __exit tegra_cpufreq_exit(void)
+{
+        cpufreq_unregister_driver(&tegra_cpufreq_driver);
+}
+
+
+MODULE_AUTHOR("Colin Cross <ccross@android.com>");
+MODULE_DESCRIPTION("cpufreq driver for Nvidia Tegra2");
+MODULE_LICENSE("GPL");
+module_init(tegra_cpufreq_init);
+module_exit(tegra_cpufreq_exit);
-- 
1.7.1
