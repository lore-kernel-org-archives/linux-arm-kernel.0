From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Jan 2010 17:49:08 +0900
Subject: [PATCH v4 1/8] ARM: S5P6440: Add new CPU initialization support
Message-ID: <1263286148-19883-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Samsung's S5P6440 CPU support.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/cpu.c                      |  112 ++++++++++++++++++++++
 arch/arm/mach-s5p6440/include/mach/debug-macro.S |   37 +++++++
 arch/arm/mach-s5p6440/include/mach/entry-macro.S |   16 +++
 arch/arm/mach-s5p6440/include/mach/gpio-core.h   |   19 ++++
 arch/arm/mach-s5p6440/include/mach/gpio.h        |   80 +++++++++++++++
 arch/arm/mach-s5p6440/include/mach/hardware.h    |   18 ++++
 arch/arm/mach-s5p6440/include/mach/map.h         |  102 ++++++++++++++++++++
 arch/arm/mach-s5p6440/include/mach/memory.h      |   19 ++++
 arch/arm/mach-s5p6440/include/mach/uncompress.h  |   24 +++++
 arch/arm/plat-s3c/include/plat/cpu.h             |    2 +
 arch/arm/plat-s5p/cpu.c                          |   88 +++++++++++++++++
 arch/arm/plat-s5p/include/plat/s5p6440.h         |   37 +++++++
 arch/arm/plat-s5p/s5p6440-init.c                 |   50 ++++++++++
 arch/arm/plat-s5p/setup-i2c0.c                   |   25 +++++
 14 files changed, 629 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/cpu.c
 create mode 100644 arch/arm/mach-s5p6440/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-s5p6440/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5p6440/include/mach/gpio-core.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/hardware.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/map.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/memory.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/uncompress.h
 create mode 100644 arch/arm/plat-s5p/cpu.c
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p6440.h
 create mode 100644 arch/arm/plat-s5p/s5p6440-init.c
 create mode 100644 arch/arm/plat-s5p/setup-i2c0.c

diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
new file mode 100644
index 0000000..8742708
--- /dev/null
+++ b/arch/arm/mach-s5p6440/cpu.c
@@ -0,0 +1,112 @@
+/* linux/arch/arm/mach-s5p6440/cpu.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
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
+
+#include <asm/proc-fns.h>
+#include <mach/idle.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <asm/irq.h>
+
+#include <plat/regs-serial.h>
+#include <mach/regs-clock.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/s5p6440.h>
+
+static void s5p6440_idle(void)
+{
+	unsigned long val;
+
+	val = __raw_readl(S5P_PWR_CFG);
+	val &= ~(0x3<<5);
+	val |= (0x1<<5);
+	__raw_writel(val, S5P_PWR_CFG);
+
+	cpu_do_idle();
+}
+
+/* s5p6440_map_io
+ *
+ * register the standard cpu IO areas
+*/
+
+void __init s5p6440_map_io(void)
+{
+	/* set idle function */
+	s3c_idle_fn = s5p6440_idle;
+
+	/* initialize device information early */
+}
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
+void __init s5p6440_init_irq(void)
+{
+	/* S5P6440 supports only 2 VIC */
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
+struct sysdev_class s5p6440_sysclass = {
+	.name	= "s5p6440-core",
+};
+
+static struct sys_device s5p6440_sysdev = {
+	.cls	= &s5p6440_sysclass,
+};
+
+static int __init s5p6440_core_init(void)
+{
+	return sysdev_class_register(&s5p6440_sysclass);
+}
+
+core_initcall(s5p6440_core_init);
+
+int __init s5p6440_init(void)
+{
+	printk(KERN_INFO "S5P6440: Initializing architecture\n");
+
+	return sysdev_register(&s5p6440_sysdev);
+}
diff --git a/arch/arm/mach-s5p6440/include/mach/debug-macro.S b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
new file mode 100644
index 0000000..f3a5d16
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/debug-macro.S
@@ -0,0 +1,37 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/debug-macro.S
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* pull in the relevant register and map files. */
+
+#include <mach/map.h>
+#include <plat/regs-serial.h>
+
+	/* note, for the boot process to work we have to keep the UART
+	 * virtual address aligned to an 1MiB boundary for the L1
+	 * mapping the head code makes. We keep the UART virtual address
+	 * aligned and add in the offset when we load the value here.
+	 */
+
+	.macro addruart, rx
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1
+		ldreq	\rx, = S5P_PA_UART
+		ldrne	\rx, = (S5P_VA_UART + S5P_PA_UART & 0xfffff)
+#if CONFIG_DEBUG_S3C_UART != 0
+		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+#endif
+	.endm
+
+/* include the reset of the code which will do the work, we're only
+ * compiling for a single cpu processor type so the default of s3c2440
+ * will be fine with us.
+ */
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5p6440/include/mach/entry-macro.S b/arch/arm/mach-s5p6440/include/mach/entry-macro.S
new file mode 100644
index 0000000..e65f1b9
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/entry-macro.S
@@ -0,0 +1,16 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/entry-macro.S
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Low-level IRQ helper macros for the Samsung S5P6440
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <mach/map.h>
+#include <plat/irqs.h>
+
+#include <asm/entry-macro-vic2.S>
diff --git a/arch/arm/mach-s5p6440/include/mach/gpio-core.h b/arch/arm/mach-s5p6440/include/mach/gpio-core.h
new file mode 100644
index 0000000..ff7fb30
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/gpio-core.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/gpio-core.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - GPIO core support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_CORE_H
+#define __ASM_ARCH_GPIO_CORE_H __FILE__
+
+/* currently we just include the platform support */
+#include <plat/gpio-core.h>
+
+#endif /* __ASM_ARCH_GPIO_CORE_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/gpio.h b/arch/arm/mach-s5p6440/include/mach/gpio.h
new file mode 100644
index 0000000..2178383
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/gpio.h
@@ -0,0 +1,80 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/gpio.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+/* GPIO bank sizes */
+#define S5P6440_GPIO_A_NR	(6)
+#define S5P6440_GPIO_B_NR	(7)
+#define S5P6440_GPIO_C_NR	(8)
+#define S5P6440_GPIO_F_NR	(2)
+#define S5P6440_GPIO_G_NR	(7)
+#define S5P6440_GPIO_H_NR	(10)
+#define S5P6440_GPIO_I_NR	(16)
+#define S5P6440_GPIO_J_NR	(12)
+#define S5P6440_GPIO_N_NR	(16)
+#define S5P6440_GPIO_P_NR	(8)
+#define S5P6440_GPIO_R_NR	(15)
+
+/* GPIO bank numbers */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+#define S5P6440_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	S5P6440_GPIO_A_START = 0,
+	S5P6440_GPIO_B_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_A),
+	S5P6440_GPIO_C_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_B),
+	S5P6440_GPIO_F_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_C),
+	S5P6440_GPIO_G_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_F),
+	S5P6440_GPIO_H_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_G),
+	S5P6440_GPIO_I_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_H),
+	S5P6440_GPIO_J_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_I),
+	S5P6440_GPIO_N_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_J),
+	S5P6440_GPIO_P_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_N),
+	S5P6440_GPIO_R_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_P),
+};
+
+/* S5P6440 GPIO number definitions. */
+#define S5P6440_GPA(_nr)	(S5P6440_GPIO_A_START + (_nr))
+#define S5P6440_GPB(_nr)	(S5P6440_GPIO_B_START + (_nr))
+#define S5P6440_GPC(_nr)	(S5P6440_GPIO_C_START + (_nr))
+#define S5P6440_GPF(_nr)	(S5P6440_GPIO_F_START + (_nr))
+#define S5P6440_GPG(_nr)	(S5P6440_GPIO_G_START + (_nr))
+#define S5P6440_GPH(_nr)	(S5P6440_GPIO_H_START + (_nr))
+#define S5P6440_GPI(_nr)	(S5P6440_GPIO_I_START + (_nr))
+#define S5P6440_GPJ(_nr)	(S5P6440_GPIO_J_START + (_nr))
+#define S5P6440_GPN(_nr)	(S5P6440_GPIO_N_START + (_nr))
+#define S5P6440_GPP(_nr)	(S5P6440_GPIO_P_START + (_nr))
+#define S5P6440_GPR(_nr)	(S5P6440_GPIO_R_START + (_nr))
+
+/* the end of the S5P6440 specific gpios */
+#define S5P6440_GPIO_END	(S5P6440_GPR(S5P6440_GPIO_R_NR) + 1)
+#define S3C_GPIO_END		S5P6440_GPIO_END
+
+/* define the number of gpios we need to the one after the GPR() range */
+#define ARCH_NR_GPIOS		(S5P6440_GPR(S5P6440_GPIO_R_NR) +	\
+				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/hardware.h b/arch/arm/mach-s5p6440/include/mach/hardware.h
new file mode 100644
index 0000000..be8b26e
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/hardware.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/hardware.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - Hardware support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H __FILE__
+
+/* currently nothing here, placeholder */
+
+#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
new file mode 100644
index 0000000..401436f
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -0,0 +1,102 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/map.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - Memory map definitions
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
+
+/* SYSCON */
+#define S5P6440_PA_SYSCON	(0xE0100000)
+#define S5P_PA_SYSCON		S5P6440_PA_SYSCON
+#define S5P_VA_SYSCON		S3C_VA_SYS
+
+#define S5P6440_PA_CLK		(S5P6440_PA_SYSCON + 0x0)
+#define S5P_PA_CLK		S5P6440_PA_CLK
+#define S5P_VA_CLK		(S5P_VA_SYSCON + 0x0)
+
+#define S5P6440_PA_OTHER	(S5P6440_PA_SYSCON + 0x100)
+#define S5P_PA_OTHER		S5P6440_PA_OTHER
+#define S5P_VA_OTHER		(S5P_VA_SYSCON + 0x100)
+
+#define S5P6440_PA_PWR		(S5P6440_PA_SYSCON + 0x800)
+#define S5P_PA_PWR		S5P6440_PA_PWR
+#define S5P_VA_PWR		(S5P_VA_SYSCON + 0x800)
+
+/* GPIO */
+#define S5P6440_PA_GPIO		(0xE0308000)
+#define S5P_PA_GPIO		S5P6440_PA_GPIO
+#define S5P_VA_GPIO		S3C_ADDR(0x00500000)
+
+/* VIC0 */
+#define S5P6440_PA_VIC0		(0xE4000000)
+#define S5P_PA_VIC0		S5P6440_PA_VIC0
+#define S5P_VA_VIC0		(S3C_VA_IRQ + 0x0)
+#define VA_VIC0			S5P_VA_VIC0
+
+/* VIC1 */
+#define S5P6440_PA_VIC1		(0xE4100000)
+#define S5P_PA_VIC1		S5P6440_PA_VIC1
+#define S5P_VA_VIC1		(S3C_VA_IRQ + 0x10000)
+#define VA_VIC1			S5P_VA_VIC1
+
+/* Timer */
+#define S5P6440_PA_TIMER	(0xEA000000)
+#define S5P_PA_TIMER		S5P6440_PA_TIMER
+#define S5P_VA_TIMER		S3C_VA_TIMER
+
+/* RTC */
+#define S5P6440_PA_RTC		(0xEA100000)
+#define S5P_PA_RTC		S5P6440_PA_RTC
+#define S5P_VA_RTC		S3C_ADDR(0x00600000)
+
+/* WDT */
+#define S5P6440_PA_WDT		(0xEA200000)
+#define S5P_PA_WDT		S5P6440_PA_WDT
+#define S5p_VA_WDT		S3C_VA_WATCHDOG
+
+/* UART */
+#define S5P6440_PA_UART		(0xEC000000)
+#define S5P_PA_UART		S5P6440_PA_UART
+#define S5P_VA_UART		S3C_VA_UART
+
+#define S5P_PA_UART0		(S5P_PA_UART + 0x0)
+#define S5P_PA_UART1		(S5P_PA_UART + 0x400)
+#define S5P_PA_UART2		(S5P_PA_UART + 0x800)
+#define S5P_PA_UART3		(S5P_PA_UART + 0xC00)
+#define S5P_UART_OFFSET		(0x400)
+
+#define S5P_VA_UARTx(x)		(S5P_VA_UART + (S5P_PA_UART & 0xfffff) \
+				+ ((x) * S5P_UART_OFFSET))
+
+#define S5P_VA_UART0		S5P_VA_UARTx(0)
+#define S5P_VA_UART1		S5P_VA_UARTx(1)
+#define S5P_VA_UART2		S5P_VA_UARTx(2)
+#define S5P_VA_UART3		S5P_VA_UARTx(3)
+#define S5P_SZ_UART		SZ_256
+
+/* I2C */
+#define S5P6440_PA_IIC0		(0xEC104000)
+#define S5P_PA_IIC0		S5P6440_PA_IIC0
+#define S5p_VA_IIC0		S3C_ADDR(0x00700000)
+
+/* SDRAM */
+#define S5P6440_PA_SDRAM	(0x20000000)
+#define S5P_PA_SDRAM		S5P6440_PA_SDRAM
+
+/* compatibiltiy defines. */
+#define S3C_PA_UART		S5P_PA_UART
+#define S3C_UART_OFFSET		S5P_UART_OFFSET
+#define S3C_PA_TIMER		S5P_PA_TIMER
+#define S3C_PA_IIC		S5P_PA_IIC0
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/memory.h b/arch/arm/mach-s5p6440/include/mach/memory.h
new file mode 100644
index 0000000..d62910c
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/memory.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/memory.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - Memory definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PHYS_OFFSET     	UL(0x20000000)
+#define CONSISTENT_DMA_SIZE	SZ_8M
+
+#endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/uncompress.h b/arch/arm/mach-s5p6440/include/mach/uncompress.h
new file mode 100644
index 0000000..7c1f600
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/uncompress.h
@@ -0,0 +1,24 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/uncompress.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - uncompress code
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
+#include <plat/uncompress.h>
+
+static void arch_detect_cpu(void)
+{
+	/* we do not need to do any cpu detection here at the moment. */
+}
+
+#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/plat-s3c/include/plat/cpu.h b/arch/arm/plat-s3c/include/plat/cpu.h
index d1131ca..d8e134c 100644
--- a/arch/arm/plat-s3c/include/plat/cpu.h
+++ b/arch/arm/plat-s3c/include/plat/cpu.h
@@ -48,9 +48,11 @@ extern void s3c_init_cpu(unsigned long idcode,
 
 extern void s3c24xx_init_irq(void);
 extern void s3c64xx_init_irq(u32 vic0, u32 vic1);
+extern void s5p_init_irq(u32 *vic, u32 num_vic);
 
 extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
 extern void s3c64xx_init_io(struct map_desc *mach_desc, int size);
+extern void s5p_init_io(struct map_desc *mach_desc, int size);
 
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
new file mode 100644
index 0000000..7e1ade6
--- /dev/null
+++ b/arch/arm/plat-s5p/cpu.c
@@ -0,0 +1,88 @@
+/* linux/arch/arm/plat-s5p/cpu.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P CPU Support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <mach/map.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/regs-clock.h>
+#include <plat/cpu.h>
+#include <plat/s5p6440.h>
+
+/* table of supported CPUs */
+
+static const char name_s5p6440[] = "S5P6440";
+
+static struct cpu_table cpu_ids[] __initdata = {
+	{
+		.idcode		= 0x56440100,
+		.idmask		= 0xffffff00,
+		.map_io		= s5p6440_map_io,
+		.init_clocks	= s5p6440_init_clocks,
+		.init_uarts	= s5p6440_init_uarts,
+		.init		= s5p6440_init,
+		.name		= name_s5p6440,
+	},
+};
+
+/* minimal IO mapping */
+
+#define UART_OFFS (S5P_PA_UART & 0xfffff)
+
+static struct map_desc s5p_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSCON,
+		.pfn		= __phys_to_pfn(S5P_PA_SYSCON),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)(S5P_VA_UART + UART_OFFS),
+		.pfn		= __phys_to_pfn(S5P_PA_UART),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_VIC0,
+		.pfn		= __phys_to_pfn(S5P_PA_VIC0),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_VIC1,
+		.pfn		= __phys_to_pfn(S5P_PA_VIC1),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_TIMER,
+		.pfn		= __phys_to_pfn(S5P_PA_TIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GPIO,
+		.pfn		= __phys_to_pfn(S5P_PA_GPIO),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+/* read cpu identification code */
+
+void __init s5p_init_io(struct map_desc *mach_desc, int size)
+{
+	unsigned long idcode;
+
+	/* initialize the io descriptors we need for initialization */
+	iotable_init(s5p_iodesc, ARRAY_SIZE(s5p_iodesc));
+	iotable_init(mach_desc, size);
+
+	idcode = __raw_readl(S5P_SYS_ID);
+	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
+}
diff --git a/arch/arm/plat-s5p/include/plat/s5p6440.h b/arch/arm/plat-s5p/include/plat/s5p6440.h
new file mode 100644
index 0000000..a4cd75a
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5p6440.h
@@ -0,0 +1,37 @@
+/* arch/arm/plat-s5p/include/plat/s5p6440.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for s5p6440 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+ /* Common init code for S5P6440 related SoCs */
+
+extern void s5p6440_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5p6440_register_clocks(void);
+extern void s5p6440_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5P6440
+
+extern  int s5p6440_init(void);
+extern void s5p6440_init_irq(void);
+extern void s5p6440_map_io(void);
+extern void s5p6440_init_clocks(int xtal);
+
+#define s5p6440_init_uarts s5p6440_common_init_uarts
+
+#else
+#define s5p6440_init_clocks NULL
+#define s5p6440_init_uarts NULL
+#define s5p6440_map_io NULL
+#define s5p6440_init NULL
+#endif
+
+/* S5P6440 timer */
+
+extern struct sys_timer s5p6440_timer;
diff --git a/arch/arm/plat-s5p/s5p6440-init.c b/arch/arm/plat-s5p/s5p6440-init.c
new file mode 100644
index 0000000..9017825
--- /dev/null
+++ b/arch/arm/plat-s5p/s5p6440-init.c
@@ -0,0 +1,50 @@
+/* linux/arch/arm/plat-s5p/s5p6440-init.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
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
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/s5p6440.h>
+#include <plat/regs-serial.h>
+
+static struct s3c24xx_uart_clksrc s5p6440_serial_clocks[] = {
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
+void __init s5p6440_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5p6440_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5p6440_serial_clocks);
+		}
+	}
+
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
+}
diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/plat-s5p/setup-i2c0.c
new file mode 100644
index 0000000..67a66e0
--- /dev/null
+++ b/arch/arm/plat-s5p/setup-i2c0.c
@@ -0,0 +1,25 @@
+/* linux/arch/arm/plat-s5p/setup-i2c0.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C0 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <plat/iic.h>
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	/* Will be populated later */
+}
-- 
1.6.2.5
