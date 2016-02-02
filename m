From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  2 Feb 2016 19:18:06 -0200
Subject: [PATCH] ARM: mx25: Add basic suspend/resume support
Message-ID: <1454447886-4045-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Tested basic suspend/resume on a mx25pdk:

$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
$ echo mem > /sys/power/state

Then press any key in the serial console and the system wakes up.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/Makefile     |  2 +-
 arch/arm/mach-imx/common.h     |  1 +
 arch/arm/mach-imx/mach-imx25.c |  1 +
 arch/arm/mach-imx/pm-imx25.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/pm-imx25.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fb689d8..9fbe624 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -3,7 +3,7 @@ obj-y := cpu.o system.o irq-common.o
 obj-$(CONFIG_SOC_IMX1) += mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += mm-imx21.o
 
-obj-$(CONFIG_SOC_IMX25) += cpu-imx25.o mach-imx25.o
+obj-$(CONFIG_SOC_IMX25) += cpu-imx25.o mach-imx25.o pm-imx25.o
 
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += mm-imx27.o ehci-imx27.o
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 32b83f0..58a3846 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -66,6 +66,7 @@ void imx_gpc_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
+void imx25_pm_init(void);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
diff --git a/arch/arm/mach-imx/mach-imx25.c b/arch/arm/mach-imx/mach-imx25.c
index 9379fd0..32dcb5e 100644
--- a/arch/arm/mach-imx/mach-imx25.c
+++ b/arch/arm/mach-imx/mach-imx25.c
@@ -41,6 +41,7 @@ static const char * const imx25_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.init_early	= imx25_init_early,
+	.init_late      = imx25_pm_init,
 	.init_irq	= mx25_init_irq,
 	.dt_compat	= imx25_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/pm-imx25.c b/arch/arm/mach-imx/pm-imx25.c
new file mode 100644
index 0000000..cd27c4c
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx25.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2016 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/io.h>
+
+#ifdef CONFIG_PM
+static int imx25_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		cpu_do_idle();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#else
+static inline int imx25_suspend_enter(suspend_state_t state)
+{
+	return 0;
+}
+#endif
+
+static const struct platform_suspend_ops imx25_suspend_ops = {
+	.enter = imx25_suspend_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+void __init imx25_pm_init(void)
+{
+	suspend_set_ops(&imx25_suspend_ops);
+}
-- 
1.9.1
