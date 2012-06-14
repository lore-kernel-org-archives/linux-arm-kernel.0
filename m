From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:47 +0800
Subject: [PATCH 16/16] ARM: imx: enable SPARSE_IRQ for imx platform
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-17-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all irqchips on imx have been changed to allocate their irq_descs,
and all unneeded mach/irqs.h inclusions on imx have been cleaned up,
now it's time to select SPARSE_IRQ for imx/mxc.

The SPARSE_IRQ support forces irqs allocation starting from 16.  All
those static irq number definition for SoCs need to shift 16 to keep
non-DT boot works.

With all those static IRQ number and start definitions removed from
mach/irqs.h, the header becomes just a container of a couple of
mach-imx specific irq/fiq calls.  Since mach/irqs.h is not included
by asm/irq.h now, the users of mxc_set_irq_fiq needs to explicitly
include mach/irqs.h themselves.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/plat-mxc/include/mach/irqs.h |   44 -------
 arch/arm/plat-mxc/include/mach/mx1.h  |  111 +++++++++---------
 arch/arm/plat-mxc/include/mach/mx21.h |  107 ++++++++--------
 arch/arm/plat-mxc/include/mach/mx25.h |   72 ++++++-----
 arch/arm/plat-mxc/include/mach/mx27.h |  127 ++++++++++----------
 arch/arm/plat-mxc/include/mach/mx2x.h |   87 +++++++-------
 arch/arm/plat-mxc/include/mach/mx31.h |  118 +++++++++---------
 arch/arm/plat-mxc/include/mach/mx35.h |  109 +++++++++--------
 arch/arm/plat-mxc/include/mach/mx3x.h |   77 ++++++------
 arch/arm/plat-mxc/include/mach/mx50.h |  187 ++++++++++++++--------------
 arch/arm/plat-mxc/include/mach/mx51.h |  209 ++++++++++++++++----------------
 arch/arm/plat-mxc/include/mach/mx53.h |  217 +++++++++++++++++----------------
 drivers/media/video/mx1_camera.c      |    1 +
 sound/soc/fsl/imx-pcm-fiq.c           |    1 +
 15 files changed, 722 insertions(+), 746 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..63f40b4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -446,6 +446,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index fd9efb0..d73f5e8 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -11,50 +11,6 @@
 #ifndef __ASM_ARCH_MXC_IRQS_H__
 #define __ASM_ARCH_MXC_IRQS_H__
 
-#include <asm-generic/gpio.h>
-
-/*
- * SoCs with GIC interrupt controller have 160 IRQs, those with TZIC
- * have 128 IRQs, and those with AVIC have 64.
- *
- * To support single image, the biggest number should be defined on
- * top of the list.
- */
-#if defined CONFIG_ARM_GIC
-#define MXC_INTERNAL_IRQS	160
-#elif defined CONFIG_MXC_TZIC
-#define MXC_INTERNAL_IRQS	128
-#else
-#define MXC_INTERNAL_IRQS	64
-#endif
-
-#define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
-
-/*
- * The next 16 interrupts are for board specific purposes.  Since
- * the kernel can only run on one machine at a time, we can re-use
- * these.  If you need more, increase MXC_BOARD_IRQS, but keep it
- * within sensible limits.
- */
-#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + ARCH_NR_GPIOS)
-
-#ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
-#define MXC_BOARD_IRQS  80
-#else
-#define MXC_BOARD_IRQS	16
-#endif
-
-#define MXC_IPU_IRQ_START	(MXC_BOARD_IRQ_START + MXC_BOARD_IRQS)
-
-#ifdef CONFIG_MX3_IPU_IRQS
-#define MX3_IPU_IRQS CONFIG_MX3_IPU_IRQS
-#else
-#define MX3_IPU_IRQS 0
-#endif
-/* REVISIT: Add IPU irqs on IMX51 */
-
-#define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
-
 extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
 
 /* all normal IRQs can be FIQs */
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 2b7c08d..45bd31c 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -78,61 +78,62 @@
 #define MX1_IO_ADDRESS(x)		IOMEM(MX1_IO_P2V(x))
 
 /* fixed interrput numbers */
-#define MX1_INT_SOFTINT		0
-#define MX1_INT_CSI		6
-#define MX1_DSPA_MAC_INT	7
-#define MX1_DSPA_INT		8
-#define MX1_COMP_INT		9
-#define MX1_MSHC_XINT		10
-#define MX1_GPIO_INT_PORTA	11
-#define MX1_GPIO_INT_PORTB	12
-#define MX1_GPIO_INT_PORTC	13
-#define MX1_INT_LCDC		14
-#define MX1_SIM_INT		15
-#define MX1_SIM_DATA_INT	16
-#define MX1_RTC_INT		17
-#define MX1_RTC_SAMINT		18
-#define MX1_INT_UART2PFERR	19
-#define MX1_INT_UART2RTS	20
-#define MX1_INT_UART2DTR	21
-#define MX1_INT_UART2UARTC	22
-#define MX1_INT_UART2TX		23
-#define MX1_INT_UART2RX		24
-#define MX1_INT_UART1PFERR	25
-#define MX1_INT_UART1RTS	26
-#define MX1_INT_UART1DTR	27
-#define MX1_INT_UART1UARTC	28
-#define MX1_INT_UART1TX		29
-#define MX1_INT_UART1RX		30
-#define MX1_VOICE_DAC_INT	31
-#define MX1_VOICE_ADC_INT	32
-#define MX1_PEN_DATA_INT	33
-#define MX1_PWM_INT		34
-#define MX1_SDHC_INT		35
-#define MX1_INT_I2C		39
-#define MX1_INT_CSPI2		40
-#define MX1_INT_CSPI1		41
-#define MX1_SSI_TX_INT		42
-#define MX1_SSI_TX_ERR_INT	43
-#define MX1_SSI_RX_INT		44
-#define MX1_SSI_RX_ERR_INT	45
-#define MX1_TOUCH_INT		46
-#define MX1_INT_USBD0		47
-#define MX1_INT_USBD1		48
-#define MX1_INT_USBD2		49
-#define MX1_INT_USBD3		50
-#define MX1_INT_USBD4		51
-#define MX1_INT_USBD5		52
-#define MX1_INT_USBD6		53
-#define MX1_BTSYS_INT		55
-#define MX1_BTTIM_INT		56
-#define MX1_BTWUI_INT		57
-#define MX1_TIM2_INT		58
-#define MX1_TIM1_INT		59
-#define MX1_DMA_ERR		60
-#define MX1_DMA_INT		61
-#define MX1_GPIO_INT_PORTD	62
-#define MX1_WDT_INT		63
+#include <asm/irq.h>
+#define MX1_INT_SOFTINT		(NR_IRQS_LEGACY + 0)
+#define MX1_INT_CSI		(NR_IRQS_LEGACY + 6)
+#define MX1_DSPA_MAC_INT	(NR_IRQS_LEGACY + 7)
+#define MX1_DSPA_INT		(NR_IRQS_LEGACY + 8)
+#define MX1_COMP_INT		(NR_IRQS_LEGACY + 9)
+#define MX1_MSHC_XINT		(NR_IRQS_LEGACY + 10)
+#define MX1_GPIO_INT_PORTA	(NR_IRQS_LEGACY + 11)
+#define MX1_GPIO_INT_PORTB	(NR_IRQS_LEGACY + 12)
+#define MX1_GPIO_INT_PORTC	(NR_IRQS_LEGACY + 13)
+#define MX1_INT_LCDC		(NR_IRQS_LEGACY + 14)
+#define MX1_SIM_INT		(NR_IRQS_LEGACY + 15)
+#define MX1_SIM_DATA_INT	(NR_IRQS_LEGACY + 16)
+#define MX1_RTC_INT		(NR_IRQS_LEGACY + 17)
+#define MX1_RTC_SAMINT		(NR_IRQS_LEGACY + 18)
+#define MX1_INT_UART2PFERR	(NR_IRQS_LEGACY + 19)
+#define MX1_INT_UART2RTS	(NR_IRQS_LEGACY + 20)
+#define MX1_INT_UART2DTR	(NR_IRQS_LEGACY + 21)
+#define MX1_INT_UART2UARTC	(NR_IRQS_LEGACY + 22)
+#define MX1_INT_UART2TX		(NR_IRQS_LEGACY + 23)
+#define MX1_INT_UART2RX		(NR_IRQS_LEGACY + 24)
+#define MX1_INT_UART1PFERR	(NR_IRQS_LEGACY + 25)
+#define MX1_INT_UART1RTS	(NR_IRQS_LEGACY + 26)
+#define MX1_INT_UART1DTR	(NR_IRQS_LEGACY + 27)
+#define MX1_INT_UART1UARTC	(NR_IRQS_LEGACY + 28)
+#define MX1_INT_UART1TX		(NR_IRQS_LEGACY + 29)
+#define MX1_INT_UART1RX		(NR_IRQS_LEGACY + 30)
+#define MX1_VOICE_DAC_INT	(NR_IRQS_LEGACY + 31)
+#define MX1_VOICE_ADC_INT	(NR_IRQS_LEGACY + 32)
+#define MX1_PEN_DATA_INT	(NR_IRQS_LEGACY + 33)
+#define MX1_PWM_INT		(NR_IRQS_LEGACY + 34)
+#define MX1_SDHC_INT		(NR_IRQS_LEGACY + 35)
+#define MX1_INT_I2C		(NR_IRQS_LEGACY + 39)
+#define MX1_INT_CSPI2		(NR_IRQS_LEGACY + 40)
+#define MX1_INT_CSPI1		(NR_IRQS_LEGACY + 41)
+#define MX1_SSI_TX_INT		(NR_IRQS_LEGACY + 42)
+#define MX1_SSI_TX_ERR_INT	(NR_IRQS_LEGACY + 43)
+#define MX1_SSI_RX_INT		(NR_IRQS_LEGACY + 44)
+#define MX1_SSI_RX_ERR_INT	(NR_IRQS_LEGACY + 45)
+#define MX1_TOUCH_INT		(NR_IRQS_LEGACY + 46)
+#define MX1_INT_USBD0		(NR_IRQS_LEGACY + 47)
+#define MX1_INT_USBD1		(NR_IRQS_LEGACY + 48)
+#define MX1_INT_USBD2		(NR_IRQS_LEGACY + 49)
+#define MX1_INT_USBD3		(NR_IRQS_LEGACY + 50)
+#define MX1_INT_USBD4		(NR_IRQS_LEGACY + 51)
+#define MX1_INT_USBD5		(NR_IRQS_LEGACY + 52)
+#define MX1_INT_USBD6		(NR_IRQS_LEGACY + 53)
+#define MX1_BTSYS_INT		(NR_IRQS_LEGACY + 55)
+#define MX1_BTTIM_INT		(NR_IRQS_LEGACY + 56)
+#define MX1_BTWUI_INT		(NR_IRQS_LEGACY + 57)
+#define MX1_TIM2_INT		(NR_IRQS_LEGACY + 58)
+#define MX1_TIM1_INT		(NR_IRQS_LEGACY + 59)
+#define MX1_DMA_ERR		(NR_IRQS_LEGACY + 60)
+#define MX1_DMA_INT		(NR_IRQS_LEGACY + 61)
+#define MX1_GPIO_INT_PORTD	(NR_IRQS_LEGACY + 62)
+#define MX1_WDT_INT		(NR_IRQS_LEGACY + 63)
 
 /* DMA */
 #define MX1_DMA_REQ_UART3_T		2
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index 6cd049e..468738a 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -99,59 +99,60 @@
 #define MX21_IO_ADDRESS(x)		IOMEM(MX21_IO_P2V(x))
 
 /* fixed interrupt numbers */
