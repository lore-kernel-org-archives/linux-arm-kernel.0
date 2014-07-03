From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Jul 2014 21:27:17 -0300
Subject: [PATCH v2] ARM: mx25: Add basic suspend/resume support
Message-ID: <1404347237-19665-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Tested basic suspend/resume on a mx25pdk:

root at freescale /$ echo mem > /sys/power/state 
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

(Press the keypad)

PM: suspend of devices complete after 5.637 msecs
PM: late suspend of devices complete after 1.649 msecs
PM: noirq suspend of devices complete after 1.874 msecs
PM: noirq resume of devices complete after 1.643 msecs
PM: early resume of devices complete after 1.923 msecs
PM: resume of devices complete after 62.884 msecs
Restarting tasks ... done.
fec 50038000.ethernet eth0: Link is Down
fec 50038000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
root at freescale /$ 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Change since v1:
- Fix blank lines
- Do not create a new file for storing the prototype

 arch/arm/mach-imx/Makefile   |  2 +-
 arch/arm/mach-imx/imx25-dt.c |  1 +
 arch/arm/mach-imx/mx25.h     |  2 ++
 arch/arm/mach-imx/pm-imx25.c | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/pm-imx25.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index a364e20..ddc28d4 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -3,7 +3,7 @@ obj-y := time.o cpu.o system.o irq-common.o
 obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
 
-obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
+obj-$(CONFIG_SOC_IMX25) += clk-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o pm-imx25.o
 
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clk-imx27.o mm-imx27.o ehci-imx27.o
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index cf8032b..2872ef7 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -33,6 +33,7 @@ DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
 	.init_irq	= mx25_init_irq,
+	.init_late      = imx25_pm_init,
 	.init_machine	= imx25_dt_init,
 	.dt_compat	= imx25_dt_board_compat,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mx25.h b/arch/arm/mach-imx/mx25.h
index ec46640..0bb5894 100644
--- a/arch/arm/mach-imx/mx25.h
+++ b/arch/arm/mach-imx/mx25.h
@@ -114,4 +114,6 @@
 extern int mx25_revision(void);
 #endif
 
+void imx25_pm_init(void);
+
 #endif /* ifndef __MACH_MX25_H__ */
diff --git a/arch/arm/mach-imx/pm-imx25.c b/arch/arm/mach-imx/pm-imx25.c
new file mode 100644
index 0000000..560baba
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx25.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2014 Freescale Semiconductor, Inc.
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
+static int mx25_suspend_enter(suspend_state_t state)
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
+static inline int mx25_suspend_enter(suspend_state_t state)
+{
+	return 0;
+}
+#endif
+
+static const struct platform_suspend_ops mx25_suspend_ops = {
+	.enter = mx25_suspend_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+void __init imx25_pm_init(void)
+{
+	suspend_set_ops(&mx25_suspend_ops);
+}
-- 
1.8.3.2
