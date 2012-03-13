From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Mar 2012 08:30:38 -0700
Subject: [PATCH v3 07/12] ARM: EXYNOS: add interrupt definitions for EXYNOS5250
In-Reply-To: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331652643-12626-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: EXYNOS: irqs.h for exynos4 and exynos5 - WIP
This patch adds the interrupt definitions for EXYNOS5250 at
<mach/irqs.h> file. Basically, now it is needed for EXYNOS5250
interrupt and will be updated for single zImage next time.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c            |   97 ++++--
 arch/arm/mach-exynos/dev-ahci.c          |    4 +-
 arch/arm/mach-exynos/dev-audio.c         |    4 +-
 arch/arm/mach-exynos/include/mach/irqs.h |  580 ++++++++++++++++++++++--------
 arch/arm/mach-exynos/mct.c               |   23 +-
 arch/arm/plat-s5p/irq-pm.c               |   25 +-
 arch/arm/plat-samsung/irq-vic-timer.c    |   16 +
 7 files changed, 548 insertions(+), 201 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 7fdb139..0b53018 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -345,6 +345,11 @@ static void __init exynos5_map_io(void)
 {
 	iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
 
+	s3c_device_i2c0.resource[0].start = EXYNOS5_PA_IIC(0);
+	s3c_device_i2c0.resource[0].end   = EXYNOS5_PA_IIC(0) + SZ_4K - 1;
+	s3c_device_i2c0.resource[1].start = EXYNOS5_IRQ_IIC;
+	s3c_device_i2c0.resource[1].end   = EXYNOS5_IRQ_IIC;
+
 	/* The I2C bus controllers are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
@@ -451,7 +456,14 @@ static struct irq_chip combiner_chip = {
 
 static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
 {
-	if (combiner_nr >= MAX_COMBINER_NR)
+	unsigned int max_nr;
+
+	if (soc_is_exynos5250())
+		max_nr = EXYNOS5_MAX_COMBINER_NR;
+	else
+		max_nr = EXYNOS4_MAX_COMBINER_NR;
+
+	if (combiner_nr >= max_nr)
 		BUG();
 	if (irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0)
 		BUG();
@@ -462,8 +474,14 @@ static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
 			  unsigned int irq_start)
 {
 	unsigned int i;
+	unsigned int max_nr;
 
-	if (combiner_nr >= MAX_COMBINER_NR)
+	if (soc_is_exynos5250())
+		max_nr = EXYNOS5_MAX_COMBINER_NR;
+	else
+		max_nr = EXYNOS4_MAX_COMBINER_NR;
+
+	if (combiner_nr >= max_nr)
 		BUG();
 
 	combiner_data[combiner_nr].base = base;
@@ -506,7 +524,7 @@ void __init exynos4_init_irq(void)
 		of_irq_init(exynos4_dt_irq_match);
 #endif
 
-	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
+	for (irq = 0; irq < EXYNOS4_MAX_COMBINER_NR; irq++) {
 
 		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
 				COMBINER_IRQ(irq, 0));
@@ -527,7 +545,7 @@ void __init exynos5_init_irq(void)
 
 	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
 
-	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
+	for (irq = 0; irq < EXYNOS5_MAX_COMBINER_NR; irq++) {
 		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
 				COMBINER_IRQ(irq, 0));
 		combiner_cascade_irq(irq, IRQ_SPI(irq));
@@ -651,27 +669,43 @@ static DEFINE_SPINLOCK(eint_lock);
 
 static unsigned int eint0_15_data[16];
 
-static unsigned int exynos4_get_irq_nr(unsigned int number)
-{
-	u32 ret = 0;
-
-	switch (number) {
-	case 0 ... 3:
-		ret = (number + IRQ_EINT0);
-		break;
-	case 4 ... 7:
-		ret = (number + (IRQ_EINT4 - 4));
-		break;
-	case 8 ... 15:
-		ret = (number + (IRQ_EINT8 - 8));
-		break;
-	default:
-		printk(KERN_ERR "number available : %d\n", number);
-	}
-
-	return ret;
-}
+static unsigned int exynos4_eint0_15_src_int[16] = {
+	EXYNOS4_IRQ_EINT0,
+	EXYNOS4_IRQ_EINT1,
+	EXYNOS4_IRQ_EINT2,
+	EXYNOS4_IRQ_EINT3,
+	EXYNOS4_IRQ_EINT4,
+	EXYNOS4_IRQ_EINT5,
+	EXYNOS4_IRQ_EINT6,
+	EXYNOS4_IRQ_EINT7,
+	EXYNOS4_IRQ_EINT8,
+	EXYNOS4_IRQ_EINT9,
+	EXYNOS4_IRQ_EINT10,
+	EXYNOS4_IRQ_EINT11,
+	EXYNOS4_IRQ_EINT12,
+	EXYNOS4_IRQ_EINT13,
+	EXYNOS4_IRQ_EINT14,
+	EXYNOS4_IRQ_EINT15,
+};
 
+static unsigned int exynos5_eint0_15_src_int[16] = {
+	EXYNOS5_IRQ_EINT0,
+	EXYNOS5_IRQ_EINT1,
+	EXYNOS5_IRQ_EINT2,
+	EXYNOS5_IRQ_EINT3,
+	EXYNOS5_IRQ_EINT4,
+	EXYNOS5_IRQ_EINT5,
+	EXYNOS5_IRQ_EINT6,
+	EXYNOS5_IRQ_EINT7,
+	EXYNOS5_IRQ_EINT8,
+	EXYNOS5_IRQ_EINT9,
+	EXYNOS5_IRQ_EINT10,
+	EXYNOS5_IRQ_EINT11,
+	EXYNOS5_IRQ_EINT12,
+	EXYNOS5_IRQ_EINT13,
+	EXYNOS5_IRQ_EINT14,
+	EXYNOS5_IRQ_EINT15,
+};
 static inline void exynos4_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
@@ -846,15 +880,22 @@ static int __init exynos4_init_irq_eint(void)
 		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
 	}
 
-	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
+	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
 
 	for (irq = 0 ; irq <= 15 ; irq++) {
 		eint0_15_data[irq] = IRQ_EINT(irq);
 
-		irq_set_handler_data(exynos4_get_irq_nr(irq),
-				     &eint0_15_data[irq]);
-		irq_set_chained_handler(exynos4_get_irq_nr(irq),
+		if (soc_is_exynos5250()) {
+			irq_set_handler_data(exynos4_eint0_15_src_int[irq],
+					     &eint0_15_data[irq]);
+			irq_set_chained_handler(exynos4_eint0_15_src_int[irq],
+						exynos4_irq_eint0_15);
+		} else {
+			irq_set_handler_data(exynos5_eint0_15_src_int[irq],
+					     &eint0_15_data[irq]);
+			irq_set_chained_handler(exynos5_eint0_15_src_int[irq],
 					exynos4_irq_eint0_15);
+		}
 	}
 
 	return 0;
diff --git a/arch/arm/mach-exynos/dev-ahci.c b/arch/arm/mach-exynos/dev-ahci.c
index f57a3de..50ce5b0 100644
--- a/arch/arm/mach-exynos/dev-ahci.c
+++ b/arch/arm/mach-exynos/dev-ahci.c
@@ -242,8 +242,8 @@ static struct resource exynos4_ahci_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_SATA,
-		.end	= IRQ_SATA,
+		.start	= EXYNOS4_IRQ_SATA,
+		.end	= EXYNOS4_IRQ_SATA,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
index 5a9f9c2e..7199e1a 100644
--- a/arch/arm/mach-exynos/dev-audio.c
+++ b/arch/arm/mach-exynos/dev-audio.c
@@ -304,8 +304,8 @@ static struct resource exynos4_ac97_resource[] = {
 		.flags	= IORESOURCE_DMA,
 	},
 	[4] = {
-		.start	= IRQ_AC97,
-		.end	= IRQ_AC97,
+		.start	= EXYNOS4_IRQ_AC97,
+		.end	= EXYNOS4_IRQ_AC97,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index e27e0f9..6f51361 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -1,9 +1,8 @@
-/* linux/arch/arm/mach-exynos4/include/mach/irqs.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS4 - IRQ definitions
+ * EXYNOS - IRQ definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,170 +16,445 @@
 
 /* PPI: Private Peripheral Interrupt */
 
-#define IRQ_PPI(x)		(x+16)
-
-#define IRQ_MCT_LOCALTIMER	IRQ_PPI(12)
+#define IRQ_PPI(x)			(x + 16)
 
 /* SPI: Shared Peripheral Interrupt */
 
-#define IRQ_SPI(x)		(x+32)
-
-#define IRQ_EINT0		IRQ_SPI(16)
-#define IRQ_EINT1		IRQ_SPI(17)
-#define IRQ_EINT2		IRQ_SPI(18)
-#define IRQ_EINT3		IRQ_SPI(19)
-#define IRQ_EINT4		IRQ_SPI(20)
-#define IRQ_EINT5		IRQ_SPI(21)
-#define IRQ_EINT6		IRQ_SPI(22)
-#define IRQ_EINT7		IRQ_SPI(23)
-#define IRQ_EINT8		IRQ_SPI(24)
-#define IRQ_EINT9		IRQ_SPI(25)
-#define IRQ_EINT10		IRQ_SPI(26)
-#define IRQ_EINT11		IRQ_SPI(27)
-#define IRQ_EINT12		IRQ_SPI(28)
-#define IRQ_EINT13		IRQ_SPI(29)
-#define IRQ_EINT14		IRQ_SPI(30)
-#define IRQ_EINT15		IRQ_SPI(31)
-#define IRQ_EINT16_31		IRQ_SPI(32)
-
-#define IRQ_PDMA0		IRQ_SPI(35)
-#define IRQ_PDMA1		IRQ_SPI(36)
-#define IRQ_TIMER0_VIC		IRQ_SPI(37)
-#define IRQ_TIMER1_VIC		IRQ_SPI(38)
-#define IRQ_TIMER2_VIC		IRQ_SPI(39)
-#define IRQ_TIMER3_VIC		IRQ_SPI(40)
-#define IRQ_TIMER4_VIC		IRQ_SPI(41)
-#define IRQ_MCT_L0		IRQ_SPI(42)
-#define IRQ_WDT			IRQ_SPI(43)
-#define IRQ_RTC_ALARM		IRQ_SPI(44)
-#define IRQ_RTC_TIC		IRQ_SPI(45)
-#define IRQ_GPIO_XB		IRQ_SPI(46)
-#define IRQ_GPIO_XA		IRQ_SPI(47)
-#define IRQ_MCT_L1		IRQ_SPI(48)
-
-#define IRQ_UART0		IRQ_SPI(52)
-#define IRQ_UART1		IRQ_SPI(53)
-#define IRQ_UART2		IRQ_SPI(54)
-#define IRQ_UART3		IRQ_SPI(55)
-#define IRQ_UART4		IRQ_SPI(56)
-#define IRQ_MCT_G0		IRQ_SPI(57)
-#define IRQ_IIC			IRQ_SPI(58)
-#define IRQ_IIC1		IRQ_SPI(59)
-#define IRQ_IIC2		IRQ_SPI(60)
-#define IRQ_IIC3		IRQ_SPI(61)
-#define IRQ_IIC4		IRQ_SPI(62)
-#define IRQ_IIC5		IRQ_SPI(63)
-#define IRQ_IIC6		IRQ_SPI(64)
-#define IRQ_IIC7		IRQ_SPI(65)
-#define IRQ_SPI0		IRQ_SPI(66)
-#define IRQ_SPI1		IRQ_SPI(67)
-#define IRQ_SPI2		IRQ_SPI(68)
-
-#define IRQ_USB_HOST		IRQ_SPI(70)
-#define IRQ_USB_HSOTG		IRQ_SPI(71)
-#define IRQ_MODEM_IF		IRQ_SPI(72)
-#define IRQ_HSMMC0		IRQ_SPI(73)
-#define IRQ_HSMMC1		IRQ_SPI(74)
-#define IRQ_HSMMC2		IRQ_SPI(75)
-#define IRQ_HSMMC3		IRQ_SPI(76)
-#define IRQ_DWMCI		IRQ_SPI(77)
-
-#define IRQ_MIPI_CSIS0		IRQ_SPI(78)
-#define IRQ_MIPI_CSIS1		IRQ_SPI(80)
-
-#define IRQ_ONENAND_AUDI	IRQ_SPI(82)
-#define IRQ_ROTATOR		IRQ_SPI(83)
-#define IRQ_FIMC0		IRQ_SPI(84)
-#define IRQ_FIMC1		IRQ_SPI(85)
-#define IRQ_FIMC2		IRQ_SPI(86)
-#define IRQ_FIMC3		IRQ_SPI(87)
-#define IRQ_JPEG		IRQ_SPI(88)
-#define IRQ_2D			IRQ_SPI(89)
-#define IRQ_PCIE		IRQ_SPI(90)
-
-#define IRQ_MIXER		IRQ_SPI(91)
-#define IRQ_HDMI		IRQ_SPI(92)
-#define IRQ_IIC_HDMIPHY		IRQ_SPI(93)
-#define IRQ_MFC			IRQ_SPI(94)
-#define IRQ_SDO			IRQ_SPI(95)
-
-#define IRQ_AUDIO_SS		IRQ_SPI(96)
-#define IRQ_I2S0		IRQ_SPI(97)
-#define IRQ_I2S1		IRQ_SPI(98)
-#define IRQ_I2S2		IRQ_SPI(99)
-#define IRQ_AC97		IRQ_SPI(100)
-
-#define IRQ_SPDIF		IRQ_SPI(104)
-#define IRQ_ADC0		IRQ_SPI(105)
-#define IRQ_PEN0		IRQ_SPI(106)
-#define IRQ_ADC1		IRQ_SPI(107)
-#define IRQ_PEN1		IRQ_SPI(108)
-#define IRQ_KEYPAD		IRQ_SPI(109)
-#define IRQ_PMU			IRQ_SPI(110)
-#define IRQ_GPS			IRQ_SPI(111)
-#define IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
-#define IRQ_SLIMBUS		IRQ_SPI(113)
-
-#define IRQ_TSI			IRQ_SPI(115)
-#define IRQ_SATA		IRQ_SPI(116)
-
-#define MAX_IRQ_IN_COMBINER	8
-#define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(128))
-#define COMBINER_IRQ(x, y)	(COMBINER_GROUP(x) + y)
-
-#define IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(4, 0)
-#define IRQ_SYSMMU_SSS_0	COMBINER_IRQ(4, 1)
-#define IRQ_SYSMMU_FIMC0_0	COMBINER_IRQ(4, 2)
-#define IRQ_SYSMMU_FIMC1_0	COMBINER_IRQ(4, 3)
-#define IRQ_SYSMMU_FIMC2_0	COMBINER_IRQ(4, 4)
-#define IRQ_SYSMMU_FIMC3_0	COMBINER_IRQ(4, 5)
-#define IRQ_SYSMMU_JPEG_0	COMBINER_IRQ(4, 6)
-#define IRQ_SYSMMU_2D_0		COMBINER_IRQ(4, 7)
-
-#define IRQ_SYSMMU_ROTATOR_0	COMBINER_IRQ(5, 0)
-#define IRQ_SYSMMU_MDMA1_0	COMBINER_IRQ(5, 1)
-#define IRQ_SYSMMU_LCD0_M0_0	COMBINER_IRQ(5, 2)
-#define IRQ_SYSMMU_LCD1_M1_0	COMBINER_IRQ(5, 3)
-#define IRQ_SYSMMU_TV_M0_0	COMBINER_IRQ(5, 4)
-#define IRQ_SYSMMU_MFC_M0_0	COMBINER_IRQ(5, 5)
-#define IRQ_SYSMMU_MFC_M1_0	COMBINER_IRQ(5, 6)
-#define IRQ_SYSMMU_PCIE_0	COMBINER_IRQ(5, 7)
-
-#define IRQ_FIMD0_FIFO		COMBINER_IRQ(11, 0)
-#define IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
-#define IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
-
-#define MAX_COMBINER_NR		16
-
-#define IRQ_ADC			IRQ_ADC0
-#define IRQ_TC			IRQ_PEN0
-
-#define S5P_IRQ_EINT_BASE	COMBINER_IRQ(MAX_COMBINER_NR, 0)
-
-#define S5P_EINT_BASE1		(S5P_IRQ_EINT_BASE + 0)
-#define S5P_EINT_BASE2		(S5P_IRQ_EINT_BASE + 16)
-
-/* optional GPIO interrupts */
-#define S5P_GPIOINT_BASE	(S5P_IRQ_EINT_BASE + 32)
-#define IRQ_GPIO1_NR_GROUPS	16
-#define IRQ_GPIO2_NR_GROUPS	9
-#define IRQ_GPIO_END		(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
-
-#define IRQ_TIMER_BASE		(IRQ_GPIO_END + 64)
+#define IRQ_SPI(x)			(x + 32)
 
-/* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
+/* COMBINER */
+
+#define MAX_IRQ_IN_COMBINER		8
+#define COMBINER_GROUP(x)		((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(128))
+#define COMBINER_IRQ(x, y)		(COMBINER_GROUP(x) + y)
+
+/* For EXYNOS4 and EXYNOS5 */
+
+#define EXYNOS_IRQ_MCT_LOCALTIMER	IRQ_PPI(12)
+
+#define EXYNOS_IRQ_EINT16_31		IRQ_SPI(32)
+
+/* For EXYNOS4 SoCs */
+
+#define EXYNOS4_IRQ_EINT0		IRQ_SPI(16)
+#define EXYNOS4_IRQ_EINT1		IRQ_SPI(17)
+#define EXYNOS4_IRQ_EINT2		IRQ_SPI(18)
+#define EXYNOS4_IRQ_EINT3		IRQ_SPI(19)
+#define EXYNOS4_IRQ_EINT4		IRQ_SPI(20)
+#define EXYNOS4_IRQ_EINT5		IRQ_SPI(21)
+#define EXYNOS4_IRQ_EINT6		IRQ_SPI(22)
+#define EXYNOS4_IRQ_EINT7		IRQ_SPI(23)
+#define EXYNOS4_IRQ_EINT8		IRQ_SPI(24)
+#define EXYNOS4_IRQ_EINT9		IRQ_SPI(25)
+#define EXYNOS4_IRQ_EINT10		IRQ_SPI(26)
+#define EXYNOS4_IRQ_EINT11		IRQ_SPI(27)
+#define EXYNOS4_IRQ_EINT12		IRQ_SPI(28)
+#define EXYNOS4_IRQ_EINT13		IRQ_SPI(29)
+#define EXYNOS4_IRQ_EINT14		IRQ_SPI(30)
+#define EXYNOS4_IRQ_EINT15		IRQ_SPI(31)
+
+#define EXYNOS4_IRQ_PDMA0		IRQ_SPI(35)
+#define EXYNOS4_IRQ_PDMA1		IRQ_SPI(36)
+#define EXYNOS4_IRQ_TIMER0_VIC		IRQ_SPI(37)
+#define EXYNOS4_IRQ_TIMER1_VIC		IRQ_SPI(38)
+#define EXYNOS4_IRQ_TIMER2_VIC		IRQ_SPI(39)
+#define EXYNOS4_IRQ_TIMER3_VIC		IRQ_SPI(40)
+#define EXYNOS4_IRQ_TIMER4_VIC		IRQ_SPI(41)
+#define EXYNOS4_IRQ_MCT_L0		IRQ_SPI(42)
+#define EXYNOS4_IRQ_WDT			IRQ_SPI(43)
+#define EXYNOS4_IRQ_RTC_ALARM		IRQ_SPI(44)
+#define EXYNOS4_IRQ_RTC_TIC		IRQ_SPI(45)
+#define EXYNOS4_IRQ_GPIO_XB		IRQ_SPI(46)
+#define EXYNOS4_IRQ_GPIO_XA		IRQ_SPI(47)
+#define EXYNOS4_IRQ_MCT_L1		IRQ_SPI(48)
 
 #define EXYNOS4_IRQ_UART0		IRQ_SPI(52)
 #define EXYNOS4_IRQ_UART1		IRQ_SPI(53)
 #define EXYNOS4_IRQ_UART2		IRQ_SPI(54)
 #define EXYNOS4_IRQ_UART3		IRQ_SPI(55)
 #define EXYNOS4_IRQ_UART4		IRQ_SPI(56)
+#define EXYNOS4_IRQ_MCT_G0		IRQ_SPI(57)
+#define EXYNOS4_IRQ_IIC			IRQ_SPI(58)
+#define EXYNOS4_IRQ_IIC1		IRQ_SPI(59)
+#define EXYNOS4_IRQ_IIC2		IRQ_SPI(60)
+#define EXYNOS4_IRQ_IIC3		IRQ_SPI(61)
+#define EXYNOS4_IRQ_IIC4		IRQ_SPI(62)
+#define EXYNOS4_IRQ_IIC5		IRQ_SPI(63)
+#define EXYNOS4_IRQ_IIC6		IRQ_SPI(64)
+#define EXYNOS4_IRQ_IIC7		IRQ_SPI(65)
+#define EXYNOS4_IRQ_SPI0		IRQ_SPI(66)
+#define EXYNOS4_IRQ_SPI1		IRQ_SPI(67)
+#define EXYNOS4_IRQ_SPI2		IRQ_SPI(68)
+
+#define EXYNOS4_IRQ_USB_HOST		IRQ_SPI(70)
+#define EXYNOS4_IRQ_USB_HSOTG		IRQ_SPI(71)
+#define EXYNOS4_IRQ_MODEM_IF		IRQ_SPI(72)
+#define EXYNOS4_IRQ_HSMMC0		IRQ_SPI(73)
+#define EXYNOS4_IRQ_HSMMC1		IRQ_SPI(74)
+#define EXYNOS4_IRQ_HSMMC2		IRQ_SPI(75)
+#define EXYNOS4_IRQ_HSMMC3		IRQ_SPI(76)
+#define EXYNOS4_IRQ_DWMCI		IRQ_SPI(77)
+
+#define EXYNOS4_IRQ_MIPI_CSIS0		IRQ_SPI(78)
+#define EXYNOS4_IRQ_MIPI_CSIS1		IRQ_SPI(80)
+
+#define EXYNOS4_IRQ_ONENAND_AUDI	IRQ_SPI(82)
+#define EXYNOS4_IRQ_ROTATOR		IRQ_SPI(83)
+#define EXYNOS4_IRQ_FIMC0		IRQ_SPI(84)
+#define EXYNOS4_IRQ_FIMC1		IRQ_SPI(85)
+#define EXYNOS4_IRQ_FIMC2		IRQ_SPI(86)
+#define EXYNOS4_IRQ_FIMC3		IRQ_SPI(87)
+#define EXYNOS4_IRQ_JPEG		IRQ_SPI(88)
+#define EXYNOS4_IRQ_2D			IRQ_SPI(89)
+#define EXYNOS4_IRQ_PCIE		IRQ_SPI(90)
+
+#define EXYNOS4_IRQ_MIXER		IRQ_SPI(91)
+#define EXYNOS4_IRQ_HDMI		IRQ_SPI(92)
+#define EXYNOS4_IRQ_IIC_HDMIPHY		IRQ_SPI(93)
+#define EXYNOS4_IRQ_MFC			IRQ_SPI(94)
+#define EXYNOS4_IRQ_SDO			IRQ_SPI(95)
+
+#define EXYNOS4_IRQ_AUDIO_SS		IRQ_SPI(96)
+#define EXYNOS4_IRQ_I2S0		IRQ_SPI(97)
+#define EXYNOS4_IRQ_I2S1		IRQ_SPI(98)
+#define EXYNOS4_IRQ_I2S2		IRQ_SPI(99)
+#define EXYNOS4_IRQ_AC97		IRQ_SPI(100)
+
+#define EXYNOS4_IRQ_SPDIF		IRQ_SPI(104)
+#define EXYNOS4_IRQ_ADC0		IRQ_SPI(105)
+#define EXYNOS4_IRQ_PEN0		IRQ_SPI(106)
+#define EXYNOS4_IRQ_ADC1		IRQ_SPI(107)
+#define EXYNOS4_IRQ_PEN1		IRQ_SPI(108)
+#define EXYNOS4_IRQ_KEYPAD		IRQ_SPI(109)
+#define EXYNOS4_IRQ_PMU			IRQ_SPI(110)
+#define EXYNOS4_IRQ_GPS			IRQ_SPI(111)
+#define EXYNOS4_IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
+#define EXYNOS4_IRQ_SLIMBUS		IRQ_SPI(113)
+
+#define EXYNOS4_IRQ_TSI			IRQ_SPI(115)
+#define EXYNOS4_IRQ_SATA		IRQ_SPI(116)
+
+#define EXYNOS4_IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(4, 0)
+#define EXYNOS4_IRQ_SYSMMU_SSS_0	COMBINER_IRQ(4, 1)
+#define EXYNOS4_IRQ_SYSMMU_FIMC0_0	COMBINER_IRQ(4, 2)
+#define EXYNOS4_IRQ_SYSMMU_FIMC1_0	COMBINER_IRQ(4, 3)
+#define EXYNOS4_IRQ_SYSMMU_FIMC2_0	COMBINER_IRQ(4, 4)
+#define EXYNOS4_IRQ_SYSMMU_FIMC3_0	COMBINER_IRQ(4, 5)
+#define EXYNOS4_IRQ_SYSMMU_JPEG_0	COMBINER_IRQ(4, 6)
+#define EXYNOS4_IRQ_SYSMMU_2D_0		COMBINER_IRQ(4, 7)
+
+#define EXYNOS4_IRQ_SYSMMU_ROTATOR_0	COMBINER_IRQ(5, 0)
+#define EXYNOS4_IRQ_SYSMMU_MDMA1_0	COMBINER_IRQ(5, 1)
+#define EXYNOS4_IRQ_SYSMMU_LCD0_M0_0	COMBINER_IRQ(5, 2)
+#define EXYNOS4_IRQ_SYSMMU_LCD1_M1_0	COMBINER_IRQ(5, 3)
+#define EXYNOS4_IRQ_SYSMMU_TV_M0_0	COMBINER_IRQ(5, 4)
+#define EXYNOS4_IRQ_SYSMMU_MFC_M0_0	COMBINER_IRQ(5, 5)
+#define EXYNOS4_IRQ_SYSMMU_MFC_M1_0	COMBINER_IRQ(5, 6)
+#define EXYNOS4_IRQ_SYSMMU_PCIE_0	COMBINER_IRQ(5, 7)
+
+#define EXYNOS4_IRQ_FIMD0_FIFO		COMBINER_IRQ(11, 0)
+#define EXYNOS4_IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
+#define EXYNOS4_IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
+
+#define EXYNOS4_MAX_COMBINER_NR		16
+
+#define EXYNOS4_IRQ_GPIO1_NR_GROUPS	16
+#define EXYNOS4_IRQ_GPIO2_NR_GROUPS	9
+
+/*
+ * For Compatibility:
+ * the default is for EXYNOS4, and
+ * for exynos5, should be re-mapped@function
+ */
+
+#define IRQ_TIMER0_VIC			EXYNOS4_IRQ_TIMER0_VIC
+#define IRQ_TIMER1_VIC			EXYNOS4_IRQ_TIMER1_VIC
+#define IRQ_TIMER2_VIC			EXYNOS4_IRQ_TIMER2_VIC
+#define IRQ_TIMER3_VIC			EXYNOS4_IRQ_TIMER3_VIC
+#define IRQ_TIMER4_VIC			EXYNOS4_IRQ_TIMER4_VIC
+
+#define IRQ_WDT				EXYNOS4_IRQ_WDT
+#define IRQ_RTC_ALARM			EXYNOS4_IRQ_RTC_ALARM
+#define IRQ_RTC_TIC			EXYNOS4_IRQ_RTC_TIC
+#define IRQ_GPIO_XB			EXYNOS4_IRQ_GPIO_XB
+#define IRQ_GPIO_XA			EXYNOS4_IRQ_GPIO_XA
+
+#define IRQ_IIC				EXYNOS4_IRQ_IIC
+#define IRQ_IIC1			EXYNOS4_IRQ_IIC1
+#define IRQ_IIC3			EXYNOS4_IRQ_IIC3
+#define IRQ_IIC5			EXYNOS4_IRQ_IIC5
+#define IRQ_IIC7			EXYNOS4_IRQ_IIC7
+
+#define IRQ_USB_HOST			EXYNOS4_IRQ_USB_HOST
+
+#define IRQ_HSMMC0			EXYNOS4_IRQ_HSMMC0
+#define IRQ_HSMMC1			EXYNOS4_IRQ_HSMMC1
+#define IRQ_HSMMC2			EXYNOS4_IRQ_HSMMC2
+#define IRQ_HSMMC3			EXYNOS4_IRQ_HSMMC3
+
+#define IRQ_MIPI_CSIS0			EXYNOS4_IRQ_MIPI_CSIS0
+
+#define IRQ_ONENAND_AUDI		EXYNOS4_IRQ_ONENAND_AUDI
+
+#define IRQ_FIMC0			EXYNOS4_IRQ_FIMC0
+#define IRQ_FIMC1			EXYNOS4_IRQ_FIMC1
+#define IRQ_FIMC2			EXYNOS4_IRQ_FIMC2
+#define IRQ_FIMC3			EXYNOS4_IRQ_FIMC3
+
+#define IRQ_MIXER			EXYNOS4_IRQ_MIXER
+#define IRQ_HDMI			EXYNOS4_IRQ_HDMI
+#define IRQ_IIC_HDMIPHY			EXYNOS4_IRQ_IIC_HDMIPHY
+#define IRQ_MFC				EXYNOS4_IRQ_MFC
+#define IRQ_SDO				EXYNOS4_IRQ_SDO
+
+#define IRQ_ADC				EXYNOS4_IRQ_ADC0
+#define IRQ_TC				EXYNOS4_IRQ_PEN0
+
+#define IRQ_KEYPAD			EXYNOS4_IRQ_KEYPAD
+#define IRQ_PMU				EXYNOS4_IRQ_PMU
+
+#define IRQ_SYSMMU_MDMA0_0		EXYNOS4_IRQ_SYSMMU_MDMA0_0
+#define IRQ_SYSMMU_SSS_0                EXYNOS4_IRQ_SYSMMU_SSS_0
+#define IRQ_SYSMMU_FIMC0_0              EXYNOS4_IRQ_SYSMMU_FIMC0_0
+#define IRQ_SYSMMU_FIMC1_0              EXYNOS4_IRQ_SYSMMU_FIMC1_0
+#define IRQ_SYSMMU_FIMC2_0              EXYNOS4_IRQ_SYSMMU_FIMC2_0
+#define IRQ_SYSMMU_FIMC3_0              EXYNOS4_IRQ_SYSMMU_FIMC3_0
+#define IRQ_SYSMMU_JPEG_0               EXYNOS4_IRQ_SYSMMU_JPEG_0
+#define IRQ_SYSMMU_2D_0                 EXYNOS4_IRQ_SYSMMU_2D_0
 
+#define IRQ_SYSMMU_ROTATOR_0            EXYNOS4_IRQ_SYSMMU_ROTATOR_0
+#define IRQ_SYSMMU_MDMA1_0              EXYNOS4_IRQ_SYSMMU_MDMA1_0
+#define IRQ_SYSMMU_LCD0_M0_0            EXYNOS4_IRQ_SYSMMU_LCD0_M0_0
+#define IRQ_SYSMMU_LCD1_M1_0            EXYNOS4_IRQ_SYSMMU_LCD1_M1_0
+#define IRQ_SYSMMU_TV_M0_0              EXYNOS4_IRQ_SYSMMU_TV_M0_0
+#define IRQ_SYSMMU_MFC_M0_0             EXYNOS4_IRQ_SYSMMU_MFC_M0_0
+#define IRQ_SYSMMU_MFC_M1_0             EXYNOS4_IRQ_SYSMMU_MFC_M1_0
+#define IRQ_SYSMMU_PCIE_0               EXYNOS4_IRQ_SYSMMU_PCIE_0
+
+#define IRQ_FIMD0_FIFO			EXYNOS4_IRQ_FIMD0_FIFO
+#define IRQ_FIMD0_VSYNC			EXYNOS4_IRQ_FIMD0_VSYNC
+#define IRQ_FIMD0_SYSTEM		EXYNOS4_IRQ_FIMD0_SYSTEM
+
+#define IRQ_GPIO1_NR_GROUPS		EXYNOS4_IRQ_GPIO1_NR_GROUPS
+#define IRQ_GPIO2_NR_GROUPS		EXYNOS4_IRQ_GPIO2_NR_GROUPS
+
+/* For EXYNOS5 SoCs */
+
+#define EXYNOS5_IRQ_MDMA0		IRQ_SPI(33)
+#define EXYNOS5_IRQ_PDMA0		IRQ_SPI(34)
+#define EXYNOS5_IRQ_PDMA1		IRQ_SPI(35)
+#define EXYNOS5_IRQ_TIMER0_VIC		IRQ_SPI(36)
+#define EXYNOS5_IRQ_TIMER1_VIC		IRQ_SPI(37)
+#define EXYNOS5_IRQ_TIMER2_VIC		IRQ_SPI(38)
+#define EXYNOS5_IRQ_TIMER3_VIC		IRQ_SPI(39)
+#define EXYNOS5_IRQ_TIMER4_VIC		IRQ_SPI(40)
+#define EXYNOS5_IRQ_RTIC		IRQ_SPI(41)
+#define EXYNOS5_IRQ_WDT			IRQ_SPI(42)
+#define EXYNOS5_IRQ_RTC_ALARM		IRQ_SPI(43)
+#define EXYNOS5_IRQ_RTC_TIC		IRQ_SPI(44)
+#define EXYNOS5_IRQ_GPIO_XB		IRQ_SPI(45)
+#define EXYNOS5_IRQ_GPIO_XA		IRQ_SPI(46)
+#define EXYNOS5_IRQ_GPIO		IRQ_SPI(47)
+#define EXYNOS5_IRQ_IEM_IEC		IRQ_SPI(48)
+#define EXYNOS5_IRQ_IEM_APC		IRQ_SPI(49)
+#define EXYNOS5_IRQ_GPIO_C2C		IRQ_SPI(50)
 #define EXYNOS5_IRQ_UART0		IRQ_SPI(51)
 #define EXYNOS5_IRQ_UART1		IRQ_SPI(52)
 #define EXYNOS5_IRQ_UART2		IRQ_SPI(53)
 #define EXYNOS5_IRQ_UART3		IRQ_SPI(54)
 #define EXYNOS5_IRQ_UART4		IRQ_SPI(55)
+#define EXYNOS5_IRQ_IIC			IRQ_SPI(56)
+#define EXYNOS5_IRQ_IIC1		IRQ_SPI(57)
+#define EXYNOS5_IRQ_IIC2		IRQ_SPI(58)
+#define EXYNOS5_IRQ_IIC3		IRQ_SPI(59)
+#define EXYNOS5_IRQ_IIC4		IRQ_SPI(60)
+#define EXYNOS5_IRQ_IIC5		IRQ_SPI(61)
+#define EXYNOS5_IRQ_IIC6		IRQ_SPI(62)
+#define EXYNOS5_IRQ_IIC7		IRQ_SPI(63)
+#define EXYNOS5_IRQ_IIC_HDMIPHY		IRQ_SPI(64)
+#define EXYNOS5_IRQ_TMU			IRQ_SPI(65)
+#define EXYNOS5_IRQ_FIQ_0		IRQ_SPI(66)
+#define EXYNOS5_IRQ_FIQ_1		IRQ_SPI(67)
+#define EXYNOS5_IRQ_SPI0		IRQ_SPI(68)
+#define EXYNOS5_IRQ_SPI1		IRQ_SPI(69)
+#define EXYNOS5_IRQ_SPI2		IRQ_SPI(70)
+#define EXYNOS5_IRQ_USB_HOST		IRQ_SPI(71)
+#define EXYNOS5_IRQ_USB3_DRD		IRQ_SPI(72)
+#define EXYNOS5_IRQ_MIPI_HSI		IRQ_SPI(73)
+#define EXYNOS5_IRQ_USB_HSOTG		IRQ_SPI(74)
+#define EXYNOS5_IRQ_HSMMC0		IRQ_SPI(75)
+#define EXYNOS5_IRQ_HSMMC1		IRQ_SPI(76)
+#define EXYNOS5_IRQ_HSMMC2		IRQ_SPI(77)
+#define EXYNOS5_IRQ_HSMMC3		IRQ_SPI(78)
+#define EXYNOS5_IRQ_MIPICSI0		IRQ_SPI(79)
+#define EXYNOS5_IRQ_MIPICSI1		IRQ_SPI(80)
+#define EXYNOS5_IRQ_EFNFCON_DMA_ABORT	IRQ_SPI(81)
+#define EXYNOS5_IRQ_MIPIDSI0		IRQ_SPI(82)
+#define EXYNOS5_IRQ_ROTATOR		IRQ_SPI(84)
+#define EXYNOS5_IRQ_GSC0		IRQ_SPI(85)
+#define EXYNOS5_IRQ_GSC1		IRQ_SPI(86)
+#define EXYNOS5_IRQ_GSC2		IRQ_SPI(87)
+#define EXYNOS5_IRQ_GSC3		IRQ_SPI(88)
+#define EXYNOS5_IRQ_JPEG		IRQ_SPI(89)
+#define EXYNOS5_IRQ_EFNFCON_DMA		IRQ_SPI(90)
+#define EXYNOS5_IRQ_2D			IRQ_SPI(91)
+#define EXYNOS5_IRQ_SFMC0		IRQ_SPI(92)
+#define EXYNOS5_IRQ_SFMC1		IRQ_SPI(93)
+#define EXYNOS5_IRQ_MIXER		IRQ_SPI(94)
+#define EXYNOS5_IRQ_HDMI		IRQ_SPI(95)
+#define EXYNOS5_IRQ_MFC			IRQ_SPI(96)
+#define EXYNOS5_IRQ_AUDIO_SS		IRQ_SPI(97)
+#define EXYNOS5_IRQ_I2S0		IRQ_SPI(98)
+#define EXYNOS5_IRQ_I2S1		IRQ_SPI(99)
+#define EXYNOS5_IRQ_I2S2		IRQ_SPI(100)
+#define EXYNOS5_IRQ_AC97		IRQ_SPI(101)
+#define EXYNOS5_IRQ_PCM0		IRQ_SPI(102)
+#define EXYNOS5_IRQ_PCM1		IRQ_SPI(103)
+#define EXYNOS5_IRQ_PCM2		IRQ_SPI(104)
+#define EXYNOS5_IRQ_SPDIF		IRQ_SPI(105)
+#define EXYNOS5_IRQ_ADC0		IRQ_SPI(106)
+
+#define EXYNOS5_IRQ_SATA_PHY		IRQ_SPI(108)
+#define EXYNOS5_IRQ_SATA_PMEMREQ	IRQ_SPI(109)
+#define EXYNOS5_IRQ_CAM_C		IRQ_SPI(110)
+#define EXYNOS5_IRQ_EAGLE_PMU		IRQ_SPI(111)
+#define EXYNOS5_IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
+#define EXYNOS5_IRQ_DP1_INTP1		IRQ_SPI(113)
+#define EXYNOS5_IRQ_CEC			IRQ_SPI(114)
+#define EXYNOS5_IRQ_SATA		IRQ_SPI(115)
+#define EXYNOS5_IRQ_NFCON		IRQ_SPI(116)
+
+#define EXYNOS5_IRQ_MMC44		IRQ_SPI(123)
+#define EXYNOS5_IRQ_MDMA1		IRQ_SPI(124)
+#define EXYNOS5_IRQ_FIMC_LITE0		IRQ_SPI(125)
+#define EXYNOS5_IRQ_FIMC_LITE1		IRQ_SPI(126)
+#define EXYNOS5_IRQ_RP_TIMER		IRQ_SPI(127)
+
+#define EXYNOS5_IRQ_PMU			COMBINER_IRQ(1, 2)
+#define EXYNOS5_IRQ_PMU_CPU1		COMBINER_IRQ(1, 6)
+
+#define EXYNOS5_IRQ_SYSMMU_GSC0_0	COMBINER_IRQ(2, 0)
+#define EXYNOS5_IRQ_SYSMMU_GSC0_1	COMBINER_IRQ(2, 1)
+#define EXYNOS5_IRQ_SYSMMU_GSC1_0	COMBINER_IRQ(2, 2)
+#define EXYNOS5_IRQ_SYSMMU_GSC1_1	COMBINER_IRQ(2, 3)
+#define EXYNOS5_IRQ_SYSMMU_GSC2_0	COMBINER_IRQ(2, 4)
+#define EXYNOS5_IRQ_SYSMMU_GSC2_1	COMBINER_IRQ(2, 5)
+#define EXYNOS5_IRQ_SYSMMU_GSC3_0	COMBINER_IRQ(2, 6)
+#define EXYNOS5_IRQ_SYSMMU_GSC3_1	COMBINER_IRQ(2, 7)
+
+#define EXYNOS5_IRQ_SYSMMU_FIMD1_0	COMBINER_IRQ(3, 2)
+#define EXYNOS5_IRQ_SYSMMU_FIMD1_1	COMBINER_IRQ(3, 3)
+#define EXYNOS5_IRQ_SYSMMU_LITE0_0	COMBINER_IRQ(3, 4)
+#define EXYNOS5_IRQ_SYSMMU_LITE0_1	COMBINER_IRQ(3, 5)
+#define EXYNOS5_IRQ_SYSMMU_SCALERPISP_0	COMBINER_IRQ(3, 6)
+#define EXYNOS5_IRQ_SYSMMU_SCALERPISP_1	COMBINER_IRQ(3, 7)
+
+#define EXYNOS5_IRQ_SYSMMU_ROTATOR_0	COMBINER_IRQ(4, 0)
+#define EXYNOS5_IRQ_SYSMMU_ROTATOR_1	COMBINER_IRQ(4, 1)
+#define EXYNOS5_IRQ_SYSMMU_JPEG_0	COMBINER_IRQ(4, 2)
+#define EXYNOS5_IRQ_SYSMMU_JPEG_1	COMBINER_IRQ(4, 3)
+
+#define EXYNOS5_IRQ_SYSMMU_FD_0		COMBINER_IRQ(5, 0)
+#define EXYNOS5_IRQ_SYSMMU_FD_1		COMBINER_IRQ(5, 1)
+#define EXYNOS5_IRQ_SYSMMU_SCALERCISP_0	COMBINER_IRQ(5, 2)
+#define EXYNOS5_IRQ_SYSMMU_SCALERCISP_1	COMBINER_IRQ(5, 3)
+#define EXYNOS5_IRQ_SYSMMU_MCUISP_0	COMBINER_IRQ(5, 4)
+#define EXYNOS5_IRQ_SYSMMU_MCUISP_1	COMBINER_IRQ(5, 5)
+#define EXYNOS5_IRQ_SYSMMU_3DNR_0	COMBINER_IRQ(5, 6)
+#define EXYNOS5_IRQ_SYSMMU_3DNR_1	COMBINER_IRQ(5, 7)
+
+#define EXYNOS5_IRQ_SYSMMU_ARM_0	COMBINER_IRQ(6, 0)
+#define EXYNOS5_IRQ_SYSMMU_ARM_1	COMBINER_IRQ(6, 1)
+#define EXYNOS5_IRQ_SYSMMU_MFC_L_0	COMBINER_IRQ(6, 2)
+#define EXYNOS5_IRQ_SYSMMU_MFC_L_1	COMBINER_IRQ(6, 3)
+#define EXYNOS5_IRQ_SYSMMU_RTIC_0	COMBINER_IRQ(6, 4)
+#define EXYNOS5_IRQ_SYSMMU_RTIC_1	COMBINER_IRQ(6, 5)
+#define EXYNOS5_IRQ_SYSMMU_SSS_0	COMBINER_IRQ(6, 6)
+#define EXYNOS5_IRQ_SYSMMU_SSS_1	COMBINER_IRQ(6, 7)
+
+#define EXYNOS5_IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(7, 0)
+#define EXYNOS5_IRQ_SYSMMU_MDMA0_1	COMBINER_IRQ(7, 1)
+#define EXYNOS5_IRQ_SYSMMU_MDMA1_0	COMBINER_IRQ(7, 2)
+#define EXYNOS5_IRQ_SYSMMU_MDMA1_1	COMBINER_IRQ(7, 3)
+#define EXYNOS5_IRQ_SYSMMU_TV_0		COMBINER_IRQ(7, 4)
+#define EXYNOS5_IRQ_SYSMMU_TV_1		COMBINER_IRQ(7, 5)
+#define EXYNOS5_IRQ_SYSMMU_GPSX_0	COMBINER_IRQ(7, 6)
+#define EXYNOS5_IRQ_SYSMMU_GPSX_1	COMBINER_IRQ(7, 7)
+
+#define EXYNOS5_IRQ_SYSMMU_MFC_R_0	COMBINER_IRQ(8, 5)
+#define EXYNOS5_IRQ_SYSMMU_MFC_R_1	COMBINER_IRQ(8, 6)
+
+#define EXYNOS5_IRQ_SYSMMU_DIS1_0	COMBINER_IRQ(9, 4)
+#define EXYNOS5_IRQ_SYSMMU_DIS1_1	COMBINER_IRQ(9, 5)
+
+#define EXYNOS5_IRQ_DP			COMBINER_IRQ(10, 3)
+#define EXYNOS5_IRQ_SYSMMU_DIS0_0	COMBINER_IRQ(10, 4)
+#define EXYNOS5_IRQ_SYSMMU_DIS0_1	COMBINER_IRQ(10, 5)
+#define EXYNOS5_IRQ_SYSMMU_ISP_0	COMBINER_IRQ(10, 6)
+#define EXYNOS5_IRQ_SYSMMU_ISP_1	COMBINER_IRQ(10, 7)
+
+#define EXYNOS5_IRQ_SYSMMU_ODC_0	COMBINER_IRQ(11, 0)
+#define EXYNOS5_IRQ_SYSMMU_ODC_1	COMBINER_IRQ(11, 1)
+#define EXYNOS5_IRQ_SYSMMU_DRC_0	COMBINER_IRQ(11, 6)
+#define EXYNOS5_IRQ_SYSMMU_DRC_1	COMBINER_IRQ(11, 7)
+
+#define EXYNOS5_IRQ_FIMD1_FIFO		COMBINER_IRQ(18, 4)
+#define EXYNOS5_IRQ_FIMD1_VSYNC		COMBINER_IRQ(18, 5)
+#define EXYNOS5_IRQ_FIMD1_SYSTEM	COMBINER_IRQ(18, 6)
+
+#define EXYNOS5_IRQ_EINT0		COMBINER_IRQ(23, 0)
+#define EXYNOS5_IRQ_MCT_L0		COMBINER_IRQ(23, 1)
+#define EXYNOS5_IRQ_MCT_L1		COMBINER_IRQ(23, 2)
+#define EXYNOS5_IRQ_MCT_G0		COMBINER_IRQ(23, 3)
+#define EXYNOS5_IRQ_MCT_G1		COMBINER_IRQ(23, 4)
+#define EXYNOS5_IRQ_MCT_G2		COMBINER_IRQ(23, 5)
+#define EXYNOS5_IRQ_MCT_G3		COMBINER_IRQ(23, 6)
+
+#define EXYNOS5_IRQ_EINT1		COMBINER_IRQ(24, 0)
+#define EXYNOS5_IRQ_SYSMMU_LITE1_0	COMBINER_IRQ(24, 1)
+#define EXYNOS5_IRQ_SYSMMU_LITE1_1	COMBINER_IRQ(24, 2)
+#define EXYNOS5_IRQ_SYSMMU_2D_0		COMBINER_IRQ(24, 5)
+#define EXYNOS5_IRQ_SYSMMU_2D_1		COMBINER_IRQ(24, 6)
+
+#define EXYNOS5_IRQ_EINT2		COMBINER_IRQ(25, 0)
+#define EXYNOS5_IRQ_EINT3		COMBINER_IRQ(25, 1)
+
+#define EXYNOS5_IRQ_EINT4		COMBINER_IRQ(26, 0)
+#define EXYNOS5_IRQ_EINT5		COMBINER_IRQ(26, 1)
+
+#define EXYNOS5_IRQ_EINT6		COMBINER_IRQ(27, 0)
+#define EXYNOS5_IRQ_EINT7		COMBINER_IRQ(27, 1)
+
+#define EXYNOS5_IRQ_EINT8		COMBINER_IRQ(28, 0)
+#define EXYNOS5_IRQ_EINT9		COMBINER_IRQ(28, 1)
+
+#define EXYNOS5_IRQ_EINT10		COMBINER_IRQ(29, 0)
+#define EXYNOS5_IRQ_EINT11		COMBINER_IRQ(29, 1)
+
+#define EXYNOS5_IRQ_EINT12		COMBINER_IRQ(30, 0)
+#define EXYNOS5_IRQ_EINT13		COMBINER_IRQ(30, 1)
+
+#define EXYNOS5_IRQ_EINT14		COMBINER_IRQ(31, 0)
+#define EXYNOS5_IRQ_EINT15		COMBINER_IRQ(31, 1)
+
+#define EXYNOS5_MAX_COMBINER_NR		32
+
+#define EXYNOS5_IRQ_GPIO1_NR_GROUPS	13
+#define EXYNOS5_IRQ_GPIO2_NR_GROUPS	9
+#define EXYNOS5_IRQ_GPIO3_NR_GROUPS	5
+#define EXYNOS5_IRQ_GPIO4_NR_GROUPS	1
+
+#define MAX_COMBINER_NR			(EXYNOS4_MAX_COMBINER_NR > EXYNOS5_MAX_COMBINER_NR ? \
+					EXYNOS4_MAX_COMBINER_NR : EXYNOS5_MAX_COMBINER_NR)
+
+#define S5P_EINT_BASE1			COMBINER_IRQ(MAX_COMBINER_NR, 0)
+#define S5P_EINT_BASE2			(S5P_EINT_BASE1 + 16)
+#define S5P_GPIOINT_BASE		(S5P_EINT_BASE1 + 32)
+#define IRQ_GPIO_END			(S5P_GPIOINT_BASE + S5P_GPIOINT_COUNT)
+#define IRQ_TIMER_BASE			(IRQ_GPIO_END + 64)
+
+/* Set the default NR_IRQS */
+
+#define NR_IRQS				(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 85b5527..1016515 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -258,7 +258,10 @@ static void exynos4_clockevent_init(void)
 	mct_comp_device.cpumask = cpumask_of(0);
 	clockevents_register_device(&mct_comp_device);
 