-#define MX21_INT_CSPI3		6
-#define MX21_INT_GPIO		8
-#define MX21_INT_FIRI		9
-#define MX21_INT_SDHC2		10
-#define MX21_INT_SDHC1		11
-#define MX21_INT_I2C		12
-#define MX21_INT_SSI2		13
-#define MX21_INT_SSI1		14
-#define MX21_INT_CSPI2		15
-#define MX21_INT_CSPI1		16
-#define MX21_INT_UART4		17
-#define MX21_INT_UART3		18
-#define MX21_INT_UART2		19
-#define MX21_INT_UART1		20
-#define MX21_INT_KPP		21
-#define MX21_INT_RTC		22
-#define MX21_INT_PWM		23
-#define MX21_INT_GPT3		24
-#define MX21_INT_GPT2		25
-#define MX21_INT_GPT1		26
-#define MX21_INT_WDOG		27
-#define MX21_INT_PCMCIA		28
-#define MX21_INT_NFC		29
-#define MX21_INT_BMI		30
-#define MX21_INT_CSI		31
-#define MX21_INT_DMACH0		32
-#define MX21_INT_DMACH1		33
-#define MX21_INT_DMACH2		34
-#define MX21_INT_DMACH3		35
-#define MX21_INT_DMACH4		36
-#define MX21_INT_DMACH5		37
-#define MX21_INT_DMACH6		38
-#define MX21_INT_DMACH7		39
-#define MX21_INT_DMACH8		40
-#define MX21_INT_DMACH9		41
-#define MX21_INT_DMACH10	42
-#define MX21_INT_DMACH11	43
-#define MX21_INT_DMACH12	44
-#define MX21_INT_DMACH13	45
-#define MX21_INT_DMACH14	46
-#define MX21_INT_DMACH15	47
-#define MX21_INT_EMMAENC	49
-#define MX21_INT_EMMADEC	50
-#define MX21_INT_EMMAPRP	51
-#define MX21_INT_EMMAPP		52
-#define MX21_INT_USBWKUP	53
-#define MX21_INT_USBDMA		54
-#define MX21_INT_USBHOST	55
-#define MX21_INT_USBFUNC	56
-#define MX21_INT_USBMNP		57
-#define MX21_INT_USBCTRL	58
-#define MX21_INT_SLCDC		60
-#define MX21_INT_LCDC		61
+#include <asm/irq.h>
+#define MX21_INT_CSPI3		(NR_IRQS_LEGACY + 6)
+#define MX21_INT_GPIO		(NR_IRQS_LEGACY + 8)
+#define MX21_INT_FIRI		(NR_IRQS_LEGACY + 9)
+#define MX21_INT_SDHC2		(NR_IRQS_LEGACY + 10)
+#define MX21_INT_SDHC1		(NR_IRQS_LEGACY + 11)
+#define MX21_INT_I2C		(NR_IRQS_LEGACY + 12)
+#define MX21_INT_SSI2		(NR_IRQS_LEGACY + 13)
+#define MX21_INT_SSI1		(NR_IRQS_LEGACY + 14)
+#define MX21_INT_CSPI2		(NR_IRQS_LEGACY + 15)
+#define MX21_INT_CSPI1		(NR_IRQS_LEGACY + 16)
+#define MX21_INT_UART4		(NR_IRQS_LEGACY + 17)
+#define MX21_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX21_INT_UART2		(NR_IRQS_LEGACY + 19)
+#define MX21_INT_UART1		(NR_IRQS_LEGACY + 20)
+#define MX21_INT_KPP		(NR_IRQS_LEGACY + 21)
+#define MX21_INT_RTC		(NR_IRQS_LEGACY + 22)
+#define MX21_INT_PWM		(NR_IRQS_LEGACY + 23)
+#define MX21_INT_GPT3		(NR_IRQS_LEGACY + 24)
+#define MX21_INT_GPT2		(NR_IRQS_LEGACY + 25)
+#define MX21_INT_GPT1		(NR_IRQS_LEGACY + 26)
+#define MX21_INT_WDOG		(NR_IRQS_LEGACY + 27)
+#define MX21_INT_PCMCIA		(NR_IRQS_LEGACY + 28)
+#define MX21_INT_NFC		(NR_IRQS_LEGACY + 29)
+#define MX21_INT_BMI		(NR_IRQS_LEGACY + 30)
+#define MX21_INT_CSI		(NR_IRQS_LEGACY + 31)
+#define MX21_INT_DMACH0		(NR_IRQS_LEGACY + 32)
+#define MX21_INT_DMACH1		(NR_IRQS_LEGACY + 33)
+#define MX21_INT_DMACH2		(NR_IRQS_LEGACY + 34)
+#define MX21_INT_DMACH3		(NR_IRQS_LEGACY + 35)
+#define MX21_INT_DMACH4		(NR_IRQS_LEGACY + 36)
+#define MX21_INT_DMACH5		(NR_IRQS_LEGACY + 37)
+#define MX21_INT_DMACH6		(NR_IRQS_LEGACY + 38)
+#define MX21_INT_DMACH7		(NR_IRQS_LEGACY + 39)
+#define MX21_INT_DMACH8		(NR_IRQS_LEGACY + 40)
+#define MX21_INT_DMACH9		(NR_IRQS_LEGACY + 41)
+#define MX21_INT_DMACH10	(NR_IRQS_LEGACY + 42)
+#define MX21_INT_DMACH11	(NR_IRQS_LEGACY + 43)
+#define MX21_INT_DMACH12	(NR_IRQS_LEGACY + 44)
+#define MX21_INT_DMACH13	(NR_IRQS_LEGACY + 45)
+#define MX21_INT_DMACH14	(NR_IRQS_LEGACY + 46)
+#define MX21_INT_DMACH15	(NR_IRQS_LEGACY + 47)
+#define MX21_INT_EMMAENC	(NR_IRQS_LEGACY + 49)
+#define MX21_INT_EMMADEC	(NR_IRQS_LEGACY + 50)
+#define MX21_INT_EMMAPRP	(NR_IRQS_LEGACY + 51)
+#define MX21_INT_EMMAPP		(NR_IRQS_LEGACY + 52)
+#define MX21_INT_USBWKUP	(NR_IRQS_LEGACY + 53)
+#define MX21_INT_USBDMA		(NR_IRQS_LEGACY + 54)
+#define MX21_INT_USBHOST	(NR_IRQS_LEGACY + 55)
+#define MX21_INT_USBFUNC	(NR_IRQS_LEGACY + 56)
+#define MX21_INT_USBMNP		(NR_IRQS_LEGACY + 57)
+#define MX21_INT_USBCTRL	(NR_IRQS_LEGACY + 58)
+#define MX21_INT_SLCDC		(NR_IRQS_LEGACY + 60)
+#define MX21_INT_LCDC		(NR_IRQS_LEGACY + 61)
 
 /* fixed DMA request numbers */
 #define MX21_DMA_REQ_CSPI3_RX	1
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index ccebf5b..627d94f 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -61,40 +61,44 @@
 #define MX25_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX25_IO_ADDRESS(x)		IOMEM(MX25_IO_P2V(x))
 
-#define MX25_INT_CSPI3		0
-#define MX25_INT_I2C1		3
-#define MX25_INT_I2C2		4
-#define MX25_INT_UART4		5
-#define MX25_INT_ESDHC2		8
-#define MX25_INT_ESDHC1		9
-#define MX25_INT_I2C3		10
-#define MX25_INT_SSI2		11
-#define MX25_INT_SSI1		12
-#define MX25_INT_CSPI2		13
-#define MX25_INT_CSPI1		14
-#define MX25_INT_GPIO3		16
-#define MX25_INT_CSI		17
-#define MX25_INT_UART3		18
-#define MX25_INT_GPIO4		23
-#define MX25_INT_KPP		24
-#define MX25_INT_DRYICE		25
-#define MX25_INT_PWM1		26
-#define MX25_INT_UART2		32
-#define MX25_INT_NFC		33
-#define MX25_INT_SDMA		34
-#define MX25_INT_USB_HS		35
-#define MX25_INT_PWM2		36
-#define MX25_INT_USB_OTG	37
-#define MX25_INT_LCDC		39
-#define MX25_INT_UART5		40
-#define MX25_INT_PWM3		41
-#define MX25_INT_PWM4		42
-#define MX25_INT_CAN1		43
-#define MX25_INT_CAN2		44
-#define MX25_INT_UART1		45
-#define MX25_INT_GPIO2		51
-#define MX25_INT_GPIO1		52
-#define MX25_INT_FEC		57
+/*
+ * Interrupt numbers
+ */
+#include <asm/irq.h>
+#define MX25_INT_CSPI3		(NR_IRQS_LEGACY + 0)
+#define MX25_INT_I2C1		(NR_IRQS_LEGACY + 3)
+#define MX25_INT_I2C2		(NR_IRQS_LEGACY + 4)
+#define MX25_INT_UART4		(NR_IRQS_LEGACY + 5)
+#define MX25_INT_ESDHC2		(NR_IRQS_LEGACY + 8)
+#define MX25_INT_ESDHC1		(NR_IRQS_LEGACY + 9)
+#define MX25_INT_I2C3		(NR_IRQS_LEGACY + 10)
+#define MX25_INT_SSI2		(NR_IRQS_LEGACY + 11)
+#define MX25_INT_SSI1		(NR_IRQS_LEGACY + 12)
+#define MX25_INT_CSPI2		(NR_IRQS_LEGACY + 13)
+#define MX25_INT_CSPI1		(NR_IRQS_LEGACY + 14)
+#define MX25_INT_GPIO3		(NR_IRQS_LEGACY + 16)
+#define MX25_INT_CSI		(NR_IRQS_LEGACY + 17)
+#define MX25_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX25_INT_GPIO4		(NR_IRQS_LEGACY + 23)
+#define MX25_INT_KPP		(NR_IRQS_LEGACY + 24)
+#define MX25_INT_DRYICE		(NR_IRQS_LEGACY + 25)
+#define MX25_INT_PWM1		(NR_IRQS_LEGACY + 26)
+#define MX25_INT_UART2		(NR_IRQS_LEGACY + 32)
+#define MX25_INT_NFC		(NR_IRQS_LEGACY + 33)
+#define MX25_INT_SDMA		(NR_IRQS_LEGACY + 34)
+#define MX25_INT_USB_HS		(NR_IRQS_LEGACY + 35)
+#define MX25_INT_PWM2		(NR_IRQS_LEGACY + 36)
+#define MX25_INT_USB_OTG	(NR_IRQS_LEGACY + 37)
+#define MX25_INT_LCDC		(NR_IRQS_LEGACY + 39)
+#define MX25_INT_UART5		(NR_IRQS_LEGACY + 40)
+#define MX25_INT_PWM3		(NR_IRQS_LEGACY + 41)
+#define MX25_INT_PWM4		(NR_IRQS_LEGACY + 42)
+#define MX25_INT_CAN1		(NR_IRQS_LEGACY + 43)
+#define MX25_INT_CAN2		(NR_IRQS_LEGACY + 44)
+#define MX25_INT_UART1		(NR_IRQS_LEGACY + 45)
+#define MX25_INT_GPIO2		(NR_IRQS_LEGACY + 51)
+#define MX25_INT_GPIO1		(NR_IRQS_LEGACY + 52)
+#define MX25_INT_FEC		(NR_IRQS_LEGACY + 57)
 
 #define MX25_DMA_REQ_SSI2_RX1	22
 #define MX25_DMA_REQ_SSI2_TX1	23
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 6265357..e074616 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -128,69 +128,70 @@
 #define MX27_IO_ADDRESS(x)		IOMEM(MX27_IO_P2V(x))
 
 /* fixed interrupt numbers */
