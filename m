From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 07:51:08 +0200
Subject: [PATCH 1/4] ARM: Samsung: move S5PC100 support from plat-s5pc1xx to
	plat-s5p framework
In-Reply-To: <1274334671-21838-1-git-send-email-m.szyprowski@samsung.com>
References: <1274334671-21838-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274334671-21838-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S5PC100 SoC support to plat-s5p framework. Most
periperal support code has been already moved from plat-s5pc1xx to
mach-s5pc100.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig                                   |    9 +-
 arch/arm/Makefile                                  |    3 +-
 arch/arm/mach-s5pc100/Kconfig                      |    7 +-
 arch/arm/mach-s5pc100/Makefile                     |    3 +-
 arch/arm/mach-s5pc100/cpu.c                        |   56 ++++---
 arch/arm/mach-s5pc100/gpiolib.c                    |   24 ++--
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    6 +-
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    8 +-
 arch/arm/mach-s5pc100/include/mach/irqs.h          |  101 +++++++++++++-
 arch/arm/mach-s5pc100/include/mach/map.h           |  156 +++++---------------
 arch/arm/mach-s5pc100/include/mach/regs-clock.h    |    6 +
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h     |    6 +-
 arch/arm/mach-s5pc100/include/mach/regs-irq.h      |    7 +-
 arch/arm/mach-s5pc100/include/mach/system.h        |    9 +-
 arch/arm/mach-s5pc100/include/mach/tick.h          |    4 +-
 .../s5pc100-init.c => mach-s5pc100/init.c}         |    7 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |   11 +-
 arch/arm/plat-s5p/Kconfig                          |    2 +-
 arch/arm/plat-s5p/cpu.c                            |   10 ++
 arch/arm/plat-s5p/include/plat/s5pc100.h           |   33 ++++
 arch/arm/plat-samsung/Kconfig                      |    2 +-
 21 files changed, 267 insertions(+), 203 deletions(-)
 rename arch/arm/{plat-s5pc1xx/s5pc100-init.c => mach-s5pc100/init.c} (68%)
 create mode 100644 arch/arm/plat-s5p/include/plat/s5pc100.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f8718f..1cb098f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -699,14 +699,14 @@ config ARCH_S5P6442
 	help
 	  Samsung S5P6442 CPU based systems
 
-config ARCH_S5PC1XX
-	bool "Samsung S5PC1XX"
+config ARCH_S5PC100
+	bool "Samsung S5PC100"
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
 	help
-	  Samsung S5PC1XX series based systems
+	  Samsung S5PC100 series based systems
 
 config ARCH_S5PV210
 	bool "Samsung S5PV210/S5PC110"
@@ -890,7 +890,6 @@ source "arch/arm/mach-sa1100/Kconfig"
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s5p/Kconfig"
-source "arch/arm/plat-s5pc1xx/Kconfig"
 
 if ARCH_S3C2410
 source "arch/arm/mach-s3c2400/Kconfig"
@@ -909,9 +908,7 @@ source "arch/arm/mach-s5p6440/Kconfig"
 
 source "arch/arm/mach-s5p6442/Kconfig"
 
-if ARCH_S5PC1XX
 source "arch/arm/mach-s5pc100/Kconfig"
-endif
 
 source "arch/arm/mach-s5pv210/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9505a70..f7cb6d4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -167,7 +167,7 @@ machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
 machine-$(CONFIG_ARCH_S5P6442)		:= s5p6442
-machine-$(CONFIG_ARCH_S5PC1XX)		:= s5pc100
+machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
@@ -192,7 +192,6 @@ plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
 plat-$(CONFIG_PLAT_ORION)	:= orion
 plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
-plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx samsung
 plat-$(CONFIG_PLAT_S5P)		:= s5p samsung
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 70b57d1..fe1216b 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -5,10 +5,11 @@
 
 # Configuration options for the S5PC100 CPU
 
+if ARCH_S5PC100
+
 config CPU_S5PC100
 	bool
-	select CPU_S5PC100_INIT
-	select CPU_S5PC100_CLOCK
+	select PLAT_S5P
 	help
 	  Enable S5PC100 CPU support
 
@@ -46,3 +47,5 @@ config MACH_SMDKC100
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
+
+endif
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 9a545ca..9b52d2a 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -11,7 +11,7 @@ obj-				:=
 
 # Core support for S5PC100 system
 
-obj-$(CONFIG_CPU_S5PC100)	+= cpu.o gpiolib.o
+obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o gpiolib.o
 obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
 
 # Helper and device support
@@ -22,4 +22,5 @@ obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
+
 obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index d79e757..d424a9f 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -22,47 +22,53 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 
-#include <asm/proc-fns.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <asm/proc-fns.h>
+
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <asm/irq.h>
 