-	setup_irq(IRQ_MCT_G0, &mct_comp_event_irq);
+	if (soc_is_exynos5250())
+		setup_irq(EXYNOS5_IRQ_MCT_G0, &mct_comp_event_irq);
+	else
+		setup_irq(EXYNOS4_IRQ_MCT_G0, &mct_comp_event_irq);
 }
 
 #ifdef CONFIG_LOCAL_TIMERS
@@ -406,16 +409,16 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 	if (mct_int_type == MCT_INT_SPI) {
 		if (cpu == 0) {
 			mct_tick0_event_irq.dev_id = mevt;
-			evt->irq = IRQ_MCT_L0;
-			setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
+			evt->irq = EXYNOS4_IRQ_MCT_L0;
+			setup_irq(EXYNOS4_IRQ_MCT_L0, &mct_tick0_event_irq);
 		} else {
 			mct_tick1_event_irq.dev_id = mevt;
-			evt->irq = IRQ_MCT_L1;
-			setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
-			irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
+			evt->irq = EXYNOS4_IRQ_MCT_L1;
+			setup_irq(EXYNOS4_IRQ_MCT_L1, &mct_tick1_event_irq);
+			irq_set_affinity(EXYNOS4_IRQ_MCT_L1, cpumask_of(1));
 		}
 	} else {
-		enable_percpu_irq(IRQ_MCT_LOCALTIMER, 0);
+		enable_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER, 0);
 	}
 }
 