-#define MX27_INT_I2C2		1
-#define MX27_INT_GPT6		2
-#define MX27_INT_GPT5		3
-#define MX27_INT_GPT4		4
-#define MX27_INT_RTIC		5
-#define MX27_INT_CSPI3		6
-#define MX27_INT_SDHC		7
-#define MX27_INT_GPIO		8
-#define MX27_INT_SDHC3		9
-#define MX27_INT_SDHC2		10
-#define MX27_INT_SDHC1		11
-#define MX27_INT_I2C1		12
-#define MX27_INT_SSI2		13
-#define MX27_INT_SSI1		14
-#define MX27_INT_CSPI2		15
-#define MX27_INT_CSPI1		16
-#define MX27_INT_UART4		17
-#define MX27_INT_UART3		18
-#define MX27_INT_UART2		19
-#define MX27_INT_UART1		20
-#define MX27_INT_KPP		21
-#define MX27_INT_RTC		22
-#define MX27_INT_PWM		23
-#define MX27_INT_GPT3		24
-#define MX27_INT_GPT2		25
-#define MX27_INT_GPT1		26
-#define MX27_INT_WDOG		27
-#define MX27_INT_PCMCIA		28
-#define MX27_INT_NFC		29
-#define MX27_INT_ATA		30
-#define MX27_INT_CSI		31
-#define MX27_INT_DMACH0		32
-#define MX27_INT_DMACH1		33
-#define MX27_INT_DMACH2		34
-#define MX27_INT_DMACH3		35
-#define MX27_INT_DMACH4		36
-#define MX27_INT_DMACH5		37
-#define MX27_INT_DMACH6		38
-#define MX27_INT_DMACH7		39
-#define MX27_INT_DMACH8		40
-#define MX27_INT_DMACH9		41
-#define MX27_INT_DMACH10	42
-#define MX27_INT_DMACH11	43
-#define MX27_INT_DMACH12	44
-#define MX27_INT_DMACH13	45
-#define MX27_INT_DMACH14	46
-#define MX27_INT_DMACH15	47
-#define MX27_INT_UART6		48
-#define MX27_INT_UART5		49
-#define MX27_INT_FEC		50
-#define MX27_INT_EMMAPRP	51
-#define MX27_INT_EMMAPP		52
-#define MX27_INT_VPU		53
-#define MX27_INT_USB_HS1	54
-#define MX27_INT_USB_HS2	55
-#define MX27_INT_USB_OTG	56
-#define MX27_INT_SCC_SMN	57
-#define MX27_INT_SCC_SCM	58
-#define MX27_INT_SAHARA		59
-#define MX27_INT_SLCDC		60
-#define MX27_INT_LCDC		61
-#define MX27_INT_IIM		62
-#define MX27_INT_CCM		63
+#include <asm/irq.h>
+#define MX27_INT_I2C2		(NR_IRQS_LEGACY + 1)
+#define MX27_INT_GPT6		(NR_IRQS_LEGACY + 2)
+#define MX27_INT_GPT5		(NR_IRQS_LEGACY + 3)
+#define MX27_INT_GPT4		(NR_IRQS_LEGACY + 4)
+#define MX27_INT_RTIC		(NR_IRQS_LEGACY + 5)
+#define MX27_INT_CSPI3		(NR_IRQS_LEGACY + 6)
+#define MX27_INT_SDHC		(NR_IRQS_LEGACY + 7)
+#define MX27_INT_GPIO		(NR_IRQS_LEGACY + 8)
+#define MX27_INT_SDHC3		(NR_IRQS_LEGACY + 9)
+#define MX27_INT_SDHC2		(NR_IRQS_LEGACY + 10)
+#define MX27_INT_SDHC1		(NR_IRQS_LEGACY + 11)
+#define MX27_INT_I2C1		(NR_IRQS_LEGACY + 12)
+#define MX27_INT_SSI2		(NR_IRQS_LEGACY + 13)
+#define MX27_INT_SSI1		(NR_IRQS_LEGACY + 14)
+#define MX27_INT_CSPI2		(NR_IRQS_LEGACY + 15)
+#define MX27_INT_CSPI1		(NR_IRQS_LEGACY + 16)
+#define MX27_INT_UART4		(NR_IRQS_LEGACY + 17)
+#define MX27_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX27_INT_UART2		(NR_IRQS_LEGACY + 19)
+#define MX27_INT_UART1		(NR_IRQS_LEGACY + 20)
+#define MX27_INT_KPP		(NR_IRQS_LEGACY + 21)
+#define MX27_INT_RTC		(NR_IRQS_LEGACY + 22)
+#define MX27_INT_PWM		(NR_IRQS_LEGACY + 23)
+#define MX27_INT_GPT3		(NR_IRQS_LEGACY + 24)
+#define MX27_INT_GPT2		(NR_IRQS_LEGACY + 25)
+#define MX27_INT_GPT1		(NR_IRQS_LEGACY + 26)
+#define MX27_INT_WDOG		(NR_IRQS_LEGACY + 27)
+#define MX27_INT_PCMCIA		(NR_IRQS_LEGACY + 28)
+#define MX27_INT_NFC		(NR_IRQS_LEGACY + 29)
+#define MX27_INT_ATA		(NR_IRQS_LEGACY + 30)
+#define MX27_INT_CSI		(NR_IRQS_LEGACY + 31)
+#define MX27_INT_DMACH0		(NR_IRQS_LEGACY + 32)
+#define MX27_INT_DMACH1		(NR_IRQS_LEGACY + 33)
+#define MX27_INT_DMACH2		(NR_IRQS_LEGACY + 34)
+#define MX27_INT_DMACH3		(NR_IRQS_LEGACY + 35)
+#define MX27_INT_DMACH4		(NR_IRQS_LEGACY + 36)
+#define MX27_INT_DMACH5		(NR_IRQS_LEGACY + 37)
+#define MX27_INT_DMACH6		(NR_IRQS_LEGACY + 38)
+#define MX27_INT_DMACH7		(NR_IRQS_LEGACY + 39)
+#define MX27_INT_DMACH8		(NR_IRQS_LEGACY + 40)
+#define MX27_INT_DMACH9		(NR_IRQS_LEGACY + 41)
+#define MX27_INT_DMACH10	(NR_IRQS_LEGACY + 42)
+#define MX27_INT_DMACH11	(NR_IRQS_LEGACY + 43)
+#define MX27_INT_DMACH12	(NR_IRQS_LEGACY + 44)
+#define MX27_INT_DMACH13	(NR_IRQS_LEGACY + 45)
+#define MX27_INT_DMACH14	(NR_IRQS_LEGACY + 46)
+#define MX27_INT_DMACH15	(NR_IRQS_LEGACY + 47)
+#define MX27_INT_UART6		(NR_IRQS_LEGACY + 48)
+#define MX27_INT_UART5		(NR_IRQS_LEGACY + 49)
+#define MX27_INT_FEC		(NR_IRQS_LEGACY + 50)
+#define MX27_INT_EMMAPRP	(NR_IRQS_LEGACY + 51)
+#define MX27_INT_EMMAPP		(NR_IRQS_LEGACY + 52)
+#define MX27_INT_VPU		(NR_IRQS_LEGACY + 53)
+#define MX27_INT_USB_HS1	(NR_IRQS_LEGACY + 54)
+#define MX27_INT_USB_HS2	(NR_IRQS_LEGACY + 55)
+#define MX27_INT_USB_OTG	(NR_IRQS_LEGACY + 56)
+#define MX27_INT_SCC_SMN	(NR_IRQS_LEGACY + 57)
+#define MX27_INT_SCC_SCM	(NR_IRQS_LEGACY + 58)
+#define MX27_INT_SAHARA		(NR_IRQS_LEGACY + 59)
+#define MX27_INT_SLCDC		(NR_IRQS_LEGACY + 60)
+#define MX27_INT_LCDC		(NR_IRQS_LEGACY + 61)
+#define MX27_INT_IIM		(NR_IRQS_LEGACY + 62)
+#define MX27_INT_CCM		(NR_IRQS_LEGACY + 63)
 
 /* fixed DMA request numbers */
 #define MX27_DMA_REQ_CSPI3_RX	1
diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/plat-mxc/include/mach/mx2x.h
index 6d07839..11642f5 100644
--- a/arch/arm/plat-mxc/include/mach/mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/mx2x.h
@@ -68,49 +68,50 @@
 #define MX2x_CSI_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x0000)
 
 /* fixed interrupt numbers */
-#define MX2x_INT_CSPI3		6
-#define MX2x_INT_GPIO		8
-#define MX2x_INT_SDHC2		10
-#define MX2x_INT_SDHC1		11
-#define MX2x_INT_I2C		12
-#define MX2x_INT_SSI2		13
-#define MX2x_INT_SSI1		14
-#define MX2x_INT_CSPI2		15
-#define MX2x_INT_CSPI1		16
-#define MX2x_INT_UART4		17
-#define MX2x_INT_UART3		18
-#define MX2x_INT_UART2		19
-#define MX2x_INT_UART1		20
-#define MX2x_INT_KPP		21
-#define MX2x_INT_RTC		22
-#define MX2x_INT_PWM		23
-#define MX2x_INT_GPT3		24
-#define MX2x_INT_GPT2		25
-#define MX2x_INT_GPT1		26
-#define MX2x_INT_WDOG		27
-#define MX2x_INT_PCMCIA		28
-#define MX2x_INT_NANDFC		29
-#define MX2x_INT_CSI		31
-#define MX2x_INT_DMACH0		32
-#define MX2x_INT_DMACH1		33
-#define MX2x_INT_DMACH2		34
-#define MX2x_INT_DMACH3		35
-#define MX2x_INT_DMACH4		36
-#define MX2x_INT_DMACH5		37
-#define MX2x_INT_DMACH6		38
-#define MX2x_INT_DMACH7		39
-#define MX2x_INT_DMACH8		40
-#define MX2x_INT_DMACH9		41
-#define MX2x_INT_DMACH10	42
-#define MX2x_INT_DMACH11	43
-#define MX2x_INT_DMACH12	44
-#define MX2x_INT_DMACH13	45
-#define MX2x_INT_DMACH14	46
-#define MX2x_INT_DMACH15	47
-#define MX2x_INT_EMMAPRP	51
-#define MX2x_INT_EMMAPP		52
-#define MX2x_INT_SLCDC		60
-#define MX2x_INT_LCDC		61
+#include <asm/irq.h>
+#define MX2x_INT_CSPI3		(NR_IRQS_LEGACY + 6)
+#define MX2x_INT_GPIO		(NR_IRQS_LEGACY + 8)
+#define MX2x_INT_SDHC2		(NR_IRQS_LEGACY + 10)
+#define MX2x_INT_SDHC1		(NR_IRQS_LEGACY + 11)
+#define MX2x_INT_I2C		(NR_IRQS_LEGACY + 12)
+#define MX2x_INT_SSI2		(NR_IRQS_LEGACY + 13)
+#define MX2x_INT_SSI1		(NR_IRQS_LEGACY + 14)
+#define MX2x_INT_CSPI2		(NR_IRQS_LEGACY + 15)
+#define MX2x_INT_CSPI1		(NR_IRQS_LEGACY + 16)
+#define MX2x_INT_UART4		(NR_IRQS_LEGACY + 17)
+#define MX2x_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX2x_INT_UART2		(NR_IRQS_LEGACY + 19)
+#define MX2x_INT_UART1		(NR_IRQS_LEGACY + 20)
+#define MX2x_INT_KPP		(NR_IRQS_LEGACY + 21)
+#define MX2x_INT_RTC		(NR_IRQS_LEGACY + 22)
+#define MX2x_INT_PWM		(NR_IRQS_LEGACY + 23)
+#define MX2x_INT_GPT3		(NR_IRQS_LEGACY + 24)
+#define MX2x_INT_GPT2		(NR_IRQS_LEGACY + 25)
+#define MX2x_INT_GPT1		(NR_IRQS_LEGACY + 26)
+#define MX2x_INT_WDOG		(NR_IRQS_LEGACY + 27)
+#define MX2x_INT_PCMCIA		(NR_IRQS_LEGACY + 28)
+#define MX2x_INT_NANDFC		(NR_IRQS_LEGACY + 29)
+#define MX2x_INT_CSI		(NR_IRQS_LEGACY + 31)
+#define MX2x_INT_DMACH0		(NR_IRQS_LEGACY + 32)
+#define MX2x_INT_DMACH1		(NR_IRQS_LEGACY + 33)
+#define MX2x_INT_DMACH2		(NR_IRQS_LEGACY + 34)
+#define MX2x_INT_DMACH3		(NR_IRQS_LEGACY + 35)
+#define MX2x_INT_DMACH4		(NR_IRQS_LEGACY + 36)
+#define MX2x_INT_DMACH5		(NR_IRQS_LEGACY + 37)
+#define MX2x_INT_DMACH6		(NR_IRQS_LEGACY + 38)
+#define MX2x_INT_DMACH7		(NR_IRQS_LEGACY + 39)
+#define MX2x_INT_DMACH8		(NR_IRQS_LEGACY + 40)
+#define MX2x_INT_DMACH9		(NR_IRQS_LEGACY + 41)
+#define MX2x_INT_DMACH10	(NR_IRQS_LEGACY + 42)
+#define MX2x_INT_DMACH11	(NR_IRQS_LEGACY + 43)
+#define MX2x_INT_DMACH12	(NR_IRQS_LEGACY + 44)
+#define MX2x_INT_DMACH13	(NR_IRQS_LEGACY + 45)
+#define MX2x_INT_DMACH14	(NR_IRQS_LEGACY + 46)
+#define MX2x_INT_DMACH15	(NR_IRQS_LEGACY + 47)
+#define MX2x_INT_EMMAPRP	(NR_IRQS_LEGACY + 51)
+#define MX2x_INT_EMMAPP		(NR_IRQS_LEGACY + 52)
+#define MX2x_INT_SLCDC		(NR_IRQS_LEGACY + 60)
+#define MX2x_INT_LCDC		(NR_IRQS_LEGACY + 61)
 
 /* fixed DMA request numbers */
 #define MX2x_DMA_REQ_CSPI3_RX	1
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index e27619e..dbced61 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -118,63 +118,67 @@
 #define MX31_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX31_IO_ADDRESS(x)		IOMEM(MX31_IO_P2V(x))
 
