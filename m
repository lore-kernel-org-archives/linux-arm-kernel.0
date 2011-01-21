From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 21 Jan 2011 09:23:15 +0530
Subject: [PATCH V5 resend 39/63] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <cover.1295581815.git.viresh.kumar@st.com>
References: <cover.1295581815.git.viresh.kumar@st.com>
Message-ID: <01612f9ae6c475b861c2f03cc24a4cb4639e01d1.1295581815.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-spear13xx/clock.c |    7 +-
 arch/arm/mach-spear3xx/clock.c  |    5 +-
 arch/arm/mach-spear6xx/clock.c  |    5 +-
 arch/arm/plat-spear/Makefile    |    2 +-
 arch/arm/plat-spear/cpufreq.c   |  164 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 176 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/plat-spear/cpufreq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 957d320..11501de 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -872,6 +872,7 @@ config PLAT_SPEAR
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
+	select ARCH_HAS_CPUFREQ
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 709adb2..a7e75ca 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -91,6 +91,7 @@ static struct pll_clk_config pll1_config = {
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
 	/* PCLK 24MHz */
+	{.mode = 0, .m = 0x64, .n = 0x03, .p = 0x2}, /* 400 MHz */
 	{.mode = 0, .m = 0x7D, .n = 0x03, .p = 0x2}, /* 500 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x03, .p = 0x2}, /* 664 MHz */
 	{.mode = 0, .m = 0xC8, .n = 0x03, .p = 0x2}, /* 800 MHz */
@@ -107,7 +108,7 @@ static struct clk pll1_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 4},
 	.private_data = &pll1_config,
 };
 
@@ -144,7 +145,7 @@ static struct clk pll2_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 4},
 	.private_data = &pll2_config,
 };
 
@@ -165,7 +166,7 @@ static struct clk pll3_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 3},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 4},
 	.private_data = &pll3_config,
 };
 
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 58f0259..37faef1 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -55,6 +55,7 @@ static struct pll_clk_masks pll_masks = {
 
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
+	{.mode = 0, .m = 0x53, .n = 0x0C, .p = 0x1}, /* 166 MHz */
 	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
 };
@@ -75,7 +76,7 @@ static struct clk pll1_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 2},
 	.private_data = &pll1_config,
 };
 
@@ -95,7 +96,7 @@ static struct clk pll2_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 2},
 	.private_data = &pll2_config,
 };
 
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 99cc21d..0a38e16 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -55,6 +55,7 @@ static struct pll_clk_masks pll_masks = {
 
 /* pll rate configuration table, in ascending order of rates */
 struct pll_rate_tbl pll_rtbl[] = {
+	{.mode = 0, .m = 0x53, .n = 0x0C, .p = 0x1}, /* 166 MHz */
 	{.mode = 0, .m = 0x85, .n = 0x0C, .p = 0x1}, /* 266 MHz */
 	{.mode = 0, .m = 0xA6, .n = 0x0C, .p = 0x1}, /* 332 MHz */
 };
@@ -75,7 +76,7 @@ static struct clk pll1_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 2},
 	.private_data = &pll1_config,
 };
 
@@ -95,7 +96,7 @@ static struct clk pll2_clk = {
 	.calc_rate = &pll_calc_rate,
 	.recalc = &pll_clk_recalc,
 	.set_rate = &pll_clk_set_rate,
-	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 1},
+	.rate_config = {pll_rtbl, ARRAY_SIZE(pll_rtbl), 2},
 	.private_data = &pll2_config,
 };
 
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 4c28f01..ec85b82 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -6,7 +6,7 @@
 obj-y	:= clcd.o clock.o pll_clk.o time.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
-
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
 obj-$(CONFIG_MACH_SPEAR320)	+= plgpio.o
 obj-$(CONFIG_SPEAR_PWM)		+= pwm.o
