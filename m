From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Sep 2010 16:09:10 +0900
Subject: [PATCH 03/13] ARM: S5P64X0: Add S5P64X0(S5P6440 and S5P6450)
	initialization support
In-Reply-To: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283324960-21629-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARCH_S5P64X0 which can support S5P6440 and S5P6450 with
one kernel image. So moved some files of mach-s5p6440 into the new ARCH
directory mach-s5p64x0.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/cpu.c                        |  145 -------------
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |   37 ----
 arch/arm/mach-s5p6440/include/mach/io.h            |   18 --
 arch/arm/mach-s5p6440/include/mach/map.h           |   81 --------
 arch/arm/mach-s5p6440/include/mach/uncompress.h    |   24 ---
 arch/arm/mach-s5p6440/init.c                       |   52 -----
 arch/arm/mach-s5p64x0/cpu.c                        |  208 +++++++++++++++++++
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |   39 ++++
 .../include/mach/entry-macro.S                     |    8 +-
 .../include/mach/hardware.h                        |    8 +-
 arch/arm/mach-s5p64x0/include/mach/io.h            |   25 +++
 arch/arm/mach-s5p64x0/include/mach/map.h           |   83 ++++++++
 .../include/mach/memory.h                          |   12 +-
 .../include/mach/system.h                          |    8 +-
 .../include/mach/timex.h                           |    7 +-
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |  212 ++++++++++++++++++++
 .../include/mach/vmalloc.h                         |    5 +-
 arch/arm/mach-s5p64x0/init.c                       |   73 +++++++
 arch/arm/plat-s5p/cpu.c                            |   12 +-
 arch/arm/plat-s5p/include/plat/s5p6440.h           |    7 +-
 arch/arm/plat-s5p/include/plat/s5p6450.h           |   36 ++++
 21 files changed, 717 insertions(+), 383 deletions(-)
 delete mode 100644 arch/arm/mach-s5p6440/cpu.c
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/map.h
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5p6440/init.c
 create mode 100644 arch/arm/mach-s5p64x0/cpu.c
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/debug-macro.S
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/entry-macro.S (58%)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/hardware.h (67%)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/io.h
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/map.h
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/memory.h (55%)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/system.h (69%)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/timex.h (80%)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/uncompress.h
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/vmalloc.h (74%)
 create mode 100644 arch/arm/mach-s5p64x0/init.c
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p6450.h

diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
deleted file mode 100644
index a3c33d9..0000000
--- a/arch/arm/mach-s5p6440/cpu.c
+++ /dev/null
@@ -1,145 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/cpu.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/timer.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/sysdev.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <asm/proc-fns.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <asm/irq.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-clock.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/clock.h>
-#include <plat/s5p6440.h>
-#include <plat/adc-core.h>
-
-/* Initial IO mappings */
-
-static struct map_desc s5p6440_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_GPIO,
-		.pfn		= __phys_to_pfn(S5P6440_PA_GPIO),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC0,
-		.pfn		= __phys_to_pfn(S5P6440_PA_VIC0),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC1,
-		.pfn		= __phys_to_pfn(S5P6440_PA_VIC1),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_UART,
-		.pfn		= __phys_to_pfn(S3C_PA_UART),
-		.length		= SZ_512K,
-		.type		= MT_DEVICE,
-	}
-};
-
-static void s5p6440_idle(void)
-{
-	unsigned long val;
-
-	if (!need_resched()) {
-		val = __raw_readl(S5P_PWR_CFG);
-		val &= ~(0x3<<5);
-		val |= (0x1<<5);
-		__raw_writel(val, S5P_PWR_CFG);
-
-		cpu_do_idle();
-	}
-	local_irq_enable();
-}
-
-/*
- * s5p6440_map_io
- *
- * register the standard cpu IO areas
- */
-
-void __init s5p6440_map_io(void)
-{
-	/* initialize any device information early */
-	s3c_adc_setname("s3c64xx-adc");
-
-	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
-}
-
-void __init s5p6440_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
-
-	s3c24xx_register_baseclocks(xtal);
-	s5p_register_clocks(xtal);
-	s5p6440_register_clocks();
-	s5p6440_setup_clocks();
-}
-
-void __init s5p6440_init_irq(void)
-{
-	/* S5P6440 supports only 2 VIC */
-	u32 vic[2];
-
-	/*
-	 * VIC0 is missing IRQ_VIC0[3, 4, 8, 10, (12-22)]
-	 * VIC1 is missing IRQ VIC1[1, 3, 4, 10, 11, 12, 14, 15, 22]
-	 */
-	vic[0] = 0xff800ae7;
-	vic[1] = 0xffbf23e5;
-
-	s5p_init_irq(vic, ARRAY_SIZE(vic));
-}
-
-struct sysdev_class s5p6440_sysclass = {
-	.name	= "s5p6440-core",
-};
-
-static struct sys_device s5p6440_sysdev = {
-	.cls	= &s5p6440_sysclass,
-};
-
-static int __init s5p6440_core_init(void)
-{
-	return sysdev_class_register(&s5p6440_sysclass);
-}
-
-core_initcall(s5p6440_core_init);
-
-int __init s5p6440_init(void)
-{
-	printk(KERN_INFO "S5P6440: Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = s5p6440_idle;
-
-	return sysdev_register(&s5p6440_sysdev);
-}
diff --git a/arch/arm/mach-s5p6440/include/mach/debug-macro.S b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
deleted file mode 100644
index 1347d7f..0000000
--- a/arch/arm/mach-s5p6440/include/mach/debug-macro.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/debug-macro.S
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* pull in the relevant register and map files. */
-
-#include <mach/map.h>
-#include <plat/regs-serial.h>
-
-	/* note, for the boot process to work we have to keep the UART
-	 * virtual address aligned to an 1MiB boundary for the L1
-	 * mapping the head code makes. We keep the UART virtual address
-	 * aligned and add in the offset when we load the value here.
-	 */
-
-	.macro addruart, rx, rtmp
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1
-		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = S3C_VA_UART
-#if CONFIG_DEBUG_S3C_UART != 0
-		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
-#endif
-	.endm
-
-/* include the reset of the code which will do the work, we're only
- * compiling for a single cpu processor type so the default of s3c2440
- * will be fine with us.
- */
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5p6440/include/mach/io.h b/arch/arm/mach-s5p6440/include/mach/io.h
deleted file mode 100644
index fa2d69c..0000000
--- a/arch/arm/mach-s5p6440/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s5p6440/include/mach/io.h
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for S3C64XX based
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
deleted file mode 100644
index 11d31fe..0000000
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/map.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6440 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MAP_H
-#define __ASM_ARCH_MAP_H __FILE__
-
-#include <plat/map-base.h>
-#include <plat/map-s5p.h>
-
-#define S5P6440_PA_CHIPID	(0xE0000000)
-#define S5P_PA_CHIPID		S5P6440_PA_CHIPID
-
-#define S5P6440_PA_SYSCON	(0xE0100000)
-#define S5P6440_PA_CLK		(S5P6440_PA_SYSCON + 0x0)
-#define S5P_PA_SYSCON		S5P6440_PA_SYSCON
-
-#define S5P6440_PA_GPIO		(0xE0308000)
-
-#define S5P6440_PA_VIC0		(0xE4000000)
-#define S5P6440_PA_VIC1		(0xE4100000)
-
-#define S5P6440_PA_PDMA		0xE9000000
-
-#define S5P6440_PA_TIMER	(0xEA000000)
-#define S5P_PA_TIMER		S5P6440_PA_TIMER
-
-#define S5P6440_PA_RTC		(0xEA100000)
-
-#define S5P6440_PA_WDT		(0xEA200000)
-
-#define S5P6440_PA_UART		(0xEC000000)
-
-#define S5P_PA_UART0		(S5P6440_PA_UART + 0x0)
-#define S5P_PA_UART1		(S5P6440_PA_UART + 0x400)
-#define S5P_PA_UART2		(S5P6440_PA_UART + 0x800)
-#define S5P_PA_UART3		(S5P6440_PA_UART + 0xC00)
-
-#define S5P_SZ_UART		SZ_256
-
-#define S5P6440_PA_IIC0		(0xEC104000)
-#define S5P6440_PA_IIC1		(0xEC20F000)
-
-#define S5P6440_PA_SPI0		0xEC400000
-#define S5P6440_PA_SPI1		0xEC500000
-
-#define S5P6440_PA_HSOTG	(0xED100000)
-
-#define S5P6440_PA_HSMMC0	(0xED800000)
-#define S5P6440_PA_HSMMC1	(0xED900000)
-#define S5P6440_PA_HSMMC2	(0xEDA00000)
-
-#define S5P6440_PA_SDRAM	(0x20000000)
-#define S5P_PA_SDRAM		S5P6440_PA_SDRAM
-
-/* I2S */
-#define S5P6440_PA_I2S		0xF2000000
-
-/* PCM */
-#define S5P6440_PA_PCM		0xF2100000
-
-#define S5P6440_PA_ADC		(0xF3000000)
-
-/* compatibiltiy defines. */
-#define S3C_PA_UART		S5P6440_PA_UART
-#define S3C_PA_IIC		S5P6440_PA_IIC0
-#define S3C_PA_RTC		S5P6440_PA_RTC
-#define S3C_PA_IIC1		S5P6440_PA_IIC1
-#define S3C_PA_WDT		S5P6440_PA_WDT
-
-#define SAMSUNG_PA_ADC		S5P6440_PA_ADC
-
-#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/uncompress.h b/arch/arm/mach-s5p6440/include/mach/uncompress.h
deleted file mode 100644
index 7c1f600..0000000
--- a/arch/arm/mach-s5p6440/include/mach/uncompress.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/uncompress.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6440 - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	/* we do not need to do any cpu detection here at the moment. */
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5p6440/init.c b/arch/arm/mach-s5p6440/init.c
deleted file mode 100644
index a1f3727..0000000
--- a/arch/arm/mach-s5p6440/init.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/init.c
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6440 - Init support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5p6440.h>
-#include <plat/regs-serial.h>
-
-static struct s3c24xx_uart_clksrc s5p6440_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk_low",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "uclk1",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
-/* uart registration process */
-void __init s5p6440_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5p6440_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5p6440_serial_clocks);
-		}
-	}
-
-	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
new file mode 100644
index 0000000..fb90a30
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -0,0 +1,208 @@
+/* linux/arch/arm/mach-s5p64x0/cpu.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+#include <asm/proc-fns.h>
+#include <asm/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/regs-serial.h>
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/s5p6440.h>
+#include <plat/s5p6450.h>
+#include <plat/adc-core.h>
+
+/* Initial IO mappings */
+
+static struct map_desc s5p64x0_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_GPIO,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_GPIO),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC0,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_VIC0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC1,
+		.pfn		= __phys_to_pfn(S5P64X0_PA_VIC1),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc s5p6440_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(S5P6440_PA_UART(0)),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc s5p6450_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_UART,
+		.pfn		= __phys_to_pfn(S5P6450_PA_UART(0)),
+		.length		= SZ_512K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_UART + SZ_512K,
+		.pfn		= __phys_to_pfn(S5P6450_PA_UART(5)),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void s5p64x0_idle(void)
+{
+	unsigned long val;
+
+	if (!need_resched()) {
+		val = __raw_readl(S5P64X0_PWR_CFG);
+		val &= ~(0x3 << 5);
+		val |= (0x1 << 5);
+		__raw_writel(val, S5P64X0_PWR_CFG);
+
+		cpu_do_idle();
+	}
+	local_irq_enable();
+}
+
+/*
+ * s5p64x0_map_io
+ *
+ * register the standard CPU IO areas
+ */
+
+void __init s5p6440_map_io(void)
+{
+	/* initialize any device information early */
+	s3c_adc_setname("s3c64x0-adc");
+
+	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
+	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
+}
+
+void __init s5p6450_map_io(void)
+{
+	/* initialize any device information early */
+	s3c_adc_setname("s3c64x0-adc");
+
+	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
+	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6440_iodesc));
+}
+
+/*
+ * s5p64x0_init_clocks
+ *
+ * register and setup the CPU clocks
+ */
+
+void __init s5p6440_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5p6440_register_clocks();
+	s5p6440_setup_clocks();
+}
+
+void __init s5p6450_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5p6450_register_clocks();
+	s5p6450_setup_clocks();
+}
+
+/*
+ * s5p64x0_init_irq
+ *
+ * register the CPU interrupts
+ */
+
+void __init s5p6440_init_irq(void)
+{
+	/* S5P6440 supports 2 VIC */
+	u32 vic[2];
+
+	/*
+	 * VIC0 is missing IRQ_VIC0[3, 4, 8, 10, (12-22)]
+	 * VIC1 is missing IRQ VIC1[1, 3, 4, 10, 11, 12, 14, 15, 22]
+	 */
+	vic[0] = 0xff800ae7;
+	vic[1] = 0xffbf23e5;
+
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
+}
+
+void __init s5p6450_init_irq(void)
+{
+	/* S5P6450 supports only 2 VIC */
+	u32 vic[2];
+
+	/*
+	 * VIC0 is missing IRQ_VIC0[(13-15), (21-22)]
+	 * VIC1 is missing IRQ VIC1[12, 14, 23]
+	 */
+	vic[0] = 0xff9f1fff;
+	vic[1] = 0xff7fafff;
+
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
+}
+
+struct sysdev_class s5p64x0_sysclass = {
+	.name	= "s5p64x0-core",
+};
+
+static struct sys_device s5p64x0_sysdev = {
+	.cls	= &s5p64x0_sysclass,
+};
+
+static int __init s5p64x0_core_init(void)
+{
+	return sysdev_class_register(&s5p64x0_sysclass);
+}
+core_initcall(s5p64x0_core_init);
+
+int __init s5p64x0_init(void)
+{
+	printk(KERN_INFO "S5P64X0(S5P6440/S5P6450): Initializing architecture\n");
+
+	/* set idle function */
+	pm_idle = s5p64x0_idle;
+
+	return sysdev_register(&s5p64x0_sysdev);
+}
diff --git a/arch/arm/mach-s5p64x0/include/mach/debug-macro.S b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
new file mode 100644
index 0000000..f122baa
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
@@ -0,0 +1,39 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/debug-macro.S
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* pull in the relevant register and map files. */
+
+#include <plat/map-base.h>
+#include <plat/map-s5p.h>
+
+#include <plat/regs-serial.h>
+
+	.macro addruart, rx, tmp
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@ MMU enabled?
+		bne	1002f
+
+		mov	\rx, #0xE0000000
+		orr	\rx, \rx, #0x00100000
+		ldr	\rx, [\rx, #0x118 ]
+		and	\rx, \rx, #0xff000
+		teq	\rx, #0x50000		@@ S5P6450
+		ldreq	\rx, =0xEC800000
+		movne	\rx, #0xEC000000	@@ S5P6440
+		b	1003f
+	1002:
+		ldrne	\rx, = S3C_VA_UART
+	1003:
+#if CONFIG_DEBUG_S3C_UART != 0
+		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+#endif
+	.endm
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5p6440/include/mach/entry-macro.S b/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
similarity index 58%
rename from arch/arm/mach-s5p6440/include/mach/entry-macro.S
rename to arch/arm/mach-s5p64x0/include/mach/entry-macro.S
index e65f1b9..10b62b4 100644
--- a/arch/arm/mach-s5p6440/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/entry-macro.S
+/* linux/arch/arm/mach-s5p64x0/include/mach/entry-macro.S
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * Low-level IRQ helper macros for the Samsung S5P6440
+ * Low-level IRQ helper macros for the Samsung S5P64X0
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5p6440/include/mach/hardware.h b/arch/arm/mach-s5p64x0/include/mach/hardware.h
similarity index 67%
rename from arch/arm/mach-s5p6440/include/mach/hardware.h
rename to arch/arm/mach-s5p64x0/include/mach/hardware.h
index be8b26e..d3e8799 100644
--- a/arch/arm/mach-s5p6440/include/mach/hardware.h
+++ b/arch/arm/mach-s5p64x0/include/mach/hardware.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/hardware.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/hardware.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - Hardware support
+ * S5P64X0 - Hardware support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5p64x0/include/mach/io.h b/arch/arm/mach-s5p64x0/include/mach/io.h
new file mode 100644
index 0000000..a3e095c
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/io.h
@@ -0,0 +1,25 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/io.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben-linux@fluff.org>
+ *
+ * Default IO routines for S5P64X0 based
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+/* No current ISA/PCI bus support. */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#define IO_SPACE_LIMIT (0xFFFFFFFF)
+
+#endif
diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
new file mode 100644
index 0000000..31e5341
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/map.h
@@ -0,0 +1,83 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/map.h
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MAP_H
+#define __ASM_ARCH_MAP_H __FILE__
+
+#include <plat/map-base.h>
+#include <plat/map-s5p.h>
+
+#define S5P64X0_PA_SDRAM	(0x20000000)
+
+#define S5P64X0_PA_CHIPID	(0xE0000000)
+#define S5P_PA_CHIPID		S5P64X0_PA_CHIPID
+
+#define S5P64X0_PA_SYSCON	(0xE0100000)
+#define S5P_PA_SYSCON		S5P64X0_PA_SYSCON
+
+#define S5P64X0_PA_GPIO		(0xE0308000)
+
+#define S5P64X0_PA_VIC0		(0xE4000000)
+#define S5P64X0_PA_VIC1		(0xE4100000)
+
+#define S5P64X0_PA_PDMA		(0xE9000000)
+
+#define S5P64X0_PA_TIMER	(0xEA000000)
+#define S5P_PA_TIMER		S5P64X0_PA_TIMER
+
+#define S5P64X0_PA_RTC		(0xEA100000)
+
+#define S5P64X0_PA_WDT		(0xEA200000)
+
+#define S5P6440_PA_UART(x)	(0xEC000000 + ((x) * S3C_UART_OFFSET))
+#define S5P6450_PA_UART(x)	((x < 5) ? (0xEC800000 + ((x) * S3C_UART_OFFSET)) : (0xEC000000))
+
+#define S5P_PA_UART0		S5P6450_PA_UART(0)
+#define S5P_PA_UART1		S5P6450_PA_UART(1)
+#define S5P_PA_UART2		S5P6450_PA_UART(2)
+#define S5P_PA_UART3		S5P6450_PA_UART(3)
+#define S5P_PA_UART4		S5P6450_PA_UART(4)
+#define S5P_PA_UART5		S5P6450_PA_UART(5)
+
+#define S5P_SZ_UART		SZ_256
+
+#define S5P6440_PA_IIC0		(0xEC104000)
+#define S5P6440_PA_IIC1		(0xEC20F000)
+#define S5P6450_PA_IIC0		(0xEC100000)
+#define S5P6450_PA_IIC1		(0xEC200000)
+
+#define S5P64X0_PA_SPI0		(0xEC400000)
+#define S5P64X0_PA_SPI1		(0xEC500000)
+
+#define S5P64X0_PA_HSOTG	(0xED100000)
+
+#define S5P64X0_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
+
+#define S5P64X0_PA_I2S		(0xF2000000)
+
+#define S5P64X0_PA_PCM		(0xF2100000)
+
+#define S5P64X0_PA_ADC		(0xF3000000)
+
+/* compatibiltiy defines. */
+
+#define S3C_PA_HSMMC0		S5P64X0_PA_HSMMC(0)
+#define S3C_PA_HSMMC1		S5P64X0_PA_HSMMC(1)
+#define S3C_PA_HSMMC2		S5P64X0_PA_HSMMC(2)
+#define S3C_PA_IIC		S5P6440_PA_IIC0
+#define S3C_PA_IIC1		S5P6440_PA_IIC1
+#define S3C_PA_RTC		S5P64X0_PA_RTC
+#define S3C_PA_WDT		S5P64X0_PA_WDT
+
+#define SAMSUNG_PA_ADC		S5P64X0_PA_ADC
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/memory.h b/arch/arm/mach-s5p64x0/include/mach/memory.h
similarity index 55%
rename from arch/arm/mach-s5p6440/include/mach/memory.h
rename to arch/arm/mach-s5p64x0/include/mach/memory.h
index d62910c..1b036b0 100644
--- a/arch/arm/mach-s5p6440/include/mach/memory.h
+++ b/arch/arm/mach-s5p64x0/include/mach/memory.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/memory.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/memory.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - Memory definitions
+ * S5P64X0 - Memory definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,9 +11,9 @@
 */
 
 #ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H __FILE__
 
-#define PHYS_OFFSET     	UL(0x20000000)
+#define PHYS_OFFSET		UL(0x20000000)
 #define CONSISTENT_DMA_SIZE	SZ_8M
 
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/system.h b/arch/arm/mach-s5p64x0/include/mach/system.h
similarity index 69%
rename from arch/arm/mach-s5p6440/include/mach/system.h
rename to arch/arm/mach-s5p64x0/include/mach/system.h
index a359ee3..60f5753 100644
--- a/arch/arm/mach-s5p6440/include/mach/system.h
+++ b/arch/arm/mach-s5p64x0/include/mach/system.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/system.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/system.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - system support header
+ * S5P64X0 - system support header
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5p6440/include/mach/timex.h b/arch/arm/mach-s5p64x0/include/mach/timex.h
similarity index 80%
rename from arch/arm/mach-s5p6440/include/mach/timex.h
rename to arch/arm/mach-s5p64x0/include/mach/timex.h
index fb2e8cd..4b91faa 100644
--- a/arch/arm/mach-s5p6440/include/mach/timex.h
+++ b/arch/arm/mach-s5p64x0/include/mach/timex.h
@@ -1,9 +1,12 @@
-/* arch/arm/mach-s3c64xx/include/mach/timex.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/timex.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright (c) 2003-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * S3C6400 - time parameters
+ * S5P64X0 - time parameters
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
new file mode 100644
index 0000000..c65b229
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -0,0 +1,212 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - uncompress code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <mach/map.h>
+
+/*
+ * cannot use commonly <plat/uncompress.h>
+ * because uart base of S5P6440 and S5P6450 is different
+ */
+
+typedef unsigned int upf_t;	/* cannot include linux/serial_core.h */
+
+/* uart setup */
+
+static unsigned int fifo_mask;
+static unsigned int fifo_max;
+
+/* forward declerations */
+
+static void arch_detect_cpu(void);
+
+/* defines for UART registers */
+
+#include <plat/regs-serial.h>
+#include <plat/regs-watchdog.h>
+
+/* working in physical space... */
+#undef S3C2410_WDOGREG
+#define S3C2410_WDOGREG(x) ((S3C24XX_PA_WATCHDOG + (x)))
+
+/* how many bytes we allow into the FIFO at a time in FIFO mode */
+#define FIFO_MAX	 (14)
+
+static unsigned long uart_base;
+
+static __inline__ void get_uart_base(void)
+{
+	unsigned int chipid;
+
+	chipid = *(const volatile unsigned int __force *) 0xE0100118;
+
+	uart_base = S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT;
+
+	if ((chipid & 0xff000) == 0x50000)
+		uart_base += 0xEC800000;
+	else
+		uart_base += 0xEC000000;
+}
+
+static __inline__ void uart_wr(unsigned int reg, unsigned int val)
+{
+	volatile unsigned int *ptr;
+
+	get_uart_base();
+	ptr = (volatile unsigned int *)(reg + uart_base);
+	*ptr = val;
+}
+
+static __inline__ unsigned int uart_rd(unsigned int reg)
+{
+	volatile unsigned int *ptr;
+
+	get_uart_base();
+	ptr = (volatile unsigned int *)(reg + uart_base);
+	return *ptr;
+}
+
+/*
+ * we can deal with the case the UARTs are being run
+ * in FIFO mode, so that we don't hold up our execution
+ * waiting for tx to happen...
+ */
+
+static void putc(int ch)
+{
+	if (uart_rd(S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE) {
+		int level;
+
+		while (1) {
+			level = uart_rd(S3C2410_UFSTAT);
+			level &= fifo_mask;
+
+			if (level < fifo_max)
+				break;
+		}
+
+	} else {
+		/* not using fifos */
+
+		while ((uart_rd(S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE) != S3C2410_UTRSTAT_TXE)
+			barrier();
+	}
+
+	/* write byte to transmission register */
+	uart_wr(S3C2410_UTXH, ch);
+}
+
+static inline void flush(void)
+{
+}
+
+#define __raw_writel(d, ad)			\
+	do {							\
+		*((volatile unsigned int __force *)(ad)) = (d); \
+	} while (0)
+
+/*
+ * CONFIG_S3C_BOOT_WATCHDOG
+ *
+ * Simple boot-time watchdog setup, to reboot the system if there is
+ * any problem with the boot process
+ */
+
+#ifdef CONFIG_S3C_BOOT_WATCHDOG
+
+#define WDOG_COUNT (0xff00)
+
+static inline void arch_decomp_wdog(void)
+{
+	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
+}
+
+static void arch_decomp_wdog_start(void)
+{
+	__raw_writel(WDOG_COUNT, S3C2410_WTDAT);
+	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
+	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x80), S3C2410_WTCON);
+}
+
+#else
+#define arch_decomp_wdog_start()
+#define arch_decomp_wdog()
+#endif
+
+#ifdef CONFIG_S3C_BOOT_ERROR_RESET
+
+static void arch_decomp_error(const char *x)
+{
+	putstr("\n\n");
+	putstr(x);
+	putstr("\n\n -- System resetting\n");
+
+	__raw_writel(0x4000, S3C2410_WTDAT);
+	__raw_writel(0x4000, S3C2410_WTCNT);
+	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x40), S3C2410_WTCON);
+
+	while(1);
+}
+
+#define arch_error arch_decomp_error
+#endif
+
+#ifdef CONFIG_S3C_BOOT_UART_FORCE_FIFO
+static inline void arch_enable_uart_fifo(void)
+{
+	u32 fifocon = uart_rd(S3C2410_UFCON);
+
+	if (!(fifocon & S3C2410_UFCON_FIFOMODE)) {
+		fifocon |= S3C2410_UFCON_RESETBOTH;
+		uart_wr(S3C2410_UFCON, fifocon);
+
+		/* wait for fifo reset to complete */
+		while (1) {
+			fifocon = uart_rd(S3C2410_UFCON);
+			if (!(fifocon & S3C2410_UFCON_RESETBOTH))
+				break;
+		}
+	}
+}
+#else
+#define arch_enable_uart_fifo() do { } while(0)
+#endif
+
+static void arch_decomp_setup(void)
+{
+	/*
+	 * we may need to setup the uart(s) here if we are not running
+	 * on an BAST... the BAST will have left the uarts configured
+	 * after calling linux.
+	 */
+
+	arch_detect_cpu();
+	arch_decomp_wdog_start();
+
+	/*
+	 * Enable the UART FIFOs if they where not enabled and our
+	 * configuration says we should turn them on.
+	 */
+
+	arch_enable_uart_fifo();
+}
+
+
+
+static void arch_detect_cpu(void)
+{
+	/* we do not need to do any cpu detection here at the moment. */
+}
+
+#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/vmalloc.h b/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
similarity index 74%
rename from arch/arm/mach-s5p6440/include/mach/vmalloc.h
rename to arch/arm/mach-s5p64x0/include/mach/vmalloc.h
index e3f0eeb..97a9df3 100644
--- a/arch/arm/mach-s5p6440/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
@@ -1,4 +1,7 @@
-/* arch/arm/mach-s5p6440/include/mach/vmalloc.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
  *
diff --git a/arch/arm/mach-s5p64x0/init.c b/arch/arm/mach-s5p64x0/init.c
new file mode 100644
index 0000000..79833ca
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/init.c
@@ -0,0 +1,73 @@
+/* linux/arch/arm/mach-s5p64x0/init.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - Init support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+
+#include <mach/map.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/s5p6440.h>
+#include <plat/s5p6450.h>
+#include <plat/regs-serial.h>
+
+static struct s3c24xx_uart_clksrc s5p64x0_serial_clocks[] = {
+	[0] = {
+		.name		= "pclk_low",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+	[1] = {
+		.name		= "uclk1",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+
+void __init s5p64x0_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5p64x0_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5p64x0_serial_clocks);
+		}
+	}
+}
+
+void __init s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	int uart;
+
+	for (uart = 0; uart < no; uart++) {
+		s5p_uart_resources[uart].resources->start = S5P6440_PA_UART(uart);
+		s5p_uart_resources[uart].resources->end = S5P6440_PA_UART(uart) + S5P_SZ_UART;
+	}
+
+	s5p64x0_common_init_uarts(cfg, no);
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
+}
+
+void __init s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	s5p64x0_common_init_uarts(cfg, no);
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
+}
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 57f08ee..74f7f5a 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -19,6 +19,7 @@
 #include <plat/cpu.h>
 #include <plat/s5p6440.h>
 #include <plat/s5p6442.h>
+#include <plat/s5p6450.h>
 #include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
 #include <plat/s5pv310.h>
@@ -27,6 +28,7 @@
 
 static const char name_s5p6440[] = "S5P6440";
 static const char name_s5p6442[] = "S5P6442";
+static const char name_s5p6450[] = "S5P6450";
 static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
 static const char name_s5pv310[] = "S5PV310";
@@ -38,7 +40,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.map_io		= s5p6440_map_io,
 		.init_clocks	= s5p6440_init_clocks,
 		.init_uarts	= s5p6440_init_uarts,
-		.init		= s5p6440_init,
+		.init		= s5p64x0_init,
 		.name		= name_s5p6440,
 	}, {
 		.idcode		= 0x36442000,
@@ -49,6 +51,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s5p6442_init,
 		.name		= name_s5p6442,
 	}, {
+		.idcode		= 0x36450000,
+		.idmask		= 0xffffff00,
+		.map_io		= s5p6450_map_io,
+		.init_clocks	= s5p6450_init_clocks,
+		.init_uarts	= s5p6450_init_uarts,
+		.init		= s5p64x0_init,
+		.name		= name_s5p6450,
+	}, {
 		.idcode		= 0x43100000,
 		.idmask		= 0xfffff000,
 		.map_io		= s5pc100_map_io,
diff --git a/arch/arm/plat-s5p/include/plat/s5p6440.h b/arch/arm/plat-s5p/include/plat/s5p6440.h
index a4cd75a..528585d 100644
--- a/arch/arm/plat-s5p/include/plat/s5p6440.h
+++ b/arch/arm/plat-s5p/include/plat/s5p6440.h
@@ -12,24 +12,23 @@
 
  /* Common init code for S5P6440 related SoCs */
 