-#define MX31_INT_I2C3		3
-#define MX31_INT_I2C2		4
-#define MX31_INT_MPEG4_ENCODER	5
-#define MX31_INT_RTIC		6
-#define MX31_INT_FIRI		7
-#define MX31_INT_SDHC2		8
-#define MX31_INT_SDHC1		9
-#define MX31_INT_I2C1		10
-#define MX31_INT_SSI2		11
-#define MX31_INT_SSI1		12
-#define MX31_INT_CSPI2		13
-#define MX31_INT_CSPI1		14
-#define MX31_INT_ATA		15
-#define MX31_INT_MBX		16
-#define MX31_INT_CSPI3		17
-#define MX31_INT_UART3		18
-#define MX31_INT_IIM		19
-#define MX31_INT_SIM2		20
-#define MX31_INT_SIM1		21
-#define MX31_INT_RNGA		22
-#define MX31_INT_EVTMON		23
-#define MX31_INT_KPP		24
-#define MX31_INT_RTC		25
-#define MX31_INT_PWM		26
-#define MX31_INT_EPIT2		27
-#define MX31_INT_EPIT1		28
-#define MX31_INT_GPT		29
-#define MX31_INT_POWER_FAIL	30
-#define MX31_INT_CCM_DVFS	31
-#define MX31_INT_UART2		32
-#define MX31_INT_NFC		33
-#define MX31_INT_SDMA		34
-#define MX31_INT_USB_HS1	35
-#define MX31_INT_USB_HS2	36
-#define MX31_INT_USB_OTG	37
-#define MX31_INT_MSHC1		39
-#define MX31_INT_MSHC2		40
-#define MX31_INT_IPU_ERR	41
-#define MX31_INT_IPU_SYN	42
-#define MX31_INT_UART1		45
-#define MX31_INT_UART4		46
-#define MX31_INT_UART5		47
-#define MX31_INT_ECT		48
-#define MX31_INT_SCC_SCM	49
-#define MX31_INT_SCC_SMN	50
-#define MX31_INT_GPIO2		51
-#define MX31_INT_GPIO1		52
-#define MX31_INT_CCM		53
-#define MX31_INT_PCMCIA		54
-#define MX31_INT_WDOG		55
-#define MX31_INT_GPIO3		56
-#define MX31_INT_EXT_POWER	58
-#define MX31_INT_EXT_TEMPER	59
-#define MX31_INT_EXT_SENSOR60	60
-#define MX31_INT_EXT_SENSOR61	61
-#define MX31_INT_EXT_WDOG	62
-#define MX31_INT_EXT_TV		63
+/*
+ * Interrupt numbers
+ */
+#include <asm/irq.h>
+#define MX31_INT_I2C3		(NR_IRQS_LEGACY + 3)
+#define MX31_INT_I2C2		(NR_IRQS_LEGACY + 4)
+#define MX31_INT_MPEG4_ENCODER	(NR_IRQS_LEGACY + 5)
+#define MX31_INT_RTIC		(NR_IRQS_LEGACY + 6)
+#define MX31_INT_FIRI		(NR_IRQS_LEGACY + 7)
+#define MX31_INT_SDHC2		(NR_IRQS_LEGACY + 8)
+#define MX31_INT_SDHC1		(NR_IRQS_LEGACY + 9)
+#define MX31_INT_I2C1		(NR_IRQS_LEGACY + 10)
+#define MX31_INT_SSI2		(NR_IRQS_LEGACY + 11)
+#define MX31_INT_SSI1		(NR_IRQS_LEGACY + 12)
+#define MX31_INT_CSPI2		(NR_IRQS_LEGACY + 13)
+#define MX31_INT_CSPI1		(NR_IRQS_LEGACY + 14)
+#define MX31_INT_ATA		(NR_IRQS_LEGACY + 15)
+#define MX31_INT_MBX		(NR_IRQS_LEGACY + 16)
+#define MX31_INT_CSPI3		(NR_IRQS_LEGACY + 17)
+#define MX31_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX31_INT_IIM		(NR_IRQS_LEGACY + 19)
+#define MX31_INT_SIM2		(NR_IRQS_LEGACY + 20)
+#define MX31_INT_SIM1		(NR_IRQS_LEGACY + 21)
+#define MX31_INT_RNGA		(NR_IRQS_LEGACY + 22)
+#define MX31_INT_EVTMON		(NR_IRQS_LEGACY + 23)
+#define MX31_INT_KPP		(NR_IRQS_LEGACY + 24)
+#define MX31_INT_RTC		(NR_IRQS_LEGACY + 25)
+#define MX31_INT_PWM		(NR_IRQS_LEGACY + 26)
+#define MX31_INT_EPIT2		(NR_IRQS_LEGACY + 27)
+#define MX31_INT_EPIT1		(NR_IRQS_LEGACY + 28)
+#define MX31_INT_GPT		(NR_IRQS_LEGACY + 29)
+#define MX31_INT_POWER_FAIL	(NR_IRQS_LEGACY + 30)
+#define MX31_INT_CCM_DVFS	(NR_IRQS_LEGACY + 31)
+#define MX31_INT_UART2		(NR_IRQS_LEGACY + 32)
+#define MX31_INT_NFC		(NR_IRQS_LEGACY + 33)
+#define MX31_INT_SDMA		(NR_IRQS_LEGACY + 34)
+#define MX31_INT_USB_HS1	(NR_IRQS_LEGACY + 35)
+#define MX31_INT_USB_HS2	(NR_IRQS_LEGACY + 36)
+#define MX31_INT_USB_OTG	(NR_IRQS_LEGACY + 37)
+#define MX31_INT_MSHC1		(NR_IRQS_LEGACY + 39)
+#define MX31_INT_MSHC2		(NR_IRQS_LEGACY + 40)
+#define MX31_INT_IPU_ERR	(NR_IRQS_LEGACY + 41)
+#define MX31_INT_IPU_SYN	(NR_IRQS_LEGACY + 42)
+#define MX31_INT_UART1		(NR_IRQS_LEGACY + 45)
+#define MX31_INT_UART4		(NR_IRQS_LEGACY + 46)
+#define MX31_INT_UART5		(NR_IRQS_LEGACY + 47)
+#define MX31_INT_ECT		(NR_IRQS_LEGACY + 48)
+#define MX31_INT_SCC_SCM	(NR_IRQS_LEGACY + 49)
+#define MX31_INT_SCC_SMN	(NR_IRQS_LEGACY + 50)
+#define MX31_INT_GPIO2		(NR_IRQS_LEGACY + 51)
+#define MX31_INT_GPIO1		(NR_IRQS_LEGACY + 52)
+#define MX31_INT_CCM		(NR_IRQS_LEGACY + 53)
+#define MX31_INT_PCMCIA		(NR_IRQS_LEGACY + 54)
+#define MX31_INT_WDOG		(NR_IRQS_LEGACY + 55)
+#define MX31_INT_GPIO3		(NR_IRQS_LEGACY + 56)
+#define MX31_INT_EXT_POWER	(NR_IRQS_LEGACY + 58)
+#define MX31_INT_EXT_TEMPER	(NR_IRQS_LEGACY + 59)
+#define MX31_INT_EXT_SENSOR60	(NR_IRQS_LEGACY + 60)
+#define MX31_INT_EXT_SENSOR61	(NR_IRQS_LEGACY + 61)
+#define MX31_INT_EXT_WDOG	(NR_IRQS_LEGACY + 62)
+#define MX31_INT_EXT_TV		(NR_IRQS_LEGACY + 63)
 
 #define MX31_DMA_REQ_SDHC1	20
 #define MX31_DMA_REQ_SDHC2	21
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 80965a9..2af5d3a 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -120,60 +120,61 @@
 /*
  * Interrupt numbers
  */
-#define MX35_INT_OWIRE		2
-#define MX35_INT_I2C3		3
-#define MX35_INT_I2C2		4
-#define MX35_INT_RTIC		6
-#define MX35_INT_ESDHC1		7
-#define MX35_INT_ESDHC2		8
-#define MX35_INT_ESDHC3		9
-#define MX35_INT_I2C1		10
-#define MX35_INT_SSI1		11
-#define MX35_INT_SSI2		12
-#define MX35_INT_CSPI2		13
-#define MX35_INT_CSPI1		14
-#define MX35_INT_ATA		15
-#define MX35_INT_GPU2D		16
-#define MX35_INT_ASRC		17
-#define MX35_INT_UART3		18
-#define MX35_INT_IIM		19
-#define MX35_INT_RNGA		22
-#define MX35_INT_EVTMON		23
-#define MX35_INT_KPP		24
-#define MX35_INT_RTC		25
-#define MX35_INT_PWM		26
-#define MX35_INT_EPIT2		27
-#define MX35_INT_EPIT1		28
-#define MX35_INT_GPT		29
-#define MX35_INT_POWER_FAIL	30
-#define MX35_INT_UART2		32
-#define MX35_INT_NFC		33
-#define MX35_INT_SDMA		34
-#define MX35_INT_USB_HS		35
-#define MX35_INT_USB_OTG	37
-#define MX35_INT_MSHC1		39
-#define MX35_INT_ESAI		40
-#define MX35_INT_IPU_ERR	41
-#define MX35_INT_IPU_SYN	42
-#define MX35_INT_CAN1		43
-#define MX35_INT_CAN2		44
-#define MX35_INT_UART1		45
-#define MX35_INT_MLB		46
-#define MX35_INT_SPDIF		47
-#define MX35_INT_ECT		48
-#define MX35_INT_SCC_SCM	49
-#define MX35_INT_SCC_SMN	50
-#define MX35_INT_GPIO2		51
-#define MX35_INT_GPIO1		52
-#define MX35_INT_WDOG		55
-#define MX35_INT_GPIO3		56
-#define MX35_INT_FEC		57
-#define MX35_INT_EXT_POWER	58
-#define MX35_INT_EXT_TEMPER	59
-#define MX35_INT_EXT_SENSOR60	60
-#define MX35_INT_EXT_SENSOR61	61
-#define MX35_INT_EXT_WDOG	62
-#define MX35_INT_EXT_TV		63
+#include <asm/irq.h>
+#define MX35_INT_OWIRE		(NR_IRQS_LEGACY + 2)
+#define MX35_INT_I2C3		(NR_IRQS_LEGACY + 3)
+#define MX35_INT_I2C2		(NR_IRQS_LEGACY + 4)
+#define MX35_INT_RTIC		(NR_IRQS_LEGACY + 6)
+#define MX35_INT_ESDHC1		(NR_IRQS_LEGACY + 7)
+#define MX35_INT_ESDHC2		(NR_IRQS_LEGACY + 8)
+#define MX35_INT_ESDHC3		(NR_IRQS_LEGACY + 9)
+#define MX35_INT_I2C1		(NR_IRQS_LEGACY + 10)
+#define MX35_INT_SSI1		(NR_IRQS_LEGACY + 11)
+#define MX35_INT_SSI2		(NR_IRQS_LEGACY + 12)
+#define MX35_INT_CSPI2		(NR_IRQS_LEGACY + 13)
+#define MX35_INT_CSPI1		(NR_IRQS_LEGACY + 14)
+#define MX35_INT_ATA		(NR_IRQS_LEGACY + 15)
+#define MX35_INT_GPU2D		(NR_IRQS_LEGACY + 16)
+#define MX35_INT_ASRC		(NR_IRQS_LEGACY + 17)
+#define MX35_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX35_INT_IIM		(NR_IRQS_LEGACY + 19)
+#define MX35_INT_RNGA		(NR_IRQS_LEGACY + 22)
+#define MX35_INT_EVTMON		(NR_IRQS_LEGACY + 23)
+#define MX35_INT_KPP		(NR_IRQS_LEGACY + 24)
+#define MX35_INT_RTC		(NR_IRQS_LEGACY + 25)
+#define MX35_INT_PWM		(NR_IRQS_LEGACY + 26)
+#define MX35_INT_EPIT2		(NR_IRQS_LEGACY + 27)
+#define MX35_INT_EPIT1		(NR_IRQS_LEGACY + 28)
+#define MX35_INT_GPT		(NR_IRQS_LEGACY + 29)
+#define MX35_INT_POWER_FAIL	(NR_IRQS_LEGACY + 30)
+#define MX35_INT_UART2		(NR_IRQS_LEGACY + 32)
+#define MX35_INT_NFC		(NR_IRQS_LEGACY + 33)
+#define MX35_INT_SDMA		(NR_IRQS_LEGACY + 34)
+#define MX35_INT_USB_HS		(NR_IRQS_LEGACY + 35)
+#define MX35_INT_USB_OTG	(NR_IRQS_LEGACY + 37)
+#define MX35_INT_MSHC1		(NR_IRQS_LEGACY + 39)
+#define MX35_INT_ESAI		(NR_IRQS_LEGACY + 40)
+#define MX35_INT_IPU_ERR	(NR_IRQS_LEGACY + 41)
+#define MX35_INT_IPU_SYN	(NR_IRQS_LEGACY + 42)
+#define MX35_INT_CAN1		(NR_IRQS_LEGACY + 43)
+#define MX35_INT_CAN2		(NR_IRQS_LEGACY + 44)
+#define MX35_INT_UART1		(NR_IRQS_LEGACY + 45)
+#define MX35_INT_MLB		(NR_IRQS_LEGACY + 46)
+#define MX35_INT_SPDIF		(NR_IRQS_LEGACY + 47)
+#define MX35_INT_ECT		(NR_IRQS_LEGACY + 48)
+#define MX35_INT_SCC_SCM	(NR_IRQS_LEGACY + 49)
+#define MX35_INT_SCC_SMN	(NR_IRQS_LEGACY + 50)
+#define MX35_INT_GPIO2		(NR_IRQS_LEGACY + 51)
+#define MX35_INT_GPIO1		(NR_IRQS_LEGACY + 52)
+#define MX35_INT_WDOG		(NR_IRQS_LEGACY + 55)
+#define MX35_INT_GPIO3		(NR_IRQS_LEGACY + 56)
+#define MX35_INT_FEC		(NR_IRQS_LEGACY + 57)
+#define MX35_INT_EXT_POWER	(NR_IRQS_LEGACY + 58)
+#define MX35_INT_EXT_TEMPER	(NR_IRQS_LEGACY + 59)
+#define MX35_INT_EXT_SENSOR60	(NR_IRQS_LEGACY + 60)
+#define MX35_INT_EXT_SENSOR61	(NR_IRQS_LEGACY + 61)
+#define MX35_INT_EXT_WDOG	(NR_IRQS_LEGACY + 62)
+#define MX35_INT_EXT_TV		(NR_IRQS_LEGACY + 63)
 
 #define MX35_DMA_REQ_SSI2_RX1   22
 #define MX35_DMA_REQ_SSI2_TX1   23
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 30dbf42..96fb4fb 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -143,44 +143,45 @@
 /*
  * Interrupt numbers
  */
