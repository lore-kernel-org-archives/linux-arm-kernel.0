From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:40 +0900
Subject: [PATCH v2 06/11] ARM: EXYNOS: add support uart for EXYNOS4 and EXYNOS5
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually, the base address of uart is different between EXYNOS4
and EXYNOS5 and this patch enables to support uart for EXYNOS4
and EXYNOS5 SoCs at runtime.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Makefile                   |    1 +
 arch/arm/mach-exynos/common.c                   |    5 +-
 arch/arm/mach-exynos/dev-uart.c                 |   78 +++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/debug-macro.S |    9 ++-
 arch/arm/mach-exynos/include/mach/irqs.h        |   12 ++++
 arch/arm/mach-exynos/include/mach/map.h         |   20 +++---
 arch/arm/mach-exynos/include/mach/uncompress.h  |   17 ++++--
 arch/arm/plat-s5p/Kconfig                       |    4 +
 arch/arm/plat-s5p/Makefile                      |    3 +-
 arch/arm/plat-samsung/include/plat/devs.h       |    2 +
 arch/arm/plat-samsung/include/plat/uncompress.h |    2 +
 11 files changed, 135 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-exynos/dev-uart.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 2117f02..f8a3770 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 
 # device support
 
+obj-y					+= dev-uart.o
 obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 37257b0..8db2627 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -489,7 +489,10 @@ static void __init exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	for (ucnt = 0; ucnt < no; ucnt++, tcfg++)
 		tcfg->has_fracval = 1;
 
-	s3c24xx_init_uartdevs("exynos4210-uart", s5p_uart_resources, cfg, no);
+	if (soc_is_exynos5250())
+		s3c24xx_init_uartdevs("exynos4210-uart", exynos5_uart_resources, cfg, no);
+	else
+		s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
 }
 
 static DEFINE_SPINLOCK(eint_lock);
