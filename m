From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  7 Sep 2012 09:33:19 +0800
Subject: [PATCH] cpufreq: add helper function cpufreq_set_target()
Message-ID: <1346981599-28081-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .set_target implementation of cpufreq-cpu0 and omap-cpufreq
drivers are functionally identical.  Rename cpu0_set_target() to
cpufreq_set_target() as a helper function in cpufreq_target.c, which
should work for omap-cpufreq as well.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/cpufreq/Kconfig          |    4 ++
 drivers/cpufreq/Kconfig.arm      |    1 +
 drivers/cpufreq/Makefile         |    1 +
 drivers/cpufreq/cpufreq-cpu0.c   |   94 +++++-----------------------------
 drivers/cpufreq/cpufreq.h        |   31 +++++++++++
 drivers/cpufreq/cpufreq_target.c |   99 +++++++++++++++++++++++++++++++++++
 drivers/cpufreq/omap-cpufreq.c   |  105 +++++---------------------------------
 7 files changed, 163 insertions(+), 172 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq.h
 create mode 100644 drivers/cpufreq/cpufreq_target.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ea512f4..206eec9 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -20,6 +20,9 @@ if CPU_FREQ
 config CPU_FREQ_TABLE
 	tristate
 
+config CPU_FREQ_TARGET
+	tristate
+
 config CPU_FREQ_STAT
 	tristate "CPU frequency translation statistics"
 	select CPU_FREQ_TABLE
@@ -183,6 +186,7 @@ config GENERIC_CPUFREQ_CPU0
 	bool "Generic CPU0 cpufreq driver"
 	depends on HAVE_CLK && REGULATOR && PM_OPP && OF
 	select CPU_FREQ_TABLE
+	select CPU_FREQ_TARGET
 	help
 	  This adds a generic cpufreq driver for CPU0 frequency management.
 	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5961e64..60d81d0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -7,6 +7,7 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 	select CPU_FREQ_TABLE
+	select CPU_FREQ_TARGET
 
 config ARM_S3C2416_CPUFREQ
 	bool "S3C2416 CPU Frequency scaling support"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index a378ed2..f7d19d1 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 
 # CPUfreq cross-arch helpers
 obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
+obj-$(CONFIG_CPU_FREQ_TARGET)		+= cpufreq_target.o
 
 obj-$(CONFIG_GENERIC_CPUFREQ_CPU0)	+= cpufreq-cpu0.o
 
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index e915827..51096e8 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -1,9 +1,6 @@
 /*
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  *
- * The OPP code in function cpu0_set_target() is reused from
- * drivers/cpufreq/omap-cpufreq.c
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -20,6 +17,7 @@
 #include <linux/opp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include "cpufreq.h"
 
 static unsigned int transition_latency;
 static unsigned int voltage_tolerance; /* in percentage */