-#include <plat/cpu-freq.h>
 #include <plat/regs-serial.h>
-#include <plat/regs-power.h>
+#include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/sdhci.h>
 #include <plat/iic-core.h>
+#include <plat/sdhci.h>
 #include <plat/s5pc100.h>
 
 /* Initial IO mappings */
 
 static struct map_desc s5pc100_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
+		.pfn		= __phys_to_pfn(S5PC100_PA_SYSTIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC2,
+		.pfn		= __phys_to_pfn(S5PC100_PA_VIC2),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5PC100_VA_OTHERS,
+		.pfn		= __phys_to_pfn(S5PC100_PA_OTHERS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}
 };
 
 static void s5pc100_idle(void)
 {
-	unsigned long tmp;
-
-	tmp = __raw_readl(S5PC100_PWR_CFG);
-	tmp &= ~S5PC100_PWRCFG_CFG_DEEP_IDLE;
-	tmp &= ~S5PC100_PWRCFG_CFG_WFI_MASK;
-	tmp |= S5PC100_PWRCFG_CFG_WFI_DEEP_IDLE;
-	__raw_writel(tmp, S5PC100_PWR_CFG);
+	if (!need_resched())
+		cpu_do_idle();
 
-	tmp = __raw_readl(S5PC100_OTHERS);
-	tmp |= S5PC100_PMU_INT_DISABLE;
-	__raw_writel(tmp, S5PC100_OTHERS);
-
-	cpu_do_idle();
+	local_irq_enable();
 }
 
 /* s5pc100_map_io
@@ -86,22 +92,23 @@ void __init s5pc100_map_io(void)
 
 void __init s5pc100_init_clocks(int xtal)
 {
-	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
 	s3c24xx_register_baseclocks(xtal);
-	s5pc1xx_register_clocks();
+	s5p_register_clocks(xtal);
 	s5pc100_register_clocks();
 	s5pc100_setup_clocks();
 }
 
 void __init s5pc100_init_irq(void)
 {
-	u32 vic_valid[] = {~0, ~0, ~0};
+	u32 vic[] = {~0, ~0, ~0};
 
 	/* VIC0, VIC1, and VIC2 are fully populated. */
-	s5pc1xx_init_irq(vic_valid, ARRAY_SIZE(vic_valid));
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
 }
 
-struct sysdev_class s5pc100_sysclass = {
+static struct sysdev_class s5pc100_sysclass = {
 	.name	= "s5pc100-core",
 };
 
@@ -118,9 +125,10 @@ core_initcall(s5pc100_core_init);
 
 int __init s5pc100_init(void)
 {
-	printk(KERN_DEBUG "S5PC100: Initialising architecture\n");
+	printk(KERN_INFO "S5PC100: Initializing architecture\n");
 
-	s5pc1xx_idle = s5pc100_idle;
+	/* set idle function */
+	pm_idle = s5pc100_idle;
 
 	return sysdev_register(&s5pc100_sysdev);
 }
diff --git a/arch/arm/mach-s5pc100/gpiolib.c b/arch/arm/mach-s5pc100/gpiolib.c
index c8e8336..494a53b 100644
--- a/arch/arm/mach-s5pc100/gpiolib.c
+++ b/arch/arm/mach-s5pc100/gpiolib.c
@@ -1,10 +1,10 @@
 /*
- * arch/arm/plat-s5pc1xx/gpiolib.c
+ * arch/arm/plat-s5pc100/gpiolib.c
  *
  *  Copyright 2009 Samsung Electronics Co
  *  Kyungmin Park <kyungmin.park@samsung.com>
  *
- * S5PC1XX - GPIOlib support
+ * S5PC100 - GPIOlib support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -62,12 +62,12 @@
  */
 
 #if 0
-static int s5pc1xx_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
+static int s5pc100_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	return S3C_IRQ_GPIO(chip->base + offset);
 }
 
-static int s5pc1xx_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
+static int s5pc100_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
 {
 	int base;
 
@@ -382,8 +382,8 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
 };
 
 /* FIXME move from irq-gpio.c */
-extern struct irq_chip s5pc1xx_gpioint;
-extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
+extern struct irq_chip s5pc100_gpioint;
+extern void s5pc100_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
 
 static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 {
@@ -392,21 +392,21 @@ static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 	if (chip->config == &gpio_cfg) {
 		int i, irq;
 
-		chip->chip.to_irq = s5pc1xx_gpiolib_to_irq;
+		chip->chip.to_irq = s5pc100_gpiolib_to_irq;
 
 		for (i = 0;  i < chip->chip.ngpio; i++) {
 			irq = S3C_IRQ_GPIO_BASE + chip->chip.base + i;
-			set_irq_chip(irq, &s5pc1xx_gpioint);
+			set_irq_chip(irq, &s5pc100_gpioint);
 			set_irq_data(irq, &chip->chip);
 			set_irq_handler(irq, handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID);
 		}
 	} else if (chip->config == &gpio_cfg_eint)
-		chip->chip.to_irq = s5pc1xx_gpiolib_to_eint;
+		chip->chip.to_irq = s5pc100_gpiolib_to_eint;
 #endif
 }
 