-#define MX3x_INT_I2C3		3
-#define MX3x_INT_I2C2		4
-#define MX3x_INT_RTIC		6
-#define MX3x_INT_I2C		10
-#define MX3x_INT_CSPI2		13
-#define MX3x_INT_CSPI1		14
-#define MX3x_INT_ATA		15
-#define MX3x_INT_UART3		18
-#define MX3x_INT_IIM		19
-#define MX3x_INT_RNGA		22
-#define MX3x_INT_EVTMON		23
-#define MX3x_INT_KPP		24
-#define MX3x_INT_RTC		25
-#define MX3x_INT_PWM		26
-#define MX3x_INT_EPIT2		27
-#define MX3x_INT_EPIT1		28
-#define MX3x_INT_GPT		29
-#define MX3x_INT_POWER_FAIL	30
-#define MX3x_INT_UART2		32
-#define MX3x_INT_NANDFC		33
-#define MX3x_INT_SDMA		34
-#define MX3x_INT_MSHC1		39
-#define MX3x_INT_IPU_ERR	41
-#define MX3x_INT_IPU_SYN	42
-#define MX3x_INT_UART1		45
-#define MX3x_INT_ECT		48
-#define MX3x_INT_SCC_SCM	49
-#define MX3x_INT_SCC_SMN	50
-#define MX3x_INT_GPIO2		51
-#define MX3x_INT_GPIO1		52
-#define MX3x_INT_WDOG		55
-#define MX3x_INT_GPIO3		56
-#define MX3x_INT_EXT_POWER	58
-#define MX3x_INT_EXT_TEMPER	59
-#define MX3x_INT_EXT_SENSOR60	60
-#define MX3x_INT_EXT_SENSOR61	61
-#define MX3x_INT_EXT_WDOG	62
-#define MX3x_INT_EXT_TV		63
+#include <asm/irq.h>
+#define MX3x_INT_I2C3		(NR_IRQS_LEGACY + 3)
+#define MX3x_INT_I2C2		(NR_IRQS_LEGACY + 4)
+#define MX3x_INT_RTIC		(NR_IRQS_LEGACY + 6)
+#define MX3x_INT_I2C		(NR_IRQS_LEGACY + 10)
+#define MX3x_INT_CSPI2		(NR_IRQS_LEGACY + 13)
+#define MX3x_INT_CSPI1		(NR_IRQS_LEGACY + 14)
+#define MX3x_INT_ATA		(NR_IRQS_LEGACY + 15)
+#define MX3x_INT_UART3		(NR_IRQS_LEGACY + 18)
+#define MX3x_INT_IIM		(NR_IRQS_LEGACY + 19)
+#define MX3x_INT_RNGA		(NR_IRQS_LEGACY + 22)
+#define MX3x_INT_EVTMON		(NR_IRQS_LEGACY + 23)
+#define MX3x_INT_KPP		(NR_IRQS_LEGACY + 24)
+#define MX3x_INT_RTC		(NR_IRQS_LEGACY + 25)
+#define MX3x_INT_PWM		(NR_IRQS_LEGACY + 26)
+#define MX3x_INT_EPIT2		(NR_IRQS_LEGACY + 27)
+#define MX3x_INT_EPIT1		(NR_IRQS_LEGACY + 28)
+#define MX3x_INT_GPT		(NR_IRQS_LEGACY + 29)
+#define MX3x_INT_POWER_FAIL	(NR_IRQS_LEGACY + 30)
+#define MX3x_INT_UART2		(NR_IRQS_LEGACY + 32)
+#define MX3x_INT_NANDFC		(NR_IRQS_LEGACY + 33)
+#define MX3x_INT_SDMA		(NR_IRQS_LEGACY + 34)
+#define MX3x_INT_MSHC1		(NR_IRQS_LEGACY + 39)
+#define MX3x_INT_IPU_ERR	(NR_IRQS_LEGACY + 41)
+#define MX3x_INT_IPU_SYN	(NR_IRQS_LEGACY + 42)
+#define MX3x_INT_UART1		(NR_IRQS_LEGACY + 45)
+#define MX3x_INT_ECT		(NR_IRQS_LEGACY + 48)
+#define MX3x_INT_SCC_SCM	(NR_IRQS_LEGACY + 49)
+#define MX3x_INT_SCC_SMN	(NR_IRQS_LEGACY + 50)
+#define MX3x_INT_GPIO2		(NR_IRQS_LEGACY + 51)
+#define MX3x_INT_GPIO1		(NR_IRQS_LEGACY + 52)
+#define MX3x_INT_WDOG		(NR_IRQS_LEGACY + 55)
+#define MX3x_INT_GPIO3		(NR_IRQS_LEGACY + 56)
+#define MX3x_INT_EXT_POWER	(NR_IRQS_LEGACY + 58)
+#define MX3x_INT_EXT_TEMPER	(NR_IRQS_LEGACY + 59)
+#define MX3x_INT_EXT_SENSOR60	(NR_IRQS_LEGACY + 60)
+#define MX3x_INT_EXT_SENSOR61	(NR_IRQS_LEGACY + 61)
+#define MX3x_INT_EXT_WDOG	(NR_IRQS_LEGACY + 62)
+#define MX3x_INT_EXT_TV		(NR_IRQS_LEGACY + 63)
 
 #define MX3x_PROD_SIGNATURE		0x1	/* For MX31 */
 
diff --git a/arch/arm/plat-mxc/include/mach/mx50.h b/arch/arm/plat-mxc/include/mach/mx50.h
index 5f2da75a..09ac19c 100644
--- a/arch/arm/plat-mxc/include/mach/mx50.h
+++ b/arch/arm/plat-mxc/include/mach/mx50.h
@@ -188,99 +188,100 @@
 /*
  * Interrupt numbers
  */
