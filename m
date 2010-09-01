From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Sep 2010 16:09:12 +0900
Subject: [PATCH 05/13] ARM: S5P64X0: Update IRQ support
In-Reply-To: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283324960-21629-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates IRQ support for S5P6440 and S5P6450 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../include/mach/irqs.h                            |   48 +++++++++++++++-----
 .../include/mach/regs-irq.h                        |    8 ++--
 2 files changed, 40 insertions(+), 16 deletions(-)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/irqs.h (71%)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/regs-irq.h (66%)

diff --git a/arch/arm/mach-s5p6440/include/mach/irqs.h b/arch/arm/mach-s5p64x0/include/mach/irqs.h
similarity index 71%
rename from arch/arm/mach-s5p6440/include/mach/irqs.h
rename to arch/arm/mach-s5p64x0/include/mach/irqs.h
index 16a7612..513abff 100644
--- a/arch/arm/mach-s5p6440/include/mach/irqs.h
+++ b/arch/arm/mach-s5p64x0/include/mach/irqs.h
@@ -1,17 +1,17 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/irqs.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/irqs.h
  *
- * Copyright 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - IRQ definitions
+ * S5P64X0 - IRQ definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_S5P_IRQS_H
-#define __ASM_ARCH_S5P_IRQS_H __FILE__
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H __FILE__
 
 #include <plat/irqs.h>
 
@@ -20,10 +20,12 @@
 #define IRQ_EINT0_3		S5P_IRQ_VIC0(0)
 #define IRQ_EINT4_11		S5P_IRQ_VIC0(1)
 #define IRQ_RTC_TIC		S5P_IRQ_VIC0(2)
+#define IRQ_IIS1		S5P_IRQ_VIC0(3)	/* for only S5P6450 */
+#define IRQ_IIS2		S5P_IRQ_VIC0(4)	/* for only S5P6450 */
 #define IRQ_IIC1		S5P_IRQ_VIC0(5)
 #define IRQ_I2SV40		S5P_IRQ_VIC0(6)
-#define IRQ_GPS			S5P_IRQ_VIC0(7)
-#define IRQ_POST0		S5P_IRQ_VIC0(9)
+#define IRQ_GPS			S5P_IRQ_VIC0(7)	/* for only S5P6450 */
+
 #define IRQ_2D			S5P_IRQ_VIC0(11)
 #define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(23)
 #define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(24)
@@ -39,22 +41,26 @@
 
 #define IRQ_EINT12_15		S5P_IRQ_VIC1(0)
 #define IRQ_PCM0		S5P_IRQ_VIC1(2)
+#define IRQ_PCM1		S5P_IRQ_VIC1(3)	/* for only S5P6450 */
+#define IRQ_PCM2		S5P_IRQ_VIC1(4)	/* for only S5P6450 */
 #define IRQ_UART0		S5P_IRQ_VIC1(5)
 #define IRQ_UART1		S5P_IRQ_VIC1(6)
 #define IRQ_UART2		S5P_IRQ_VIC1(7)
 #define IRQ_UART3		S5P_IRQ_VIC1(8)
 #define IRQ_DMA0		S5P_IRQ_VIC1(9)
+#define IRQ_UART4		S5P_IRQ_VIC1(10)	/* S5P6450 */
+#define IRQ_UART5		S5P_IRQ_VIC1(11)	/* S5P6450 */
 #define IRQ_NFC			S5P_IRQ_VIC1(13)
+#define IRQ_USI			S5P_IRQ_VIC1(15)	/* S5P6450 */
 #define IRQ_SPI0		S5P_IRQ_VIC1(16)
 #define IRQ_SPI1		S5P_IRQ_VIC1(17)
+#define IRQ_HSMMC2		S5P_IRQ_VIC1(17)	/* Shared */
 #define IRQ_IIC			S5P_IRQ_VIC1(18)
 #define IRQ_DISPCON3		S5P_IRQ_VIC1(19)
-#define IRQ_FIMGVG		S5P_IRQ_VIC1(20)
 #define IRQ_EINT_GROUPS		S5P_IRQ_VIC1(21)
-#define IRQ_PMU			S5P_IRQ_VIC1(23)
+#define IRQ_PMU			S5P_IRQ_VIC1(23)	/* S5P6440 */
 #define IRQ_HSMMC0		S5P_IRQ_VIC1(24)
 #define IRQ_HSMMC1		S5P_IRQ_VIC1(25)
-#define IRQ_HSMMC2		IRQ_SPI1	/* shared with SPI1 */
 #define IRQ_OTG			S5P_IRQ_VIC1(26)
 #define IRQ_DSI			S5P_IRQ_VIC1(27)
 #define IRQ_RTC_ALARM		S5P_IRQ_VIC1(28)
@@ -63,6 +69,24 @@
 #define IRQ_TC			IRQ_PENDN
 #define IRQ_ADC			S5P_IRQ_VIC1(31)
 
+/* UART interrupts, S5P6450 has 5 UARTs */
+#define IRQ_S5P_UART_BASE4	(96)
+#define IRQ_S5P_UART_BASE5	(100)
+
+#define IRQ_S5P_UART_RX4	(IRQ_S5P_UART_BASE4 + UART_IRQ_RXD)
+#define IRQ_S5P_UART_TX4	(IRQ_S5P_UART_BASE4 + UART_IRQ_TXD)
+#define IRQ_S5P_UART_ERR4	(IRQ_S5P_UART_BASE4 + UART_IRQ_ERR)
+
+#define IRQ_S5P_UART_RX5	(IRQ_S5P_UART_BASE5 + UART_IRQ_RXD)
+#define IRQ_S5P_UART_TX5	(IRQ_S5P_UART_BASE5 + UART_IRQ_TXD)
+#define IRQ_S5P_UART_ERR5	(IRQ_S5P_UART_BASE5 + UART_IRQ_ERR)
+
+/* S3C compatibilty defines */
+#define IRQ_S3CUART_RX4		IRQ_S5P_UART_RX4
+#define IRQ_S3CUART_RX5		IRQ_S5P_UART_RX5
+
+/* S5P6450 EINT feature will be added */
+
 /*
  * Since the IRQ_EINT(x) are a linear mapping on s5p6440 we just defined
  * them as an IRQ_EINT(x) macro from S5P_IRQ_EINT_BASE which we place
@@ -115,4 +139,4 @@
 
 #define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
 
-#endif /* __ASM_ARCH_S5P_IRQS_H */
+#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/regs-irq.h b/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
similarity index 66%
rename from arch/arm/mach-s5p6440/include/mach/regs-irq.h
rename to arch/arm/mach-s5p64x0/include/mach/regs-irq.h
index a961f4b..4aaebda 100644
--- a/arch/arm/mach-s5p6440/include/mach/regs-irq.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/regs-irq.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/regs-irq.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - IRQ register definitions
+ * S5P64X0 - IRQ register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.6.2.5
