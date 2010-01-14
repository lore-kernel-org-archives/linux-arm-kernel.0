From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:32 +0100
Subject: [PATCH 14/21] ARM: S5PC1XX: add support for s5pc110 irqs
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-15-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds interrupt support on S5PC110 SoCs. Unlike S5PC100,
S5PC110 has 4 VICs, so the S5PC110 specifi virtual memory area is
extended to cover VIC3 register block.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Byungho Min <bhmin@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/cpu.c                   |   10 ++
 arch/arm/mach-s5pc110/include/mach/regs-irq.h |   25 +++
 arch/arm/mach-s5pc110/include/plat/irqs.h     |  216 +++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/include/mach/regs-irq.h
 create mode 100644 arch/arm/mach-s5pc110/include/plat/irqs.h

diff --git a/arch/arm/mach-s5pc110/cpu.c b/arch/arm/mach-s5pc110/cpu.c
index 6c9ebcb..3ea26ff 100644
--- a/arch/arm/mach-s5pc110/cpu.c
+++ b/arch/arm/mach-s5pc110/cpu.c
@@ -43,6 +43,12 @@
 /* Initial IO mappings */
 
 static struct map_desc s5pc110_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5PC1XX_VA_VIC(3),
+		.pfn		= __phys_to_pfn(S5PC1XX_PA_VIC(3)),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
 };
 
 static void s5pc110_idle(void)