-#define MX50_INT_MMC_SDHC1	1
-#define MX50_INT_MMC_SDHC2	2
-#define MX50_INT_MMC_SDHC3	3
-#define MX50_INT_MMC_SDHC4	4
-#define MX50_INT_DAP		5
-#define MX50_INT_SDMA		6
-#define MX50_INT_IOMUX		7
-#define MX50_INT_UART4		13
-#define MX50_INT_USB_H1		14
-#define MX50_INT_USB_OTG	18
-#define MX50_INT_DATABAHN	19
-#define MX50_INT_ELCDIF		20
-#define MX50_INT_EPXP		21
-#define MX50_INT_SRTC_NTZ	24
-#define MX50_INT_SRTC_TZ	25
-#define MX50_INT_EPDC		27
-#define MX50_INT_NIC		28
-#define MX50_INT_SSI1		29
-#define MX50_INT_SSI2		30
-#define MX50_INT_UART1		31
-#define MX50_INT_UART2		32
-#define MX50_INT_UART3		33
-#define MX50_INT_RESV34		34
-#define MX50_INT_RESV35		35
-#define MX50_INT_CSPI1		36
-#define MX50_INT_CSPI2		37
-#define MX50_INT_CSPI		38
-#define MX50_INT_GPT		39
-#define MX50_INT_EPIT1		40
-#define MX50_INT_GPIO1_INT7	42
-#define MX50_INT_GPIO1_INT6	43
-#define MX50_INT_GPIO1_INT5	44
-#define MX50_INT_GPIO1_INT4	45
-#define MX50_INT_GPIO1_INT3	46
-#define MX50_INT_GPIO1_INT2	47
-#define MX50_INT_GPIO1_INT1	48
-#define MX50_INT_GPIO1_INT0	49
-#define MX50_INT_GPIO1_LOW	50
-#define MX50_INT_GPIO1_HIGH	51
-#define MX50_INT_GPIO2_LOW	52
-#define MX50_INT_GPIO2_HIGH	53
-#define MX50_INT_GPIO3_LOW	54
-#define MX50_INT_GPIO3_HIGH	55
-#define MX50_INT_GPIO4_LOW	56
-#define MX50_INT_GPIO4_HIGH	57
-#define MX50_INT_WDOG1		58
-#define MX50_INT_KPP		60
-#define MX50_INT_PWM1		61
-#define MX50_INT_I2C1		62
-#define MX50_INT_I2C2		63
-#define MX50_INT_I2C3		64
-#define MX50_INT_RESV65		65
-#define MX50_INT_DCDC		66
-#define MX50_INT_THERMAL_ALARM	67
-#define MX50_INT_ANA3		68
-#define MX50_INT_ANA4		69
-#define MX50_INT_CCM1		71
-#define MX50_INT_CCM2		72
-#define MX50_INT_GPC1		73
-#define MX50_INT_GPC2		74
-#define MX50_INT_SRC		75
-#define MX50_INT_NM		76
-#define MX50_INT_PMU		77
-#define MX50_INT_CTI_IRQ	78
-#define MX50_INT_CTI1_TG0	79
-#define MX50_INT_CTI1_TG1	80
-#define MX50_INT_GPU2_IRQ	84
-#define MX50_INT_GPU2_BUSY	85
-#define MX50_INT_UART5		86
-#define MX50_INT_FEC		87
-#define MX50_INT_OWIRE		88
-#define MX50_INT_CTI1_TG2	89
-#define MX50_INT_SJC		90
-#define MX50_INT_DCP_CHAN1_3	91
-#define MX50_INT_DCP_CHAN0	92
-#define MX50_INT_PWM2		94
-#define MX50_INT_RNGB		97
-#define MX50_INT_CTI1_TG3	98
-#define MX50_INT_RAWNAND_BCH	100
-#define MX50_INT_RAWNAND_GPMI	102
-#define MX50_INT_GPIO5_LOW	103
-#define MX50_INT_GPIO5_HIGH	104
-#define MX50_INT_GPIO6_LOW	105
-#define MX50_INT_GPIO6_HIGH	106
-#define MX50_INT_MSHC		109
-#define MX50_INT_APBHDMA_CHAN0	110
-#define MX50_INT_APBHDMA_CHAN1	111
-#define MX50_INT_APBHDMA_CHAN2	112
-#define MX50_INT_APBHDMA_CHAN3	113
-#define MX50_INT_APBHDMA_CHAN4	114
-#define MX50_INT_APBHDMA_CHAN5	115
-#define MX50_INT_APBHDMA_CHAN6	116
-#define MX50_INT_APBHDMA_CHAN7	117
+#include <asm/irq.h>
+#define MX50_INT_MMC_SDHC1	(NR_IRQS_LEGACY + 1)
+#define MX50_INT_MMC_SDHC2	(NR_IRQS_LEGACY + 2)
+#define MX50_INT_MMC_SDHC3	(NR_IRQS_LEGACY + 3)
+#define MX50_INT_MMC_SDHC4	(NR_IRQS_LEGACY + 4)
+#define MX50_INT_DAP		(NR_IRQS_LEGACY + 5)
+#define MX50_INT_SDMA		(NR_IRQS_LEGACY + 6)
+#define MX50_INT_IOMUX		(NR_IRQS_LEGACY + 7)
+#define MX50_INT_UART4		(NR_IRQS_LEGACY + 13)
+#define MX50_INT_USB_H1		(NR_IRQS_LEGACY + 14)
+#define MX50_INT_USB_OTG	(NR_IRQS_LEGACY + 18)
+#define MX50_INT_DATABAHN	(NR_IRQS_LEGACY + 19)
+#define MX50_INT_ELCDIF		(NR_IRQS_LEGACY + 20)
+#define MX50_INT_EPXP		(NR_IRQS_LEGACY + 21)
+#define MX50_INT_SRTC_NTZ	(NR_IRQS_LEGACY + 24)
+#define MX50_INT_SRTC_TZ	(NR_IRQS_LEGACY + 25)
+#define MX50_INT_EPDC		(NR_IRQS_LEGACY + 27)
+#define MX50_INT_NIC		(NR_IRQS_LEGACY + 28)
+#define MX50_INT_SSI1		(NR_IRQS_LEGACY + 29)
+#define MX50_INT_SSI2		(NR_IRQS_LEGACY + 30)
+#define MX50_INT_UART1		(NR_IRQS_LEGACY + 31)
+#define MX50_INT_UART2		(NR_IRQS_LEGACY + 32)
+#define MX50_INT_UART3		(NR_IRQS_LEGACY + 33)
+#define MX50_INT_RESV34		(NR_IRQS_LEGACY + 34)
+#define MX50_INT_RESV35		(NR_IRQS_LEGACY + 35)
+#define MX50_INT_CSPI1		(NR_IRQS_LEGACY + 36)
+#define MX50_INT_CSPI2		(NR_IRQS_LEGACY + 37)
+#define MX50_INT_CSPI		(NR_IRQS_LEGACY + 38)
+#define MX50_INT_GPT		(NR_IRQS_LEGACY + 39)
+#define MX50_INT_EPIT1		(NR_IRQS_LEGACY + 40)
+#define MX50_INT_GPIO1_INT7	(NR_IRQS_LEGACY + 42)
+#define MX50_INT_GPIO1_INT6	(NR_IRQS_LEGACY + 43)
+#define MX50_INT_GPIO1_INT5	(NR_IRQS_LEGACY + 44)
+#define MX50_INT_GPIO1_INT4	(NR_IRQS_LEGACY + 45)
+#define MX50_INT_GPIO1_INT3	(NR_IRQS_LEGACY + 46)
+#define MX50_INT_GPIO1_INT2	(NR_IRQS_LEGACY + 47)
+#define MX50_INT_GPIO1_INT1	(NR_IRQS_LEGACY + 48)
+#define MX50_INT_GPIO1_INT0	(NR_IRQS_LEGACY + 49)
+#define MX50_INT_GPIO1_LOW	(NR_IRQS_LEGACY + 50)
+#define MX50_INT_GPIO1_HIGH	(NR_IRQS_LEGACY + 51)
+#define MX50_INT_GPIO2_LOW	(NR_IRQS_LEGACY + 52)
+#define MX50_INT_GPIO2_HIGH	(NR_IRQS_LEGACY + 53)
+#define MX50_INT_GPIO3_LOW	(NR_IRQS_LEGACY + 54)
+#define MX50_INT_GPIO3_HIGH	(NR_IRQS_LEGACY + 55)
+#define MX50_INT_GPIO4_LOW	(NR_IRQS_LEGACY + 56)
+#define MX50_INT_GPIO4_HIGH	(NR_IRQS_LEGACY + 57)
+#define MX50_INT_WDOG1		(NR_IRQS_LEGACY + 58)
+#define MX50_INT_KPP		(NR_IRQS_LEGACY + 60)
+#define MX50_INT_PWM1		(NR_IRQS_LEGACY + 61)
+#define MX50_INT_I2C1		(NR_IRQS_LEGACY + 62)
+#define MX50_INT_I2C2		(NR_IRQS_LEGACY + 63)
+#define MX50_INT_I2C3		(NR_IRQS_LEGACY + 64)
+#define MX50_INT_RESV65		(NR_IRQS_LEGACY + 65)
+#define MX50_INT_DCDC		(NR_IRQS_LEGACY + 66)
+#define MX50_INT_THERMAL_ALARM	(NR_IRQS_LEGACY + 67)
+#define MX50_INT_ANA3		(NR_IRQS_LEGACY + 68)
+#define MX50_INT_ANA4		(NR_IRQS_LEGACY + 69)
+#define MX50_INT_CCM1		(NR_IRQS_LEGACY + 71)
+#define MX50_INT_CCM2		(NR_IRQS_LEGACY + 72)
+#define MX50_INT_GPC1		(NR_IRQS_LEGACY + 73)
+#define MX50_INT_GPC2		(NR_IRQS_LEGACY + 74)
+#define MX50_INT_SRC		(NR_IRQS_LEGACY + 75)
+#define MX50_INT_NM		(NR_IRQS_LEGACY + 76)
+#define MX50_INT_PMU		(NR_IRQS_LEGACY + 77)
+#define MX50_INT_CTI_IRQ	(NR_IRQS_LEGACY + 78)
+#define MX50_INT_CTI1_TG0	(NR_IRQS_LEGACY + 79)
+#define MX50_INT_CTI1_TG1	(NR_IRQS_LEGACY + 80)
+#define MX50_INT_GPU2_IRQ	(NR_IRQS_LEGACY + 84)
+#define MX50_INT_GPU2_BUSY	(NR_IRQS_LEGACY + 85)
+#define MX50_INT_UART5		(NR_IRQS_LEGACY + 86)
+#define MX50_INT_FEC		(NR_IRQS_LEGACY + 87)
+#define MX50_INT_OWIRE		(NR_IRQS_LEGACY + 88)
+#define MX50_INT_CTI1_TG2	(NR_IRQS_LEGACY + 89)
+#define MX50_INT_SJC		(NR_IRQS_LEGACY + 90)
+#define MX50_INT_DCP_CHAN1_3	(NR_IRQS_LEGACY + 91)
+#define MX50_INT_DCP_CHAN0	(NR_IRQS_LEGACY + 92)
+#define MX50_INT_PWM2		(NR_IRQS_LEGACY + 94)
+#define MX50_INT_RNGB		(NR_IRQS_LEGACY + 97)
+#define MX50_INT_CTI1_TG3	(NR_IRQS_LEGACY + 98)
+#define MX50_INT_RAWNAND_BCH	(NR_IRQS_LEGACY + 100)
+#define MX50_INT_RAWNAND_GPMI	(NR_IRQS_LEGACY + 102)
+#define MX50_INT_GPIO5_LOW	(NR_IRQS_LEGACY + 103)
+#define MX50_INT_GPIO5_HIGH	(NR_IRQS_LEGACY + 104)
+#define MX50_INT_GPIO6_LOW	(NR_IRQS_LEGACY + 105)
+#define MX50_INT_GPIO6_HIGH	(NR_IRQS_LEGACY + 106)
+#define MX50_INT_MSHC		(NR_IRQS_LEGACY + 109)
+#define MX50_INT_APBHDMA_CHAN0	(NR_IRQS_LEGACY + 110)
+#define MX50_INT_APBHDMA_CHAN1	(NR_IRQS_LEGACY + 111)
+#define MX50_INT_APBHDMA_CHAN2	(NR_IRQS_LEGACY + 112)
+#define MX50_INT_APBHDMA_CHAN3	(NR_IRQS_LEGACY + 113)
+#define MX50_INT_APBHDMA_CHAN4	(NR_IRQS_LEGACY + 114)
+#define MX50_INT_APBHDMA_CHAN5	(NR_IRQS_LEGACY + 115)
+#define MX50_INT_APBHDMA_CHAN6	(NR_IRQS_LEGACY + 116)
+#define MX50_INT_APBHDMA_CHAN7	(NR_IRQS_LEGACY + 117)
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
 extern int mx50_revision(void);
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index cdf07c6..af844f7 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -232,110 +232,111 @@
 /*
  * Interrupt numbers
  */
