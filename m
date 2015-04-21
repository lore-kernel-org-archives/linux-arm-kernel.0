From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 22 Apr 2015 05:43:26 +0800
Subject: [PATCH v6 07/11] ARM: imx: add msl support for imx7d
In-Reply-To: <1429652610-25265-1-git-send-email-Frank.Li@freescale.com>
References: <1429652610-25265-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1429652610-25265-8-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <b20788@freescale.com>

Add i.MX7D MSL support.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-imx/Kconfig      | 11 ++++++++++
 arch/arm/mach-imx/Makefile     |  1 +
 arch/arm/mach-imx/anatop.c     |  5 ++++-
 arch/arm/mach-imx/cpu.c        |  3 +++
 arch/arm/mach-imx/hardware.h   |  7 ++++++-
 arch/arm/mach-imx/mach-imx7d.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mx7.h        | 38 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mxc.h        |  8 +++++++-
 8 files changed, 116 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx7d.c
 create mode 100644 arch/arm/mach-imx/mx7.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3a3d3e9..162f2c3 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -582,6 +582,17 @@ config SOC_IMX6SX
 	help
 	  This enables support for Freescale i.MX6 SoloX processor.
 
+config SOC_IMX7
+	bool
+	select ARM_GIC
+
+config SOC_IMX7D
+	bool "i.MX7 Dual support"
+	select SOC_IMX7
+	select PINCTRL_IMX7D
+	help
+		This enables support for Freescale i.MX7 Dual processor.
+
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 3244cf1..3d9d755 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -90,6 +90,7 @@ endif
 obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o mach-imx6sx.o
+obj-$(CONFIG_SOC_IMX7D) += clk-imx7d.o mach-imx7d.o
 
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
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 76af2c0..747fe0b 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007, 2014 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2007, 2014-2015 Freescale Semiconductor, Inc.
  * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
  *
  * This program is free software; you can redistribute it and/or
@@ -93,6 +93,10 @@
  *	CCM	0x020c4000+0x004000	->	0xf42c4000+0x004000
  *	ANATOP	0x020c8000+0x004000	->	0xf42c8000+0x004000
  *	UART4	0x021f0000+0x004000	->	0xf42f0000+0x004000
+ * mx7d:
+ *	CCM	0x30380000+0x010000	->	0xf5380000+0x010000
+ *	ANATOP	0x30360000+0x010000	->	0xf5360000+0x010000
+ *	UART1	0x30860000+0x010000	->	0xf5860000+0x010000
  */
 #define IMX_IO_P2V(x)	(						\
 			(((x) & 0x80000000) >> 7) |			\
@@ -112,6 +116,7 @@
 #include "mx21.h"
 #include "mx27.h"
 #include "mx1.h"
+#include "mx7.h"
 
 #define imx_map_entry(soc, name, _type)	{				\
 	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
new file mode 100644
index 0000000..cca6ee6
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <linux/phy.h>
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
+	.restart	= mxc_restart,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mx7.h b/arch/arm/mach-imx/mx7.h
new file mode 100644
index 0000000..4aa673f
--- /dev/null
+++ b/arch/arm/mach-imx/mx7.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_MX7_IOMAP_H__
+#define __ASM_ARCH_MX7_IOMAP_H__
+
+#define MX7D_IO_P2V(x)                  IMX_IO_P2V(x)
+#define MX7D_IO_ADDRESS(x)              IOMEM(MX7D_IO_P2V(x))
+
+#define MX7D_CCM_BASE_ADDR              0x30380000
+#define MX7D_CCM_SIZE                   0x10000
+#define MX7D_IOMUXC_BASE_ADDR           0x30330000
+#define MX7D_IOMUXC_SIZE                0x10000
+#define MX7D_ANATOP_BASE_ADDR           0x30360000
+#define MX7D_ANATOP_SIZE                0x10000
+#define MX7D_GPC_BASE_ADDR              0x303a0000
+#define MX7D_GPC_SIZE                   0x10000
+#define MX7D_SRC_BASE_ADDR              0x30390000
+#define MX7D_SRC_SIZE                   0x10000
+#define MX7D_DDRC_BASE_ADDR             0x307a0000
+#define MX7D_DDRC_SIZE                  0x10000
+#define MX7D_AIPS1_BASE_ADDR            0x30000000
+#define MX7D_AIPS1_SIZE                 0x400000
+#define MX7D_AIPS2_BASE_ADDR            0x30400000
+#define MX7D_AIPS2_SIZE                 0x400000
+#define MX7D_AIPS3_BASE_ADDR            0x30900000
+#define MX7D_AIPS3_SIZE                 0x300000
+
+#define TT_ATTRIB_NON_CACHEABLE_1M	0x802
+#define MX7_IRAM_TLB_SIZE		0x4000
+#endif
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 4c1343d..e55c1e7 100644
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
 
 #define IMX_CHIP_REVISION_1_0		0x10
 #define IMX_CHIP_REVISION_1_1		0x11
@@ -185,6 +186,11 @@ static inline bool cpu_is_imx6q(void)
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
