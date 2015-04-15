From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 16 Apr 2015 06:30:12 +0800
Subject: [PATCH 3/7] ARM: imx: add msl support for imx7d
In-Reply-To: <1429137016-21816-1-git-send-email-Frank.Li@freescale.com>
References: <1429137016-21816-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1429137016-21816-4-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <b20788@freescale.com>

Add i.MX7D MSL support.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-imx/Kconfig      | 11 +++++++++
 arch/arm/mach-imx/Makefile     |  1 +
 arch/arm/mach-imx/anatop.c     | 33 +++++++++++++++++++++++++-
 arch/arm/mach-imx/common.h     |  1 +
 arch/arm/mach-imx/cpu.c        | 10 ++++++++
 arch/arm/mach-imx/hardware.h   |  7 +++++-
 arch/arm/mach-imx/mach-imx7d.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mx7.h        | 38 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mxc.h        | 15 +++++++++++-
 arch/arm/mach-imx/platsmp.c    | 24 ++++++++++++++++++-
 10 files changed, 189 insertions(+), 4 deletions(-)
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
index 7f262fe..12ca5a9 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -21,6 +21,12 @@
 #define REG_SET		0x4
 #define REG_CLR		0x8
 
+#define ANADIG_ARM_PLL		0x60
+#define ANADIG_DDR_PLL		0x70
+#define ANADIG_SYS_PLL		0xb0
+#define ANADIG_ENET_PLL		0xe0
+#define ANADIG_AUDIO_PLL	0xf0
+#define ANADIG_VIDEO_PLL	0x130
 #define ANADIG_REG_2P5		0x130
 #define ANADIG_REG_CORE		0x140
 #define ANADIG_ANA_MISC0	0x150
@@ -28,6 +34,7 @@
 #define ANADIG_USB2_CHRG_DETECT	0x210
 #define ANADIG_DIGPROG		0x260
 #define ANADIG_DIGPROG_IMX6SL	0x280