-static __init int s5pc1xx_gpiolib_init(void)
+static __init int s5pc100_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip;
 	int nr_chips;
@@ -421,8 +421,8 @@ static __init int s5pc1xx_gpiolib_init(void)
 				       ARRAY_SIZE(s5pc100_gpio_chips));
 #if 0
 	/* Interrupt */
-	set_irq_chained_handler(IRQ_GPIOINT, s5pc1xx_irq_gpioint_handler);
+	set_irq_chained_handler(IRQ_GPIOINT, s5pc100_irq_gpioint_handler);
 #endif
 	return 0;
 }
-core_initcall(s5pc1xx_gpiolib_init);
+core_initcall(s5pc100_gpiolib_init);
diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
index e181f57..70e02e9 100644
--- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
@@ -22,12 +22,14 @@
 	 * aligned and add in the offset when we load the value here.
 	 */
 
-	.macro addruart, rx, tmp
+	.macro addruart, rx, rtmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1
 		ldreq	\rx, = S3C_PA_UART
-		ldrne	\rx, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
+		ldrne	\rx, = S3C_VA_UART
+#if CONFIG_DEBUG_S3C_UART != 0
 		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+#endif
 	.endm
 
 /* include the reset of the code which will do the work, we're only
diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
index 6713193..ba76af0 100644
--- a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
+++ b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
@@ -20,7 +20,7 @@
 	.endm
 
 	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =S3C_VA_VIC0
+	ldr	\base, =VA_VIC0
 	.endm
 
 	.macro	arch_ret_to_user, tmp1, tmp2
@@ -29,18 +29,18 @@
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	@ check the vic0
-	mov	\irqnr, # S3C_IRQ_OFFSET + 31
+	mov	\irqnr, # S5P_IRQ_OFFSET + 31
 	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
 	teq	\irqstat, #0
 
 	@ otherwise try vic1
-	addeq	\tmp, \base, #(S3C_VA_VIC1 - S3C_VA_VIC0)
+	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
 	addeq	\irqnr, \irqnr, #32
 	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
 	teqeq	\irqstat, #0
 
 	@ otherwise try vic2
-	addeq	\tmp, \base, #(S3C_VA_VIC2 - S3C_VA_VIC0)
+	addeq	\tmp, \base, #(VA_VIC2 - VA_VIC0)
 	addeq	\irqnr, \irqnr, #32
 	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
 	teqeq	\irqstat, #0
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index b53fa48..84c74ac 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -11,9 +11,106 @@
 
 #include <plat/irqs.h>
 
-/* LCD */
+/* VIC0: system, DMA, timer */
+#define IRQ_EINT16_31		S5P_IRQ_VIC0(16)
+#define IRQ_BATF		S5P_IRQ_VIC0(17)
+#define IRQ_MDMA		S5P_IRQ_VIC0(18)
+#define IRQ_PDMA0		S5P_IRQ_VIC0(19)
+#define IRQ_PDMA1		S5P_IRQ_VIC0(20)
+#define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(21)
+#define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(22)
+#define IRQ_TIMER2_VIC		S5P_IRQ_VIC0(23)
+#define IRQ_TIMER3_VIC		S5P_IRQ_VIC0(24)
+#define IRQ_TIMER4_VIC		S5P_IRQ_VIC0(25)
+#define IRQ_SYSTIMER		S5P_IRQ_VIC0(26)
+#define IRQ_WDT			S5P_IRQ_VIC0(27)
+#define IRQ_RTC_ALARM		S5P_IRQ_VIC0(28)
+#define IRQ_RTC_TIC		S5P_IRQ_VIC0(29)
+#define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
+
+/* VIC1: ARM, power, memory, connectivity */
+#define IRQ_CORTEX0		S5P_IRQ_VIC1(0)
+#define IRQ_CORTEX1		S5P_IRQ_VIC1(1)
+#define IRQ_CORTEX2		S5P_IRQ_VIC1(2)
+#define IRQ_CORTEX3		S5P_IRQ_VIC1(3)
+#define IRQ_CORTEX4		S5P_IRQ_VIC1(4)
+#define IRQ_IEMAPC		S5P_IRQ_VIC1(5)
+#define IRQ_IEMIEC		S5P_IRQ_VIC1(6)
+#define IRQ_ONENAND		S5P_IRQ_VIC1(7)
+#define IRQ_NFC			S5P_IRQ_VIC1(8)
+#define IRQ_CFC			S5P_IRQ_VIC1(9)
+#define IRQ_UART0		S5P_IRQ_VIC1(10)
+#define IRQ_UART1		S5P_IRQ_VIC1(11)
+#define IRQ_UART2		S5P_IRQ_VIC1(12)
+#define IRQ_UART3		S5P_IRQ_VIC1(13)
+#define IRQ_IIC			S5P_IRQ_VIC1(14)
+#define IRQ_SPI0		S5P_IRQ_VIC1(15)
+#define IRQ_SPI1		S5P_IRQ_VIC1(16)
+#define IRQ_SPI2		S5P_IRQ_VIC1(17)
+#define IRQ_IRDA		S5P_IRQ_VIC1(18)
+#define IRQ_CAN0		S5P_IRQ_VIC1(19)
+#define IRQ_CAN1		S5P_IRQ_VIC1(20)
+#define IRQ_HSIRX		S5P_IRQ_VIC1(21)
+#define IRQ_HSITX		S5P_IRQ_VIC1(22)
+#define IRQ_UHOST		S5P_IRQ_VIC1(23)
+#define IRQ_OTG			S5P_IRQ_VIC1(24)
+#define IRQ_MSM			S5P_IRQ_VIC1(25)
+#define IRQ_HSMMC0		S5P_IRQ_VIC1(26)
+#define IRQ_HSMMC1		S5P_IRQ_VIC1(27)
+#define IRQ_HSMMC2		S5P_IRQ_VIC1(28)
+#define IRQ_MIPICSI		S5P_IRQ_VIC1(29)
+#define IRQ_MIPIDSI		S5P_IRQ_VIC1(30)
+
+/* VIC2: multimedia, audio, security */
+#define IRQ_LCD0		S5P_IRQ_VIC2(0)
+#define IRQ_LCD1		S5P_IRQ_VIC2(1)
+#define IRQ_LCD2		S5P_IRQ_VIC2(2)
+#define IRQ_LCD3		S5P_IRQ_VIC2(3)
+#define IRQ_ROTATOR		S5P_IRQ_VIC2(4)
+#define IRQ_FIMC0		S5P_IRQ_VIC2(5)
+#define IRQ_FIMC1		S5P_IRQ_VIC2(6)
+#define IRQ_FIMC2		S5P_IRQ_VIC2(7)
+#define IRQ_JPEG		S5P_IRQ_VIC2(8)
+#define IRQ_2D			S5P_IRQ_VIC2(9)
+#define IRQ_3D			S5P_IRQ_VIC2(10)
+#define IRQ_MIXER		S5P_IRQ_VIC2(11)
+#define IRQ_HDMI		S5P_IRQ_VIC2(12)
+#define IRQ_IIC1		S5P_IRQ_VIC2(13)
+#define IRQ_MFC			S5P_IRQ_VIC2(14)
+#define IRQ_TVENC		S5P_IRQ_VIC2(15)
+#define IRQ_I2S0		S5P_IRQ_VIC2(16)
+#define IRQ_I2S1		S5P_IRQ_VIC2(17)
+#define IRQ_I2S2		S5P_IRQ_VIC2(18)
+#define IRQ_AC97		S5P_IRQ_VIC2(19)
+#define IRQ_PCM0		S5P_IRQ_VIC2(20)
+#define IRQ_PCM1		S5P_IRQ_VIC2(21)
+#define IRQ_SPDIF		S5P_IRQ_VIC2(22)
+#define IRQ_ADC			S5P_IRQ_VIC2(23)
+#define IRQ_PENDN		S5P_IRQ_VIC2(24)
+#define IRQ_TC			IRQ_PENDN
+#define IRQ_KEYPAD		S5P_IRQ_VIC2(25)
+#define IRQ_CG			S5P_IRQ_VIC2(26)
+#define IRQ_SEC			S5P_IRQ_VIC2(27)
+#define IRQ_SECRX		S5P_IRQ_VIC2(28)
+#define IRQ_SECTX		S5P_IRQ_VIC2(29)
+#define IRQ_SDMIRQ		S5P_IRQ_VIC2(30)
+#define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
+#define IRQ_VIC_END		S5P_IRQ_VIC2(31)
+
+#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
+
+#define IRQ_EINT(x)             ((x) < 16 ? S5P_IRQ_VIC0(x) : \
+					(S5P_IRQ_EINT_BASE + (x)-16))
+
+#define S3C_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
+#define S3C_IRQ_GPIO(x)		(S3C_IRQ_GPIO_BASE + (x))
+
+/* Until MP04 Groups -> 40 (exactly 39) Groups * 8 ~= 320 GPIOs */
+#define NR_IRQS		(S3C_IRQ_GPIO(320) + 1)
+
+/* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
 #define IRQ_LCD_VSYNC		IRQ_LCD1
 #define IRQ_LCD_SYSTEM		IRQ_LCD2
 
-#endif /* __ASM_ARCH_IRQ_H */
+#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index 4681ebe..6428f48 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -3,9 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *	Byungho Min <bhmin@samsung.com>
  *
