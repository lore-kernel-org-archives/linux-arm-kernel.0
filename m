From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:25 +0900
Subject: [PATCH 01/12] ARM: S3C64XX: introduce
 arch/arm/mach-s3c64xx/common.[ch]
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces common.[ch] which are used only in the
arch/arm/mach-s3c64xx/ directory. The common.c file merges
the cpu.c, irq.c and irq-eint.c which are used commonly on
S3C64XX SoCs and the common.h file replaces with plat/s3c6400.h
and plat/s3c6410.h files.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Makefile                 |   65 ++++-----
 arch/arm/mach-s3c64xx/clock.c                  |    4 +-
 arch/arm/mach-s3c64xx/{irq-eint.c => common.c} |  182 ++++++++++++++++++++++--
 arch/arm/mach-s3c64xx/common.h                 |   55 +++++++
 arch/arm/mach-s3c64xx/cpu.c                    |  161 ---------------------
 arch/arm/mach-s3c64xx/irq.c                    |   47 ------
 arch/arm/mach-s3c64xx/mach-anw6410.c           |    3 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c          |    3 +-
 arch/arm/mach-s3c64xx/mach-hmt.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c          |    3 +-
 arch/arm/mach-s3c64xx/mach-ncp.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-real6410.c          |    3 +-
 arch/arm/mach-s3c64xx/mach-smartq.c            |    2 +
 arch/arm/mach-s3c64xx/mach-smartq5.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c          |    3 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c          |    3 +-
 arch/arm/mach-s3c64xx/s3c6400.c                |    5 +-
 arch/arm/mach-s3c64xx/s3c6410.c                |    6 +-
 arch/arm/plat-samsung/include/plat/cpu.h       |    4 -
 arch/arm/plat-samsung/include/plat/s3c6400.h   |   36 -----
 arch/arm/plat-samsung/include/plat/s3c6410.h   |   29 ----
 22 files changed, 285 insertions(+), 339 deletions(-)
 rename arch/arm/mach-s3c64xx/{irq-eint.c => common.c} (51%)
 create mode 100644 arch/arm/mach-s3c64xx/common.h
 delete mode 100644 arch/arm/mach-s3c64xx/cpu.c
 delete mode 100644 arch/arm/mach-s3c64xx/irq.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c6400.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c6410.h

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index cfc0b99..f37016c 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -10,54 +10,49 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-# Core files
-obj-y				+= cpu.o
-obj-y				+= clock.o
+# Core
 
-# Core support for S3C6400 system
+obj-y				+= common.o clock.o
+
+# Core support
 
 obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
 obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 
-obj-y				+= irq.o
-obj-y				+= irq-eint.o
+# PM
+
+obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
 
 # DMA support
 
 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
-# Device setup
+# Device support
 
-obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
-obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
-obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
-obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
-obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
-obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
-obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
+obj-y				+= dev-uart.o
+obj-y				+= dev-audio.o
+obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
-# PM
+# Device setup
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= sleep.o
-obj-$(CONFIG_PM)		+= irq-pm.o
+obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+= setup-i2c0.o
+obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S3C64XX_SETUP_IDE)		+= setup-ide.o
+obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+= setup-keypad.o
+obj-$(CONFIG_S3C64XX_SETUP_SDHCI)	+= setup-sdhci.o
+obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # Machine support
 