+#define ANADIG_DIGPROG_IMX7D	0x800
 
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
@@ -73,6 +80,17 @@ static inline void imx_anatop_disconnect_high_snvs(bool enable)
 
 void imx_anatop_pre_suspend(void)
 {
+	if (cpu_is_imx7d()) {
+		/* PLL overwrite set */
+		regmap_write(anatop, ANADIG_ARM_PLL + REG_SET, 1 << 20);
+		regmap_write(anatop, ANADIG_DDR_PLL + REG_SET, 1 << 19);
+		regmap_write(anatop, ANADIG_SYS_PLL + REG_SET, 1 << 17);
+		regmap_write(anatop, ANADIG_ENET_PLL + REG_SET, 1 << 13);
+		regmap_write(anatop, ANADIG_AUDIO_PLL + REG_SET, 1 << 24);
+		regmap_write(anatop, ANADIG_VIDEO_PLL + REG_SET, 1 << 24);
+		return;
+	}
+
 	if (imx_mmdc_get_ddr_type() == IMX_DDR_TYPE_LPDDR2)
 		imx_anatop_enable_2p5_pulldown(true);
 	else
@@ -86,6 +104,17 @@ void imx_anatop_pre_suspend(void)
 
 void imx_anatop_post_resume(void)
 {
+	if (cpu_is_imx7d()) {
+		/* PLL overwrite clear */
+		regmap_write(anatop, ANADIG_ARM_PLL + REG_CLR, 1 << 20);
+		regmap_write(anatop, ANADIG_DDR_PLL + REG_CLR, 1 << 19);
+		regmap_write(anatop, ANADIG_SYS_PLL + REG_CLR, 1 << 17);
+		regmap_write(anatop, ANADIG_ENET_PLL + REG_CLR, 1 << 13);
+		regmap_write(anatop, ANADIG_AUDIO_PLL + REG_CLR, 1 << 24);
+		regmap_write(anatop, ANADIG_VIDEO_PLL + REG_CLR, 1 << 24);
+		return;
+	}
+
 	if (imx_mmdc_get_ddr_type() == IMX_DDR_TYPE_LPDDR2)
 		imx_anatop_enable_2p5_pulldown(false);
 	else
@@ -121,6 +150,8 @@ void __init imx_init_revision_from_anatop(void)
 	WARN_ON(!anatop_base);
 	if (of_device_is_compatible(np, "fsl,imx6sl-anatop"))
 		offset = ANADIG_DIGPROG_IMX6SL;
+	if (of_device_is_compatible(np, "fsl,imx7d-anatop"))
+		offset = ANADIG_DIGPROG_IMX7D;
 	digprog = readl_relaxed(anatop_base + offset);
 	iounmap(anatop_base);
 
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 0f04e30..c8ef395 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -54,6 +54,7 @@ int mx31_clocks_init_dt(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 void mxc_set_cpu_type(unsigned int type);
+void mxc_set_arch_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
 int mx51_revision(void);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index df42c14..4e84a7a 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -11,6 +11,8 @@
 
 unsigned int __mxc_cpu_type;
 EXPORT_SYMBOL(__mxc_cpu_type);
+unsigned int __mxc_arch_type;
+EXPORT_SYMBOL(__mxc_arch_type);
 
 static unsigned int imx_soc_revision;
 
@@ -19,6 +21,11 @@ void mxc_set_cpu_type(unsigned int type)
 	__mxc_cpu_type = type;
 }
 
+void mxc_set_arch_type(unsigned int type)
+{
+	__mxc_arch_type = type;
+}
+
 void imx_set_soc_revision(unsigned int rev)
 {
 	imx_soc_revision = rev;
@@ -130,6 +137,9 @@ struct device * __init imx_soc_device_init(void)
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
  * Copyright 2008 Juergen Beisert, kernel@pengutronix.de
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
index 0000000..5a9c47e6
--- /dev/null
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -0,0 +1,53 @@
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
+static void __init imx7d_map_io(void)
+{
+	debug_ll_io_init();
+}
+
+DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
+	.map_io		= imx7d_map_io,
+	.smp            = smp_ops(imx_smp_ops),
+	.init_irq	= imx7d_init_irq,
+	.init_machine	= imx7d_init_machine,
+	.dt_compat	= imx7d_dt_compat,
+	.restart	= mxc_restart,
+MACHINE_END
diff --git a/arch/arm/mach-imx/mx7.h b/arch/arm/mach-imx/mx7.h
new file mode 100644
index 0000000..bfef936
--- /dev/null
+++ b/arch/arm/mach-imx/mx7.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ *  * This program is free software; you can redistribute it and/or modify
+ *   * it under the terms of the GNU General Public License version 2 as
+ *    * published by the Free Software Foundation.
+ *     */
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
index 4c1343d..2d5e19e 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007, 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2007, 2010-2015 Freescale Semiconductor, Inc.
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
  * This program is free software; you can redistribute it and/or
@@ -38,6 +38,8 @@
 #define MXC_CPU_IMX6DL		0x61
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
+#define MXC_CPU_IMX7D		0x72
+#define MXC_ARCH_CA7		0xc07
 
 #define IMX_CHIP_REVISION_1_0		0x10
 #define IMX_CHIP_REVISION_1_1		0x11
@@ -59,6 +61,7 @@
 
 #ifndef __ASSEMBLY__
 extern unsigned int __mxc_cpu_type;
+extern unsigned int __mxc_arch_type;
 #endif
 
 #ifdef CONFIG_SOC_IMX1
@@ -185,6 +188,16 @@ static inline bool cpu_is_imx6q(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
 }
 
+static inline bool cpu_is_imx7d(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX7D;
+}
+
+static inline bool arm_is_ca7(void)
+{
+	return __mxc_arch_type == MXC_ARCH_CA7;
+}
+
 struct cpu_op {
 	u32 cpu_rate;
 };
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7f27001..2ca4a41 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -60,11 +60,33 @@ static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 static void __init imx_smp_init_cpus(void)
 {
 	int i, ncores;
+	unsigned long arch_type;
 
-	ncores = scu_get_core_count(scu_base);
+	asm volatile(
+		".align 4\n"
+		"mrc p15, 0, %0, c0, c0, 0\n"
+		: "=r" (arch_type)
+	);
+
+	/* MIDR[15:4] defines ARCH type */
+	mxc_set_arch_type((arch_type >> 4) & 0xfff);
+
+	if (arm_is_ca7()) {
+		unsigned long val;
+
+		/* CA7 core number, [25:24] of CP15 L2CTLR */
+		asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
+		ncores = ((val >> 24) & 0x3) + 1;
+	} else {
+		ncores = scu_get_core_count(scu_base);
+	}
+
+	if (setup_max_cpus < ncores)
+		ncores = (setup_max_cpus) ? setup_max_cpus : 1;
 
 	for (i = ncores; i < NR_CPUS; i++)
 		set_cpu_possible(i, false);
+
 }
 
 void imx_smp_prepare(void)
-- 
1.9.1
