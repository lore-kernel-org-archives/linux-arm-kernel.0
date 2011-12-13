From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 13 Dec 2011 14:25:26 +0800
Subject: [PATCH V2 3/7] arm/imx: cpufreq: add multi-core support
In-Reply-To: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323757530-19402-4-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/cpufreq.c |   99 ++++++++++++++++++++++++++++--------------
 1 files changed, 66 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index adbff70..85d037f 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <asm/cpu.h>
 #include <mach/hardware.h>
 #include <mach/clock.h>
 
@@ -34,6 +35,7 @@ static int cpu_freq_khz_min;
 static int cpu_freq_khz_max;
 
 static struct clk *cpu_clk;
+static DEFINE_MUTEX(cpu_lock);
 static struct cpufreq_frequency_table *imx_freq_table;
 
 static int cpu_op_nr;
@@ -59,17 +61,11 @@ static int set_cpu_freq(int freq)
 
 static int mxc_verify_speed(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -EINVAL;
-
 	return cpufreq_frequency_table_verify(policy, imx_freq_table);
 }
 
 static unsigned int mxc_get_speed(unsigned int cpu)
 {
-	if (cpu)
-		return 0;
-
 	return clk_get_rate(cpu_clk) / 1000;
 }
 
@@ -77,23 +73,49 @@ static int mxc_set_target(struct cpufreq_policy *policy,
 			  unsigned int target_freq, unsigned int relation)
 {
 	struct cpufreq_freqs freqs;
-	int freq_Hz;
+	int freq_Hz, cpu;
 	int ret = 0;
 	unsigned int index;
 
+	mutex_lock(&cpu_lock);
+
 	cpufreq_frequency_table_target(policy, imx_freq_table,
 			target_freq, relation, &index);
 	freq_Hz = imx_freq_table[index].frequency * 1000;
 
 	freqs.old = clk_get_rate(cpu_clk) / 1000;
-	freqs.new = freq_Hz / 1000;
-	freqs.cpu = 0;
+	freqs.new = clk_round_rate(cpu_clk, freq_Hz);
+	freqs.new = (freqs.new ? freqs.new : freq_Hz) / 1000;
 	freqs.flags = 0;
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	if (freqs.old == freqs.new) {
+		mutex_unlock(&cpu_lock);
+		return 0;
+	}
+
+	for_each_possible_cpu(cpu) {
+		freqs.cpu = cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
 
 	ret = set_cpu_freq(freq_Hz);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+#ifdef CONFIG_SMP
+	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
+	 * So update it for all CPUs.
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(cpu_data, cpu).loops_per_jiffy =
+		cpufreq_scale(per_cpu(cpu_data, cpu).loops_per_jiffy,
+					freqs.old, freqs.new);
+#endif
+
+	for_each_possible_cpu(cpu) {
+		freqs.cpu = cpu;
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
+
+	mutex_unlock(&cpu_lock);
 
 	return ret;
 }
@@ -105,7 +127,7 @@ static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
 
 	printk(KERN_INFO "i.MXC CPU frequency driver\n");
 
-	if (policy->cpu != 0)
+	if (policy->cpu >= num_possible_cpus())
 		return -EINVAL;
 
 	if (!get_cpu_op)
@@ -117,37 +139,45 @@ static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
 		return PTR_ERR(cpu_clk);
 	}
 
-	cpu_op_tbl = get_cpu_op(&cpu_op_nr);
+	mutex_lock(&cpu_lock);
+	if (!imx_freq_table) {
+		cpu_op_tbl = get_cpu_op(&cpu_op_nr);
 
-	cpu_freq_khz_min = cpu_op_tbl[0].cpu_rate / 1000;
-	cpu_freq_khz_max = cpu_op_tbl[0].cpu_rate / 1000;
+		cpu_freq_khz_min = cpu_op_tbl[0].cpu_rate / 1000;
+		cpu_freq_khz_max = cpu_op_tbl[0].cpu_rate / 1000;
 
-	imx_freq_table = kmalloc(
-		sizeof(struct cpufreq_frequency_table) * (cpu_op_nr + 1),
-			GFP_KERNEL);
-	if (!imx_freq_table) {
-		ret = -ENOMEM;
-		goto err1;
-	}
+		imx_freq_table = kmalloc(sizeof(struct cpufreq_frequency_table)
+					* (cpu_op_nr + 1), GFP_KERNEL);
+		if (!imx_freq_table) {
+			ret = -ENOMEM;
+			mutex_unlock(&cpu_lock);
+			goto err1;
+		}
 
-	for (i = 0; i < cpu_op_nr; i++) {
-		imx_freq_table[i].index = i;
-		imx_freq_table[i].frequency = cpu_op_tbl[i].cpu_rate / 1000;
+		for (i = 0; i < cpu_op_nr; i++) {
+			imx_freq_table[i].index = i;
+			imx_freq_table[i].frequency =
+					cpu_op_tbl[i].cpu_rate / 1000;
 
-		if ((cpu_op_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
-			cpu_freq_khz_min = cpu_op_tbl[i].cpu_rate / 1000;
+			if ((cpu_op_tbl[i].cpu_rate / 1000) < cpu_freq_khz_min)
+				cpu_freq_khz_min =
+					cpu_op_tbl[i].cpu_rate / 1000;
 
-		if ((cpu_op_tbl[i].cpu_rate / 1000) > cpu_freq_khz_max)
-			cpu_freq_khz_max = cpu_op_tbl[i].cpu_rate / 1000;
-	}
+			if ((cpu_op_tbl[i].cpu_rate / 1000) > cpu_freq_khz_max)
+				cpu_freq_khz_max =
+					cpu_op_tbl[i].cpu_rate / 1000;
+		}
 
-	imx_freq_table[i].index = i;
-	imx_freq_table[i].frequency = CPUFREQ_TABLE_END;
+		imx_freq_table[i].index = i;
+		imx_freq_table[i].frequency = CPUFREQ_TABLE_END;
+	}
+	mutex_unlock(&cpu_lock);
 
 	policy->cur = clk_get_rate(cpu_clk) / 1000;
 	policy->min = policy->cpuinfo.min_freq = cpu_freq_khz_min;
 	policy->max = policy->cpuinfo.max_freq = cpu_freq_khz_max;
-
+	policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+	cpumask_setall(policy->cpus);
 	/* Manual states, that PLL stabilizes in two CLK32 periods */
 	policy->cpuinfo.transition_latency = 2 * NANOSECOND / CLK32_FREQ;
 
@@ -174,7 +204,10 @@ static int mxc_cpufreq_exit(struct cpufreq_policy *policy)
 
 	set_cpu_freq(cpu_freq_khz_max * 1000);
 	clk_put(cpu_clk);
+	mutex_lock(&cpu_lock);
 	kfree(imx_freq_table);
+	imx_freq_table = NULL;
+	mutex_unlock(&cpu_lock);
 	return 0;
 }
 
-- 
1.7.5.4