diff --git a/arch/arm/plat-spear/cpufreq.c b/arch/arm/plat-spear/cpufreq.c
new file mode 100644
index 0000000..d8fb1e2
--- /dev/null
+++ b/arch/arm/plat-spear/cpufreq.c
@@ -0,0 +1,164 @@
+/*
+ * arch/arm/plat-spear/cpufreq.c
+ *
+ * CPU Frequency Scaling for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Deepak Sikri<deepak.sikri@st.com>
+ *
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <asm/system.h>
+#include <mach/hardware.h>
+
+#define CPU_CLK		"cpu_clk"
+
+#ifdef CONFIG_ARCH_SPEAR13XX
+#define MIN_CPU_FREQ	200000
+#define MAX_CPU_FREQ	500000
+
+static u32 spear_cpu_freq[] = {
+	200000, /* 200 MHZ */
+	250000, /* 250 MHZ */
+	332000, /* 332 MHZ */
+	400000, /* 400 MHZ */
+	500000, /* 500 MHZ */
+};
+#elif defined(CONFIG_ARCH_SPEAR6XX) || defined(CONFIG_ARCH_SPEAR3XX)
+#define MIN_CPU_FREQ	166000
+#define MAX_CPU_FREQ	332000
+
+static u32 spear_cpu_freq[] = {
+	166000, /* 166 MHZ */
+	266000, /* 266 MHZ */
+	332000, /* 333 MHZ */
+};
+#endif
+
+static struct
+	cpufreq_frequency_table spear_freq_tbl[ARRAY_SIZE(spear_cpu_freq) + 1];
+static struct clk *cpu_clk;
+
+int spear_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, spear_freq_tbl);
+}
+
+static unsigned int spear_cpufreq_get(unsigned int cpu)
+{
+	return cpu ? 0 : clk_get_rate(cpu_clk) / 1000;
+}
+
+static int spear_cpufreq_target(struct cpufreq_policy *policy,
+		unsigned int target_freq, unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	int index, ret;
+	long newfreq;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	if (cpufreq_frequency_table_target(policy, spear_freq_tbl,
+				target_freq, relation, &index))
+		return -EINVAL;
+
+	freqs.old = spear_cpufreq_get(0);
+	freqs.cpu = policy->cpu;
+
+	if (freqs.old == target_freq)
+		return 0;
+
+	newfreq = clk_round_rate(cpu_clk, spear_cpu_freq[index] * 1000);
+	if (newfreq < 0) {
+		pr_err("CPU Freq: clk_round_rate failed: %ld\n", newfreq);
+		return newfreq;
+	}
+
+	freqs.new = newfreq / 1000;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	/* Get current rate after clk_set_rate, for both success and failure */
+	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
+	if (ret) {
+		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
+		freqs.new = clk_get_rate(cpu_clk) / 1000;
+	}
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	return ret;
+}
+
+static int spear_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int i = 0;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	cpu_clk = clk_get(NULL, CPU_CLK);
+	if (IS_ERR(cpu_clk))
+		return PTR_ERR(cpu_clk);
+
+	policy->cpuinfo.min_freq = MIN_CPU_FREQ;
+	policy->cpuinfo.max_freq = MAX_CPU_FREQ;
+	policy->cur = policy->min = policy->max = spear_cpufreq_get(0);
+
+	for (i = 0; i < ARRAY_SIZE(spear_cpu_freq); i++) {
+		spear_freq_tbl[i].index = i;
+		spear_freq_tbl[i].frequency = spear_cpu_freq[i];
+	}
+
+	spear_freq_tbl[i].index = i;
+	spear_freq_tbl[i].frequency = CPUFREQ_TABLE_END;
+	if (!cpufreq_frequency_table_cpuinfo(policy, spear_freq_tbl))
+		cpufreq_frequency_table_get_attr(spear_freq_tbl,
+				policy->cpu);
+
+	policy->cpuinfo.transition_latency = 300*1000; /*300 us*/
+
+	return 0;
+}
+
+static int spear_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	clk_put(cpu_clk);
+	return 0;
+}
+
+static struct freq_attr *spear_cpufreq_attr[] = {
+	 &cpufreq_freq_attr_scaling_available_freqs,
+	 NULL,
+};
+
+static struct cpufreq_driver spear_driver = {
+	.flags		= CPUFREQ_STICKY,
+	.verify		= spear_cpufreq_verify,
+	.target		= spear_cpufreq_target,
+	.get		= spear_cpufreq_get,
+	.init		= spear_cpufreq_init,
+	.exit		= spear_cpufreq_exit,
+	.name		= "spear_cpufreq",
+	.attr		= spear_cpufreq_attr,
+};
+
+static int __init spear_cpufreq_register(void)
+{
+	return cpufreq_register_driver(&spear_driver);
+}
+
+arch_initcall(spear_cpufreq_register);
-- 
1.7.2.2