@@ -93,6 +99,10 @@ void __init s5pc110_init_clocks(int xtal)
 
 void __init s5pc110_init_irq(void)
 {
+	u32 vic_valid[] = {~0, ~0, ~0, ~0};
+
+	/* VIC0, VIC1, VIC2, and VIC3 are fully populated. */
+	s5pc1xx_init_irq(vic_valid, ARRAY_SIZE(vic_valid));
 }
 
 struct sysdev_class s5pc110_sysclass = {
diff --git a/arch/arm/mach-s5pc110/include/mach/regs-irq.h b/arch/arm/mach-s5pc110/include/mach/regs-irq.h
new file mode 100644
index 0000000..b467e3b
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/regs-irq.h
@@ -0,0 +1,25 @@
+/* linux/arch/arm/mach-s5pc110/include/mach/regs-irq.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC110 - IRQ register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_IRQ_H
+#define __ASM_ARCH_REGS_IRQ_H __FILE__
+
+#include <mach/map.h>
+#include <asm/hardware/vic.h>
+
+/* interrupt controller */
+#define S5PC1XX_VIC0REG(x)          		((x) + S5PC1XX_VA_VIC(0))
+#define S5PC1XX_VIC1REG(x)          		((x) + S5PC1XX_VA_VIC(1))
+#define S5PC1XX_VIC2REG(x)         		((x) + S5PC1XX_VA_VIC(2))
+#define S5PC1XX_VIC3REG(x)         		((x) + S5PC1XX_VA_VIC(3))
+
+#endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5pc110/include/plat/irqs.h b/arch/arm/mach-s5pc110/include/plat/irqs.h
new file mode 100644
index 0000000..3a3d11d
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/plat/irqs.h
@@ -0,0 +1,216 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/irqs.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC110 - Common IRQ support
+ *
+ * Based on plat-s3c64xx/include/plat/irqs.h
+ */
+
+#ifndef __ASM_PLAT_S5PC110_IRQS_H
+#define __ASM_PLAT_S5PC110_IRQS_H __FILE__
+
+/* we keep the first set of CPU IRQs out of the range of
+ * the ISA space, so that the PC104 has them to itself
+ * and we don't end up having to do horrible things to the
+ * standard ISA drivers....
+ *
+ * note, since we're using the VICs, our start must be a
+ * mulitple of 32 to allow the common code to work
+ */
+
+#define S3C_IRQ_OFFSET		(32)
+
+#define S3C_IRQ(x)		((x) + S3C_IRQ_OFFSET)
+
+#define S3C_VIC0_BASE		S3C_IRQ(0)
+#define S3C_VIC1_BASE		S3C_IRQ(32)
+#define S3C_VIC2_BASE		S3C_IRQ(64)
+#define S3C_VIC3_BASE		S3C_IRQ(96)
+
+/* UART interrupts, each UART has 4 interupts per channel so
+ * use the space between the ISA and S3C main interrupts. Note, these
+ * are not in the same order as the S3C24XX series! */
+
+#define IRQ_S3CUART_BASE0	(16)
+#define IRQ_S3CUART_BASE1	(20)
+#define IRQ_S3CUART_BASE2	(24)
+#define IRQ_S3CUART_BASE3	(28)
+
+#define UART_IRQ_RXD		(0)
+#define UART_IRQ_ERR		(1)
+#define UART_IRQ_TXD		(2)
+#define UART_IRQ_MODEM		(3)
+
+#define IRQ_S3CUART_RX0		(IRQ_S3CUART_BASE0 + UART_IRQ_RXD)
+#define IRQ_S3CUART_TX0		(IRQ_S3CUART_BASE0 + UART_IRQ_TXD)
+#define IRQ_S3CUART_ERR0	(IRQ_S3CUART_BASE0 + UART_IRQ_ERR)
+
+#define IRQ_S3CUART_RX1		(IRQ_S3CUART_BASE1 + UART_IRQ_RXD)
+#define IRQ_S3CUART_TX1		(IRQ_S3CUART_BASE1 + UART_IRQ_TXD)
+#define IRQ_S3CUART_ERR1	(IRQ_S3CUART_BASE1 + UART_IRQ_ERR)
+
+#define IRQ_S3CUART_RX2		(IRQ_S3CUART_BASE2 + UART_IRQ_RXD)
+#define IRQ_S3CUART_TX2		(IRQ_S3CUART_BASE2 + UART_IRQ_TXD)
+#define IRQ_S3CUART_ERR2	(IRQ_S3CUART_BASE2 + UART_IRQ_ERR)
+
+#define IRQ_S3CUART_RX3		(IRQ_S3CUART_BASE3 + UART_IRQ_RXD)
+#define IRQ_S3CUART_TX3		(IRQ_S3CUART_BASE3 + UART_IRQ_TXD)
+#define IRQ_S3CUART_ERR3	(IRQ_S3CUART_BASE3 + UART_IRQ_ERR)
+
+/* VIC based IRQs */
+
+#define S5PC1XX_IRQ_VIC0(x)	(S3C_VIC0_BASE + (x))
+#define S5PC1XX_IRQ_VIC1(x)	(S3C_VIC1_BASE + (x))
+#define S5PC1XX_IRQ_VIC2(x)	(S3C_VIC2_BASE + (x))
+#define S5PC110_IRQ_VIC3(x)	(S3C_VIC3_BASE + (x))
+
+/*
+ * VIC0: system, DMA, timer
+ */
+#define IRQ_EINT0		S5PC1XX_IRQ_VIC0(0)
+#define IRQ_EINT1		S5PC1XX_IRQ_VIC0(1)
+#define IRQ_EINT2		S5PC1XX_IRQ_VIC0(2)
+#define IRQ_EINT3		S5PC1XX_IRQ_VIC0(3)
+#define IRQ_EINT4		S5PC1XX_IRQ_VIC0(4)
+#define IRQ_EINT5		S5PC1XX_IRQ_VIC0(5)
+#define IRQ_EINT6		S5PC1XX_IRQ_VIC0(6)
+#define IRQ_EINT7		S5PC1XX_IRQ_VIC0(7)
+#define IRQ_EINT8		S5PC1XX_IRQ_VIC0(8)
+#define IRQ_EINT9		S5PC1XX_IRQ_VIC0(9)
+#define IRQ_EINT10		S5PC1XX_IRQ_VIC0(10)
+#define IRQ_EINT11		S5PC1XX_IRQ_VIC0(11)
+#define IRQ_EINT12		S5PC1XX_IRQ_VIC0(12)
+#define IRQ_EINT13		S5PC1XX_IRQ_VIC0(13)
+#define IRQ_EINT14		S5PC1XX_IRQ_VIC0(14)
+#define IRQ_EINT15		S5PC1XX_IRQ_VIC0(15)
+#define IRQ_EINT16_31		S5PC1XX_IRQ_VIC0(16)
+#define IRQ_BATF		S5PC1XX_IRQ_VIC0(17)
+#define IRQ_MDMA		S5PC1XX_IRQ_VIC0(18)
+#define IRQ_PDMA0		S5PC1XX_IRQ_VIC0(19)
+#define IRQ_PDMA1		S5PC1XX_IRQ_VIC0(20)
+#define IRQ_TIMER0_VIC		S5PC1XX_IRQ_VIC0(21)
+#define IRQ_TIMER1_VIC		S5PC1XX_IRQ_VIC0(22)
+#define IRQ_TIMER2_VIC		S5PC1XX_IRQ_VIC0(23)
+#define IRQ_TIMER3_VIC		S5PC1XX_IRQ_VIC0(24)
+#define IRQ_TIMER4_VIC		S5PC1XX_IRQ_VIC0(25)
+#define IRQ_SYSTIMER		S5PC1XX_IRQ_VIC0(26)
+#define IRQ_WDT			S5PC1XX_IRQ_VIC0(27)
+#define IRQ_RTC_ALARM		S5PC1XX_IRQ_VIC0(28)
+#define IRQ_RTC			IRQ_RTC_ALARM
+#define IRQ_RTC_TIC		S5PC1XX_IRQ_VIC0(29)
+#define IRQ_TICK		IRQ_RTC_TIC
+#define IRQ_GPIOINT		S5PC1XX_IRQ_VIC0(30)
+#define IRQ_FIMC3		S5PC1XX_IRQ_VIC0(31)
+
+/*
+ * VIC1: ARM, power, memory, connectivity
+ */
+#define IRQ_CORTEX0		S5PC1XX_IRQ_VIC1(0)
+#define IRQ_CORTEX1		S5PC1XX_IRQ_VIC1(1)
+#define IRQ_CORTEX2		S5PC1XX_IRQ_VIC1(2)
+#define IRQ_CORTEX3		S5PC1XX_IRQ_VIC1(3)
+#define IRQ_CORTEX4		S5PC1XX_IRQ_VIC1(4)
+#define IRQ_IEMAPC		S5PC1XX_IRQ_VIC1(5)
+#define IRQ_IEMIEC		S5PC1XX_IRQ_VIC1(6)
+#define IRQ_NFC			S5PC1XX_IRQ_VIC1(8)
+#define IRQ_CFC			S5PC1XX_IRQ_VIC1(9)
+#define IRQ_UART0		S5PC1XX_IRQ_VIC1(10)
+#define IRQ_UART1		S5PC1XX_IRQ_VIC1(11)
+#define IRQ_UART2		S5PC1XX_IRQ_VIC1(12)
+#define IRQ_UART3		S5PC1XX_IRQ_VIC1(13)
+#define IRQ_IIC			S5PC1XX_IRQ_VIC1(14)
+#define IRQ_SPI0		S5PC1XX_IRQ_VIC1(15)
+#define IRQ_SPI1		S5PC1XX_IRQ_VIC1(16)
+#define IRQ_SPI2		S5PC1XX_IRQ_VIC1(17)
+#define IRQ_IRDA		S5PC1XX_IRQ_VIC1(18)
+#define IRQ_I2C_PMIC_LINK	S5PC1XX_IRQ_VIC1(19)
+#define IRQ_I2C_HDMI_PHY	S5PC1XX_IRQ_VIC1(20)
+#define IRQ_HSIRX		S5PC1XX_IRQ_VIC1(21)
+#define IRQ_HSITX		S5PC1XX_IRQ_VIC1(22)
+#define IRQ_UHOST		S5PC1XX_IRQ_VIC1(23)
+#define IRQ_OTG			S5PC1XX_IRQ_VIC1(24)
+#define IRQ_MSM			S5PC1XX_IRQ_VIC1(25)
+#define IRQ_HSMMC0		S5PC1XX_IRQ_VIC1(26)
+#define IRQ_HSMMC1		S5PC1XX_IRQ_VIC1(27)
+#define IRQ_HSMMC2		S5PC1XX_IRQ_VIC1(28)
+#define IRQ_MIPICSI		S5PC1XX_IRQ_VIC1(29)
+#define IRQ_MIPIDSI		S5PC1XX_IRQ_VIC1(30)
+#define IRQ_ONENAND_AUDI	S5PC1XX_IRQ_VIC1(31)
+
+/*
+ * VIC2: multimedia, audio, security
+ */
+#define IRQ_LCD0		S5PC1XX_IRQ_VIC2(0)
+#define IRQ_LCD1		S5PC1XX_IRQ_VIC2(1)
+#define IRQ_LCD2		S5PC1XX_IRQ_VIC2(2)
+#define IRQ_LCD3		S5PC1XX_IRQ_VIC2(3)
+#define IRQ_ROTATOR		S5PC1XX_IRQ_VIC2(4)
+#define IRQ_FIMC0		S5PC1XX_IRQ_VIC2(5)
+#define IRQ_FIMC1		S5PC1XX_IRQ_VIC2(6)
+#define IRQ_FIMC2		S5PC1XX_IRQ_VIC2(7)
+#define IRQ_JPEG		S5PC1XX_IRQ_VIC2(8)
+#define IRQ_2D			S5PC1XX_IRQ_VIC2(9)
+#define IRQ_3D			S5PC1XX_IRQ_VIC2(10)
+#define IRQ_MIXER		S5PC1XX_IRQ_VIC2(11)
+#define IRQ_HDMI		S5PC1XX_IRQ_VIC2(12)
+#define IRQ_IIC1		S5PC1XX_IRQ_VIC2(13)
+#define IRQ_HDMI_I2C		S5PC1XX_IRQ_VIC2(13)
+#define IRQ_MFC			S5PC1XX_IRQ_VIC2(14)
+#define IRQ_TVENC		S5PC1XX_IRQ_VIC2(15)
+#define IRQ_I2S0		S5PC1XX_IRQ_VIC2(16)
+#define IRQ_I2S1		S5PC1XX_IRQ_VIC2(17)
+#define IRQ_AC97		S5PC1XX_IRQ_VIC2(19)
+#define IRQ_PCM0		S5PC1XX_IRQ_VIC2(20)
+#define IRQ_PCM1		S5PC1XX_IRQ_VIC2(21)
+#define IRQ_SPDIF		S5PC1XX_IRQ_VIC2(22)
+#define IRQ_ADC			S5PC1XX_IRQ_VIC2(23)
+#define IRQ_PENDN		S5PC1XX_IRQ_VIC2(24)
+#define IRQ_TC			IRQ_PENDN
+#define IRQ_KEYPAD		S5PC1XX_IRQ_VIC2(25)
+#define IRQ_CG			S5PC1XX_IRQ_VIC2(26)
+#define IRQ_SEC			S5PC1XX_IRQ_VIC2(27)
+#define IRQ_SECRX		S5PC1XX_IRQ_VIC2(28)
+#define IRQ_SECTX		S5PC1XX_IRQ_VIC2(29)
+#define IRQ_SDMIRQ		S5PC1XX_IRQ_VIC2(30)
+#define IRQ_SDMFIQ		S5PC1XX_IRQ_VIC2(31)
+
+/* VIC3 used at S5PC110 */
+#define IRQ_IPC			S5PC110_IRQ_VIC3(0)
+#define IRQ_HOSTIF		S5PC110_IRQ_VIC3(1)
+#define IRQ_MMC3		S5PC110_IRQ_VIC3(2)
+#define IRQ_CEC			S5PC110_IRQ_VIC3(3)
+#define IRQ_TSI			S5PC110_IRQ_VIC3(4)
+#define IRQ_MDNIE0		S5PC110_IRQ_VIC3(5)
+#define IRQ_MDNIE1		S5PC110_IRQ_VIC3(6)
+#define IRQ_MDNIE2		S5PC110_IRQ_VIC3(7)
+#define IRQ_MDNIE3		S5PC110_IRQ_VIC3(8)
+#define IRQ_ADC1		S5PC110_IRQ_VIC3(9)
+#define IRQ_PENDN1		S5PC110_IRQ_VIC3(10)
+
+#define IRQ_TIMER(x)		(S5PC110_IRQ_VIC3(31) + 1 + (x))
+#define IRQ_TIMER0		IRQ_TIMER(0)
+#define IRQ_TIMER1		IRQ_TIMER(1)
+#define IRQ_TIMER2		IRQ_TIMER(2)
+#define IRQ_TIMER3		IRQ_TIMER(3)
+#define IRQ_TIMER4		IRQ_TIMER(4)
+
+/* External interrupt */
+#define S3C_IRQ_EINT_BASE	(IRQ_TIMER(4) + 1)
+
+#define S3C_EINT(x)		(S3C_IRQ_EINT_BASE + ((x) - 16))
+#define IRQ_EINT(x)		((x) < 16 ? IRQ_EINT0 + (x) : S3C_EINT(x))
+#define IRQ_EINT_BIT(x)	((x) < IRQ_EINT16_31 ? (x) - IRQ_EINT0 : (x) - S3C_EINT(0))
+
+/* GPIO interrupt */
+#define S3C_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
+#define S3C_IRQ_GPIO(x)		(S3C_IRQ_GPIO_BASE + (x))
+
+/*
+ * Until MP04 Groups -> 40 (exactly 39) Groups * 8 ~= 320 GPIOs
+ */
+#define NR_IRQS			(S3C_IRQ_GPIO(320) + 1)
+
+#endif /* __ASM_PLAT_S5PC1XX_IRQS_H */
+
-- 
1.6.4
