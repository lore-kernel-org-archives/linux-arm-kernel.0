From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:19 +0000
Subject: [PATCH v3 08/14] picoxcell: add cpufreq support
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-9-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PC3X3 devices have a PLL to control the ARM core speed. Add a cpufreq
driver so that we can run at optimum speed and power.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile         |    1 +
 arch/arm/mach-picoxcell/cpufreq.c        |  145 ++++++++++++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c |    3 +
 arch/arm/mach-picoxcell/picoxcell_core.h |    9 ++
 4 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/cpufreq.c

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index f71a33e..c0bbb25 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -4,3 +4,4 @@ obj-y				:= picoxcell_core.o io.o axi2cfg.o \
 				   gpio.o \
 				   clk.o \
 				   devices.o
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
diff --git a/arch/arm/mach-picoxcell/cpufreq.c b/arch/arm/mach-picoxcell/cpufreq.c
new file mode 100644
index 0000000..7fa8719
--- /dev/null
+++ b/arch/arm/mach-picoxcell/cpufreq.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (c) 2010 picoChip Designs Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#define pr_fmt(fmt) "picoxcell_cpufreq: " fmt
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/cpufreq.h>
+
+#include <mach/hardware.h>
+
+#include "picoxcell_core.h"
+
+static struct {
+	struct clk  *arm_clk;
+} cpufreq;
+
+/* The minimum frequency that we'll allow the ARM to run at (in KHz). */
+#define PC3X3_PLL_MIN_KHZ			    140000
+/* The maximum frequency that we'll allow the ARM to run at (in KHz). */
+#define PC3X3_PLL_MAX_KHZ			    700000
+/* The step between frequencies that the PLL can generate. */
+#define PC3X3_PLL_STEP				    5000
+
+/*
+ * The fuse block contains an 8 bit number which is the maximum clkf value
+ * that we can program. If this isn't programmed then allow 700Mhz operation.
+ * If not, limit the maximum speed to whatever this value corresponds to.
+ */
+static unsigned int picoxcell_cpufreq_max_clkf(void)
+{
+#define MAX_CLKF_FUSE	904
+#define MAX_CLKF_REG	IO_ADDRESS(PICOXCELL_FUSE_BASE + 904 / 8)
+	u8 max_clkf = readb(MAX_CLKF_REG);
+
+	return max_clkf ? ((max_clkf + 1) * 5) / 1000 : PC3X3_PLL_MAX_KHZ;
+}
+
+/*
+ * Initialise the new policy. We allow the PLL to go to the minimum speed but
+ * limit it to either 700Mhz or the frequency that corresponds to the clkf
+ * value in ARM_PLL_M_NUMBER fuses in the fuse block (if nonzero), whichever
+ * is smallest.
+ *
+ * A change of 20% should take ~2uS so we specify the transition latency as
+ * 50uS. This should allow jumps from 400MHz->700MHz within this period.
+ */
+static int picoxcell_cpufreq_init_policy(struct cpufreq_policy *policy)
+{
+	policy->cpuinfo.min_freq		= PC3X3_PLL_MIN_KHZ;
+	policy->cpuinfo.max_freq		= picoxcell_cpufreq_max_clkf();
+	policy->cpuinfo.transition_latency	= 50000;
+	policy->cur				= clk_get_rate(cpufreq.arm_clk);
+	policy->min				= PC3X3_PLL_MIN_KHZ;
+	policy->max				= picoxcell_cpufreq_max_clkf();
+
+	return 0;
+}
+
+static int picoxcell_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     policy->cpuinfo.max_freq);
+
+	policy->min = clk_round_rate(cpufreq.arm_clk, policy->min);
+	policy->max = clk_round_rate(cpufreq.arm_clk, policy->max);
+
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     policy->cpuinfo.max_freq);
+
+	return 0;
+}
+
+static int picoxcell_cpufreq_target(struct cpufreq_policy *policy,
+				    unsigned int target_freq,
+				    unsigned int relation)
+{
+	int ret = 0;
+	struct cpufreq_freqs freqs;
+
+	if (target_freq > policy->max)
+		target_freq = policy->max;
+	if (target_freq < policy->min)
+		target_freq = policy->min;
+
+	target_freq = clk_round_rate(cpufreq.arm_clk, target_freq);
+
+	freqs.old = clk_get_rate(cpufreq.arm_clk);
+	freqs.new = target_freq;
+	freqs.cpu = policy->cpu;
+
+	if (freqs.new == freqs.old)
+		return 0;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	ret = clk_set_rate(cpufreq.arm_clk, target_freq);
+	if (ret) {
+		pr_err("unable to set cpufreq rate to %u\n", target_freq);
+		freqs.new = freqs.old;
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return ret;
+}
+
+static unsigned int picoxcell_cpufreq_get(unsigned int cpu)
+{
+	return (unsigned int)clk_get_rate(cpufreq.arm_clk);
+}
+
+static struct cpufreq_driver picoxcell_cpufreq_driver = {
+	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_STICKY,
+	.name		= "picoxcell",
+	.init		= picoxcell_cpufreq_init_policy,
+	.verify		= picoxcell_cpufreq_verify,
+	.target		= picoxcell_cpufreq_target,
+	.get		= picoxcell_cpufreq_get,
+};
+
+int __init picoxcell_cpufreq_init(void)
+{
+	cpufreq.arm_clk = clk_get(NULL, "arm");
+
+	/*
+	 * If there isn't a clock then there's nothing to do. Some devices
+	 * e.g. PC3X2 don't have scalable clocks.
+	 */
+	if (IS_ERR_OR_NULL(cpufreq.arm_clk)) {
+		pr_info("cpufreq: no arm clock available - disabling scaling\n");
+		return 0;
+	}
+
+	return cpufreq_register_driver(&picoxcell_cpufreq_driver);
+}
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index a912cfe..60bc878 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -274,4 +274,7 @@ void __init picoxcell_core_init(void)
 
 	/* Register the devices. */
 	picoxcell_add_devices();
+
+	if (picoxcell_has_feature(PICOXCELL_FEATURE_CPUFREQ))
+		WARN_ON(picoxcell_cpufreq_init());
 }
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.h b/arch/arm/mach-picoxcell/picoxcell_core.h
index 9647b7a..f6d90bf 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.h
+++ b/arch/arm/mach-picoxcell/picoxcell_core.h
@@ -21,4 +21,13 @@ extern void __init picoxcell_map_io(void);
 extern struct sys_timer picoxcell_sys_timer;
 extern void __init picoxcell_add_devices(void);
 
+# ifdef CONFIG_CPU_FREQ
+extern int __init picoxcell_cpufreq_init(void);
+# else /* CONFIG_CPU_FREQ */
+static inline int picoxcell_cpufreq_init(void)
+{
+	return 0;
+}
+# endif /* CONFIG_CPU_FREQ */
+
 #endif /* __ASM_ARCH_PICOXCELL_CORE_H__ */
-- 
1.7.2.3
