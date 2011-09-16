From: rob.lee@linaro.org (Robert Lee)
Date: Fri, 16 Sep 2011 12:27:48 -0500
Subject: [PATCH v2 1/3] ARM: imx: Add imx cpuidle driver
In-Reply-To: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1316194070-21889-2-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new cpuidle driver which provides the common cpuidle
functionality necessary for any imx soc cpuidle implementation.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/plat-mxc/Makefile               |    1 +
 arch/arm/plat-mxc/cpuidle.c              |  151 ++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/cpuidle.h |   56 +++++++++++
 3 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/cpuidle.c
 create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index d53c35f..8939f79 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
+obj-$(CONFIG_CPU_IDLE) += cpuidle.o
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/plat-mxc/cpuidle.c b/arch/arm/plat-mxc/cpuidle.c
new file mode 100644
index 0000000..9e4c176
--- /dev/null
+++ b/arch/arm/plat-mxc/cpuidle.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/cpuidle.h>
+#include <linux/err.h>
+#include <asm/proc-fns.h>
+#include <mach/cpuidle.h>
+
+static int (*mach_cpuidle)(struct cpuidle_device *dev,
+			       struct cpuidle_state *state);
+static struct cpuidle_driver *imx_cpuidle_driver;
+static struct __initdata cpuidle_device * device;
+
+static int imx_enter_idle(struct cpuidle_device *dev,
+			       struct cpuidle_state *state)
+{
+	struct timeval before, after;
+	int idle_time;
+
+	local_irq_disable();
+	local_fiq_disable();
+
+	do_gettimeofday(&before);
+
+	mach_cpuidle(dev, state);
+
+	do_gettimeofday(&after);
+
+	local_fiq_enable();
+	local_irq_enable();
+
+	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
+		(after.tv_usec - before.tv_usec);
+
+	return idle_time;
+}
+
+static DEFINE_PER_CPU(struct cpuidle_device, imx_cpuidle_device);
+
+int __init imx_cpuidle_init(struct imx_cpuidle_data *cpuidle_data)
+{
+	int i, cpu_id;
+
+	if (cpuidle_data == NULL) {
+		pr_err("%s: cpuidle_data pointer NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	if (cpuidle_data->mach_cpuidle == NULL) {
+		pr_err("%s: idle callback function NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	imx_cpuidle_driver = cpuidle_data->imx_cpuidle_driver;
+
+	mach_cpuidle = cpuidle_data->mach_cpuidle;
+
+	/* register imx_cpuidle driver */
+	if (cpuidle_register_driver(imx_cpuidle_driver)) {
+		pr_err("%s: Failed to register cpuidle driver\n", __func__);
+		return -ENODEV;
+	}
+
+	/* if provided, initialize the mach level cpuidle functionality */
+	if (cpuidle_data->mach_cpuidle_init) {
+		if (cpuidle_data->mach_cpuidle_init(cpuidle_data)) {
+			pr_err("%s: Failed to register cpuidle driver\n",
+				 __func__);
+			cpuidle_unregister_driver(imx_cpuidle_driver);
+			return -ENODEV;
+		}
+	}
+
+	/* initialize state data for each cpuidle_device */
+	for_each_cpu(cpu_id, cpu_online_mask) {
+
+		device = &per_cpu(imx_cpuidle_device, cpu_id);
+		device->cpu = cpu_id;
+
+		device->state_count = min((unsigned int) CPUIDLE_STATE_MAX,
+			cpuidle_data->num_states);
+
+		device->prepare = cpuidle_data->prepare;
+
+		for (i = 0; i < device->state_count; i++) {
+			strlcpy(device->states[i].name,
+				cpuidle_data->state_data[i].name,
+				CPUIDLE_NAME_LEN);
+
+			strlcpy(device->states[i].desc,
+				cpuidle_data->state_data[i].desc,
+				CPUIDLE_DESC_LEN);
+
+			device->states[i].driver_data =
+				(void *)cpuidle_data->
+				state_data[i].mach_cpu_pwr_state;
+
+			/*
+			 * Because the imx_enter_idle function measures
+			 * and returns a valid time for all imx SoCs,
+			 * we always set this flag.
+			 */
+			device->states[i].flags = CPUIDLE_FLAG_TIME_VALID;
+
+			device->states[i].exit_latency =
+				cpuidle_data->state_data[i].exit_latency;
+
+			device->states[i].power_usage =
+				cpuidle_data->state_data[i].power_usage;
+
+			device->states[i].target_residency =
+				cpuidle_data->state_data[i].target_residency;
+
+			device->states[i].enter = imx_enter_idle;
+		}
+	}
+
+	return 0;
+}
+
+int __init imx_cpuidle_dev_init(void)
+{
+	int cpu_id;
+
+	if (device == NULL) {
+		pr_err("%s: Failed to register (No device)\n", __func__);
+		return -ENODEV;
+	}
+
+	for_each_cpu(cpu_id, cpu_online_mask) {
+		device = &per_cpu(imx_cpuidle_device, cpu_id);
+		if (cpuidle_register_device(device)) {
+			pr_err("%s: Failed to register\n", __func__);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+late_initcall(imx_cpuidle_dev_init);
diff --git a/arch/arm/plat-mxc/include/mach/cpuidle.h b/arch/arm/plat-mxc/include/mach/cpuidle.h
new file mode 100644
index 0000000..2bb109e
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/cpuidle.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __ARCH_ARM_PLAT_MXC_CPUIDLE_H__
+#define __ARCH_ARM_PLAT_MXC_CPUIDLE_H__
+
+#include <linux/cpuidle.h>
+#include <mach/hardware.h>
+
+/* for passing cpuidle state info to the cpuidle driver. */
+struct imx_cpuidle_state_data {
+	enum mxc_cpu_pwr_mode	mach_cpu_pwr_state;
+	char			*name;
+	char			*desc;
+	/* time in uS to exit this idle state */
+	unsigned int		exit_latency;
+	/* OPTIONAL - power usage of this idle state in mW */
+	unsigned int		power_usage;
+	/* OPTIONAL - in uS. See drivers/cpuidle/governors/menu.c for usage */
+	unsigned int		target_residency;
+};
+
+struct imx_cpuidle_data {
+	unsigned int num_states;
+	struct cpuidle_driver *imx_cpuidle_driver;
+	struct imx_cpuidle_state_data *state_data;
+	int (*mach_cpuidle)(struct cpuidle_device *dev,
+		struct cpuidle_state *state);
+
+	/* OPTIONAL - parameter of mach_cpuidle_init func below */
+	void *mach_init_data;
+	/* OPTIONAL - callback for mach level cpuidle initialization */
+	int (*mach_cpuidle_init)(void *mach_init_data);
+	/* OPTIONAL - Search drivers/cpuidle/cpuidle.c for usage */
+	int (*prepare)(struct cpuidle_device *dev);
+};
+
+#ifdef CONFIG_CPU_IDLE
+int imx_cpuidle_init(struct imx_cpuidle_data *cpuidle_data);
+#else
+static inline int imx_cpuidle_init(struct imx_cpuidle_data *cpuidle_data)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_CPU_IDLE */
+
+#endif /* __ARCH_ARM_PLAT_MXC_CPUIDLE_H__ */
-- 
1.7.1