-#define MX51_INT_BASE			0
-#define MX51_INT_RESV0			0
-#define MX51_INT_ESDHC1			1
-#define MX51_INT_ESDHC2			2
-#define MX51_INT_ESDHC3			3
-#define MX51_INT_ESDHC4			4
-#define MX51_INT_RESV5			5
-#define MX51_INT_SDMA			6
-#define MX51_INT_IOMUX			7
-#define MX51_INT_NFC			8
-#define MX51_INT_VPU			9
-#define MX51_INT_IPU_ERR		10
-#define MX51_INT_IPU_SYN		11
-#define MX51_INT_GPU			12
-#define MX51_INT_RESV13			13
-#define MX51_INT_USB_HS1		14
-#define MX51_INT_EMI			15
-#define MX51_INT_USB_HS2		16
-#define MX51_INT_USB_HS3		17
-#define MX51_INT_USB_OTG		18
-#define MX51_INT_SAHARA_H0		19
-#define MX51_INT_SAHARA_H1		20
-#define MX51_INT_SCC_SMN		21
-#define MX51_INT_SCC_STZ		22
-#define MX51_INT_SCC_SCM		23
-#define MX51_INT_SRTC_NTZ		24
-#define MX51_INT_SRTC_TZ		25
-#define MX51_INT_RTIC			26
-#define MX51_INT_CSU			27
-#define MX51_INT_SLIM_B			28
-#define MX51_INT_SSI1			29
-#define MX51_INT_SSI2			30
-#define MX51_INT_UART1			31
-#define MX51_INT_UART2			32
-#define MX51_INT_UART3			33
-#define MX51_INT_RESV34			34
-#define MX51_INT_RESV35			35
-#define MX51_INT_ECSPI1			36
-#define MX51_INT_ECSPI2			37
-#define MX51_INT_CSPI			38
-#define MX51_INT_GPT			39
-#define MX51_INT_EPIT1			40
-#define MX51_INT_EPIT2			41
-#define MX51_INT_GPIO1_INT7		42
-#define MX51_INT_GPIO1_INT6		43
-#define MX51_INT_GPIO1_INT5		44
-#define MX51_INT_GPIO1_INT4		45
-#define MX51_INT_GPIO1_INT3		46
-#define MX51_INT_GPIO1_INT2		47
-#define MX51_INT_GPIO1_INT1		48
-#define MX51_INT_GPIO1_INT0		49
-#define MX51_INT_GPIO1_LOW		50
-#define MX51_INT_GPIO1_HIGH		51
-#define MX51_INT_GPIO2_LOW		52
-#define MX51_INT_GPIO2_HIGH		53
-#define MX51_INT_GPIO3_LOW		54
-#define MX51_INT_GPIO3_HIGH		55
-#define MX51_INT_GPIO4_LOW		56
-#define MX51_INT_GPIO4_HIGH		57
-#define MX51_INT_WDOG1			58
-#define MX51_INT_WDOG2			59
-#define MX51_INT_KPP			60
-#define MX51_INT_PWM1			61
-#define MX51_INT_I2C1			62
-#define MX51_INT_I2C2			63
-#define MX51_INT_HS_I2C			64
-#define MX51_INT_RESV65			65
-#define MX51_INT_RESV66			66
-#define MX51_INT_SIM_IPB		67
-#define MX51_INT_SIM_DAT		68
-#define MX51_INT_IIM			69
-#define MX51_INT_ATA			70
-#define MX51_INT_CCM1			71
-#define MX51_INT_CCM2			72
-#define MX51_INT_GPC1				73
-#define MX51_INT_GPC2			74
-#define MX51_INT_SRC			75
-#define MX51_INT_NM			76
-#define MX51_INT_PMU			77
-#define MX51_INT_CTI_IRQ		78
-#define MX51_INT_CTI1_TG0		79
-#define MX51_INT_CTI1_TG1		80
-#define MX51_INT_MCG_ERR		81
-#define MX51_INT_MCG_TMR		82
-#define MX51_INT_MCG_FUNC		83
-#define MX51_INT_GPU2_IRQ		84
-#define MX51_INT_GPU2_BUSY		85
-#define MX51_INT_RESV86			86
-#define MX51_INT_FEC			87
-#define MX51_INT_OWIRE			88
-#define MX51_INT_CTI1_TG2		89
-#define MX51_INT_SJC			90
-#define MX51_INT_SPDIF			91
-#define MX51_INT_TVE			92
-#define MX51_INT_FIRI			93
-#define MX51_INT_PWM2			94
-#define MX51_INT_SLIM_EXP		95
-#define MX51_INT_SSI3			96
-#define MX51_INT_EMI_BOOT		97
-#define MX51_INT_CTI1_TG3		98
-#define MX51_INT_SMC_RX			99
-#define MX51_INT_VPU_IDLE		100
-#define MX51_INT_EMI_NFC		101
-#define MX51_INT_GPU_IDLE		102
+#include <asm/irq.h>
+#define MX51_INT_BASE			(NR_IRQS_LEGACY + 0)
+#define MX51_INT_RESV0			(NR_IRQS_LEGACY + 0)
+#define MX51_INT_ESDHC1			(NR_IRQS_LEGACY + 1)
+#define MX51_INT_ESDHC2			(NR_IRQS_LEGACY + 2)
+#define MX51_INT_ESDHC3			(NR_IRQS_LEGACY + 3)
+#define MX51_INT_ESDHC4			(NR_IRQS_LEGACY + 4)
+#define MX51_INT_RESV5			(NR_IRQS_LEGACY + 5)
+#define MX51_INT_SDMA			(NR_IRQS_LEGACY + 6)
+#define MX51_INT_IOMUX			(NR_IRQS_LEGACY + 7)
+#define MX51_INT_NFC			(NR_IRQS_LEGACY + 8)
+#define MX51_INT_VPU			(NR_IRQS_LEGACY + 9)
+#define MX51_INT_IPU_ERR		(NR_IRQS_LEGACY + 10)
+#define MX51_INT_IPU_SYN		(NR_IRQS_LEGACY + 11)
+#define MX51_INT_GPU			(NR_IRQS_LEGACY + 12)
+#define MX51_INT_RESV13			(NR_IRQS_LEGACY + 13)
+#define MX51_INT_USB_HS1		(NR_IRQS_LEGACY + 14)
+#define MX51_INT_EMI			(NR_IRQS_LEGACY + 15)
+#define MX51_INT_USB_HS2		(NR_IRQS_LEGACY + 16)
+#define MX51_INT_USB_HS3		(NR_IRQS_LEGACY + 17)
+#define MX51_INT_USB_OTG		(NR_IRQS_LEGACY + 18)
+#define MX51_INT_SAHARA_H0		(NR_IRQS_LEGACY + 19)
+#define MX51_INT_SAHARA_H1		(NR_IRQS_LEGACY + 20)
+#define MX51_INT_SCC_SMN		(NR_IRQS_LEGACY + 21)
+#define MX51_INT_SCC_STZ		(NR_IRQS_LEGACY + 22)
+#define MX51_INT_SCC_SCM		(NR_IRQS_LEGACY + 23)
+#define MX51_INT_SRTC_NTZ		(NR_IRQS_LEGACY + 24)
+#define MX51_INT_SRTC_TZ		(NR_IRQS_LEGACY + 25)
+#define MX51_INT_RTIC			(NR_IRQS_LEGACY + 26)
+#define MX51_INT_CSU			(NR_IRQS_LEGACY + 27)
+#define MX51_INT_SLIM_B			(NR_IRQS_LEGACY + 28)
+#define MX51_INT_SSI1			(NR_IRQS_LEGACY + 29)
+#define MX51_INT_SSI2			(NR_IRQS_LEGACY + 30)
+#define MX51_INT_UART1			(NR_IRQS_LEGACY + 31)
+#define MX51_INT_UART2			(NR_IRQS_LEGACY + 32)
+#define MX51_INT_UART3			(NR_IRQS_LEGACY + 33)
+#define MX51_INT_RESV34			(NR_IRQS_LEGACY + 34)
+#define MX51_INT_RESV35			(NR_IRQS_LEGACY + 35)
+#define MX51_INT_ECSPI1			(NR_IRQS_LEGACY + 36)
+#define MX51_INT_ECSPI2			(NR_IRQS_LEGACY + 37)
+#define MX51_INT_CSPI			(NR_IRQS_LEGACY + 38)
+#define MX51_INT_GPT			(NR_IRQS_LEGACY + 39)
+#define MX51_INT_EPIT1			(NR_IRQS_LEGACY + 40)
+#define MX51_INT_EPIT2			(NR_IRQS_LEGACY + 41)
+#define MX51_INT_GPIO1_INT7		(NR_IRQS_LEGACY + 42)
+#define MX51_INT_GPIO1_INT6		(NR_IRQS_LEGACY + 43)
+#define MX51_INT_GPIO1_INT5		(NR_IRQS_LEGACY + 44)
+#define MX51_INT_GPIO1_INT4		(NR_IRQS_LEGACY + 45)
+#define MX51_INT_GPIO1_INT3		(NR_IRQS_LEGACY + 46)
+#define MX51_INT_GPIO1_INT2		(NR_IRQS_LEGACY + 47)
+#define MX51_INT_GPIO1_INT1		(NR_IRQS_LEGACY + 48)
+#define MX51_INT_GPIO1_INT0		(NR_IRQS_LEGACY + 49)
+#define MX51_INT_GPIO1_LOW		(NR_IRQS_LEGACY + 50)
+#define MX51_INT_GPIO1_HIGH		(NR_IRQS_LEGACY + 51)
+#define MX51_INT_GPIO2_LOW		(NR_IRQS_LEGACY + 52)
+#define MX51_INT_GPIO2_HIGH		(NR_IRQS_LEGACY + 53)
+#define MX51_INT_GPIO3_LOW		(NR_IRQS_LEGACY + 54)
+#define MX51_INT_GPIO3_HIGH		(NR_IRQS_LEGACY + 55)
+#define MX51_INT_GPIO4_LOW		(NR_IRQS_LEGACY + 56)
+#define MX51_INT_GPIO4_HIGH		(NR_IRQS_LEGACY + 57)
+#define MX51_INT_WDOG1			(NR_IRQS_LEGACY + 58)
+#define MX51_INT_WDOG2			(NR_IRQS_LEGACY + 59)
+#define MX51_INT_KPP			(NR_IRQS_LEGACY + 60)
+#define MX51_INT_PWM1			(NR_IRQS_LEGACY + 61)
+#define MX51_INT_I2C1			(NR_IRQS_LEGACY + 62)
+#define MX51_INT_I2C2			(NR_IRQS_LEGACY + 63)
+#define MX51_INT_HS_I2C			(NR_IRQS_LEGACY + 64)
+#define MX51_INT_RESV65			(NR_IRQS_LEGACY + 65)
+#define MX51_INT_RESV66			(NR_IRQS_LEGACY + 66)
+#define MX51_INT_SIM_IPB		(NR_IRQS_LEGACY + 67)
+#define MX51_INT_SIM_DAT		(NR_IRQS_LEGACY + 68)
+#define MX51_INT_IIM			(NR_IRQS_LEGACY + 69)
+#define MX51_INT_ATA			(NR_IRQS_LEGACY + 70)
+#define MX51_INT_CCM1			(NR_IRQS_LEGACY + 71)
+#define MX51_INT_CCM2			(NR_IRQS_LEGACY + 72)
+#define MX51_INT_GPC1			(NR_IRQS_LEGACY + 73)
+#define MX51_INT_GPC2			(NR_IRQS_LEGACY + 74)
+#define MX51_INT_SRC			(NR_IRQS_LEGACY + 75)
+#define MX51_INT_NM			(NR_IRQS_LEGACY + 76)
+#define MX51_INT_PMU			(NR_IRQS_LEGACY + 77)
+#define MX51_INT_CTI_IRQ		(NR_IRQS_LEGACY + 78)
+#define MX51_INT_CTI1_TG0		(NR_IRQS_LEGACY + 79)
+#define MX51_INT_CTI1_TG1		(NR_IRQS_LEGACY + 80)
+#define MX51_INT_MCG_ERR		(NR_IRQS_LEGACY + 81)
+#define MX51_INT_MCG_TMR		(NR_IRQS_LEGACY + 82)
+#define MX51_INT_MCG_FUNC		(NR_IRQS_LEGACY + 83)
+#define MX51_INT_GPU2_IRQ		(NR_IRQS_LEGACY + 84)
+#define MX51_INT_GPU2_BUSY		(NR_IRQS_LEGACY + 85)
+#define MX51_INT_RESV86			(NR_IRQS_LEGACY + 86)
+#define MX51_INT_FEC			(NR_IRQS_LEGACY + 87)
+#define MX51_INT_OWIRE			(NR_IRQS_LEGACY + 88)
+#define MX51_INT_CTI1_TG2		(NR_IRQS_LEGACY + 89)
+#define MX51_INT_SJC			(NR_IRQS_LEGACY + 90)
+#define MX51_INT_SPDIF			(NR_IRQS_LEGACY + 91)
+#define MX51_INT_TVE			(NR_IRQS_LEGACY + 92)
+#define MX51_INT_FIRI			(NR_IRQS_LEGACY + 93)
+#define MX51_INT_PWM2			(NR_IRQS_LEGACY + 94)
+#define MX51_INT_SLIM_EXP		(NR_IRQS_LEGACY + 95)
+#define MX51_INT_SSI3			(NR_IRQS_LEGACY + 96)
+#define MX51_INT_EMI_BOOT		(NR_IRQS_LEGACY + 97)
+#define MX51_INT_CTI1_TG3		(NR_IRQS_LEGACY + 98)
+#define MX51_INT_SMC_RX			(NR_IRQS_LEGACY + 99)
+#define MX51_INT_VPU_IDLE		(NR_IRQS_LEGACY + 100)
+#define MX51_INT_EMI_NFC		(NR_IRQS_LEGACY + 101)
+#define MX51_INT_GPU_IDLE		(NR_IRQS_LEGACY + 102)
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
 extern int mx51_revision(void);
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index a37e8c3..f829d1c 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -229,113 +229,114 @@
 /*
  * Interrupt numbers
  */
