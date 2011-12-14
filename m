From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 14 Dec 2011 01:02:06 -0600
Subject: [RFC PATCH v2 2/2] ARM: imx: Add mx5 cpuidle implmentation
In-Reply-To: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323846126-7516-3-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mx5 cpuidle implmentation (based upon the new common cpuidle code).

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/Makefile          |    3 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c |    3 ++
 arch/arm/mach-mx5/cpuidle.c         |   65 +++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletions(-)
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
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 4cb2769..12c8a2b 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1533,6 +1533,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
 	_REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
+	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
 };
 
 static void clk_tree_init(void)
@@ -1572,6 +1573,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
+	clk_enable(&gpc_dvfs_clk);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
@@ -1615,6 +1617,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
 	clk_enable(&cpu_clk);
 	clk_enable(&main_bus_clk);
+	clk_enable(&gpc_dvfs_clk);
 
 	clk_enable(&iim_clk);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
diff --git a/arch/arm/mach-mx5/cpuidle.c b/arch/arm/mach-mx5/cpuidle.c
new file mode 100644
index 0000000..7e8ad0a
--- /dev/null
+++ b/arch/arm/mach-mx5/cpuidle.c
@@ -0,0 +1,65 @@
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
+			      int index)
+{
+	mx5_cpu_lp_set((unsigned int)dev->states_usage[index].driver_data);
+	cpu_do_idle();
+	return index;
+}
+
+static struct cpuidle_driver imx5_cpuidle_driver = {
+	.name	= "imx5_cpuidle",
+	.owner	= THIS_MODULE,
+	.states[0] = {
+		.enter			= imx5_enter,
+		.exit_latency		= 12,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "idle cpu powered, unclocked.",
+	},
+	.states[1] = {
+		.enter			= imx5_enter,
+		.exit_latency		= 20,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI SRPG",
+		.desc			= "idle cpu unpowered, unclocked.",
+	},
+	.state_count = 2,
+};
+
+/* use drive_data field to hold the mx5 idle parameter */
+static void __init imx5_dd_init(struct cpuidle_device * dev)
+{
+	dev->states_usage[0].driver_data = (void *)WAIT_UNCLOCKED;
+	dev->states_usage[1].driver_data = (void *)WAIT_UNCLOCKED_POWER_OFF;
+}
+
+static int __init imx5_init_cpuidle(void)
+{
+	int ret;
+
+	ret = common_cpuidle_init(&imx5_cpuidle_driver,
+					true,
+					imx5_dd_init);
+	return ret;
+}
+late_initcall(imx5_init_cpuidle);
-- 
1.7.1