@@ -437,7 +440,7 @@ void local_timer_stop(struct clock_event_device *evt)
 		else
 			remove_irq(evt->irq, &mct_tick1_event_irq);
 	else
-		disable_percpu_irq(IRQ_MCT_LOCALTIMER);
+		disable_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER);
 }
 #endif /* CONFIG_LOCAL_TIMERS */
 
@@ -452,11 +455,11 @@ static void __init exynos4_timer_resources(void)
 	if (mct_int_type == MCT_INT_PPI) {
 		int err;
 
-		err = request_percpu_irq(IRQ_MCT_LOCALTIMER,
+		err = request_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER,
 					 exynos4_mct_tick_isr, "MCT",
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
-		     IRQ_MCT_LOCALTIMER, err);
+		     EXYNOS_IRQ_MCT_LOCALTIMER, err);
 	}
 #endif /* CONFIG_LOCAL_TIMERS */
 }
diff --git a/arch/arm/plat-s5p/irq-pm.c b/arch/arm/plat-s5p/irq-pm.c
index 327acb3..d1bfeca 100644
--- a/arch/arm/plat-s5p/irq-pm.c
+++ b/arch/arm/plat-s5p/irq-pm.c
@@ -39,19 +39,32 @@ unsigned long s3c_irqwake_eintallow	= 0xffffffffL;
 int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
 	unsigned long irqbit;