-obj-$(CONFIG_MACH_ANW6410)	+= mach-anw6410.o
-obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
-obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
-obj-$(CONFIG_MACH_REAL6410)     += mach-real6410.o
-obj-$(CONFIG_MACH_MINI6410)     += mach-mini6410.o
-obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
-obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
-obj-$(CONFIG_MACH_SMARTQ)	+= mach-smartq.o
-obj-$(CONFIG_MACH_SMARTQ5)	+= mach-smartq5.o
-obj-$(CONFIG_MACH_SMARTQ7)	+= mach-smartq7.o
-obj-$(CONFIG_MACH_WLF_CRAGG_6410) += mach-crag6410.o mach-crag6410-module.o
-
-# device support
-
-obj-y				+= dev-uart.o
-obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+obj-$(CONFIG_MACH_ANW6410)		+= mach-anw6410.o
+obj-$(CONFIG_MACH_HMT)			+= mach-hmt.o
+obj-$(CONFIG_MACH_MINI6410)		+= mach-mini6410.o
+obj-$(CONFIG_MACH_NCP)			+= mach-ncp.o
+obj-$(CONFIG_MACH_REAL6410)		+= mach-real6410.o
+obj-$(CONFIG_MACH_SMARTQ)		+= mach-smartq.o
+obj-$(CONFIG_MACH_SMARTQ5)		+= mach-smartq5.o
+obj-$(CONFIG_MACH_SMARTQ7)		+= mach-smartq7.o
+obj-$(CONFIG_MACH_SMDK6400)		+= mach-smdk6400.o
+obj-$(CONFIG_MACH_SMDK6410)		+= mach-smdk6410.o
+obj-$(CONFIG_MACH_WLF_CRAGG_6410)	+= mach-crag6410.o mach-crag6410-module.o
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 39c238d..625219b 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -705,7 +705,7 @@ static struct clksrc_clk *init_parents[] = {
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
 
-void __init_or_cpufreq s3c6400_setup_clocks(void)
+void __init_or_cpufreq s3c64xx_setup_clocks(void)
 {
 	struct clk *xtal_clk;
 	unsigned long xtal;
@@ -804,7 +804,7 @@ static struct clk *clks[] __initdata = {
  * as ARMCLK as well as the necessary parent clocks.
  *
  * This call does not setup the clocks, which is left to the
- * s3c6400_setup_clocks() call which may be needed by the cpufreq
+ * s3c64xx_setup_clocks() call which may be needed by the cpufreq
  * or resume code to re-set the clocks if the bootloader has changed
  * them.
  */
diff --git a/arch/arm/mach-s3c64xx/irq-eint.c b/arch/arm/mach-s3c64xx/common.c
similarity index 51%
rename from arch/arm/mach-s3c64xx/irq-eint.c
rename to arch/arm/mach-s3c64xx/common.c
index 4d203be..8ae5b16 100644
--- a/arch/arm/mach-s3c64xx/irq-eint.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -1,11 +1,13 @@
-/* arch/arm/plat-s3c64xx/irq-eint.c
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
  *
- * S3C64XX - Interrupt handling for IRQ_EINT(x)
+ * Common Codes for S3C64XX machines
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,21 +15,182 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/sysdev.h>
-#include <linux/gpio.h>
-#include <linux/irq.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
 
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <asm/hardware/vic.h>
 
-#include <plat/regs-irqtype.h>
+#include <mach/map.h>
+#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <plat/gpio-cfg.h>
 
-#include <mach/map.h>
 #include <plat/cpu.h>
+#include <plat/clock.h>
+#include <plat/devs.h>
 #include <plat/pm.h>
+#include <plat/gpio-cfg.h>
+#include <plat/irq-uart.h>
+#include <plat/irq-vic-timer.h>
+#include <plat/regs-irqtype.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
+
+/* uart registration process */
+
+void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg, no);
+}
+
+/* table of supported CPUs */
+
+static const char name_s3c6400[] = "S3C6400";
+static const char name_s3c6410[] = "S3C6410";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= S3C6400_CPU_ID,
+		.idmask		= S3C64XX_CPU_MASK,
+		.map_io		= s3c6400_map_io,
+		.init_clocks	= s3c6400_init_clocks,
+		.init_uarts	= s3c64xx_init_uarts,
+		.init		= s3c6400_init,
+		.name		= name_s3c6400,
+	}, {
+		.idcode		= S3C6410_CPU_ID,
+		.idmask		= S3C64XX_CPU_MASK,
+		.map_io		= s3c6410_map_io,
+		.init_clocks	= s3c6410_init_clocks,
+		.init_uarts	= s3c64xx_init_uarts,
+		.init		= s3c6410_init,
+		.name		= name_s3c6410,
+	},
+};
+
+/* minimal IO mapping */
+
+/* see notes on uart map in arch/arm/mach-s3c64xx/include/mach/debug-macro.S */
+#define UART_OFFS (S3C_PA_UART & 0xfffff)
+
+static struct map_desc s3c_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S3C_VA_SYS,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_SYSCON),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_MEM,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_SROM),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)(S3C_VA_UART + UART_OFFS),
+		.pfn		= __phys_to_pfn(S3C_PA_UART),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC0,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_VIC0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC1,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_VIC1),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_TIMER,
+		.pfn		= __phys_to_pfn(S3C_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C64XX_VA_GPIO,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_GPIO),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C64XX_VA_MODEM,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_MODEM),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_WATCHDOG),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
+		.pfn		= __phys_to_pfn(S3C64XX_PA_USB_HSPHY),
+		.length		= SZ_1K,
+		.type		= MT_DEVICE,
+	},
+};
+
+struct sysdev_class s3c64xx_sysclass = {
+	.name	= "s3c64xx-core",
+};
+
+static struct sys_device s3c64xx_sysdev = {
+	.cls	= &s3c64xx_sysclass,
+};
+
+/* read cpu identification code */
+
+void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
+{
+	/* initialise the io descriptors we need for initialisation */
+	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
+	iotable_init(mach_desc, size);
+	init_consistent_dma_size(SZ_8M);
+
+	/* detect cpu id */
+	s3c64xx_init_cpu();
+
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
+
+static __init int s3c64xx_sysdev_init(void)
+{
+	sysdev_class_register(&s3c64xx_sysclass);
+	return sysdev_register(&s3c64xx_sysdev);
+}
+core_initcall(s3c64xx_sysdev_init);
+
+/*
+ * setup the sources the vic should advertise resume
+ * for, even though it is not doing the wake
+ * (set_irq_wake needs to be valid)
+ */
+#define IRQ_VIC0_RESUME (1 << (IRQ_RTC_TIC - IRQ_VIC0_BASE))
+#define IRQ_VIC1_RESUME (1 << (IRQ_RTC_ALARM - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_PENDN - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_HSMMC0 - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_HSMMC1 - IRQ_VIC1_BASE) |	\
+			 1 << (IRQ_HSMMC2 - IRQ_VIC1_BASE))
+
+void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
+{
+	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
+
+	/* initialise the pair of VICs */
+	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
+	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
+
+	/* add the timer sub-irqs */
+	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
+}
 
 #define eint_offset(irq)	((irq) - IRQ_EINT(0))
 #define eint_irq_to_bit(irq)	((u32)(1 << eint_offset(irq)))
