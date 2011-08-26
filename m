From: rob.lee@linaro.org (Robert Lee)
Date: Thu, 25 Aug 2011 21:33:15 -0500
Subject: [PATCH 2/2] Adding support for the plat-mxc cpuidle driver to
	mach-mx5. Tested on i.MX51 Babbage board with ARM core running
	at 800Mhz. Idle OS ARM core power before patch = ~400mW. Idle
	OS ARM core power after patch = ~1.25mW.
In-Reply-To: <1314325995-29118-1-git-send-email-rob.lee@linaro.org>
References: <1314325995-29118-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1314325995-29118-2-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/Kconfig                |    4 ++
 arch/arm/mach-mx5/include/mach/cpuidle.h |   45 ++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/system.c               |   42 ++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/include/mach/cpuidle.h

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b4e7c58..1672cfe 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -19,6 +19,7 @@ config SOC_IMX50
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_CPUIDLE
 	select ARCH_MX5
 	select ARCH_MX50
 
@@ -30,6 +31,7 @@ config	SOC_IMX51
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_CPUIDLE
 	select ARCH_MX5
 
 config	SOC_IMX53
@@ -38,9 +40,11 @@ config	SOC_IMX53
 	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
+	select ARCH_HAS_CPUIDLE
 	select ARCH_MX5
 	select ARCH_MX53
 
+
 if ARCH_MX50_SUPPORTED
 #comment "i.MX50 machines:"
 
diff --git a/arch/arm/mach-mx5/include/mach/cpuidle.h b/arch/arm/mach-mx5/include/mach/cpuidle.h
new file mode 100644
index 0000000..6c37963
--- /dev/null
+++ b/arch/arm/mach-mx5/include/mach/cpuidle.h
@@ -0,0 +1,45 @@
+/*
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_ARM_PLAT_MXC_CPUIDLE_H__
+#define __ARCH_ARM_PLAT_MXC_CPUIDLE_H__
+
+
+/* CPUIDLE state parameters: name, description, exit_latency (us)
+ * exit_latencies were tested using i.MX51 running at 160MHz P-state
+ * for worst case latencies as to not cause a pm_qos violation when
+ * running at lower speeds.
+ */
+#define MXC_CPUIDLE_TABLE {\
+MXC_X_MACRO(POWERED_CLOCKED, "idle cpu clocked, powered.", 12),\
+MXC_X_MACRO(POWERED_NOCLOCK, "idle cpu powered, unclocked.", 14),\
+MXC_X_MACRO(NOPOWER_NOCLOCK, "idle cpu unpowered, unclocked.", 20),\
+MXC_X_MACRO(MXC_NUM_CPUIDLE_STATES, "", -1)}
+
+#define MXC_X_MACRO(a, b, c) a
+enum MXC_CPUIDLE_STATE_NAME MXC_CPUIDLE_TABLE;
+#undef MXC_X_MACRO
+
+struct imx_cpuidle_params {
+	unsigned int latency;
+};
+
+void imx_cpu_do_idle(int cpuidle_state_num);
+
+/* if you want to override the mach level params at the board level,
+ * define MXC_OVERRIDE_CPUIDLE_PARAMS and pass your board level paramaters
+ * into the imx_cpuidle_board_params function */
+
+/* #define MXC_OVERRIDE_DEFAULT_CPUIDLE_PARAMS */
+
+#ifdef CONFIG_MXC_CPUIDLE
+extern void imx_cpuidle_board_params(struct imx_cpuidle_params *cpuidle_params);
+#else
+inline void imx_cpuidle_board_params(struct imx_cpuidle_params *cpuidle_params)
+{}
+#endif
+
+#endif /* #ifndef __ARCH_ARM_PLAT_MXC_CPUIDLE_H__ */
diff --git a/arch/arm/mach-mx5/system.c b/arch/arm/mach-mx5/system.c
index 76ae8dc..6ff938d 100644
--- a/arch/arm/mach-mx5/system.c
+++ b/arch/arm/mach-mx5/system.c
@@ -12,9 +12,16 @@
  */
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <asm/proc-fns.h>
 #include <mach/hardware.h>
+#include <mach/mxc.h>
+#include <mach/cpuidle.h>
 #include "crm_regs.h"
 
+static int arch_idle_mode = WAIT_UNCLOCKED_POWER_OFF;
+static struct clk *gpc_dvfs_clk;
+
 /* set cpu low power mode before WFI instruction. This function is called
   * mx5 because it can be used for mx50, mx51, and mx53.*/
 void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
@@ -82,3 +89,38 @@ void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 		__raw_writel(empgc1, MXC_SRPG_EMPGC1_SRPGCR);
 	}
 }
+
+void imx_cpu_do_idle(int cpuidle_state_num)
+{
+
+	int local_arch_idle_mode = arch_idle_mode;
+
+	if (gpc_dvfs_clk == NULL)
+		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs_clk");
+	/* gpc clock is needed for SRPG */
+	clk_enable(gpc_dvfs_clk);
+
+	/* convert MXC_CPUIDLE_STATE_NAME to mxc_cpu_pwr_mode. */
+	switch (cpuidle_state_num) {
+	case POWERED_CLOCKED:
+		local_arch_idle_mode = WAIT_CLOCKED;
+		break;
+	case POWERED_NOCLOCK:
+		local_arch_idle_mode = WAIT_UNCLOCKED;
+		break;
+	case NOPOWER_NOCLOCK:
+		local_arch_idle_mode = WAIT_UNCLOCKED_POWER_OFF;
+		break;
+	default:
+		break;
+	}
+	/* prepare registers for upcoming idle mode */
+	mx5_cpu_lp_set(local_arch_idle_mode);
+
+	/* enter wfi state which on i.MX5 can trigger */
+	cpu_do_idle();
+
+	clk_disable(gpc_dvfs_clk);
+}
+
+
-- 
1.7.1
