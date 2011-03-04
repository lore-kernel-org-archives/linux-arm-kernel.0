From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 04 Mar 2011 13:54:55 +0900
Subject: [PATCH] Exynos4: Basic CPUidle support
Message-ID: <20110304045455.GA13315@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This series adds Exynos4 cpuidle support.
In cpuidle, low power states are attempted.
Currently only WFI is supported.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index fa9e814..ba5d5b7 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -15,6 +15,7 @@ obj-				:=
 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
diff --git a/arch/arm/mach-exynos4/cpuidle.c b/arch/arm/mach-exynos4/cpuidle.c
new file mode 100644
index 0000000..eb2f945
--- /dev/null
+++ b/arch/arm/mach-exynos4/cpuidle.c
@@ -0,0 +1,110 @@
+/*
+ * arch/arm/mach-exynos4/cpuidle.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/cpuidle.h>
+
+#include <asm/proc-fns.h>
+
+#include <mach/hardware.h>
+
+#define EXYNOS4_MAX_STATES	1
+/* C1 - CPUx WFI */
+#define EXYNOS4_STATE_C1	0
+
+struct exynos4_processor_cx {
+	unsigned int	flags;
+	unsigned int	exit_latency; /* in US */
+	unsigned int	target_residency; /* in US */
+	const char	*desc;
+};
+
+struct exynos4_processor_cx exynos4_power_states[EXYNOS4_MAX_STATES];
+
+static int exynos4_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_state *state)
+{
+	struct timespec ts_preidle, ts_postidle, ts_idle;
+
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
+
+	local_irq_disable();
+	local_fiq_disable();
+
+	cpu_do_idle();
+
+	getnstimeofday(&ts_postidle);
+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
+
+	local_irq_enable();
+	local_fiq_enable();
+
+	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
+}
+
+static void exynos4_init_power_states(void)
+{
+	/* C1 CPUx WFI */
+	exynos4_power_states[EXYNOS4_STATE_C1].exit_latency = 1;
+	exynos4_power_states[EXYNOS4_STATE_C1].target_residency = 10000;
+	exynos4_power_states[EXYNOS4_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
+	exynos4_power_states[EXYNOS4_STATE_C1].desc = "CPUx WFI";
+}
+
+static DEFINE_PER_CPU(struct cpuidle_device, exynos_cpuidle_device);
+
+static struct cpuidle_driver exynos4_cpuidle_driver = {
+	.name		= "exynos4_idle",
+	.owner		= THIS_MODULE,
+};
+
+static int __init exynos4_cpuidle_init(void)
+{
+	struct exynos4_processor_cx *cx;
+	struct cpuidle_state *state;
+	struct cpuidle_device *dev;
+	int cpu_id, i, count;
+
+	exynos4_init_power_states();
+	cpuidle_register_driver(&exynos4_cpuidle_driver);
+
+	for_each_cpu(cpu_id, cpu_online_mask) {
+		pr_info("cpuidle for CPU%d registered\n", cpu_id);
+		dev = &per_cpu(exynos_cpuidle_device, cpu_id);
+		dev->cpu = cpu_id;
+		count = 0;
+
+		for (i = EXYNOS4_STATE_C1; i < EXYNOS4_MAX_STATES; i++) {
+			cx = &exynos4_power_states[i];
+			state = &dev->states[count];
+
+			cpuidle_set_statedata(state, cx);
+			state->exit_latency = cx->exit_latency;
+			state->target_residency = cx->target_residency;
+			state->flags = cx->flags;
+			state->enter = exynos4_enter_idle;
+			sprintf(state->name, "C%d", count+1);
+			strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
+			count++;
+		}
+
+		if (!count)
+			return -EINVAL;
+		dev->state_count = count;
+
+		if (cpuidle_register_device(dev)) {
+			pr_err("cpuidle register device failed\n");
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+late_initcall(exynos4_cpuidle_init);