- * Based on mach-s3c6400/include/mach/map.h
- *
- * S5PC1XX - Memory map definitions
+ * S5PC100 - Memory map definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,135 +14,59 @@
 #define __ASM_ARCH_MAP_H __FILE__
 
 #include <plat/map-base.h>
+#include <plat/map-s5p.h>
 
-/*
- * map-base.h has already defined virtual memory address
- * S3C_VA_IRQ		S3C_ADDR(0x00000000)	irq controller(s)
- * S3C_VA_SYS		S3C_ADDR(0x00100000)	system control
- * S3C_VA_MEM		S3C_ADDR(0x00200000)	system control (not used)
- * S3C_VA_TIMER		S3C_ADDR(0x00300000)	timer block
- * S3C_VA_WATCHDOG	S3C_ADDR(0x00400000)	watchdog
- * S3C_VA_UART		S3C_ADDR(0x01000000)	UART
- *
- * S5PC100 specific virtual memory address can be defined here
- * S5PC1XX_VA_GPIO	S3C_ADDR(0x00500000)	GPIO
- *
- */
-
-/* Chip ID */
 #define S5PC100_PA_CHIPID	(0xE0000000)
-#define S5PC1XX_PA_CHIPID	S5PC100_PA_CHIPID
-#define S5PC1XX_VA_CHIPID	S3C_VA_SYS
-
-/* System */
-#define S5PC100_PA_CLK		(0xE0100000)
-#define S5PC100_PA_CLK_OTHER	(0xE0200000)
-#define S5PC100_PA_PWR		(0xE0108000)
-#define S5PC1XX_PA_CLK		S5PC100_PA_CLK
-#define S5PC1XX_PA_PWR		S5PC100_PA_PWR
-#define S5PC1XX_PA_CLK_OTHER	S5PC100_PA_CLK_OTHER
-#define S5PC1XX_VA_CLK		(S3C_VA_SYS + 0x10000)
-#define S5PC1XX_VA_PWR		(S3C_VA_SYS + 0x20000)
-#define S5PC1XX_VA_CLK_OTHER	(S3C_VA_SYS + 0x30000)
-
-/* GPIO */
+#define S5P_PA_CHIPID		S5PC100_PA_CHIPID
+
+#define S5PC100_PA_SYSCON	(0xE0100000)
+#define S5P_PA_SYSCON		S5PC100_PA_SYSCON
+
+#define S5PC100_PA_OTHERS	(0xE0200000)
+#define S5PC100_VA_OTHERS	(S3C_VA_SYS + 0x10000)
+
 #define S5PC100_PA_GPIO		(0xE0300000)
