From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:13 +0900
Subject: [PATCH 2/7] ARM: EXYNOS4: modify interrupt mappings for external GIC
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1308555258-4322-3-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support external GIC needs to update mapping of interrupt number.
This patch modifies it for external GIC and accordingly removes
the unused code.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c               |    8 --
 arch/arm/mach-exynos4/include/mach/irqs.h |  188 ++++++++++++++---------------
 2 files changed, 93 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 6a1ed74..fa33294 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -167,14 +167,6 @@ void __init exynos4_init_irq(void)
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
 
-		/*
-		 * From SPI(0) to SPI(39) and SPI(51), SPI(53) are
-		 * connected to the interrupt combiner. These irqs
-		 * should be initialized to support cascade interrupt.
-		 */
-		if ((irq >= 40) && !(irq == 51) && !(irq == 53))
-			continue;
-
 		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
 				COMBINER_IRQ(irq, 0));
 		combiner_cascade_irq(irq, IRQ_SPI(irq));
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 5d03730..e497ea2 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -25,34 +25,100 @@
 
 #define IRQ_SPI(x)		S5P_IRQ(x+32)
 
-#define IRQ_MCT1		IRQ_SPI(35)
-
-#define IRQ_EINT0		IRQ_SPI(40)
-#define IRQ_EINT1		IRQ_SPI(41)
-#define IRQ_EINT2		IRQ_SPI(42)
-#define IRQ_EINT3		IRQ_SPI(43)
-#define IRQ_USB_HSOTG		IRQ_SPI(44)
-#define IRQ_USB_HOST		IRQ_SPI(45)
-#define IRQ_MODEM_IF		IRQ_SPI(46)
-#define IRQ_ROTATOR		IRQ_SPI(47)
-#define IRQ_JPEG		IRQ_SPI(48)
-#define IRQ_2D			IRQ_SPI(49)
-#define IRQ_PCIE		IRQ_SPI(50)
-#define IRQ_MCT0		IRQ_SPI(51)
-#define IRQ_MFC			IRQ_SPI(52)
-#define IRQ_AUDIO_SS		IRQ_SPI(54)
-#define IRQ_AC97		IRQ_SPI(55)
-#define IRQ_SPDIF		IRQ_SPI(56)
-#define IRQ_KEYPAD		IRQ_SPI(57)
-#define IRQ_INTFEEDCTRL_SSS	IRQ_SPI(58)
-#define IRQ_SLIMBUS		IRQ_SPI(59)
-#define IRQ_PMU			IRQ_SPI(60)
-#define IRQ_TSI			IRQ_SPI(61)
-#define IRQ_SATA		IRQ_SPI(62)
-#define IRQ_GPS			IRQ_SPI(63)
+#define IRQ_EINT0		IRQ_SPI(16)
+#define IRQ_EINT1		IRQ_SPI(17)
+#define IRQ_EINT2		IRQ_SPI(18)
+#define IRQ_EINT3		IRQ_SPI(19)
+#define IRQ_EINT4		IRQ_SPI(20)
+#define IRQ_EINT5		IRQ_SPI(21)
+#define IRQ_EINT6		IRQ_SPI(22)
+#define IRQ_EINT7		IRQ_SPI(23)
+#define IRQ_EINT8		IRQ_SPI(24)
+#define IRQ_EINT9		IRQ_SPI(25)
+#define IRQ_EINT10		IRQ_SPI(26)
+#define IRQ_EINT11		IRQ_SPI(27)
+#define IRQ_EINT12		IRQ_SPI(28)
+#define IRQ_EINT13		IRQ_SPI(29)
+#define IRQ_EINT14		IRQ_SPI(30)
+#define IRQ_EINT15		IRQ_SPI(31)
+#define IRQ_EINT16_31		IRQ_SPI(32)
+
+#define IRQ_PDMA0		IRQ_SPI(35)
+#define IRQ_PDMA1		IRQ_SPI(36)
+#define IRQ_TIMER0_VIC		IRQ_SPI(37)
+#define IRQ_TIMER1_VIC		IRQ_SPI(38)
+#define IRQ_TIMER2_VIC		IRQ_SPI(39)
+#define IRQ_TIMER3_VIC		IRQ_SPI(40)
+#define IRQ_TIMER4_VIC		IRQ_SPI(41)
+#define IRQ_MCT_L0		IRQ_SPI(42)
+#define IRQ_WDT			IRQ_SPI(43)
+#define IRQ_RTC_ALARM		IRQ_SPI(44)
+#define IRQ_RTC_TIC		IRQ_SPI(45)
+#define IRQ_GPIO_XB		IRQ_SPI(46)
+#define IRQ_GPIO_XA		IRQ_SPI(47)
+#define IRQ_MCT_L1		IRQ_SPI(48)
+
+#define IRQ_UART0		IRQ_SPI(52)
+#define IRQ_UART1		IRQ_SPI(53)
+#define IRQ_UART2		IRQ_SPI(54)
+#define IRQ_UART3		IRQ_SPI(55)
+#define IRQ_UART4		IRQ_SPI(56)
+#define IRQ_MCT_G0		IRQ_SPI(57)
+#define IRQ_IIC			IRQ_SPI(58)
+#define IRQ_IIC1		IRQ_SPI(59)
+#define IRQ_IIC2		IRQ_SPI(60)
+#define IRQ_IIC3		IRQ_SPI(61)
+#define IRQ_IIC4		IRQ_SPI(62)
+#define IRQ_IIC5		IRQ_SPI(63)
+#define IRQ_IIC6		IRQ_SPI(64)
+#define IRQ_IIC7		IRQ_SPI(65)
+
+#define IRQ_USB_HOST		IRQ_SPI(70)
+#define IRQ_USB_HSOTG		IRQ_SPI(71)
+#define IRQ_MODEM_IF		IRQ_SPI(72)
+#define IRQ_HSMMC0		IRQ_SPI(73)
+#define IRQ_HSMMC1		IRQ_SPI(74)
+#define IRQ_HSMMC2		IRQ_SPI(75)
+#define IRQ_HSMMC3		IRQ_SPI(76)
+
+#define IRQ_MIPICSI0		IRQ_SPI(78)
+
+#define IRQ_MIPICSI1		IRQ_SPI(80)
+
+#define IRQ_ONENAND_AUDI	IRQ_SPI(82)
+#define IRQ_ROTATOR		IRQ_SPI(83)
+#define IRQ_FIMC0		IRQ_SPI(84)
+#define IRQ_FIMC1		IRQ_SPI(85)
+#define IRQ_FIMC2		IRQ_SPI(86)
+#define IRQ_FIMC3		IRQ_SPI(87)
+#define IRQ_JPEG		IRQ_SPI(88)
+#define IRQ_2D			IRQ_SPI(89)
+#define IRQ_PCIE		IRQ_SPI(90)
+
+#define IRQ_MFC			IRQ_SPI(94)
+
+#define IRQ_AUDIO_SS		IRQ_SPI(96)
+#define IRQ_I2S0		IRQ_SPI(97)
+#define IRQ_I2S1		IRQ_SPI(98)
+#define IRQ_I2S2		IRQ_SPI(99)
+#define IRQ_AC97		IRQ_SPI(100)
+
+#define IRQ_SPDIF		IRQ_SPI(104)
+#define IRQ_ADC0		IRQ_SPI(105)
+#define IRQ_PEN0		IRQ_SPI(106)
+#define IRQ_ADC1		IRQ_SPI(107)
+#define IRQ_PEN1		IRQ_SPI(108)
+#define IRQ_KEYPAD		IRQ_SPI(109)
+#define IRQ_PMU			IRQ_SPI(110)
+#define IRQ_GPS			IRQ_SPI(111)
+#define IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
+#define IRQ_SLIMBUS		IRQ_SPI(113)
+
+#define IRQ_TSI			IRQ_SPI(115)
+#define IRQ_SATA		IRQ_SPI(116)
 
 #define MAX_IRQ_IN_COMBINER	8
