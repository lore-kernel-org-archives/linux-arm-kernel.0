From: b20788@freescale.com (Anson Huang)
Date: Mon, 6 Jan 2014 15:55:37 -0500
Subject: [PATCH 1/3] ARM: imx: add suspend in ocram support on i.mx6q
Message-ID: <1389041739-18389-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When system enter suspend, we can set the DDR IO
to high-Z state to save DDR IO's power, this operation
can save many power(from ~26mA at 1.5V to ~15mA at 1.5V,
measured on i.MX6Q/DL SabreSD board, R25) of DDR IO. To
achieve that, we need to copy the suspend code to ocram
and run the low level hardware related code(set DDR IO
to high-Z) in ocram.

If there is no ocram space available, then system will
still do suspend in DDR, hence no DDR IO will be set
to high-Z.

The OCRAM usage layout is as below,

ocram suspend region:
	ADDRESS HIGH
        .  ocram stack for saving necessary data
        .                    v
        .                    v
        .                    .
  4K    .                    .
        .                    .
        .                    ^
        .                    ^
        .              low level code
	ADDRESS LOW

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/Makefile       |    3 +-
 arch/arm/mach-imx/common.h       |    6 +-
 arch/arm/mach-imx/hardware.h     |    5 +-
 arch/arm/mach-imx/mach-imx6q.c   |    3 +-
 arch/arm/mach-imx/mx6q.h         |   31 +++
 arch/arm/mach-imx/pm-imx6q.c     |   84 +++++++-
 arch/arm/mach-imx/suspend-imx6.S |  424 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 549 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-imx/mx6q.h
 create mode 100644 arch/arm/mach-imx/suspend-imx6.S

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0db1697..61770b9 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -101,7 +101,8 @@ obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
 ifeq ($(CONFIG_PM),y)
-obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
+AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
+obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o suspend-imx6.o
 # i.MX6SL reuses i.MX6Q code
 obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
 endif
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 59c3b9b..2b0151f 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2014 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -145,10 +145,14 @@ void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_PM
+void imx6_suspend(void);
+void imx6_pm_map_io(void);
 void imx6q_pm_init(void);
 void imx6q_pm_set_ccm_base(void __iomem *base);
 void imx5_pm_init(void);
 #else
+static inline void imx6_suspend(void) {}
+static inline void imx6_pm_map_io(void) {}
 static inline void imx6q_pm_init(void) {}
 static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
 static inline void imx5_pm_init(void) {}
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index a3b0b04..a43975c 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2007, 2014 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
  *
  * This program is free software; you can redistribute it and/or
@@ -20,7 +20,9 @@
 #ifndef __ASM_ARCH_MXC_HARDWARE_H__
 #define __ASM_ARCH_MXC_HARDWARE_H__
 
+#ifndef __ASSEMBLY__
 #include <asm/io.h>
+#endif
 #include <asm/sizes.h>
 
 #define addr_in_module(addr, mod) \
@@ -105,6 +107,7 @@
 
 #include "mx51.h"
 #include "mx53.h"
+#include "mx6q.h"
 #include "mx3x.h"
 #include "mx31.h"
 #include "mx35.h"
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d2ea6e6..281e4d0 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011-2013 Freescale Semiconductor, Inc.
+ * Copyright 2011-2014 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -262,6 +262,7 @@ static void __init imx6q_map_io(void)
 {
 	debug_ll_io_init();
 	imx_scu_map_io();
+	imx6_pm_map_io();
 }
 
 static void __init imx6q_init_irq(void)
