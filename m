From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 12:49:07 -0300
Subject: [PATCH v3 2/2] ARM: kirkwood: Add standby support
In-Reply-To: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377186547-14284-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implements standby support for Kirkwood SoC. When the SoC enters
standby state the memory PM units are disabled, the DDR is set
in self-refresh mode, and the CPU is set in WFI.

At this point there's no clock gating, as that is considered each
driver's task.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-kirkwood/Makefile                   |  2 +
 arch/arm/mach-kirkwood/board-dt.c                 |  1 +
 arch/arm/mach-kirkwood/common.c                   |  1 +
 arch/arm/mach-kirkwood/common.h                   |  6 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
 arch/arm/mach-kirkwood/pm.c                       | 73 +++++++++++++++++++++++
 6 files changed, 85 insertions(+)
 create mode 100644 arch/arm/mach-kirkwood/pm.c

diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index ac4cd75..ac78dcc 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,4 +1,6 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
+obj-$(CONFIG_PM)		+= pm.o
+
 
 obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 6e122ed..2d4a4aa 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -96,6 +96,7 @@ static void __init kirkwood_dt_init(void)
 	/* Setup root of clk tree */
 	kirkwood_of_clk_init();
 
+	kirkwood_pm_init();
 	kirkwood_cpuidle_init();
 
 #ifdef CONFIG_KEXEC
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index e9238b5..aceb68a 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -717,6 +717,7 @@ void __init kirkwood_init(void)
 	kirkwood_xor1_init();
 	kirkwood_crypto_init();
 
+	kirkwood_pm_init();
 	kirkwood_cpuidle_init();
 #ifdef CONFIG_KEXEC
 	kexec_reinit = kirkwood_enable_pcie;
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index fcf3ba6..2be1226 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -58,6 +58,12 @@ void kirkwood_cpufreq_init(void);
 void kirkwood_restart(enum reboot_mode, const char *);
 void kirkwood_clk_init(void);
 
+#ifdef CONFIG_PM
+void kirkwood_pm_init(void);
+#else
+static inline void kirkwood_pm_init(void) {};
+#endif
+
 /* board init functions for boards not fully converted to fdt */
 #ifdef CONFIG_MACH_DREAMPLUG_DT
 void dreamplug_init(void);
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 91242c9..8b9d1c9 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -78,4 +78,6 @@
 #define CGC_TDM			(1 << 20)
 #define CGC_RESERVED		(0x6 << 21)
 
+#define MEMORY_PM_CTRL		(BRIDGE_VIRT_BASE + 0x118)
+
 #endif
diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
new file mode 100644
index 0000000..8783a71
--- /dev/null
+++ b/arch/arm/mach-kirkwood/pm.c
@@ -0,0 +1,73 @@
+/*
+ * Power Management driver for Marvell Kirkwood SoCs
+ *
+ * Copyright (C) 2013 Ezequiel Garcia <ezequiel@free-electrons.com>
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License,
+ * version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/io.h>
+#include <mach/bridge-regs.h>
+
+static void __iomem *ddr_operation_base;
+
+static void kirkwood_low_power(void)
+{
+	u32 mem_pm_ctrl;
+
+	mem_pm_ctrl = readl(MEMORY_PM_CTRL);
+
+	/* Set peripherals to low-power mode */
+	writel_relaxed(~0, MEMORY_PM_CTRL);
+
+	/* Set DDR in self-refresh */
+	writel_relaxed(0x7, ddr_operation_base);
+
+	/*
+	 * Set CPU in wait-for-interrupt state.
+	 * This disables the CPU core clocks,
+	 * the array clocks, and also the L2 controller.
+	 */
+	cpu_do_idle();
+
+	writel_relaxed(mem_pm_ctrl, MEMORY_PM_CTRL);
+}
+
+static int kirkwood_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		kirkwood_low_power();
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int kirkwood_pm_valid_standby(suspend_state_t state)
+{
+	return state == PM_SUSPEND_STANDBY;
+}
+
+static const struct platform_suspend_ops kirkwood_suspend_ops = {
+	.enter = kirkwood_suspend_enter,
+	.valid = kirkwood_pm_valid_standby,
+};
+
+int __init kirkwood_pm_init(void)
+{
+	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
+	suspend_set_ops(&kirkwood_suspend_ops);
+	return 0;
+}
-- 
1.8.1.5
