From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 8 May 2015 01:35:55 +0800
Subject: [PATCH V8 3/6] ARM: imx: add msl support for imx7d
In-Reply-To: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
References: <1431020158-13789-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1431020158-13789-4-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <b20788@freescale.com>

Add i.MX7D MSL support.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-imx/Kconfig      |  7 +++++++
 arch/arm/mach-imx/Makefile     |  1 +
 arch/arm/mach-imx/anatop.c     |  5 ++++-
 arch/arm/mach-imx/cpu.c        |  3 +++
 arch/arm/mach-imx/mach-imx7d.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mxc.h        |  8 +++++++-
 6 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx7d.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3a3d3e9..1d87078 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -582,6 +582,13 @@ config SOC_IMX6SX
 	help
 	  This enables support for Freescale i.MX6 SoloX processor.
 
+config SOC_IMX7D
+	bool "i.MX7 Dual support"
+	select PINCTRL_IMX7D
+	select ARM_GIC
+	help
+		This enables support for Freescale i.MX7 Dual processor.
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0622ced..40df12a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -85,6 +85,7 @@ endif
 obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
+obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
 
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 7f262fe..231bb25 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -28,6 +28,7 @@
 #define ANADIG_USB2_CHRG_DETECT	0x210
 #define ANADIG_DIGPROG		0x260
 #define ANADIG_DIGPROG_IMX6SL	0x280
+#define ANADIG_DIGPROG_IMX7D	0x800
 
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
@@ -121,6 +122,8 @@ void __init imx_init_revision_from_anatop(void)
 	WARN_ON(!anatop_base);
 	if (of_device_is_compatible(np, "fsl,imx6sl-anatop"))
 		offset = ANADIG_DIGPROG_IMX6SL;
+	if (of_device_is_compatible(np, "fsl,imx7d-anatop"))
+		offset = ANADIG_DIGPROG_IMX7D;
 	digprog = readl_relaxed(anatop_base + offset);
 	iounmap(anatop_base);
 
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index df42c14..a7fa92a 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -130,6 +130,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6Q:
 		soc_id = "i.MX6Q";
 		break;
+	case MXC_CPU_IMX7D:
+		soc_id = "i.MX7D";
+		break;
 	default:
 		soc_id = "Unknown";
 	}
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
new file mode 100644
index 0000000..4d4a190
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include "common.h"
+
+static void __init imx7d_init_machine(void)
+{
+	struct device *parent;
+
+	parent = imx_soc_device_init();
+	if (parent == NULL)
+		pr_warn("failed to initialize soc device\n");
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	imx_anatop_init();
+}
+
+static void __init imx7d_init_irq(void)
+{
+	imx_init_revision_from_anatop();
+	imx_src_init();
+	irqchip_init();
+}
+
+static const char *imx7d_dt_compat[] __initconst = {
+	"fsl,imx7d",
+	NULL,
+};
+
+DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
+	.init_irq	= imx7d_init_irq,
+	.init_machine	= imx7d_init_machine,
+	.dt_compat	= imx7d_dt_compat,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 8726051..c4436d4 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007, 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2007, 2010-2015 Freescale Semiconductor, Inc.
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
  * This program is free software; you can redistribute it and/or
@@ -38,6 +38,7 @@
 #define MXC_CPU_IMX6DL		0x61
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
+#define MXC_CPU_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
 
@@ -169,6 +170,11 @@ static inline bool cpu_is_imx6q(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
 }
 
+static inline bool cpu_is_imx7d(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX7D;
+}
+
 struct cpu_op {
 	u32 cpu_rate;
 };
-- 
1.9.1
