From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 16:19:09 -0300
Subject: [PATCH] ARM: mx25: Add basic suspend/resume support
Message-ID: <1403723949-9183-1-git-send-email-festevam@gmail.com>
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
 arch/arm/mach-imx/Makefile   |  2 +-
 arch/arm/mach-imx/imx25-dt.c |  2 ++
 arch/arm/mach-imx/pm-imx25.c | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/pm-imx25.h | 13 +++++++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/pm-imx25.c
 create mode 100644 arch/arm/mach-imx/pm-imx25.h

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
index 42a65e0..39babdf 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -16,6 +16,7 @@
 #include <asm/mach/time.h>
 #include "common.h"
 #include "mx25.h"
+#include "pm-imx25.h"
 
 static void __init imx25_dt_init(void)
 {
@@ -38,6 +39,7 @@ DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
 	.init_irq	= mx25_init_irq,
+	.init_late      = mx25_pm_init,
 	.init_time	= imx25_timer_init,
 	.init_machine	= imx25_dt_init,
 	.dt_compat	= imx25_dt_board_compat,
diff --git a/arch/arm/mach-imx/pm-imx25.c b/arch/arm/mach-imx/pm-imx25.c
new file mode 100644
index 0000000..2463548
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx25.c
@@ -0,0 +1,35 @@
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
+#include "pm-imx25.h"
+
+static int mx25_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		cpu_do_idle();
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct platform_suspend_ops mx25_suspend_ops = {
+	.enter = mx25_suspend_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+void __init mx25_pm_init(void)
+{
+	suspend_set_ops(&mx25_suspend_ops);
+}
diff --git a/arch/arm/mach-imx/pm-imx25.h b/arch/arm/mach-imx/pm-imx25.h
new file mode 100644
index 0000000..41da794
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx25.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_PM
+void mx25_pm_init(void);
+#else
+#define mx25_pm_init NULL
+#endif
-- 
1.8.3.2