-#define MX53_INT_RESV0		0
-#define MX53_INT_ESDHC1	1
-#define MX53_INT_ESDHC2	2
-#define MX53_INT_ESDHC3	3
-#define MX53_INT_ESDHC4	4
-#define MX53_INT_DAP	5
-#define MX53_INT_SDMA	6
-#define MX53_INT_IOMUX	7
-#define MX53_INT_NFC	8
-#define MX53_INT_VPU	9
-#define MX53_INT_IPU_ERR	10
-#define MX53_INT_IPU_SYN	11
-#define MX53_INT_GPU	12
-#define MX53_INT_UART4	13
-#define MX53_INT_USB_H1	14
-#define MX53_INT_EMI	15
-#define MX53_INT_USB_H2	16
-#define MX53_INT_USB_H3	17
-#define MX53_INT_USB_OTG	18
-#define MX53_INT_SAHARA_H0	19
-#define MX53_INT_SAHARA_H1	20
-#define MX53_INT_SCC_SMN	21
-#define MX53_INT_SCC_STZ	22
-#define MX53_INT_SCC_SCM	23
-#define MX53_INT_SRTC_NTZ	24
-#define MX53_INT_SRTC_TZ	25
-#define MX53_INT_RTIC	26
-#define MX53_INT_CSU	27
-#define MX53_INT_SATA	28
-#define MX53_INT_SSI1	29
-#define MX53_INT_SSI2	30
-#define MX53_INT_UART1	31
-#define MX53_INT_UART2	32
-#define MX53_INT_UART3	33
-#define MX53_INT_RTC	34
-#define MX53_INT_PTP	35
-#define MX53_INT_ECSPI1	36
-#define MX53_INT_ECSPI2	37
-#define MX53_INT_CSPI	38
-#define MX53_INT_GPT	39
-#define MX53_INT_EPIT1	40
-#define MX53_INT_EPIT2	41
-#define MX53_INT_GPIO1_INT7	42
-#define MX53_INT_GPIO1_INT6	43
-#define MX53_INT_GPIO1_INT5	44
-#define MX53_INT_GPIO1_INT4	45
-#define MX53_INT_GPIO1_INT3	46
-#define MX53_INT_GPIO1_INT2	47
-#define MX53_INT_GPIO1_INT1	48
-#define MX53_INT_GPIO1_INT0	49
-#define MX53_INT_GPIO1_LOW	50
-#define MX53_INT_GPIO1_HIGH	51
-#define MX53_INT_GPIO2_LOW	52
-#define MX53_INT_GPIO2_HIGH	53
-#define MX53_INT_GPIO3_LOW	54
-#define MX53_INT_GPIO3_HIGH	55
-#define MX53_INT_GPIO4_LOW	56
-#define MX53_INT_GPIO4_HIGH	57
-#define MX53_INT_WDOG1	58
-#define MX53_INT_WDOG2	59
-#define MX53_INT_KPP	60
-#define MX53_INT_PWM1	61
-#define MX53_INT_I2C1	62
-#define MX53_INT_I2C2	63
-#define MX53_INT_I2C3	64
-#define MX53_INT_MLB	65
-#define MX53_INT_ASRC	66
-#define MX53_INT_SPDIF	67
-#define MX53_INT_SIM_DAT	68
-#define MX53_INT_IIM	69
-#define MX53_INT_ATA	70
-#define MX53_INT_CCM1	71
-#define MX53_INT_CCM2	72
-#define MX53_INT_GPC1	73
-#define MX53_INT_GPC2	74
-#define MX53_INT_SRC	75
-#define MX53_INT_NM		76
-#define MX53_INT_PMU	77
-#define MX53_INT_CTI_IRQ	78
-#define MX53_INT_CTI1_TG0	79
-#define MX53_INT_CTI1_TG1	80
-#define MX53_INT_ESAI	81
-#define MX53_INT_CAN1	82
-#define MX53_INT_CAN2	83
-#define MX53_INT_GPU2_IRQ	84
-#define MX53_INT_GPU2_BUSY	85
-#define MX53_INT_UART5	86
-#define MX53_INT_FEC	87
-#define MX53_INT_OWIRE	88
-#define MX53_INT_CTI1_TG2	89
-#define MX53_INT_SJC	90
-#define MX53_INT_TVE	92
-#define MX53_INT_FIRI	93
-#define MX53_INT_PWM2	94
-#define MX53_INT_SLIM_EXP	95
-#define MX53_INT_SSI3	96
-#define MX53_INT_EMI_BOOT	97
-#define MX53_INT_CTI1_TG3	98
-#define MX53_INT_SMC_RX	99
-#define MX53_INT_VPU_IDLE	100
-#define MX53_INT_EMI_NFC	101
-#define MX53_INT_GPU_IDLE	102
-#define MX53_INT_GPIO5_LOW	103
-#define MX53_INT_GPIO5_HIGH	104
-#define MX53_INT_GPIO6_LOW	105
-#define MX53_INT_GPIO6_HIGH	106
-#define MX53_INT_GPIO7_LOW	107
-#define MX53_INT_GPIO7_HIGH	108
+#include <asm/irq.h>
+#define MX53_INT_RESV0		(NR_IRQS_LEGACY + 0)
+#define MX53_INT_ESDHC1		(NR_IRQS_LEGACY + 1)
+#define MX53_INT_ESDHC2		(NR_IRQS_LEGACY + 2)
+#define MX53_INT_ESDHC3		(NR_IRQS_LEGACY + 3)
+#define MX53_INT_ESDHC4		(NR_IRQS_LEGACY + 4)
+#define MX53_INT_DAP		(NR_IRQS_LEGACY + 5)
+#define MX53_INT_SDMA		(NR_IRQS_LEGACY + 6)
+#define MX53_INT_IOMUX		(NR_IRQS_LEGACY + 7)
+#define MX53_INT_NFC		(NR_IRQS_LEGACY + 8)
+#define MX53_INT_VPU		(NR_IRQS_LEGACY + 9)
+#define MX53_INT_IPU_ERR	(NR_IRQS_LEGACY + 10)
+#define MX53_INT_IPU_SYN	(NR_IRQS_LEGACY + 11)
+#define MX53_INT_GPU		(NR_IRQS_LEGACY + 12)
+#define MX53_INT_UART4		(NR_IRQS_LEGACY + 13)
+#define MX53_INT_USB_H1		(NR_IRQS_LEGACY + 14)
+#define MX53_INT_EMI		(NR_IRQS_LEGACY + 15)
+#define MX53_INT_USB_H2		(NR_IRQS_LEGACY + 16)
+#define MX53_INT_USB_H3		(NR_IRQS_LEGACY + 17)
+#define MX53_INT_USB_OTG	(NR_IRQS_LEGACY + 18)
+#define MX53_INT_SAHARA_H0	(NR_IRQS_LEGACY + 19)
+#define MX53_INT_SAHARA_H1	(NR_IRQS_LEGACY + 20)
+#define MX53_INT_SCC_SMN	(NR_IRQS_LEGACY + 21)
+#define MX53_INT_SCC_STZ	(NR_IRQS_LEGACY + 22)
+#define MX53_INT_SCC_SCM	(NR_IRQS_LEGACY + 23)
+#define MX53_INT_SRTC_NTZ	(NR_IRQS_LEGACY + 24)
+#define MX53_INT_SRTC_TZ	(NR_IRQS_LEGACY + 25)
+#define MX53_INT_RTIC		(NR_IRQS_LEGACY + 26)
+#define MX53_INT_CSU		(NR_IRQS_LEGACY + 27)
+#define MX53_INT_SATA		(NR_IRQS_LEGACY + 28)
+#define MX53_INT_SSI1		(NR_IRQS_LEGACY + 29)
+#define MX53_INT_SSI2		(NR_IRQS_LEGACY + 30)
+#define MX53_INT_UART1		(NR_IRQS_LEGACY + 31)
+#define MX53_INT_UART2		(NR_IRQS_LEGACY + 32)
+#define MX53_INT_UART3		(NR_IRQS_LEGACY + 33)
+#define MX53_INT_RTC		(NR_IRQS_LEGACY + 34)
+#define MX53_INT_PTP		(NR_IRQS_LEGACY + 35)
+#define MX53_INT_ECSPI1		(NR_IRQS_LEGACY + 36)
+#define MX53_INT_ECSPI2		(NR_IRQS_LEGACY + 37)
+#define MX53_INT_CSPI		(NR_IRQS_LEGACY + 38)
+#define MX53_INT_GPT		(NR_IRQS_LEGACY + 39)
+#define MX53_INT_EPIT1		(NR_IRQS_LEGACY + 40)
+#define MX53_INT_EPIT2		(NR_IRQS_LEGACY + 41)
+#define MX53_INT_GPIO1_INT7	(NR_IRQS_LEGACY + 42)
+#define MX53_INT_GPIO1_INT6	(NR_IRQS_LEGACY + 43)
+#define MX53_INT_GPIO1_INT5	(NR_IRQS_LEGACY + 44)
+#define MX53_INT_GPIO1_INT4	(NR_IRQS_LEGACY + 45)
+#define MX53_INT_GPIO1_INT3	(NR_IRQS_LEGACY + 46)
+#define MX53_INT_GPIO1_INT2	(NR_IRQS_LEGACY + 47)
+#define MX53_INT_GPIO1_INT1	(NR_IRQS_LEGACY + 48)
+#define MX53_INT_GPIO1_INT0	(NR_IRQS_LEGACY + 49)
+#define MX53_INT_GPIO1_LOW	(NR_IRQS_LEGACY + 50)
+#define MX53_INT_GPIO1_HIGH	(NR_IRQS_LEGACY + 51)
+#define MX53_INT_GPIO2_LOW	(NR_IRQS_LEGACY + 52)
+#define MX53_INT_GPIO2_HIGH	(NR_IRQS_LEGACY + 53)
+#define MX53_INT_GPIO3_LOW	(NR_IRQS_LEGACY + 54)
+#define MX53_INT_GPIO3_HIGH	(NR_IRQS_LEGACY + 55)
+#define MX53_INT_GPIO4_LOW	(NR_IRQS_LEGACY + 56)
+#define MX53_INT_GPIO4_HIGH	(NR_IRQS_LEGACY + 57)
+#define MX53_INT_WDOG1		(NR_IRQS_LEGACY + 58)
+#define MX53_INT_WDOG2		(NR_IRQS_LEGACY + 59)
+#define MX53_INT_KPP		(NR_IRQS_LEGACY + 60)
+#define MX53_INT_PWM1		(NR_IRQS_LEGACY + 61)
+#define MX53_INT_I2C1		(NR_IRQS_LEGACY + 62)
+#define MX53_INT_I2C2		(NR_IRQS_LEGACY + 63)
+#define MX53_INT_I2C3		(NR_IRQS_LEGACY + 64)
+#define MX53_INT_MLB		(NR_IRQS_LEGACY + 65)
+#define MX53_INT_ASRC		(NR_IRQS_LEGACY + 66)
+#define MX53_INT_SPDIF		(NR_IRQS_LEGACY + 67)
+#define MX53_INT_SIM_DAT	(NR_IRQS_LEGACY + 68)
+#define MX53_INT_IIM		(NR_IRQS_LEGACY + 69)
+#define MX53_INT_ATA		(NR_IRQS_LEGACY + 70)
+#define MX53_INT_CCM1		(NR_IRQS_LEGACY + 71)
+#define MX53_INT_CCM2		(NR_IRQS_LEGACY + 72)
+#define MX53_INT_GPC1		(NR_IRQS_LEGACY + 73)
+#define MX53_INT_GPC2		(NR_IRQS_LEGACY + 74)
+#define MX53_INT_SRC		(NR_IRQS_LEGACY + 75)
+#define MX53_INT_NM		(NR_IRQS_LEGACY + 76)
+#define MX53_INT_PMU		(NR_IRQS_LEGACY + 77)
+#define MX53_INT_CTI_IRQ	(NR_IRQS_LEGACY + 78)
+#define MX53_INT_CTI1_TG0	(NR_IRQS_LEGACY + 79)
+#define MX53_INT_CTI1_TG1	(NR_IRQS_LEGACY + 80)
+#define MX53_INT_ESAI		(NR_IRQS_LEGACY + 81)
+#define MX53_INT_CAN1		(NR_IRQS_LEGACY + 82)
+#define MX53_INT_CAN2		(NR_IRQS_LEGACY + 83)
+#define MX53_INT_GPU2_IRQ	(NR_IRQS_LEGACY + 84)
+#define MX53_INT_GPU2_BUSY	(NR_IRQS_LEGACY + 85)
+#define MX53_INT_UART5		(NR_IRQS_LEGACY + 86)
+#define MX53_INT_FEC		(NR_IRQS_LEGACY + 87)
+#define MX53_INT_OWIRE		(NR_IRQS_LEGACY + 88)
+#define MX53_INT_CTI1_TG2	(NR_IRQS_LEGACY + 89)
+#define MX53_INT_SJC		(NR_IRQS_LEGACY + 90)
+#define MX53_INT_TVE		(NR_IRQS_LEGACY + 92)
+#define MX53_INT_FIRI		(NR_IRQS_LEGACY + 93)
+#define MX53_INT_PWM2		(NR_IRQS_LEGACY + 94)
+#define MX53_INT_SLIM_EXP	(NR_IRQS_LEGACY + 95)
+#define MX53_INT_SSI3		(NR_IRQS_LEGACY + 96)
+#define MX53_INT_EMI_BOOT	(NR_IRQS_LEGACY + 97)
+#define MX53_INT_CTI1_TG3	(NR_IRQS_LEGACY + 98)
+#define MX53_INT_SMC_RX		(NR_IRQS_LEGACY + 99)
+#define MX53_INT_VPU_IDLE	(NR_IRQS_LEGACY + 100)
+#define MX53_INT_EMI_NFC	(NR_IRQS_LEGACY + 101)
+#define MX53_INT_GPU_IDLE	(NR_IRQS_LEGACY + 102)
+#define MX53_INT_GPIO5_LOW	(NR_IRQS_LEGACY + 103)
+#define MX53_INT_GPIO5_HIGH	(NR_IRQS_LEGACY + 104)
+#define MX53_INT_GPIO6_LOW	(NR_IRQS_LEGACY + 105)
+#define MX53_INT_GPIO6_HIGH	(NR_IRQS_LEGACY + 106)
+#define MX53_INT_GPIO7_LOW	(NR_IRQS_LEGACY + 107)
+#define MX53_INT_GPIO7_HIGH	(NR_IRQS_LEGACY + 108)
 
 #endif /* ifndef __MACH_MX53_H__ */
diff --git a/drivers/media/video/mx1_camera.c b/drivers/media/video/mx1_camera.c
index 4296a83..d2e6f82 100644
--- a/drivers/media/video/mx1_camera.c
+++ b/drivers/media/video/mx1_camera.c
@@ -43,6 +43,7 @@
 #include <asm/fiq.h>
 #include <mach/dma-mx1-mx2.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/mx1_camera.h>
 
 /*
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 456b7d7..ee27ba3 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -29,6 +29,7 @@
 
 #include <asm/fiq.h>
 
+#include <mach/irqs.h>
 #include <mach/ssi.h>
 
 #include "imx-ssi.h"
-- 
1.7.5.4