-extern void s5p6440_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s5p6440_register_clocks(void);
 extern void s5p6440_setup_clocks(void);
 
 #ifdef CONFIG_CPU_S5P6440
 
-extern  int s5p6440_init(void);
+extern  int s5p64x0_init(void);
 extern void s5p6440_init_irq(void);
 extern void s5p6440_map_io(void);
 extern void s5p6440_init_clocks(int xtal);
 
-#define s5p6440_init_uarts s5p6440_common_init_uarts
+extern void s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 #else
 #define s5p6440_init_clocks NULL
 #define s5p6440_init_uarts NULL
 #define s5p6440_map_io NULL
-#define s5p6440_init NULL
+#define s5p64x0_init NULL
 #endif
 
 /* S5P6440 timer */
diff --git a/arch/arm/plat-s5p/include/plat/s5p6450.h b/arch/arm/plat-s5p/include/plat/s5p6450.h
new file mode 100644
index 0000000..640a41c
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5p6450.h
@@ -0,0 +1,36 @@
+/* arch/arm/plat-s5p/include/plat/s5p6450.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header file for s5p6450 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5P6450 related SoCs */
+
+extern void s5p6450_register_clocks(void);
+extern void s5p6450_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5P6450
+
+extern  int s5p64x0_init(void);
+extern void s5p6450_init_irq(void);
+extern void s5p6450_map_io(void);
+extern void s5p6450_init_clocks(int xtal);
+
+extern void s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+#else
+#define s5p6450_init_clocks NULL
+#define s5p6450_init_uarts NULL
+#define s5p6450_map_io NULL
+#define s5p64x0_init NULL
+#endif
+
+/* S5P6450 timer */
+
+extern struct sys_timer s5p6450_timer;
-- 
1.6.2.5
