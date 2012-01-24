From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 23 Jan 2012 22:37:34 -0600
Subject: [PATCH v3 7/7] ARM: imx: Add imx5 cpuidle implementation
In-Reply-To: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1327379854-12403-8-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx5 cpuidle implementation using common cpuidle functionality.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/Makefile  |    3 +-
 arch/arm/mach-mx5/cpuidle.c |   64 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpuidle.c

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 0fc6080..2c348b4 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -3,8 +3,9 @@
 #
 
 # Object file lists.
-obj-y   := cpu.o mm.o clock-mx51-mx53.o ehci.o system.o
 
+obj-y   := cpu.o mm.o clock-mx51-mx53.o ehci.o system.o
+obj-$(CONFIG_CPU_IDLE) += cpuidle.o
 obj-$(CONFIG_PM) += pm-imx5.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
diff --git a/arch/arm/mach-mx5/cpuidle.c b/arch/arm/mach-mx5/cpuidle.c
new file mode 100644
index 0000000..230d335
--- /dev/null
+++ b/arch/arm/mach-mx5/cpuidle.c
@@ -0,0 +1,64 @@
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
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <mach/common.h>
+
+int imx5_enter(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index)
+{
+	mx5_cpu_lp_set((unsigned int)dev->states_usage[index].driver_data);
+	cpu_do_idle();
+	return index;
+}
+
+static struct cpuidle_driver imx5_cpuidle_driver __initdata = {
+	.name	= "imx5_cpuidle",
+	.owner	= THIS_MODULE,
+	.states[0] = {
+		.enter			= imx5_enter,
+		.exit_latency		= 12, /* max latency at 160MHz */
+		.target_residency	= 1,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "IMX WFI",
+		.desc			= "CPU and related clocks gated",
+	},
+	.states[1] = {
+		.enter			= imx5_enter,
+		.exit_latency		= 20, /* max latency at 160MHz */
+		.target_residency	= 1,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "IMX SRPG",
+		.desc			= "CPU state retained,powered off",
+	},
+	.state_count = 2,
+};
+
+/* use driver_data field to hold the mx5 idle parameter */
+static void __init imx5_dd_init(struct cpuidle_device * dev)
+{
+	dev->states_usage[0].driver_data = (void *)WAIT_UNCLOCKED;
+	dev->states_usage[1].driver_data = (void *)WAIT_UNCLOCKED_POWER_OFF;
+}
+
+static int __init imx5_init_cpuidle(void)
+{
+	return common_cpuidle_init(&imx5_cpuidle_driver,
+					true,
+					imx5_dd_init);
+}
+late_initcall(imx5_init_cpuidle);
-- 
1.7.1
