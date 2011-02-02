From: jamie@jamieiles.com (Jamie Iles)
Date: Wed,  2 Feb 2011 12:03:28 +0000
Subject: [PATCHv4 09/13] picoxcell: add support for pm
In-Reply-To: <1296648212-5284-1-git-send-email-jamie@jamieiles.com>
References: <1296648212-5284-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1296648212-5284-10-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PC3X3 devices support clock gating so provide support for PM on these
devices. We only support standby modes as we can't gate the ARM clock or
memory controllers.

v2:
	- move to an initcall and cleanup to remove uses of ebi and tzpc
	  clks.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile |    1 +
 arch/arm/mach-picoxcell/pm.c     |  112 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/pm.c

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index c0bbb25..f122a84 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -5,3 +5,4 @@ obj-y				:= picoxcell_core.o io.o axi2cfg.o \
 				   clk.o \
 				   devices.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
+obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/mach-picoxcell/pm.c b/arch/arm/mach-picoxcell/pm.c
new file mode 100644
index 0000000..489bba4
--- /dev/null
+++ b/arch/arm/mach-picoxcell/pm.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#define pr_fmt(fmt) "picoxcell_pm: " fmt
+#include <linux/init.h>
+#include <linux/suspend.h>
+
+#include <mach/hardware.h>
+
+#include "picoxcell_core.h"
+#include "soc.h"
+
+static int picoxcell_pm_valid(suspend_state_t state)
+{
+	/*
+	 * We only support standby mode. There is no point in doing anything
+	 * for PM_SUSPEND_MEM as we can't power down the core or the memory
+	 * interfaces.
+	 *
+	 * When we enter standby, the only thing we can do is power down some
+	 * of the peripherals.
+	 */
+	return (state == PM_SUSPEND_ON || state == PM_SUSPEND_STANDBY);
+}
+
+static void wait_for_event(void)
+{
+	pr_debug("entering sleep - wait for interrupt\n");
+	/*
+	 * Drain the writebuffer and wait for an interrupt.
+	 */
+	dsb();
+	asm volatile("mcr   p15, 0, %0, c7, c0, 4\n" : : "r"(0));
+}
+
+#ifdef CONFIG_PC3X3_STOP_WDT_IN_SUSPEND
+static inline void picoxcell_pm_stop_wdt(void)
+{
+	syscfg_update(1 << AXI2CFG_SYS_CONFIG_WDG_PAUSE_IDX,
+		      1 << AXI2CFG_SYS_CONFIG_WDG_PAUSE_IDX);
+}
+
+static inline int picoxcell_pm_restore_wdt(void)
+{
+	syscfg_update(1 << AXI2CFG_SYS_CONFIG_WDG_PAUSE_IDX, 0);
+
+	return 0;
+}
+#else /* CONFIG_PC3X3_STOP_WDT_IN_SUSPEND */
+static inline void picoxcell_pm_stop_wdt(void) {}
+
+static inline int picoxcell_pm_restore_wdt(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PC3X3_STOP_WDT_IN_SUSPEND */
+
+static int picoxcell_pm_enter(suspend_state_t state)
+{
+	int err = 0;
+
+	pr_debug("entering suspend state\n");
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		/*
+		 * Disable any clocks that aren't controlled by drivers but
+		 * need to be enabled. This includes the EBI, TZPC etc.
+		 */
+		picoxcell_pm_stop_wdt();
+		wait_for_event();
+		/*
+		 * Reenable any clcoks that aren't controlled by drivers.
+		 */
+		err = picoxcell_pm_restore_wdt();
+
+		break;
+
+	case PM_SUSPEND_ON:
+		wait_for_event();
+		break;
+
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	pr_debug("resumed\n");
+
+	return 0;
+}
+
+static struct platform_suspend_ops picoxcell_pm_ops = {
+	.valid	    = picoxcell_pm_valid,
+	.enter	    = picoxcell_pm_enter,
+};
+
+static int __init picoxcell_pm_init(void)
+{
+	if (!picoxcell_has_feature(PICOXCELL_FEATURE_PM))
+		return 0;
+
+	suspend_set_ops(&picoxcell_pm_ops);
+
+	return 0;
+}
+device_initcall(picoxcell_pm_init);
-- 
1.7.3.4
