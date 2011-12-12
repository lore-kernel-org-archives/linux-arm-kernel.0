From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 12 Dec 2011 11:42:31 +0800
Subject: [PATCH 6/7] arm/imx6q: add cpufreq support
In-Reply-To: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323661352-10291-7-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/Kconfig        |    1 +
 arch/arm/mach-imx/Makefile       |    2 +-
 arch/arm/mach-imx/cpu_op-imx6q.c |   78 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpu_op-imx6q.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index fbd414b..7d813a3 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -837,6 +837,7 @@ config SOC_IMX6Q
 	select ARM_GIC
 	select CACHE_L2X0
 	select CPU_V7
+	select ARCH_HAS_CPUFREQ
 	select HAVE_ARM_SCU
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9cf630a..2dfe4a7 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -72,7 +72,7 @@ AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o cpu_op-imx6q.o
 
 # i.MX5 based machines
 obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
diff --git a/arch/arm/mach-imx/cpu_op-imx6q.c b/arch/arm/mach-imx/cpu_op-imx6q.c
new file mode 100644
index 0000000..8807b96
--- /dev/null
+++ b/arch/arm/mach-imx/cpu_op-imx6q.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <mach/hardware.h>
+
+static u32 arm_max_freq;
+static int num_cpu_op;
+
+/* working point(wp): 0 - 1GHzMHz; 1 - 800MHz, 3 - 400MHz, 4  - 160MHz */
+static struct cpu_op mx6q_cpu_op_1G[] = {
+	{
+	 .cpu_rate = 996000000,
+	 .cpu_voltage = 1225000,},
+	{
+	 .cpu_rate = 792000000,
+	 .cpu_voltage = 1100000,},
+	{
+	  .cpu_rate = 396000000,
+	  .cpu_voltage = 950000,},
+	{
+	 .cpu_rate = 198000000,
+	 .cpu_voltage = 850000,},
+};
+
+static struct cpu_op mx6q_cpu_op[] = {
+	{
+	 .cpu_rate = 792000000,
+	 .cpu_voltage = 1100000,},
+	{
+	  .cpu_rate = 396000000,
+	  .cpu_voltage = 950000,},
+	{
+	 .cpu_rate = 198000000,
+	 .cpu_voltage = 850000,},
+};
+
+struct cpu_op *mx6q_get_cpu_op(int *op)
+{
+	if (arm_max_freq == 1000) {
+		*op =  num_cpu_op = ARRAY_SIZE(mx6q_cpu_op_1G);
+		return mx6q_cpu_op_1G;
+	} else {
+		*op =  num_cpu_op = ARRAY_SIZE(mx6q_cpu_op);
+		return mx6q_cpu_op;
+	}
+}
+
+static int __init mx6q_cpu_op_init(void)
+{
+	get_cpu_op = mx6q_get_cpu_op;
+	return 0;
+}
+
+core_initcall(mx6q_cpu_op_init);
+
+static int __init set_arm_max_freq(char *p)
+{
+	if (strncmp(p, "1000", 4) == 0)
+		arm_max_freq = 1000;
+	else if (strncmp(p, "800", 3) == 0)
+		arm_max_freq = 800;
+	return 0;
+}
+
+early_param("arm_freq", set_arm_max_freq);
-- 
1.7.5.4
