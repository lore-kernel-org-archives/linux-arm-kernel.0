From: vikram.pandita@ti.com (Pandita, Vikram)
Date: Tue, 19 Jan 2010 06:09:09 +0530
Subject: [PATCH 1/4] omap: Clean the serial port defines
In-Reply-To: <20100116013510.10065.59461.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013510.10065.59461.stgit@baageli.muru.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030070F290@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony
>Lindgren
>Sent: Friday, January 15, 2010 7:35 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: linux-omap at vger.kernel.org
>Subject: [PATCH 1/4] omap: Clean the serial port defines
>
>This way we don't have conflicts with the defines
>with compiling in multiple omaps. Set the addresses
>for uarts in struct omap_globals for the early serial
>init code.

Nice and much needed cleanup. 

>
>Signed-off-by: Tony Lindgren <tony@atomide.com>
<snip>
>diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
>index 6e5207c..349de90 100644
>--- a/arch/arm/mach-omap1/serial.c
>+++ b/arch/arm/mach-omap1/serial.c
>@@ -64,7 +64,7 @@ static void __init omap_serial_reset(struct plat_serial8250_port *p)
>
> static struct plat_serial8250_port serial_platform_data[] = {
> 	{
>-		.mapbase	= OMAP_UART1_BASE,
>+		.mapbase	= OMAP1_UART1_BASE,

Is it possible to use the same approach as mach-omap2/ for physical address assignments?
I like that approach.
Refer this part from mach-omap2:
	+	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
	+	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
	+	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;	

> 		.irq		= INT_UART1,
> 		.flags		= UPF_BOOT_AUTOCONF,
> 		.iotype		= UPIO_MEM,
<snip>
>diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-
>macro.S
>index e9f255d..0c96e1c 100644
>--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
>+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
>@@ -11,6 +11,10 @@
>  *
> */
>
>+#include <linux/serial_reg.h>
>+
>+#include <plat/serial.h>
>+
> 		.macro	addruart,rx
> 		mrc	p15, 0, \rx, c1, c0
> 		tst	\rx, #1			@ MMU enabled?
>@@ -44,15 +48,10 @@
> 		.endm
>
> 		.macro	busyuart,rd,rx
>-1001:		ldrb	\rd, [\rx, #(0x5 << 2)]	@ OMAP-1510 and friends
>-		and	\rd, \rd, #0x60
>-		teq	\rd, #0x60
>-		beq	1002f
>-		ldrb	\rd, [\rx, #(0x5 << 0)]	@ OMAP-730 only
>-		and	\rd, \rd, #0x60
>-		teq	\rd, #0x60
>+1001:		ldrb	\rd, [\rx, #(UART_LSR << OMAP_PORT_SHIFT)]

Zoom2/3 kind of boards have external debug Serial port.
For those boards and maybe others, the shift value is 1 and not OMAP_PORT_SHIFT(2).

This solution is not extensible to zoom2/3 boards with external debug board uarts.
How do we address that? 


>+		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
>+		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
> 		bne	1001b
>-1002:
> 		.endm
>
> 		.macro	waituart,rd,rx
<snip>
>diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
<snip>
>@@ -269,11 +278,15 @@ static struct omap_globals omap343x_globals = {
> 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
> 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
> 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
>+	.uart1_phys	= OMAP3_UART1_BASE,
>+	.uart2_phys	= OMAP3_UART2_BASE,
>+	.uart3_phys	= OMAP3_UART3_BASE,

OMAP3630 also has 4 UARTS and this same global is getting used for both 34xx and 36xx.
This is not right.

For 3630 uart4_phys = 0x49042000

> };
>
> void __init omap2_set_globals_343x(void)
> {
> 	__omap2_set_globals(&omap343x_globals);
>+	omap2_set_globals_uart(&omap343x_globals);
> }
> #endif
>
>@@ -285,6 +298,10 @@ static struct omap_globals omap4_globals = {
> 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
> 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
> 	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE),
>+	.uart1_phys	= OMAP4_UART1_BASE,
>+	.uart2_phys	= OMAP4_UART2_BASE,
>+	.uart3_phys	= OMAP4_UART3_BASE,
>+	.uart4_phys	= OMAP4_UART4_BASE,
> };
>
> void __init omap2_set_globals_443x(void)
>@@ -292,6 +309,7 @@ void __init omap2_set_globals_443x(void)
> 	omap2_set_globals_tap(&omap4_globals);
> 	omap2_set_globals_control(&omap4_globals);
> 	omap2_set_globals_prcm(&omap4_globals);
>+	omap2_set_globals_uart(&omap4_globals);
> }
> #endif
>
>diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
>index 32c2227..a8fa0d7 100644
>--- a/arch/arm/plat-omap/include/plat/common.h
>+++ b/arch/arm/plat-omap/include/plat/common.h
>@@ -47,6 +47,10 @@ struct omap_globals {
> 	void __iomem	*prm;		/* Power and Reset Management */
> 	void __iomem	*cm;		/* Clock Management */
> 	void __iomem	*cm2;
>+	unsigned long	uart1_phys;
>+	unsigned long	uart2_phys;
>+	unsigned long	uart3_phys;
>+	unsigned long	uart4_phys;
> };
>
> void omap2_set_globals_242x(void);
>@@ -59,6 +63,7 @@ void omap2_set_globals_tap(struct omap_globals *);
> void omap2_set_globals_sdrc(struct omap_globals *);
> void omap2_set_globals_control(struct omap_globals *);
> void omap2_set_globals_prcm(struct omap_globals *);
>+void omap2_set_globals_uart(struct omap_globals *);
>
> /**
>  * omap_test_timeout - busy-loop, testing a condition
>diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
>index f5a4a92..c7e2b85 100644
>--- a/arch/arm/plat-omap/include/plat/serial.h
>+++ b/arch/arm/plat-omap/include/plat/serial.h
>@@ -15,37 +15,39 @@
>
> #include <linux/init.h>
>
>-#if defined(CONFIG_ARCH_OMAP1)
> /* OMAP1 serial ports */
>-#define OMAP_UART1_BASE		0xfffb0000
>-#define OMAP_UART2_BASE		0xfffb0800
>-#define OMAP_UART3_BASE		0xfffb9800
>-#elif defined(CONFIG_ARCH_OMAP2)
>+#define OMAP1_UART1_BASE	0xfffb0000
>+#define OMAP1_UART2_BASE	0xfffb0800
>+#define OMAP1_UART3_BASE	0xfffb9800
>+
> /* OMAP2 serial ports */
>-#define OMAP_UART1_BASE		0x4806a000
>-#define OMAP_UART2_BASE		0x4806c000
>-#define OMAP_UART3_BASE		0x4806e000
>-#elif defined(CONFIG_ARCH_OMAP3)
>+#define OMAP2_UART1_BASE	0x4806a000
>+#define OMAP2_UART2_BASE	0x4806c000
>+#define OMAP2_UART3_BASE	0x4806e000
>+
> /* OMAP3 serial ports */
>-#define OMAP_UART1_BASE		0x4806a000
>-#define OMAP_UART2_BASE		0x4806c000
>-#define OMAP_UART3_BASE		0x49020000

Need to add 0x4904 2000 for 3630 UART4

>-#elif defined(CONFIG_ARCH_OMAP4)
>+#define OMAP3_UART1_BASE	0x4806a000
>+#define OMAP3_UART2_BASE	0x4806c000
>+#define OMAP3_UART3_BASE	0x49020000
>+
> /* OMAP4 serial ports */
>-#define OMAP_UART1_BASE		0x4806a000
>-#define OMAP_UART2_BASE		0x4806c000
>-#define OMAP_UART3_BASE		0x48020000
>-#define OMAP_UART4_BASE		0x4806e000
>-#endif
>+#define OMAP4_UART1_BASE	0x4806a000
>+#define OMAP4_UART2_BASE	0x4806c000
>+#define OMAP4_UART3_BASE	0x48020000
>+#define OMAP4_UART4_BASE	0x4806e000
>+
>+#define OMAP_PORT_SHIFT		2
>+#define OMAP7XX_PORT_SHIFT	0
>
> #define OMAP1510_BASE_BAUD	(12000000/16)
> #define OMAP16XX_BASE_BAUD	(48000000/16)
> #define OMAP24XX_BASE_BAUD	(48000000/16)
>
>+/* This is only used by 8250.c for omap1510 */
> #define is_omap_port(pt)	({int __ret = 0;			\
>-			if ((pt)->port.mapbase == OMAP_UART1_BASE ||	\
>-			    (pt)->port.mapbase == OMAP_UART2_BASE ||	\
>-			    (pt)->port.mapbase == OMAP_UART3_BASE)	\
>+			if ((pt)->port.mapbase == OMAP1_UART1_BASE ||	\
>+			    (pt)->port.mapbase == OMAP1_UART2_BASE ||	\
>+			    (pt)->port.mapbase == OMAP1_UART3_BASE)	\
> 				__ret = 1;				\
> 			__ret;						\
> 			})
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