-#define S5PC1XX_PA_GPIO		S5PC100_PA_GPIO
-#define S5PC1XX_VA_GPIO		S3C_ADDR(0x00500000)
-
-/* Interrupt */
-#define S5PC100_PA_VIC		(0xE4000000)
-#define S5PC100_VA_VIC		S3C_VA_IRQ
-#define S5PC100_PA_VIC_OFFSET	0x100000
-#define S5PC100_VA_VIC_OFFSET	0x10000
-#define S5PC1XX_PA_VIC(x)	(S5PC100_PA_VIC + ((x) * S5PC100_PA_VIC_OFFSET))
-#define S5PC1XX_VA_VIC(x)	(S5PC100_VA_VIC + ((x) * S5PC100_VA_VIC_OFFSET))
-
-/* DMA */
-#define S5PC100_PA_MDMA		(0xE8100000)
-#define S5PC100_PA_PDMA0	(0xE9000000)
-#define S5PC100_PA_PDMA1	(0xE9200000)
-
-/* Timer */
-#define S5PC100_PA_TIMER	(0xEA000000)
-#define S5PC1XX_PA_TIMER	S5PC100_PA_TIMER
-#define S5PC1XX_VA_TIMER	S3C_VA_TIMER
+#define S5P_PA_GPIO		S5PC100_PA_GPIO
 
-/* RTC */
-#define S5PC100_PA_RTC		(0xEA300000)
+#define S5PC100_PA_VIC0		(0xE4000000)
+#define S5P_PA_VIC0		S5PC100_PA_VIC0
 
-/* UART */
-#define S5PC100_PA_UART		(0xEC000000)
-#define S5PC1XX_PA_UART		S5PC100_PA_UART
-#define S5PC1XX_VA_UART		S3C_VA_UART
+#define S5PC100_PA_VIC1		(0xE4100000)
+#define S5P_PA_VIC1		S5PC100_PA_VIC1
 