@@ -209,5 +372,4 @@ static int __init s3c64xx_init_irq_eint(void)
 
 	return 0;
 }
-
 arch_initcall(s3c64xx_init_irq_eint);
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
new file mode 100644
index 0000000..9f523a2
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * Common Header for S3C64XX machines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_S3C64XX_COMMON_H
+#define __ARCH_ARM_MACH_S3C64XX_COMMON_H
+
+void s3c64xx_init_irq(u32 vic0, u32 vic1);
+void s3c64xx_init_io(struct map_desc *mach_desc, int size);
+
+void s3c64xx_register_clocks(unsigned long xtal, unsigned armclk_limit);
+void s3c64xx_setup_clocks(void);
+
+extern struct syscore_ops s3c64xx_irq_syscore_ops;
+extern struct sysdev_class s3c64xx_sysclass;
+
+#ifdef CONFIG_CPU_S3C6400
+
+extern  int s3c6400_init(void);
+extern void s3c6400_init_irq(void);
+extern void s3c6400_map_io(void);
+extern void s3c6400_init_clocks(int xtal);
+
+#else
+#define s3c6400_init_clocks NULL
+#define s3c6400_map_io NULL
+#define s3c6400_init NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C6410
+
+extern  int s3c6410_init(void);
+extern void s3c6410_init_irq(void);
+extern void s3c6410_map_io(void);
+extern void s3c6410_init_clocks(int xtal);
+
+#else
+#define s3c6410_init_clocks NULL
+#define s3c6410_map_io NULL
+#define s3c6410_init NULL
+#endif
+
+#endif /* __ARCH_ARM_MACH_S3C64XX_COMMON_H */
diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
deleted file mode 100644
index de085b7..0000000
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/* linux/arch/arm/plat-s3c64xx/cpu.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX CPU Support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/sysdev.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/dma-mapping.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <plat/regs-serial.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/clock.h>
-
-#include <plat/s3c6400.h>
-#include <plat/s3c6410.h>
-
-/* table of supported CPUs */
-
-static const char name_s3c6400[] = "S3C6400";
-static const char name_s3c6410[] = "S3C6410";
-
-static struct cpu_table cpu_ids[] __initdata = {
-	{
-		.idcode		= S3C6400_CPU_ID,
-		.idmask		= S3C64XX_CPU_MASK,
-		.map_io		= s3c6400_map_io,
-		.init_clocks	= s3c6400_init_clocks,
-		.init_uarts	= s3c6400_init_uarts,
-		.init		= s3c6400_init,
-		.name		= name_s3c6400,
-	}, {
-		.idcode		= S3C6410_CPU_ID,
-		.idmask		= S3C64XX_CPU_MASK,
-		.map_io		= s3c6410_map_io,
-		.init_clocks	= s3c6410_init_clocks,
-		.init_uarts	= s3c6410_init_uarts,
-		.init		= s3c6410_init,
-		.name		= name_s3c6410,
-	},
-};
-
-/* minimal IO mapping */
-
-/* see notes on uart map in arch/arm/mach-s3c6400/include/mach/debug-macro.S */
-#define UART_OFFS (S3C_PA_UART & 0xfffff)
-
-static struct map_desc s3c_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S3C_VA_SYS,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_SYSCON),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_MEM,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_SROM),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)(S3C_VA_UART + UART_OFFS),
-		.pfn		= __phys_to_pfn(S3C_PA_UART),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC0,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_VIC0),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC1,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_VIC1),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_TIMER,
-		.pfn		= __phys_to_pfn(S3C_PA_TIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C64XX_VA_GPIO,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_GPIO),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C64XX_VA_MODEM,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_MODEM),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_WATCHDOG),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
-		.pfn		= __phys_to_pfn(S3C64XX_PA_USB_HSPHY),
-		.length		= SZ_1K,
-		.type		= MT_DEVICE,
-	},
-};
-
-
-struct sysdev_class s3c64xx_sysclass = {
-	.name	= "s3c64xx-core",
-};
-
-static struct sys_device s3c64xx_sysdev = {
-	.cls	= &s3c64xx_sysclass,
-};
-
-/* uart registration process */
-
-void __init s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	s3c24xx_init_uartdevs("s3c6400-uart", s3c64xx_uart_resources, cfg, no);
-}
-
-/* read cpu identification code */
-
-void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
-{
-	/* initialise the io descriptors we need for initialisation */
-	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
-	iotable_init(mach_desc, size);
-	init_consistent_dma_size(SZ_8M);
-
-	/* detect cpu id */
-	s3c64xx_init_cpu();
-
-	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
-}
-
-static __init int s3c64xx_sysdev_init(void)
-{
-	sysdev_class_register(&s3c64xx_sysclass);
-	return sysdev_register(&s3c64xx_sysdev);
-}
-
-core_initcall(s3c64xx_sysdev_init);
diff --git a/arch/arm/mach-s3c64xx/irq.c b/arch/arm/mach-s3c64xx/irq.c
deleted file mode 100644
index b07357e..0000000
--- a/arch/arm/mach-s3c64xx/irq.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/* arch/arm/plat-s3c64xx/irq.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C64XX - Interrupt handling
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/serial_core.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <asm/hardware/vic.h>
-
-#include <mach/map.h>
-#include <plat/irq-vic-timer.h>
-#include <plat/irq-uart.h>
-#include <plat/cpu.h>
-
-/* setup the sources the vic should advertise resume for, even though it
- * is not doing the wake (set_irq_wake needs to be valid) */
-#define IRQ_VIC0_RESUME (1 << (IRQ_RTC_TIC - IRQ_VIC0_BASE))
-#define IRQ_VIC1_RESUME (1 << (IRQ_RTC_ALARM - IRQ_VIC1_BASE) |	\
-			 1 << (IRQ_PENDN - IRQ_VIC1_BASE) |	\
-			 1 << (IRQ_HSMMC0 - IRQ_VIC1_BASE) |	\
-			 1 << (IRQ_HSMMC1 - IRQ_VIC1_BASE) |	\
-			 1 << (IRQ_HSMMC2 - IRQ_VIC1_BASE))
-
-void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
-{
-	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
-
-	/* initialise the pair of VICs */
-	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
-	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
-
-	/* add the timer sub-irqs */
-	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
-}
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 2bbc14d..bad1d0d 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -46,13 +46,14 @@
 #include <plat/fb.h>
 #include <plat/regs-fb-v4.h>
 
