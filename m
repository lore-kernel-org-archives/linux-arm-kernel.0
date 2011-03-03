From: service@prisktech.co.nz (Tony Prisk)
Date: Thu, 3 Mar 2011 07:46:57 +0000
Subject: [PATCH 1/1] CPU Frequency Scaling for VT8500/WM8505
Message-ID: <17ADDC0A01C90B4EBBBA4630AA4DB388291D79B5@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU Frequency Scaling support for VT8500/WM8505 based system.

Signed-off-by: Tony Prisk (linux at prisktech.co.nz)
diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index 7422e8a..e1df248 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -7,3 +7,7 @@ obj-$(CONFIG_MACH_BV07) += bv07.o
 obj-$(CONFIG_MACH_WM8505_7IN_NETBOOK) += wm8505_7in.o
 
 obj-$(CONFIG_HAVE_PWM) += pwm.o
+
+ifeq ($(CONFIG_CPU_FREQ), y)
+	obj-y += cpufreq.o
+endif
diff --git a/arch/arm/mach-vt8500/cpufreq.c b/arch/arm/mach-vt8500/cpufreq.c
new file mode 100644
index 0000000..570d9e8
--- /dev/null
+++ b/arch/arm/mach-vt8500/cpufreq.c
@@ -0,0 +1,209 @@
+/*
+ * linux/arch/arm/mach-vt8500/cpufreq.c
+ *
+ * CPU frequency scaling
+ * Copyright (c) 2008 Wondermedia Technologies, Inc.
+ * Copyright (c) 2011 Tony Prisk.
+ *
+ * This program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation, either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have recieved a copy of the GNU PUblic License along with this
+ * program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * WonderMedia Technologies, Inc.
+ * 10F, 529, Chung-Cheng Road, Hsin-Tien, Taipei 231, R.O.C.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/cpufreq.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <mach/wm8505_regs.h>
+
+#define wmt_cpufreq_read_reg(reg)	readl(pmc_base + reg)
+#define wmt_cpufreq_write_reg(reg, val)	writel(val, pmc_base + reg)
+
+struct wmt_freq_t {
+	u32 cpu_khz;
+	u32 pll_a;
+	u32 ahb;
+};
+
+static struct wmt_freq_t wmt_freqs[] = {
+	{ 50000,	100000000,	50000000 },
+	{ 75000,	150000000,	75000000 },
+	{ 100000,	200000000,	100000000 },
+	{ 125000,	250000000,	62500000 },
+	{ 150000,	300000000,	75000000 },
+	{ 175000,	350000000,	87500000 },
+	{ 200000,	400000000,	100000000 },
+	{ 225000,	450000000,	112500000 },
+	{ 250000,	500000000,	125000000 },
+	{ 275000,	550000000,	137500000 },
+	{ 300000,	600000000,	150000000 },
+	{ 325000,	650000000,	162500000 },
+	{ 350000,	700000000,	175000000 },
+	{ 375000,	750000000,	125000000 },
+	{ 387500,	775000000,	129166666 },
+};
+
+#define WMT_NUM_FREQS ARRAY_SIZE(wmt_freqs)
+
+struct clk *cpufreq_clk_arm;
+struct clk *cpufreq_clk_ahb;
+
+static u32 wmt_freq_to_idx(u32 khz)
+{
+	int idx;
+
+	for (idx = 0; idx < WMT_NUM_FREQS; idx++)
+		if (wmt_freqs[idx].cpu_khz >= khz)
+			return idx;
+
+	return WMT_NUM_FREQS - 1;
+}
+
+static u32 wmt_idx_to_freq(u32 idx)
+{
+	if (idx < WMT_NUM_FREQS)
+		return wmt_freqs[idx].cpu_khz;
+	else
+		return wmt_freqs[WMT_NUM_FREQS - 1].cpu_khz;
+}
+
+static struct wmt_freq_t *wmt_idx_to_params(u32 idx)
+{
+	if (idx < WMT_NUM_FREQS)
+		return &wmt_freqs[idx];
+	else
+		return &wmt_freqs[WMT_NUM_FREQS - 1];
+}
+
+static unsigned int wmt_cpufreq_get_current(void)
+{
+	return (u32)(clk_get_rate(cpufreq_clk_arm) / 1000);
+}
+
+static unsigned int wmt_cpufreq_get(unsigned int cpu)
+{
+	return wmt_cpufreq_get_current();
+}
+
+static int wmt_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	u32 tmp;
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq, \
+					policy->cpuinfo.max_freq);
+
+	tmp = wmt_freqs[wmt_freq_to_idx(policy->min)].cpu_khz;
+
+	if (tmp > policy->max)
+		policy->max = tmp;
+
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq, \
+					policy->cpuinfo.max_freq);
+
+	return 0;
+}
+
+static void wmt_speedstep(unsigned int idx)
+{
+	struct wmt_freq_t *np;
+	np = wmt_idx_to_params(idx);
+
+	clk_set_rate(cpufreq_clk_arm, np->cpu_khz * 1000);
+	clk_set_rate(cpufreq_clk_ahb, np->ahb);
+}
+
+static int wmt_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int target_freq,
+				unsigned int relation)
+{
+	unsigned int idx;
+	unsigned long flags;
+	struct cpufreq_freqs freqs;
+
+	idx = wmt_freq_to_idx(target_freq);
+
+	switch (relation) {
+	case CPUFREQ_RELATION_L:
+		if (wmt_idx_to_freq(idx) > policy->max)
+			idx--;
+		break;
+	case CPUFREQ_RELATION_H:
+		if ((wmt_idx_to_freq(idx) > target_freq) &&
+			(wmt_idx_to_freq(idx-1) >= policy->min))
+			idx--;
+		break;
+	}
+
+	freqs.old = wmt_cpufreq_get_current();
+	freqs.new = wmt_idx_to_freq(idx);
+	freqs.cpu = 0;
+
+	if (freqs.new != freqs.old) {
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+		local_irq_save(flags);
+		wmt_speedstep(idx);
+		local_irq_restore(flags);
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
+
+	return 0;
+}
+
+static int wmt_cpufreq_init(struct cpufreq_policy *policy)
+{
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	cpufreq_clk_arm = clk_get(NULL, "arm");
+	if (IS_ERR(cpufreq_clk_arm))
+		return PTR_ERR(cpufreq_clk_arm);
+	cpufreq_clk_ahb = clk_get(NULL, "ahb");
+	if (IS_ERR(cpufreq_clk_ahb))
+		return PTR_ERR(cpufreq_clk_ahb);
+
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	policy->cpuinfo.min_freq = wmt_freqs[0].cpu_khz;
+	policy->cpuinfo.max_freq = wmt_freqs[WMT_NUM_FREQS - 1].cpu_khz;
+	policy->cpuinfo.transition_latency = 1000000;	/* 1ms, assumed? */
+	policy->cur = wmt_cpufreq_get_current();
+	policy->min = 100000;
+	policy->max = 350000;
+
+	return 0;
+}
+
+static struct cpufreq_driver wmt_cpufreq_driver = {
+	.flags = CPUFREQ_STICKY,
+	.init = wmt_cpufreq_init,
+	.verify = wmt_cpufreq_verify,
+	.target = wmt_cpufreq_target,
+	.get = wmt_cpufreq_get,
+	.name = "wmt",
+};
+
+static int __init wmt_cpuf_init(void)
+{
+	return cpufreq_register_driver(&wmt_cpufreq_driver);
+}
+
+arch_initcall(wmt_cpuf_init);