@@ -42,84 +40,18 @@ static unsigned int cpu0_get_speed(unsigned int cpu)
 static int cpu0_set_target(struct cpufreq_policy *policy,
 			   unsigned int target_freq, unsigned int relation)
 {
-	struct cpufreq_freqs freqs;
-	struct opp *opp;
-	unsigned long freq_Hz, volt = 0, volt_old = 0, tol = 0;
-	unsigned int index, cpu;
-	int ret;
-
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					     relation, &index);
-	if (ret) {
-		pr_err("failed to match target freqency %d: %d\n",
-		       target_freq, ret);
-		return ret;
-	}
-
-	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
-	if (freq_Hz < 0)
-		freq_Hz = freq_table[index].frequency * 1000;
-	freqs.new = freq_Hz / 1000;
-	freqs.old = clk_get_rate(cpu_clk) / 1000;
-
-	if (freqs.old == freqs.new)
-		return 0;
-
-	for_each_online_cpu(cpu) {
-		freqs.cpu = cpu;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
-
-	if (cpu_reg) {
-		opp = opp_find_freq_ceil(cpu_dev, &freq_Hz);
-		if (IS_ERR(opp)) {
-			pr_err("failed to find OPP for %ld\n", freq_Hz);
-			return PTR_ERR(opp);
-		}
-		volt = opp_get_voltage(opp);
-		tol = volt * voltage_tolerance / 100;
-		volt_old = regulator_get_voltage(cpu_reg);
-	}
-
-	pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
-		 freqs.old / 1000, volt_old ? volt_old / 1000 : -1,
-		 freqs.new / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (cpu_reg && freqs.new > freqs.old) {
-		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
-		if (ret) {
-			pr_err("failed to scale voltage up: %d\n", ret);
-			freqs.new = freqs.old;
-			return ret;
-		}
-	}
-
-	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
-	if (ret) {
-		pr_err("failed to set clock rate: %d\n", ret);
-		if (cpu_reg)
-			regulator_set_voltage_tol(cpu_reg, volt_old, tol);
-		return ret;
-	}
-
-	/* scaling down?  scale voltage after frequency */
-	if (cpu_reg && freqs.new < freqs.old) {
-		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
-		if (ret) {
-			pr_err("failed to scale voltage down: %d\n", ret);
-			clk_set_rate(cpu_clk, freqs.old * 1000);
-			freqs.new = freqs.old;
-			return ret;
-		}
-	}
-
-	for_each_online_cpu(cpu) {
-		freqs.cpu = cpu;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
-
-	return 0;
+	struct cpufreq_target_data data;
+
+	data.dev = cpu_dev;
+	data.clk = cpu_clk;
+	data.reg = cpu_reg;
+	data.tol = voltage_tolerance;
+	data.freq_table = freq_table;
+	data.policy = policy;
+	data.target_freq = target_freq;
+	data.relation = relation;
+
+	return cpufreq_set_target(&data);
 }
 
 static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/cpufreq.h b/drivers/cpufreq/cpufreq.h
new file mode 100644
index 0000000..ae380b3
--- /dev/null
+++ b/drivers/cpufreq/cpufreq.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DRIVERS_CPUFREQ_H
+#define _DRIVERS_CPUFREQ_H
+
+struct device;
+struct clk;
+struct regulator;
+struct cpufreq_frequency_table;
+struct cpufreq_policy;
+
+struct cpufreq_target_data {
+	struct device *dev;
+	struct clk *clk;
+	struct regulator *reg;
+	unsigned int tol;
+	struct cpufreq_frequency_table *freq_table;
+	struct cpufreq_policy *policy;
+	unsigned int target_freq;
+	unsigned int relation;
+};
+
+int cpufreq_set_target(struct cpufreq_target_data *data);
+
+#endif /* _DRIVERS_CPUFREQ_H */
diff --git a/drivers/cpufreq/cpufreq_target.c b/drivers/cpufreq/cpufreq_target.c
new file mode 100644
index 0000000..02a5584
--- /dev/null
+++ b/drivers/cpufreq/cpufreq_target.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * Based on function omap_target() from drivers/cpufreq/omap-cpufreq.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/opp.h>
+#include <linux/regulator/consumer.h>
+#include "cpufreq.h"
+
+int cpufreq_set_target(struct cpufreq_target_data *d)
+{
+	struct cpufreq_freqs freqs;
+	struct opp *opp;
+	unsigned long freq_Hz, volt = 0, volt_old = 0, tol = 0;
+	unsigned int index, cpu;
+	int ret;
+
+	ret = cpufreq_frequency_table_target(d->policy, d->freq_table,
+					     d->target_freq, d->relation,
+					     &index);
+	if (ret) {
+		pr_err("failed to match target freqency %d: %d\n",
+		       d->target_freq, ret);
+		return ret;
+	}
+
+	freq_Hz = clk_round_rate(d->clk, d->freq_table[index].frequency * 1000);
+	if (freq_Hz < 0)
+		freq_Hz = d->freq_table[index].frequency * 1000;
+	freqs.new = freq_Hz / 1000;
+	freqs.old = clk_get_rate(d->clk) / 1000;
+
+	if (freqs.old == freqs.new)
+		return 0;
+
+	for_each_online_cpu(cpu) {
+		freqs.cpu = cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
+
+	if (d->reg) {
+		opp = opp_find_freq_ceil(d->dev, &freq_Hz);
+		if (IS_ERR(opp)) {
+			pr_err("failed to find OPP for %ld\n", freq_Hz);
+			return PTR_ERR(opp);
+		}
+		volt = opp_get_voltage(opp);
+		tol = volt * d->tol / 100;
+		volt_old = regulator_get_voltage(d->reg);
+	}
+
+	pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
+		 freqs.old / 1000, volt_old ? volt_old / 1000 : -1,
+		 freqs.new / 1000, volt ? volt / 1000 : -1);
+
+	/* scaling up?  scale voltage before frequency */
+	if (d->reg && freqs.new > freqs.old) {
+		ret = regulator_set_voltage_tol(d->reg, volt, tol);
+		if (ret) {
+			pr_err("failed to scale voltage up: %d\n", ret);
+			freqs.new = freqs.old;
+			return ret;
+		}
+	}
+
+	ret = clk_set_rate(d->clk, freqs.new * 1000);
+	if (ret) {
+		pr_err("failed to set clock rate: %d\n", ret);
+		if (d->reg)
+			regulator_set_voltage_tol(d->reg, volt_old, tol);
+		return ret;
+	}
+
+	/* scaling down?  scale voltage after frequency */
+	if (d->reg && freqs.new < freqs.old) {
+		ret = regulator_set_voltage_tol(d->reg, volt, tol);
+		if (ret) {
+			pr_err("failed to scale voltage down: %d\n", ret);
+			clk_set_rate(d->clk, freqs.old * 1000);
+			freqs.new = freqs.old;
+			return ret;
+		}
+	}
+
+	for_each_online_cpu(cpu) {
+		freqs.cpu = cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_set_target);
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 83a78ad..0772df5 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -37,6 +37,8 @@
 
 #include <mach/hardware.h>
 
+#include "cpufreq.h"
+
 /* OPP tolerance in percentage */
 #define	OPP_TOLERANCE	4
 
@@ -69,97 +71,18 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	unsigned int i;
-	int r, ret = 0;
-	struct cpufreq_freqs freqs;
-	struct opp *opp;
-	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
-
-	if (!freq_table) {
-		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
-				policy->cpu);
-		return -EINVAL;
-	}
-
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-			relation, &i);
-	if (ret) {
-		dev_dbg(mpu_dev, "%s: cpu%d: no freq match for %d(ret=%d)\n",
-			__func__, policy->cpu, target_freq, ret);
-		return ret;
-	}
-	freqs.new = freq_table[i].frequency;
-	if (!freqs.new) {
-		dev_err(mpu_dev, "%s: cpu%d: no match for freq %d\n", __func__,
-			policy->cpu, target_freq);
-		return -EINVAL;
-	}
-
-	freqs.old = omap_getspeed(policy->cpu);
-	freqs.cpu = policy->cpu;
-
-	if (freqs.old == freqs.new && policy->cur == freqs.new)
-		return ret;
-
-	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	}
-
-	freq = freqs.new * 1000;
-
-	if (mpu_reg) {
-		opp = opp_find_freq_ceil(mpu_dev, &freq);
-		if (IS_ERR(opp)) {
-			dev_err(mpu_dev, "%s: unable to find MPU OPP for %d\n",
-				__func__, freqs.new);
-			return -EINVAL;
-		}
-		volt = opp_get_voltage(opp);
-		tol = volt * OPP_TOLERANCE / 100;
-		volt_old = regulator_get_voltage(mpu_reg);
-	}
-
-	dev_dbg(mpu_dev, "cpufreq-omap: %u MHz, %ld mV --> %u MHz, %ld mV\n", 
-		freqs.old / 1000, volt_old ? volt_old / 1000 : -1,
-		freqs.new / 1000, volt ? volt / 1000 : -1);
-
-	/* scaling up?  scale voltage before frequency */
-	if (mpu_reg && (freqs.new > freqs.old)) {
-		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage up.\n",
-				 __func__);
-			freqs.new = freqs.old;
-			goto done;
-		}
-	}
-
-	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
-
-	/* scaling down?  scale voltage after frequency */
-	if (mpu_reg && (freqs.new < freqs.old)) {
-		r = regulator_set_voltage(mpu_reg, volt - tol, volt + tol);
-		if (r < 0) {
-			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
-				 __func__);
-			ret = clk_set_rate(mpu_clk, freqs.old * 1000);
-			freqs.new = freqs.old;
-			goto done;
-		}
-	}
-
-	freqs.new = omap_getspeed(policy->cpu);
-
-done:
-	/* notifiers */
-	for_each_cpu(i, policy->cpus) {
-		freqs.cpu = i;
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	}
-
-	return ret;
+	struct cpufreq_target_data data;
+
+	data.dev = mpu_dev;
+	data.clk = mpu_clk;
+	data.reg = mpu_reg;
+	data.tol = OPP_TOLERANCE;
+	data.freq_table = freq_table;
+	data.policy = policy;
+	data.target_freq = target_freq;
+	data.relation = relation;
+
+	return cpufreq_set_target(&data);
 }
 
 static inline void freq_table_free(void)
-- 
1.7.5.4