-/* I2C */
-#define S5PC100_PA_I2C		(0xEC100000)
-#define S5PC100_PA_I2C1		(0xEC200000)
+#define S5PC100_PA_VIC2		(0xE4200000)
+#define S5P_PA_VIC2		S5PC100_PA_VIC2
 
-/* USB HS OTG */
-#define S5PC100_PA_USB_HSOTG	(0xED200000)
-#define S5PC100_PA_USB_HSPHY	(0xED300000)
+#define S5PC100_PA_TIMER	(0xEA000000)
+#define S5P_PA_TIMER		S5PC100_PA_TIMER
 
-/* SD/MMC */
-#define S5PC100_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
-#define S5PC100_PA_HSMMC0	S5PC100_PA_HSMMC(0)
-#define S5PC100_PA_HSMMC1	S5PC100_PA_HSMMC(1)
-#define S5PC100_PA_HSMMC2	S5PC100_PA_HSMMC(2)
+#define S5PC100_PA_SYSTIMER	(0xEA100000)
 
-/* LCD */
-#define S5PC100_PA_FB		(0xEE000000)
+#define S5PC100_PA_UART		(0xEC000000)
 
-/* Multimedia */
-#define S5PC100_PA_G2D		(0xEE800000)
-#define S5PC100_PA_JPEG		(0xEE500000)
-#define S5PC100_PA_ROTATOR	(0xEE100000)
-#define S5PC100_PA_G3D		(0xEF000000)
+#define S5P_PA_UART0		(S5PC100_PA_UART + 0x0)
+#define S5P_PA_UART1		(S5PC100_PA_UART + 0x400)
+#define S5P_PA_UART2		(S5PC100_PA_UART + 0x800)
+#define S5P_PA_UART3		(S5PC100_PA_UART + 0xC00)
+#define S5P_SZ_UART		SZ_256
 
-/* I2S */
-#define S5PC100_PA_I2S0		(0xF2000000)
-#define S5PC100_PA_I2S1		(0xF2100000)
-#define S5PC100_PA_I2S2		(0xF2200000)
+#define S5PC100_PA_IIC0		(0xEC100000)
+#define S5PC100_PA_IIC1		(0xEC200000)
 
-/* KEYPAD */
-#define S5PC100_PA_KEYPAD	(0xF3100000)
+#define S5PC100_PA_FB		(0xEE000000)
 
-/* ADC & TouchScreen */
-#define S5PC100_PA_TSADC	(0xF3000000)
+#define S5PC100_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
 
-/* ETC */
 #define S5PC100_PA_SDRAM	(0x20000000)
-#define S5PC1XX_PA_SDRAM	S5PC100_PA_SDRAM
+#define S5P_PA_SDRAM		S5PC100_PA_SDRAM
 
-/* compatibility defines. */
-#define S3C_PA_RTC		S5PC100_PA_RTC
+/* compatibiltiy defines. */
 #define S3C_PA_UART		S5PC100_PA_UART
-#define S3C_PA_UART0		(S5PC100_PA_UART + 0x0)
-#define S3C_PA_UART1		(S5PC100_PA_UART + 0x400)
-#define S3C_PA_UART2		(S5PC100_PA_UART + 0x800)
-#define S3C_PA_UART3		(S5PC100_PA_UART + 0xC00)
-#define S3C_VA_UART0		(S3C_VA_UART + 0x0)
-#define S3C_VA_UART1		(S3C_VA_UART + 0x400)
-#define S3C_VA_UART2		(S3C_VA_UART + 0x800)
-#define S3C_VA_UART3		(S3C_VA_UART + 0xC00)
-#define S3C_UART_OFFSET		0x400
-#define S3C_VA_UARTx(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
+#define S3C_PA_IIC		S5PC100_PA_IIC0
+#define S3C_PA_IIC1		S5PC100_PA_IIC1
 #define S3C_PA_FB		S5PC100_PA_FB