diff --git a/arch/arm/mach-imx/mx6q.h b/arch/arm/mach-imx/mx6q.h
new file mode 100644
index 0000000..fa4634f
--- /dev/null
+++ b/arch/arm/mach-imx/mx6q.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2004-2014 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MX6Q_H__
+#define __MACH_MX6Q_H__
+
+#define MX6Q_IO_P2V(x)			IMX_IO_P2V(x)
+#define MX6Q_IO_ADDRESS(x)		IOMEM(MX6Q_IO_P2V(x))
+
+#define MX6Q_L2_BASE_ADDR		0x00a02000
+#define MX6Q_L2_SIZE			0x1000
+#define MX6Q_IOMUXC_BASE_ADDR		0x020e0000
+#define MX6Q_IOMUXC_SIZE		0x4000
+#define MX6Q_SRC_BASE_ADDR		0x020d8000
+#define MX6Q_SRC_SIZE			0x4000
+#define MX6Q_CCM_BASE_ADDR		0x020c4000
+#define MX6Q_CCM_SIZE			0x4000
+#define MX6Q_GPC_BASE_ADDR		0x020dc000
+#define MX6Q_GPC_SIZE			0x4000
+#define MX6Q_MMDC_P0_BASE_ADDR		0x021b0000
+#define MX6Q_MMDC_P0_SIZE		0x4000
+
+#define MX6Q_SUSPEND_IRAM_SIZE		0x1000
+#endif
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 31cb9d6..e85e08e 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011-2013 Freescale Semiconductor, Inc.
+ * Copyright 2011-2014 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -18,12 +18,17 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
+#include <linux/genalloc.h>
 #include <asm/cacheflush.h>
+#include <asm/fncpy.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/map.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
-#include <asm/hardware/cache-l2x0.h>
+#include <asm/tlb.h>
 
 #include "common.h"
 #include "hardware.h"
@@ -59,6 +64,11 @@
 #define BM_CGPR_CHICKEN_BIT		(0x1 << 17)
 
 static void __iomem *ccm_base;
+static void *suspend_ocram_base;
+static unsigned int cpu_type;
+static unsigned long ocram_paddr;
+static struct gen_pool *ocram_pool;
+static int (*imx6_suspend_in_ocram_fn)(void *ocram_vbase, unsigned long ocram_pbase, unsigned int cpu_type);
 
 void imx6q_set_chicken_bit(void)
 {
@@ -174,7 +184,17 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 
 static int imx6q_suspend_finish(unsigned long val)
 {
-	cpu_do_idle();
+	if (!imx6_suspend_in_ocram_fn) {
+		cpu_do_idle();
+	} else {
+		/*
+		 * call low level suspend function in ocram,
+		 * as we need to float DDR IO.
+		 */
+		local_flush_tlb_all();
+		imx6_suspend_in_ocram_fn(suspend_ocram_base, ocram_paddr, cpu_type);
+	}
+
 	return 0;
 }
 
@@ -215,10 +235,68 @@ void __init imx6q_pm_set_ccm_base(void __iomem *base)
 	ccm_base = base;
 }
 
