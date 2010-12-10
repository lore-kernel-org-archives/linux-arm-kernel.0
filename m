From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:20 +0000
Subject: [PATCH v3 09/14] picoxcell: add support for pm
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-10-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PC3X3 devices support clock gating so provide support for PM on these
devices. We only support standby modes as we can't gate the ARM clock or
memory controllers.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile         |    1 +
 arch/arm/mach-picoxcell/picoxcell_core.c |    2 +
 arch/arm/mach-picoxcell/picoxcell_core.h |    9 ++
 arch/arm/mach-picoxcell/pm.c             |  146 ++++++++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 0 deletions(-)
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
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index 60bc878..7f6f3fd 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -277,4 +277,6 @@ void __init picoxcell_core_init(void)
 
 	if (picoxcell_has_feature(PICOXCELL_FEATURE_CPUFREQ))
 		WARN_ON(picoxcell_cpufreq_init());
+	if (picoxcell_has_feature(PICOXCELL_FEATURE_PM))
+		WARN_ON(picoxcell_pm_init());
 }
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.h b/arch/arm/mach-picoxcell/picoxcell_core.h
index f6d90bf..3a673cf 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.h
+++ b/arch/arm/mach-picoxcell/picoxcell_core.h
@@ -30,4 +30,13 @@ static inline int picoxcell_cpufreq_init(void)
 }
 # endif /* CONFIG_CPU_FREQ */
 
+# ifdef CONFIG_PM
+extern int __init picoxcell_pm_init(void);
+# else /* CONFIG_PM */
+static inline int picoxcell_pm_init(void)
+{
+	return 0;
+}
+# endif /* CONFIG_PM */
+
 #endif /* __ASM_ARCH_PICOXCELL_CORE_H__ */
diff --git a/arch/arm/mach-picoxcell/pm.c b/arch/arm/mach-picoxcell/pm.c
new file mode 100644
index 0000000..1aa591a
--- /dev/null
+++ b/arch/arm/mach-picoxcell/pm.c
@@ -0,0 +1,146 @@
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
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/suspend.h>
+
+#include <mach/hardware.h>
+
+#include "picoxcell_core.h"
+
+/*
+ * Clocks that aren't controlled by drivers and need to be explicitly
+ * controlled by the PM code. The clocks affected are:
+ *	- TZPC
+ *	- EBI
+ */
+static struct clk *tzpc_clk;
+static struct clk *ebi_clk;
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
+static void picoxcell_pm_disable_clks(void)
+{
+	pr_debug("disable ebi and tzpc clks\n");
+	clk_disable(tzpc_clk);
+	clk_disable(ebi_clk);
+
+#ifdef CONFIG_PC3X3_STOP_WDT_IN_SUSPEND
+	syscfg_update(1 << AXI2CFG_SYS_CONFIG_WDG_PAUSE_IDX,
+		      1 << AXI2CFG_SYS_CONFIG_WDG_PAUSE_IDX);
+#endif /* CONFIG_PC3X3_STOP_WDT_IN_SUSPEND */
+}
+
+static int picoxcell_pm_restore_clks(void)
+{
+	pr_debug("restore ebi and tzpc clks\n");
+
+	if (clk_enable(tzpc_clk)) {
+		pr_err("unable to restore tzpc clk\n");
+		return -EBUSY;
+	}
+
+	if (clk_enable(ebi_clk)) {
+		pr_err("unable to restore ebi clk\n");
+		return -EBUSY;
+	}
+
+#ifdef CONFIG_PC3X3_STOP_WDT_IN_SUSPEND
+	syscfg_update(1 << AXI2CFG_SYS_CONFIG_WDG_PAUSE_IDX, 0);
+#endif /* CONFIG_PC3X3_STOP_WDT_IN_SUSPEND */
+
+	return 0;
+}
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
+		picoxcell_pm_disable_clks();
+		wait_for_event();
+		/*
+		 * Reenable any clcoks that aren't controlled by drivers.
+		 */
+		err = picoxcell_pm_restore_clks();
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
+int __init picoxcell_pm_init(void)
+{
+	ebi_clk = clk_get(NULL, "ebi");
+	if (IS_ERR_OR_NULL(ebi_clk)) {
+		pr_warning("no ebi clock\n");
+		return -ENODEV;
+	}
+
+	tzpc_clk = clk_get(NULL, "tzprot_ctl");
+	if (IS_ERR_OR_NULL(tzpc_clk)) {
+		pr_warning("no tzpc clock\n");
+		goto tzpc_clk_fail;
+	}
+
+	suspend_set_ops(&picoxcell_pm_ops);
+
+	return 0;
+
+tzpc_clk_fail:
+	clk_put(ebi_clk);
+
+	return -ENODEV;
+}
-- 
1.7.2.3