-#define S3C_PA_G2D		S5PC100_PA_G2D
-#define S3C_PA_G3D		S5PC100_PA_G3D
-#define S3C_PA_JPEG		S5PC100_PA_JPEG
-#define S3C_PA_ROTATOR		S5PC100_PA_ROTATOR
-#define S3C_VA_VIC0		(S3C_VA_IRQ + 0x0)
-#define S3C_VA_VIC1		(S3C_VA_IRQ + 0x10000)
-#define S3C_VA_VIC2		(S3C_VA_IRQ + 0x20000)
-#define S3C_PA_IIC		S5PC100_PA_I2C
-#define S3C_PA_IIC1		S5PC100_PA_I2C1
-#define S3C_PA_USB_HSOTG	S5PC100_PA_USB_HSOTG
-#define S3C_PA_USB_HSPHY	S5PC100_PA_USB_HSPHY
-#define S3C_PA_HSMMC0		S5PC100_PA_HSMMC0
-#define S3C_PA_HSMMC1		S5PC100_PA_HSMMC1
-#define S3C_PA_HSMMC2		S5PC100_PA_HSMMC2
-#define S3C_PA_KEYPAD		S5PC100_PA_KEYPAD
-#define S3C_PA_TSADC		S5PC100_PA_TSADC
-
-#endif /* __ASM_ARCH_C100_MAP_H */
+#define S3C_PA_HSMMC0		S5PC100_PA_HSMMC(0)
+#define S3C_PA_HSMMC1		S5PC100_PA_HSMMC(1)
+#define S3C_PA_HSMMC2		S5PC100_PA_HSMMC(2)
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-clock.h b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
index f2283bd..5d27d28 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
@@ -17,6 +17,8 @@
 
 #define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
 
+#define S5PC100_REG_OTHERS(x)	(S5PC100_VA_OTHERS + (x))
+
 #define S5P_APLL_LOCK		S5P_CLKREG(0x00)
 #define S5P_MPLL_LOCK		S5P_CLKREG(0x04)
 #define S5P_EPLL_LOCK		S5P_CLKREG(0x08)
@@ -68,4 +70,8 @@
 #define S5P_CLKDIV1_PCLKD1_MASK		(0x7<<16)
 #define S5P_CLKDIV1_PCLKD1_SHIFT	(16)
 
+#define S5PC100_SWRESET		S5PC100_REG_OTHERS(0x000)
+
+#define S5PC100_SWRESET_RESETVAL	0xc100
+
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
index 6866691..cd6200a 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
+/* linux/arch/arm/plat-s5pc100/include/plat/regs-gpio.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
@@ -12,7 +12,7 @@
 #include <mach/map.h>
 
 /* S5PC100 */
-#define S5PC100_GPIO_BASE	S5PC1XX_VA_GPIO
+#define S5PC100_GPIO_BASE	S5P_VA_GPIO
 #define S5PC100_GPA0_BASE	(S5PC100_GPIO_BASE + 0x0000)
 #define S5PC100_GPA1_BASE	(S5PC100_GPIO_BASE + 0x0020)
 #define S5PC100_GPB_BASE	(S5PC100_GPIO_BASE + 0x0040)
@@ -60,7 +60,7 @@
 
 /* Common part */
 /* External interrupt base is same at both s5pc100 and s5pc110 */
-#define S5PC1XX_EINT_BASE	(S5PC100_EINT_BASE)
+#define S5P_EINT_BASE			(S5PC100_EINT_BASE)
 
 #define S5PC100_GPx_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
 #define S5PC100_GPx_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-irq.h b/arch/arm/mach-s5pc100/include/mach/regs-irq.h
index 751ac15..4d9036d 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-irq.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-irq.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *	Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX - IRQ register definitions
+ * S5PC100 - IRQ register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,9 +16,4 @@
 #include <mach/map.h>
 #include <asm/hardware/vic.h>
 
-/* interrupt controller */
-#define S5PC1XX_VIC0REG(x)          		((x) + S5PC1XX_VA_VIC(0))
-#define S5PC1XX_VIC1REG(x)          		((x) + S5PC1XX_VA_VIC(1))
-#define S5PC1XX_VIC2REG(x)         		((x) + S5PC1XX_VA_VIC(2))
-
 #endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-s5pc100/include/mach/system.h
index f0d31a2..681f626 100644
--- a/arch/arm/mach-s5pc100/include/mach/system.h
+++ b/arch/arm/mach-s5pc100/include/mach/system.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX - system implementation
+ * S5PC100 - system implementation
  *
  * Based on mach-s3c6400/include/mach/system.h
  */
@@ -13,14 +13,11 @@
 
 #include <linux/io.h>
 #include <mach/map.h>
-#include <plat/regs-clock.h>
-
-void (*s5pc1xx_idle)(void);
+#include <mach/regs-clock.h>
 
 static void arch_idle(void)
 {
-	if (s5pc1xx_idle)
-		s5pc1xx_idle();
+	/* nothing here yet */
 }
 
 static void arch_reset(char mode, const char *cmd)