+static struct map_desc imx6_pm_io_desc[] __initdata = {
+	imx_map_entry(MX6Q, MMDC_P0, MT_DEVICE),
+	imx_map_entry(MX6Q, SRC, MT_DEVICE),
+	imx_map_entry(MX6Q, IOMUXC, MT_DEVICE),
+	imx_map_entry(MX6Q, CCM, MT_DEVICE),
+	imx_map_entry(MX6Q, GPC, MT_DEVICE),
+	imx_map_entry(MX6Q, L2, MT_DEVICE),
+};
+
+void __init imx6_pm_map_io(void)
+{
+	iotable_init(imx6_pm_io_desc, ARRAY_SIZE(imx6_pm_io_desc));
+}
+
 void __init imx6q_pm_init(void)
 {
+	unsigned long ocram_base;
+	struct device_node *node;
+	struct platform_device *pdev;
 	struct regmap *gpr;
 
+	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
+	if (!node) {
+		pr_warn("failed to find ocram node!\n");
+		goto ocram_out;
+	}
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev) {
+		pr_warn("failed to find ocram device!\n");
+		goto ocram_out;
+	}
+
+	ocram_pool = dev_get_gen_pool(&pdev->dev);
+	if (!ocram_pool) {
+		pr_warn("ocram pool unavailable!\n");
+		goto ocram_out;
+	}
+
+	ocram_base = gen_pool_alloc(ocram_pool, MX6Q_SUSPEND_IRAM_SIZE);
+	if (!ocram_base) {
+		pr_warn("unable to alloc ocram!\n");
+		goto ocram_out;
+	}
+
+	ocram_paddr = gen_pool_virt_to_phys(ocram_pool, ocram_base);
+
+	suspend_ocram_base = __arm_ioremap(ocram_paddr, MX6Q_SUSPEND_IRAM_SIZE,
+			MT_MEMORY_RWX_NONCACHED);
+
+	imx6_suspend_in_ocram_fn = (void *)fncpy(suspend_ocram_base,
+		&imx6_suspend, MX6Q_SUSPEND_IRAM_SIZE);
+
+	/* Set cpu_type for DSM */
+	if (cpu_is_imx6q())
+		cpu_type = MXC_CPU_IMX6Q;
+	else if (cpu_is_imx6dl())
+		cpu_type = MXC_CPU_IMX6DL;
+	else
+		cpu_type = MXC_CPU_IMX6SL;
+
+ocram_out:
 	WARN_ON(!ccm_base);
 
 	/*
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
new file mode 100644
index 0000000..2ae0354
--- /dev/null
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -0,0 +1,424 @@
+/*
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/linkage.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "hardware.h"
+
+#define MX6Q_SRC_GPR1	0x20
+#define MX6Q_SRC_GPR2	0x24
+#define MX6Q_MMDC_MAPSR	0x404
+#define MX6Q_GPC_IMR1	0x08
+#define MX6Q_GPC_IMR2	0x0c
+#define MX6Q_GPC_IMR3	0x10
+#define MX6Q_GPC_IMR4	0x14
+#define MX6Q_CCM_CCR	0x0
+
+	.align 3
+
+	.macro	imx6dq_ddr_io_save
+
+	ldr	r4, [r8, #0x5ac] /* DRAM_DQM0 */
+	ldr	r5, [r8, #0x5b4] /* DRAM_DQM1 */
+	ldr	r6, [r8, #0x528] /* DRAM_DQM2 */
+	ldr	r7, [r8, #0x520] /* DRAM_DQM3 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x514] /* DRAM_DQM4 */
+	ldr	r5, [r8, #0x510] /* DRAM_DQM5 */
+	ldr	r6, [r8, #0x5bc] /* DRAM_DQM6 */
+	ldr	r7, [r8, #0x5c4] /* DRAM_DQM7 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x56c] /* DRAM_CAS */
+	ldr	r5, [r8, #0x578] /* DRAM_RAS */
+	ldr	r6, [r8, #0x588] /* DRAM_SDCLK_0 */
+	ldr	r7, [r8, #0x594] /* DRAM_SDCLK_1 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r5, [r8, #0x750] /* DDRMODE_CTL */
+	ldr	r6, [r8, #0x774] /* DDRMODE */
+	stmfd	r10!, {r5-r6}
+
+	ldr	r4, [r8, #0x5a8] /* DRAM_SDQS0 */
+	ldr	r5, [r8, #0x5b0] /* DRAM_SDQS1 */
+	ldr	r6, [r8, #0x524] /* DRAM_SDQS2 */
+	ldr	r7, [r8, #0x51c] /* DRAM_SDQS3 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x518] /* DRAM_SDQS4 */
+	ldr	r5, [r8, #0x50c] /* DRAM_SDQS5 */
+	ldr	r6, [r8, #0x5b8] /* DRAM_SDQS6 */
+	ldr	r7, [r8, #0x5c0] /* DRAM_SDQS7 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x784] /* GPR_B0DS */
+	ldr	r5, [r8, #0x788] /* GPR_B1DS */
+	ldr	r6, [r8, #0x794] /* GPR_B2DS */
+	ldr	r7, [r8, #0x79c] /* GPR_B3DS */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x7a0] /* GPR_B4DS */
+	ldr	r5, [r8, #0x7a4] /* GPR_B5DS */
+	ldr	r6, [r8, #0x7a8] /* GPR_B6DS */
+	ldr	r7, [r8, #0x748] /* GPR_B7DS */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r5, [r8, #0x74c] /* GPR_ADDS*/
+	ldr	r6, [r8, #0x59c] /* DRAM_SODT0*/
+	ldr	r7, [r8, #0x5a0] /* DRAM_SODT1*/
+	stmfd	r10!, {r5-r7}
+
+	.endm
+
+	.macro	imx6dq_ddr_io_restore
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x5ac] /* DRAM_DQM0 */
+	str	r5, [r8, #0x5b4] /* DRAM_DQM1 */
+	str	r6, [r8, #0x528] /* DRAM_DQM2 */
+	str	r7, [r8, #0x520] /* DRAM_DQM3 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x514] /* DRAM_DQM4 */
+	str	r5, [r8, #0x510] /* DRAM_DQM5 */
+	str	r6, [r8, #0x5bc] /* DRAM_DQM6 */
+	str	r7, [r8, #0x5c4] /* DRAM_DQM7 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x56c] /* DRAM_CAS */
+	str	r5, [r8, #0x578] /* DRAM_RAS */
+	str	r6, [r8, #0x588] /* DRAM_SDCLK_0 */
+	str	r7, [r8, #0x594] /* DRAM_SDCLK_1 */
+
+	ldmea	r10!, {r5-r6}
+	str	r5, [r8, #0x750] /* DDRMODE_CTL */
+	str	r6, [r8, #0x774] /* DDRMODE */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x5a8] /* DRAM_SDQS0 */
+	str	r5, [r8, #0x5b0] /* DRAM_SDQS1 */
+	str	r6, [r8, #0x524] /* DRAM_SDQS2 */
+	str	r7, [r8, #0x51c] /* DRAM_SDQS3 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x518] /* DRAM_SDQS4 */
+	str	r5, [r8, #0x50c] /* DRAM_SDQS5 */
+	str	r6, [r8, #0x5b8] /* DRAM_SDQS6 */
+	str	r7, [r8, #0x5c0] /* DRAM_SDQS7 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x784] /* GPR_B0DS */
+	str	r5, [r8, #0x788] /* GPR_B1DS */
+	str	r6, [r8, #0x794] /* GPR_B2DS */
+	str	r7, [r8, #0x79c] /* GPR_B3DS */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x7a0] /* GPR_B4DS */
+	str	r5, [r8, #0x7a4] /* GPR_B5DS */
+	str	r6, [r8, #0x7a8] /* GPR_B6DS */
+	str	r7, [r8, #0x748] /* GPR_B7DS */
+
+	ldmea	r10!, {r5-r7}
+	str	r5, [r8, #0x74c] /* GPR_ADDS*/
+	str	r6, [r8, #0x59c] /* DRAM_SODT0*/
+	str	r7, [r8, #0x5a0] /* DRAM_SODT1*/
+
+	.endm
+
+	.macro	imx6dq_ddr_io_set_lpm
+
+	mov	r10, #0
+	str	r10, [r8, #0x5ac] /* DRAM_DQM0 */
+	str	r10, [r8, #0x5b4] /* DRAM_DQM1 */
+	str	r10, [r8, #0x528] /* DRAM_DQM2 */
+	str	r10, [r8, #0x520] /* DRAM_DQM3 */
+
+	str	r10, [r8, #0x514] /* DRAM_DQM4 */
+	str	r10, [r8, #0x510] /* DRAM_DQM5 */
+	str	r10, [r8, #0x5bc] /* DRAM_DQM6 */
+	str	r10, [r8, #0x5c4] /* DRAM_DQM7 */
+
+	str	r10, [r8, #0x56c] /* DRAM_CAS */
+	str	r10, [r8, #0x578] /* DRAM_RAS */
+	str	r10, [r8, #0x588] /* DRAM_SDCLK_0 */
+	str	r10, [r8, #0x594] /* DRAM_SDCLK_1 */
+
+	str	r10, [r8, #0x750] /* DDRMODE_CTL */
+	str	r10, [r8, #0x774] /* DDRMODE */
+
+	str	r10, [r8, #0x5a8] /* DRAM_SDQS0 */
+	str	r10, [r8, #0x5b0] /* DRAM_SDQS1 */
+	str	r10, [r8, #0x524] /* DRAM_SDQS2 */
+	str	r10, [r8, #0x51c] /* DRAM_SDQS3 */
+
+	str	r10, [r8, #0x518] /* DRAM_SDQS4 */
+	str	r10, [r8, #0x50c] /* DRAM_SDQS5 */
+	str	r10, [r8, #0x5b8] /* DRAM_SDQS6 */
+	str	r10, [r8, #0x5c0] /* DRAM_SDQS7 */
+
+	str	r10, [r8, #0x784] /* GPR_B0DS */
+	str	r10, [r8, #0x788] /* GPR_B1DS */
+	str	r10, [r8, #0x794] /* GPR_B2DS */
+	str	r10, [r8, #0x79c] /* GPR_B3DS */
+
+	str	r10, [r8, #0x7a0] /* GPR_B4DS */
+	str	r10, [r8, #0x7a4] /* GPR_B5DS */
+	str	r10, [r8, #0x7a8] /* GPR_B6DS */
+	str	r10, [r8, #0x748] /* GPR_B7DS */
+
+	str	r10, [r8, #0x74c] /* GPR_ADDS*/
+	str	r10, [r8, #0x59c] /* DRAM_SODT0*/
+	str	r10, [r8, #0x5a0] /* DRAM_SODT1*/
+
+	.endm
+
+	.macro  sync_l2_cache
+
+	/* sync L2 cache to drain L2's buffers to DRAM. */
+#ifdef CONFIG_CACHE_L2X0
+	ldr	r8, =IMX_IO_P2V(MX6Q_L2_BASE_ADDR)
+	mov	r5, #0x0
+	str	r5, [r8, #L2X0_CACHE_SYNC]
+1:
+	ldr	r5, [r8, #L2X0_CACHE_SYNC]
+	ands	r5, r5, #0x1
+	bne	1b
+#endif
+	.endm
+
+ENTRY(imx6_suspend)
+
+	/*
+	 * counting the resume address in iram
+	 * to set it in SRC register.
+	 */
+	ldr	r4, =imx6_suspend
+	ldr	r5, =resume
+	sub	r5, r5, r4
+	add	r9, r1, r5
+
+	/*
+	 * make sure TLB contain the addr we want,
+	 * as we will access after DDR IO floated.
+	 */
+
+	ldr	r8, =IMX_IO_P2V(MX6Q_CCM_BASE_ADDR)
+	ldr	r7, [r8, #0x0]
+	ldr	r8, =IMX_IO_P2V(MX6Q_GPC_BASE_ADDR)
+	ldr	r7, [r8, #0x0]
+
+	/* use r8 to store the IO address */
+	ldr	r8, =IMX_IO_P2V(MX6Q_SRC_BASE_ADDR)
+
+	/*
+	 * read previous resume address from SRC
+	 * register, which is v7_cpu_resume, this
+	 * is for the jump when we finish DDR IO
+	 * restore.
+	 */
+	ldr	r5, [r8, #MX6Q_SRC_GPR1]
+	add	r10, r0, #MX6Q_SUSPEND_IRAM_SIZE
+	stmfd	r10!, {r5}
+
+	/* save cpu type */
+	stmfd	r10!, {r2}
+
+	str	r9, [r8, #MX6Q_SRC_GPR1]
+	add	r3, r1, #MX6Q_SUSPEND_IRAM_SIZE
+	str	r3, [r8, #MX6Q_SRC_GPR2]
+
+	ldr	r8, =IMX_IO_P2V(MX6Q_IOMUXC_BASE_ADDR)
+
+	cmp     r2, #MXC_CPU_IMX6Q
+	bne	ddr_io_save_dsm_done
+	imx6dq_ddr_io_save
+ddr_io_save_dsm_done:
+
+	/* need to sync L2 cache before DSM. */
+	sync_l2_cache
+
+	ldr	r8, =IMX_IO_P2V(MX6Q_MMDC_P0_BASE_ADDR)
+	/*
+	 * put DDR explicitly into self-refresh and
+	 * disable Automatic power savings.
+	 */
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	orr	r7, r7, #0x01
+	str	r7, [r8, #MX6Q_MMDC_MAPSR]
+
+	/* make the DDR explicitly enter self-refresh. */
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	orr	r7, r7, #(1 << 21)
+	str	r7, [r8, #MX6Q_MMDC_MAPSR]
+
+poll_dvfs_set_1:
+	ldr	r7, [r8, #0x404]
+	ands	r7, r7, #(1 << 25)
+	beq	poll_dvfs_set_1
+
+	ldr	r8, =IMX_IO_P2V(MX6Q_IOMUXC_BASE_ADDR)
+
+	cmp     r2, #MXC_CPU_IMX6Q
+	bne	ddr_io_set_lpm_dsm_done
+	imx6dq_ddr_io_set_lpm
+ddr_io_set_lpm_dsm_done:
+
+	/*
+	 * mask all GPC interrupts before
+	 * enabling the RBC counters to
+	 * avoid the counter starting too
+	 * early if an interupt is already
+	 * pending.
+	 */
+	ldr	r8, =IMX_IO_P2V(MX6Q_CCM_BASE_ADDR)
+	/* save CCM base in r9 */
+	mov	r9, r8
+	ldr	r8, =IMX_IO_P2V(MX6Q_GPC_BASE_ADDR)
+	ldr	r4, [r8, #MX6Q_GPC_IMR1]
+	ldr	r5, [r8, #MX6Q_GPC_IMR2]
+	ldr	r6, [r8, #MX6Q_GPC_IMR3]
+	ldr	r7, [r8, #MX6Q_GPC_IMR4]
+
+	ldr	r3, =0xffffffff
+	str	r3, [r8, #MX6Q_GPC_IMR1]
+	str	r3, [r8, #MX6Q_GPC_IMR2]
+	str	r3, [r8, #MX6Q_GPC_IMR3]
+	str	r3, [r8, #MX6Q_GPC_IMR4]
+
+	/*
+	 * enable the RBC bypass counter here
+	 * to hold off the interrupts. RBC counter
+	 * = 32 (1ms), Minimum RBC delay should be
+	 * 400us for the analog LDOs to power down.
+	 */
+	ldr	r3, [r9, #MX6Q_CCM_CCR]
+	bic	r3, r3, #(0x3f << 21)
+	orr	r3, r3, #(0x20 << 21)
+	str	r3, [r9, #MX6Q_CCM_CCR]
+
+	/* enable the counter. */
+	ldr	r3, [r9, #MX6Q_CCM_CCR]
+	orr	r3, r3, #(0x1 << 27)
+	str	r3, [r9, #MX6Q_CCM_CCR]
+
+	/* unmask all the GPC interrupts. */
+	str	r4, [r8, #MX6Q_GPC_IMR1]
+	str	r5, [r8, #MX6Q_GPC_IMR2]
+	str	r6, [r8, #MX6Q_GPC_IMR3]
+	str	r7, [r8, #MX6Q_GPC_IMR4]
+
+	/*
+	 * now delay for a short while (3usec)
+	 * ARM is at 1GHz@this point
+	 * so a short loop should be enough.
+	 * this delay is required to ensure that
+	 * the RBC counter can start counting in
+	 * case an interrupt is already pending
+	 * or in case an interrupt arrives just
+	 * as ARM is about to assert DSM_request.
+	 */
+	ldr     r4, =2000
+rbc_loop:
+	sub     r4, r4, #0x1
+	cmp     r4, #0x0
+	bne     rbc_loop
+
+	/* Zzz, enter stop mode */
+	wfi
+	nop
+	nop
+	nop
+	nop
+
+	/*
+	 * run to here means there is pending
+	 * wakeup source, system should auto
+	 * resume, we need to restore DDR IO first
+	 */
+
+	add	r10, r0, #MX6Q_SUSPEND_IRAM_SIZE
+	/* skip the lr saved in iram */
+	sub	r10, r10, #0x4
+	/* skip the cpu type saved in iram */
+	sub	r10, r10, #0x4
+
+	ldr	r8, =IMX_IO_P2V(MX6Q_IOMUXC_BASE_ADDR)
+
+	cmp     r2, #MXC_CPU_IMX6Q
+	bne	ddr_io_restore_done
+	imx6dq_ddr_io_restore
+ddr_io_restore_done:
+
+	ldr	r8, =IMX_IO_P2V(MX6Q_MMDC_P0_BASE_ADDR)
+	/* let DDR out of self-refresh. */
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	bic	r7, r7, #(1 << 21)
+	str	r7, [r8, #MX6Q_MMDC_MAPSR]
+
+poll_dvfs_clear_2:
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	ands	r7, r7, #(1 << 25)
+	bne     poll_dvfs_clear_2
+	/* enable DDR auto power saving */
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	bic	r7, r7, #0x1
+	str	r7, [r8, #MX6Q_MMDC_MAPSR]
+	/* return to suspend finish */
+	mov	pc, lr
+
+resume:
+	/* invalidate L1 I-cache first */
+	mov     r1,     #0x0
+	mcr     p15, 0, r1, c7, c5, 0
+	mcr     p15, 0, r1, c7, c5, 0
+	mcr     p15, 0, r1, c7, c5, 6
+	/* enable the Icache and branch prediction */
+	mov     r1, #0x1800
+	mcr     p15, 0, r1, c1, c0, 0
+	isb
+
+	ldr	r5, =MX6Q_SRC_BASE_ADDR
+	ldr	r10, [r5, #MX6Q_SRC_GPR2]
+	ldmea	r10!, {lr}
+
+	/* get cpu tpye */
+	ldmea	r10!, {r2}
+
+	/* clear core0's entry and parameter */
+	ldr	r8, =MX6Q_SRC_BASE_ADDR
+	mov	r7, #0
+	str	r7, [r8, #MX6Q_SRC_GPR1]
+	str	r7, [r8, #MX6Q_SRC_GPR2]
+
+	ldr	r8, =MX6Q_IOMUXC_BASE_ADDR
+
+	cmp	r2, #MXC_CPU_IMX6Q
+	bne	ddr_io_restore_dsm_done
+	imx6dq_ddr_io_restore
+ddr_io_restore_dsm_done:
+
+	ldr	r8, =MX6Q_MMDC_P0_BASE_ADDR
+	/* let DDR out of self-refresh */
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	bic	r7, r7, #(1 << 21)
+	str	r7, [r8, #MX6Q_MMDC_MAPSR]
+
+poll_dvfs_clear_1:
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	ands	r7, r7, #(1 << 25)
+	bne	poll_dvfs_clear_1
+	/* enable DDR auto power saving */
+	ldr	r7, [r8, #MX6Q_MMDC_MAPSR]
+	bic	r7, r7, #0x1
+	str	r7, [r8, #MX6Q_MMDC_MAPSR]
+	mov	pc, lr
+ENDPROC(imx6_suspend)
-- 
1.7.9.5