+	unsigned int irq_rtc_tic, irq_rtc_alarm;
+
+#ifdef CONFIG_ARCH_EXYNOS
+	if (soc_is_exynos5250()) {
+		irq_rtc_tic = EXYNOS5_IRQ_RTC_TIC;
+		irq_rtc_alarm = EXYNOS5_IRQ_RTC_ALARM;
+	} else {
+		irq_rtc_tic = EXYNOS4_IRQ_RTC_TIC;
+		irq_rtc_alarm = EXYNOS4_IRQ_RTC_ALARM;
+	}
+#else
+	irq_rtc_tic = IRQ_RTC_TIC;
+	irq_rtc_alarm = IRQ_RTC_ALARM;
+#endif
+
+	if (data->irq == irq_rtc_tic || data->irq == irq_rtc_alarm) {
+		irqbit = 1 << (data->irq + 1 - irq_rtc_alarm);
 
-	switch (data->irq) {
-	case IRQ_RTC_TIC:
-	case IRQ_RTC_ALARM:
-		irqbit = 1 << (data->irq + 1 - IRQ_RTC_ALARM);
 		if (!state)
 			s3c_irqwake_intmask |= irqbit;
 		else
 			s3c_irqwake_intmask &= ~irqbit;
-		break;
-	default:
+	} else {
 		return -ENOENT;
 	}
+
 	return 0;
 }
 
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index 51583cd..f980cf3 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 
 #include <mach/map.h>