diff --git a/arch/arm/mach-s5pc100/include/mach/tick.h b/arch/arm/mach-s5pc100/include/mach/tick.h
index f338c9e..20f6873 100644
--- a/arch/arm/mach-s5pc100/include/mach/tick.h
+++ b/arch/arm/mach-s5pc100/include/mach/tick.h
@@ -20,8 +20,8 @@
  */
 static inline u32 s3c24xx_ostimer_pending(void)
 {
-	u32 pend = __raw_readl(S3C_VA_VIC0 + VIC_RAW_STATUS);
-	return pend & 1 << (IRQ_TIMER4_VIC - S5PC1XX_IRQ_VIC0(0));
+	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
+	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
 }
 
 #define TICK_MAX	(0xffffffff)
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-init.c b/arch/arm/mach-s5pc100/init.c
similarity index 68%
rename from arch/arm/plat-s5pc1xx/s5pc100-init.c
rename to arch/arm/mach-s5pc100/init.c
index c587108..19d7b52 100644
--- a/arch/arm/plat-s5pc1xx/s5pc100-init.c
+++ b/arch/arm/mach-s5pc100/init.c
@@ -1,9 +1,8 @@
-/* linux/arch/arm/plat-s5pc1xx/s5pc100-init.c
+/* linux/arch/arm/plat-s5pc100/s5pc100-init.c
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
  *
- * S5PC100 - CPU initialisation (common with other S5PC1XX chips)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,9 +18,7 @@
 #include <plat/s5pc100.h>
 
 /* uart registration process */
-
 void __init s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
-	/* The driver name is s3c6400-uart to reuse s3c6400_serial_drv  */
-	s3c24xx_init_uartdevs("s3c6400-uart", s5pc1xx_uart_resources, cfg, no);
+	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
 }
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index b6f8a58..a95d8f7 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -149,8 +149,6 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 	.setup_gpio	= s5pc100_fb_gpio_setup_24bpp,
 };
 
-static struct map_desc smdkc100_iodesc[] = {};
-
 static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
@@ -163,7 +161,7 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 
 static void __init smdkc100_map_io(void)
 {
-	s5pc1xx_init_io(smdkc100_iodesc, ARRAY_SIZE(smdkc100_iodesc));
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdkc100_uartcfgs, ARRAY_SIZE(smdkc100_uartcfgs));
 }
@@ -187,10 +185,9 @@ static void __init smdkc100_machine_init(void)
 
 MACHINE_START(SMDKC100, "SMDKC100")
 	/* Maintainer: Byungho Min <bhmin@samsung.com> */
-	.phys_io	= S5PC100_PA_UART & 0xfff00000,
-	.io_pg_offst	= (((u32)S5PC1XX_VA_UART) >> 18) & 0xfffc,
-	.boot_params	= S5PC100_PA_SDRAM + 0x100,
-
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
 	.init_irq	= s5pc100_init_irq,
 	.map_io		= smdkc100_map_io,
 	.init_machine	= smdkc100_machine_init,
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index f426e38..11d6a1b 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,7 +7,7 @@
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PV210)
+	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210)
 	default y
 	select ARM_VIC
 	select NO_IOPORT
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index f92e5de..75cb8c3 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -19,12 +19,14 @@
 #include <plat/cpu.h>
 #include <plat/s5p6440.h>
 #include <plat/s5p6442.h>
+#include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
 
 /* table of supported CPUs */
 
 static const char name_s5p6440[] = "S5P6440";
 static const char name_s5p6442[] = "S5P6442";
+static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
 
 static struct cpu_table cpu_ids[] __initdata = {
@@ -45,6 +47,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s5p6442_init,
 		.name		= name_s5p6442,
 	}, {
+		.idcode		= 0x43100000,
+		.idmask		= 0xfffff000,
+		.map_io		= s5pc100_map_io,
+		.init_clocks	= s5pc100_init_clocks,
+		.init_uarts	= s5pc100_init_uarts,
+		.init		= s5pc100_init,
+		.name		= name_s5pc100,
+	}, {
 		.idcode		= 0x43110000,
 		.idmask		= 0xfffff000,
 		.map_io		= s5pv210_map_io,
diff --git a/arch/arm/plat-s5p/include/plat/s5pc100.h b/arch/arm/plat-s5p/include/plat/s5pc100.h
new file mode 100644
index 0000000..5f6099d
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5pc100.h
@@ -0,0 +1,33 @@
+/* arch/arm/plat-s5p/include/plat/s5pc100.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for s5pc100 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5PC100 related SoCs */
+
+extern void s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5pc100_register_clocks(void);
+extern void s5pc100_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5PC100
+
+extern  int s5pc100_init(void);
+extern void s5pc100_init_irq(void);
+extern void s5pc100_map_io(void);
+extern void s5pc100_init_clocks(int xtal);
+
+#define s5pc100_init_uarts s5pc100_common_init_uarts
+
+#else
+#define s5pc100_init_clocks NULL
+#define s5pc100_init_uarts NULL
+#define s5pc100_map_io NULL
+#define s5pc100_init NULL
+#endif
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 229919e..1077ebe 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -6,7 +6,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX || ARCH_S5PC1XX
+	depends on ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX
 	select NO_IOPORT
 	default y
 	help
-- 
1.6.4