-#define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(64))
+#define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(128))
 #define COMBINER_IRQ(x, y)	(COMBINER_GROUP(x) + y)
 
 #define IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(4, 0)
@@ -73,75 +139,7 @@
 #define IRQ_SYSMMU_MFC_M1_0	COMBINER_IRQ(5, 6)
 #define IRQ_SYSMMU_PCIE_0	COMBINER_IRQ(5, 7)
 
-#define IRQ_PDMA0		COMBINER_IRQ(21, 0)
-#define IRQ_PDMA1		COMBINER_IRQ(21, 1)
-
-#define IRQ_TIMER0_VIC		COMBINER_IRQ(22, 0)
-#define IRQ_TIMER1_VIC		COMBINER_IRQ(22, 1)
-#define IRQ_TIMER2_VIC		COMBINER_IRQ(22, 2)
-#define IRQ_TIMER3_VIC		COMBINER_IRQ(22, 3)
-#define IRQ_TIMER4_VIC		COMBINER_IRQ(22, 4)
-
-#define IRQ_RTC_ALARM		COMBINER_IRQ(23, 0)
-#define IRQ_RTC_TIC		COMBINER_IRQ(23, 1)
-
-#define IRQ_GPIO_XB		COMBINER_IRQ(24, 0)
-#define IRQ_GPIO_XA		COMBINER_IRQ(24, 1)
-
-#define IRQ_UART0		COMBINER_IRQ(26, 0)
-#define IRQ_UART1		COMBINER_IRQ(26, 1)
-#define IRQ_UART2		COMBINER_IRQ(26, 2)
-#define IRQ_UART3		COMBINER_IRQ(26, 3)
-#define IRQ_UART4		COMBINER_IRQ(26, 4)
-
-#define IRQ_IIC			COMBINER_IRQ(27, 0)
-#define IRQ_IIC1		COMBINER_IRQ(27, 1)
-#define IRQ_IIC2		COMBINER_IRQ(27, 2)
-#define IRQ_IIC3		COMBINER_IRQ(27, 3)
-#define IRQ_IIC4		COMBINER_IRQ(27, 4)
-#define IRQ_IIC5		COMBINER_IRQ(27, 5)
-#define IRQ_IIC6		COMBINER_IRQ(27, 6)
-#define IRQ_IIC7		COMBINER_IRQ(27, 7)
-
-#define IRQ_HSMMC0		COMBINER_IRQ(29, 0)
-#define IRQ_HSMMC1		COMBINER_IRQ(29, 1)
-#define IRQ_HSMMC2		COMBINER_IRQ(29, 2)
-#define IRQ_HSMMC3		COMBINER_IRQ(29, 3)
-
-#define IRQ_MIPI_CSIS0		COMBINER_IRQ(30, 0)
-#define IRQ_MIPI_CSIS1		COMBINER_IRQ(30, 1)
-
-#define IRQ_FIMC0		COMBINER_IRQ(32, 0)
-#define IRQ_FIMC1		COMBINER_IRQ(32, 1)
-#define IRQ_FIMC2		COMBINER_IRQ(33, 0)
-#define IRQ_FIMC3		COMBINER_IRQ(33, 1)
-
-#define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
-
-#define IRQ_MCT_L1		COMBINER_IRQ(35, 3)
-
-#define IRQ_EINT4		COMBINER_IRQ(37, 0)
-#define IRQ_EINT5		COMBINER_IRQ(37, 1)
-#define IRQ_EINT6		COMBINER_IRQ(37, 2)
-#define IRQ_EINT7		COMBINER_IRQ(37, 3)
-#define IRQ_EINT8		COMBINER_IRQ(38, 0)
-
-#define IRQ_EINT9		COMBINER_IRQ(38, 1)
-#define IRQ_EINT10		COMBINER_IRQ(38, 2)
-#define IRQ_EINT11		COMBINER_IRQ(38, 3)
-#define IRQ_EINT12		COMBINER_IRQ(38, 4)
-#define IRQ_EINT13		COMBINER_IRQ(38, 5)
-#define IRQ_EINT14		COMBINER_IRQ(38, 6)
-#define IRQ_EINT15		COMBINER_IRQ(38, 7)
-
-#define IRQ_EINT16_31		COMBINER_IRQ(39, 0)
-
-#define IRQ_MCT_L0		COMBINER_IRQ(51, 0)
-
-#define IRQ_WDT			COMBINER_IRQ(53, 0)
-#define IRQ_MCT_G0		COMBINER_IRQ(53, 4)
-
-#define MAX_COMBINER_NR		54
+#define MAX_COMBINER_NR		16
 
 #define S5P_IRQ_EINT_BASE	COMBINER_IRQ(MAX_COMBINER_NR, 0)
 
-- 
1.7.1