+#include <plat/cpu.h>
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-timer.h>
 
@@ -57,6 +58,21 @@ void __init s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq)
 	struct irq_chip_type *ct;
 	unsigned int i;
 
+#ifdef CONFIG_ARCH_EXYNOS
+	if (soc_is_exynos5250()) {
+		pirq[0] = EXYNOS5_IRQ_TIMER0_VIC;
+		pirq[1] = EXYNOS5_IRQ_TIMER1_VIC;
+		pirq[2] = EXYNOS5_IRQ_TIMER2_VIC;
+		pirq[3] = EXYNOS5_IRQ_TIMER3_VIC;
+		pirq[4] = EXYNOS5_IRQ_TIMER4_VIC;
+	} else {
+		pirq[0] = EXYNOS4_IRQ_TIMER0_VIC;
+		pirq[1] = EXYNOS4_IRQ_TIMER1_VIC;
+		pirq[2] = EXYNOS4_IRQ_TIMER2_VIC;
+		pirq[3] = EXYNOS4_IRQ_TIMER3_VIC;
+		pirq[4] = EXYNOS4_IRQ_TIMER4_VIC;
+	}
+#endif
 	s3c_tgc = irq_alloc_generic_chip("s3c-timer", 1, timer_irq,
 					 S3C64XX_TINT_CSTAT, handle_level_irq);
 
-- 
1.7.4.4