diff --git a/arch/arm/mach-exynos/dev-uart.c b/arch/arm/mach-exynos/dev-uart.c
new file mode 100644
index 0000000..61ebfd7
--- /dev/null
+++ b/arch/arm/mach-exynos/dev-uart.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Base EXYNOS UART resource and device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/irq.h>
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+
+#define EXYNOS_UART_RESOURCE(_series, _nr)	\
+static struct resource exynos##_series##_uart##_nr##_resource[] = {	\
+	[0] = DEFINE_RES_MEM(EXYNOS##_series##_PA_UART##_nr, EXYNOS##_series##_SZ_UART),	\
+	[1] = DEFINE_RES_IRQ(EXYNOS##_series##_IRQ_UART##_nr),	\
+};
+
+EXYNOS_UART_RESOURCE(4, 0)
+EXYNOS_UART_RESOURCE(4, 1)
+EXYNOS_UART_RESOURCE(4, 2)
+EXYNOS_UART_RESOURCE(4, 3)
+
+struct s3c24xx_uart_resources exynos4_uart_resources[] __initdata = {
+	[0] = {
+		.resources	= exynos4_uart0_resource,
+		.nr_resources	= ARRAY_SIZE(exynos4_uart0_resource),
+	},
+	[1] = {
+		.resources	= exynos4_uart1_resource,
+		.nr_resources	= ARRAY_SIZE(exynos4_uart0_resource),
+	},
+	[2] = {
+		.resources	= exynos4_uart2_resource,
+		.nr_resources	= ARRAY_SIZE(exynos4_uart2_resource),
+	},
+	[3] = {
+		.resources	= exynos4_uart3_resource,
+		.nr_resources	= ARRAY_SIZE(exynos4_uart3_resource),
+	},
+};
+
+EXYNOS_UART_RESOURCE(5, 0)
+EXYNOS_UART_RESOURCE(5, 1)
+EXYNOS_UART_RESOURCE(5, 2)
+EXYNOS_UART_RESOURCE(5, 3)
+
+struct s3c24xx_uart_resources exynos5_uart_resources[] __initdata = {
+	[0] = {
+		.resources	= exynos5_uart0_resource,
+		.nr_resources	= ARRAY_SIZE(exynos5_uart0_resource),
+	},
+	[1] = {
+		.resources	= exynos5_uart1_resource,
+		.nr_resources	= ARRAY_SIZE(exynos5_uart0_resource),
+	},
+	[2] = {
+		.resources	= exynos5_uart2_resource,
+		.nr_resources	= ARRAY_SIZE(exynos5_uart2_resource),
+	},
+	[3] = {
+		.resources	= exynos5_uart3_resource,
+		.nr_resources	= ARRAY_SIZE(exynos5_uart3_resource),
+	},
+};
diff --git a/arch/arm/mach-exynos/include/mach/debug-macro.S b/arch/arm/mach-exynos/include/mach/debug-macro.S
index 6cacf16..6c857ff 100644
--- a/arch/arm/mach-exynos/include/mach/debug-macro.S
+++ b/arch/arm/mach-exynos/include/mach/debug-macro.S
@@ -21,8 +21,13 @@
 	 */
 
 	.macro addruart, rp, rv, tmp
-		ldr	\rp, = S3C_PA_UART
-		ldr	\rv, = S3C_VA_UART
+		mov	\rp, #0x10000000
+		ldr	\rp, [\rp, #0x0]
+		and	\rp, \rp, #0xf00000
+		teq	\rp, #0x500000		@@ EXYNOS5
+		ldreq	\rp, =EXYNOS5_PA_UART
+		movne	\rp, #EXYNOS4_PA_UART	@@ EXYNOS4
+		ldr	\rv, =S3C_VA_UART
 #if CONFIG_DEBUG_S3C_UART != 0
 		add	\rp, \rp, #(0x10000 * CONFIG_DEBUG_S3C_UART)
 		add	\rv, \rv, #(0x10000 * CONFIG_DEBUG_S3C_UART)
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 0dab1b1..76aa0d3 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -399,4 +399,16 @@
 
 #endif
 
+#define EXYNOS4_IRQ_UART0		IRQ_SPI(52)
+#define EXYNOS4_IRQ_UART1		IRQ_SPI(53)
+#define EXYNOS4_IRQ_UART2		IRQ_SPI(54)
+#define EXYNOS4_IRQ_UART3		IRQ_SPI(55)
+#define EXYNOS4_IRQ_UART4		IRQ_SPI(56)
+
+#define EXYNOS5_IRQ_UART0		IRQ_SPI(51)
+#define EXYNOS5_IRQ_UART1		IRQ_SPI(52)
+#define EXYNOS5_IRQ_UART2		IRQ_SPI(53)
+#define EXYNOS5_IRQ_UART3		IRQ_SPI(54)
+#define EXYNOS5_IRQ_UART4		IRQ_SPI(55)
+
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c754a22..e8a7801 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -152,7 +152,6 @@
 #define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
 #define S3C_PA_RTC			EXYNOS4_PA_RTC
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
-#define S3C_PA_UART			EXYNOS4_PA_UART
 #define S3C_PA_SPI0			EXYNOS4_PA_SPI0
 #define S3C_PA_SPI1			EXYNOS4_PA_SPI1
 #define S3C_PA_SPI2			EXYNOS4_PA_SPI2
@@ -181,15 +180,18 @@
 
 /* Compatibility UART */
 
-#define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
+#define EXYNOS4_PA_UART0		0x13800000
+#define EXYNOS4_PA_UART1		0x13810000
+#define EXYNOS4_PA_UART2		0x13820000
+#define EXYNOS4_PA_UART3		0x13830000
+#define EXYNOS4_SZ_UART			SZ_256
 
-#define S5P_PA_UART(x)			(EXYNOS4_PA_UART + ((x) * S3C_UART_OFFSET))
-#define S5P_PA_UART0			S5P_PA_UART(0)
-#define S5P_PA_UART1			S5P_PA_UART(1)
-#define S5P_PA_UART2			S5P_PA_UART(2)
-#define S5P_PA_UART3			S5P_PA_UART(3)
-#define S5P_PA_UART4			S5P_PA_UART(4)
+#define EXYNOS5_PA_UART0		0x12C00000
+#define EXYNOS5_PA_UART1		0x12C10000
+#define EXYNOS5_PA_UART2		0x12C20000
+#define EXYNOS5_PA_UART3		0x12C30000
+#define EXYNOS5_SZ_UART			SZ_256
 
-#define S5P_SZ_UART			SZ_256
+#define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
index 21d97bc..f412e35 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -1,9 +1,8 @@
-/* linux/arch/arm/mach-exynos4/include/mach/uncompress.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS4 - uncompress code
+ * EXYNOS - uncompress code
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,12 +12,20 @@
 #ifndef __ASM_ARCH_UNCOMPRESS_H
 #define __ASM_ARCH_UNCOMPRESS_H __FILE__
 
+#include <asm/mach-types.h>
+
 #include <mach/map.h>
+
+volatile u32 *uart_base;
+
 #include <plat/uncompress.h>
 
 static void arch_detect_cpu(void)
 {
-	/* we do not need to do any cpu detection here at the moment. */
+	if (machine_is_smdk5250())
+		uart_base = (volatile u32 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
+	else
+		uart_base = (volatile u32 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
 
 	/*
 	 * For preventing FIFO overrun or infinite loop of UART console,
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 8167ce6..10e235cc7 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -40,6 +40,10 @@ config S5P_HRT
 	help
 	  Use the High Resolution timer support
 
+config S5P_DEV_UART
+	def_bool y
+	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
+
 config S5P_PM
 	bool
 	help
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 30d8c30..4bd8241 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -12,7 +12,6 @@ obj-				:=
 
 # Core files
 
-obj-y				+= dev-uart.o
 obj-y				+= clock.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
@@ -23,5 +22,7 @@ obj-$(CONFIG_S5P_SLEEP)		+= sleep.o
 obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
 
 # devices
+
+obj-$(CONFIG_S5P_DEV_UART)	+= dev-uart.o
 obj-$(CONFIG_S5P_DEV_MFC)	+= dev-mfc.o
 obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 4214ea0..32cc67e 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -26,6 +26,8 @@ struct s3c24xx_uart_resources {
 extern struct s3c24xx_uart_resources s3c2410_uart_resources[];
 extern struct s3c24xx_uart_resources s3c64xx_uart_resources[];
 extern struct s3c24xx_uart_resources s5p_uart_resources[];
+extern struct s3c24xx_uart_resources exynos4_uart_resources[];
+extern struct s3c24xx_uart_resources exynos5_uart_resources[];
 
 extern struct platform_device *s3c24xx_uart_devs[];
 extern struct platform_device *s3c24xx_uart_src[];
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index ee48e12..7e068d1 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -37,7 +37,9 @@ static void arch_detect_cpu(void);
 /* how many bytes we allow into the FIFO at a time in FIFO mode */
 #define FIFO_MAX	 (14)
 
+#ifdef S3C_PA_UART
 #define uart_base S3C_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT)
+#endif
 
 static __inline__ void
 uart_wr(unsigned int reg, unsigned int val)
-- 
1.7.4.4