-#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-modem.h>
 
+#include "common.h"
+
 /* DM9000 */
 #define ANW6410_PA_DM9000	(0x18000000)
 
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 988ac2e..b7350b0 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -51,7 +51,6 @@
 
 #include <mach/regs-gpio-memport.h>
 
-#include <plat/s3c6410.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
@@ -67,6 +66,8 @@
 #include <plat/iic.h>
 #include <plat/pm.h>
 
+#include "common.h"
+
 /* serial port setup */
 
 #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index c5955f3..df38602 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -38,12 +38,13 @@
 #include <plat/fb.h>
 #include <plat/nand.h>
 
-#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
 #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 4415c85..72ebe5d 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -34,7 +34,6 @@
 #include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
 
-#include <plat/s3c6410.h>
 #include <plat/adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
@@ -46,6 +45,8 @@
 
 #include <video/platform_lcd.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
 #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 9b2c610..8bec707 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -40,12 +40,13 @@
 #include <plat/iic.h>
 #include <plat/fb.h>
 
-#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index dbab49f..853c41e 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -35,7 +35,6 @@
 #include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
 
-#include <plat/s3c6410.h>
 #include <plat/adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
@@ -47,6 +46,8 @@
 
 #include <video/platform_lcd.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
 #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index cb1ebeb..ce31db1 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -40,6 +40,8 @@
 
 #include <video/platform_lcd.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
 #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 0539452..2804526 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -24,13 +24,13 @@
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c6410.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
 #include "mach-smartq.h"
 
 static struct gpio_led smartq5_leds[] = {
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index a58d1ba..a0f9d1a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -24,13 +24,13 @@
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c6410.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
 #include "mach-smartq.h"
 
 static struct gpio_led smartq7_leds[] = {
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index be28a59..57a7eaa 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -32,12 +32,13 @@
 
 #include <plat/regs-serial.h>
 
-#include <plat/s3c6400.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/iic.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 0830915..cba6714 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -64,7 +64,6 @@
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
-#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -74,6 +73,8 @@
 #include <plat/backlight.h>
 #include <plat/regs-fb-v4.h>
 
+#include "common.h"
+
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 7a3bc32..3336658 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -38,7 +38,8 @@
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
-#include <plat/s3c6400.h>
+
+#include "common.h"
 
 void __init s3c6400_map_io(void)
 {
@@ -60,7 +61,7 @@ void __init s3c6400_map_io(void)
 void __init s3c6400_init_clocks(int xtal)
 {
 	s3c64xx_register_clocks(xtal, S3C6400_CLKDIV0_ARM_MASK);
-	s3c6400_setup_clocks();
+	s3c64xx_setup_clocks();
 }
 
 void __init s3c6400_init_irq(void)
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 4117003..fba71bd 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -41,8 +41,8 @@
 #include <plat/adc-core.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
-#include <plat/s3c6400.h>
-#include <plat/s3c6410.h>
+
+#include "common.h"
 
 void __init s3c6410_map_io(void)
 {
@@ -66,7 +66,7 @@ void __init s3c6410_init_clocks(int xtal)
 {
 	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
 	s3c64xx_register_clocks(xtal, S3C6410_CLKDIV0_ARM_MASK);
-	s3c6400_setup_clocks();
+	s3c64xx_setup_clocks();
 }
 
 void __init s3c6410_init_irq(void)
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 40fd7b6..abbdadb 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -152,11 +152,9 @@ extern void s3c_init_cpu(unsigned long idcode,
 /* core initialisation functions */
 
 extern void s3c24xx_init_irq(void);
-extern void s3c64xx_init_irq(u32 vic0, u32 vic1);
 extern void s5p_init_irq(u32 *vic, u32 num_vic);
 
 extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
-extern void s3c64xx_init_io(struct map_desc *mach_desc, int size);
 extern void s5p_init_io(struct map_desc *mach_desc,
 			int size, void __iomem *cpuid_addr);
 
@@ -183,7 +181,6 @@ extern struct syscore_ops s3c2410_pm_syscore_ops;
 extern struct syscore_ops s3c2412_pm_syscore_ops;
 extern struct syscore_ops s3c2416_pm_syscore_ops;
 extern struct syscore_ops s3c244x_pm_syscore_ops;
-extern struct syscore_ops s3c64xx_irq_syscore_ops;
 
 /* system device classes */
 
@@ -195,7 +192,6 @@ extern struct sysdev_class s3c2440_sysclass;
 extern struct sysdev_class s3c2442_sysclass;
 extern struct sysdev_class s3c2443_sysclass;
 extern struct sysdev_class s3c6410_sysclass;
-extern struct sysdev_class s3c64xx_sysclass;
 extern struct sysdev_class s5p64x0_sysclass;
 extern struct sysdev_class s5pv210_sysclass;
 extern struct sysdev_class exynos4_sysclass;
diff --git a/arch/arm/plat-samsung/include/plat/s3c6400.h b/arch/arm/plat-samsung/include/plat/s3c6400.h
deleted file mode 100644
index 37d428a..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c6400.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c6400.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Header file for s3c6400 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for S3C6400 related SoCs */
-
-extern void s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s3c6400_setup_clocks(void);
-
-extern void s3c64xx_register_clocks(unsigned long xtal, unsigned armclk_limit);
-
-#ifdef CONFIG_CPU_S3C6400
-
-extern  int s3c6400_init(void);
-extern void s3c6400_init_irq(void);
-extern void s3c6400_map_io(void);
-extern void s3c6400_init_clocks(int xtal);
-
-#define s3c6400_init_uarts s3c6400_common_init_uarts
-
-#else
-#define s3c6400_init_clocks NULL
-#define s3c6400_init_uarts NULL
-#define s3c6400_map_io NULL
-#define s3c6400_init NULL
-#endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c6410.h b/arch/arm/plat-samsung/include/plat/s3c6410.h
deleted file mode 100644
index 20a6675..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c6410.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c6410.h
- *
- * Copyright 2008 Openmoko,  Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Header file for s3c6410 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C6410
-
-extern  int s3c6410_init(void);
-extern void s3c6410_init_irq(void);
-extern void s3c6410_map_io(void);
-extern void s3c6410_init_clocks(int xtal);
-
-#define s3c6410_init_uarts s3c6400_common_init_uarts
-
-#else
-#define s3c6410_init_clocks NULL
-#define s3c6410_init_uarts NULL
-#define s3c6410_map_io NULL
-#define s3c6410_init NULL
-#endif
-- 
1.7.4.4
