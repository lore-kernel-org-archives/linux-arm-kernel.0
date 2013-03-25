From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:22:51 +0800
Subject: [PATCH 3/3] ARM: mxs: move icoll driver into drivers/irqchip
In-Reply-To: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
References: <1364224971-28431-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364224971-28431-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move icoll.c into drivers/irqchip as irq-mxs.c, and along with the
renaming, change the driver to use IRQCHIP_DECLARE.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/include/mach/common.h            |    3 ---
 arch/arm/mach-mxs/mach-mxs.c                       |    6 ++++--
 drivers/irqchip/Makefile                           |    1 +
 .../mach-mxs/icoll.c => drivers/irqchip/irq-mxs.c  |   13 +++----------
 include/linux/irqchip/mxs.h                        |   14 ++++++++++++++
 6 files changed, 23 insertions(+), 16 deletions(-)
 rename arch/arm/mach-mxs/icoll.c => drivers/irqchip/irq-mxs.c (94%)
 create mode 100644 include/linux/irqchip/mxs.h

diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 76c336e..b934603 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,5 +1,5 @@
 # Common support
-obj-y := icoll.o ocotp.o system.o mm.o
+obj-y := ocotp.o system.o mm.o
 
 obj-$(CONFIG_PM) += pm.o
 
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index e043c47..df2a4ef 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -22,7 +22,4 @@ extern void mx23_map_io(void);
 extern int mx28_clocks_init(void);
 extern void mx28_map_io(void);
 
-extern void icoll_init_irq(void);
-extern void icoll_handle_irq(struct pt_regs *);
-
 #endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 796c5dd..79a5ce4 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -18,6 +18,8 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/mxs.h>
 #include <linux/micrel_phy.h>
 #include <linux/mxsfb.h>
 #include <linux/of_platform.h>
@@ -469,7 +471,7 @@ static const char *imx28_dt_compat[] __initdata = {
 
 DT_MACHINE_START(IMX23, "Freescale i.MX23 (Device Tree)")
 	.map_io		= mx23_map_io,
-	.init_irq	= icoll_init_irq,
+	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= imx23_timer_init,
 	.init_machine	= mxs_machine_init,
@@ -479,7 +481,7 @@ MACHINE_END
 
 DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
 	.map_io		= mx28_map_io,
-	.init_irq	= icoll_init_irq,
+	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= imx28_timer_init,
 	.init_machine	= mxs_machine_init,
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 98e3b87..9d8f4f1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
diff --git a/arch/arm/mach-mxs/icoll.c b/drivers/irqchip/irq-mxs.c
similarity index 94%
rename from arch/arm/mach-mxs/icoll.c
rename to drivers/irqchip/irq-mxs.c
index b4d6207..29889bb 100644
--- a/arch/arm/mach-mxs/icoll.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -27,6 +27,8 @@
 #include <linux/stmp_device.h>
 #include <asm/exception.h>
 
+#include "irqchip.h"
+
 #define HW_ICOLL_VECTOR				0x0000
 #define HW_ICOLL_LEVELACK			0x0010
 #define HW_ICOLL_CTRL				0x0020
@@ -116,13 +118,4 @@ static void __init icoll_of_init(struct device_node *np,
 					     &icoll_irq_domain_ops, NULL);
 	WARN_ON(!icoll_domain);
 }
-
-static const struct of_device_id icoll_of_match[] __initconst = {
-	{.compatible = "fsl,icoll", .data = icoll_of_init},
-	{ /* sentinel */ }
-};
-
-void __init icoll_init_irq(void)
-{
-	of_irq_init(icoll_of_match);
-}
+IRQCHIP_DECLARE(mxs, "fsl,icoll", icoll_of_init);
diff --git a/include/linux/irqchip/mxs.h b/include/linux/irqchip/mxs.h
new file mode 100644
index 0000000..9039a53
--- /dev/null
+++ b/include/linux/irqchip/mxs.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_IRQCHIP_MXS_H
+#define __LINUX_IRQCHIP_MXS_H
+
+extern void icoll_handle_irq(struct pt_regs *);
+
+#endif
-- 
1.7.9.5
