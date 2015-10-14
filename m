From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 15:52:01 +0200
Subject: [PATCH 2/5] arm: dts: lpc32xx: fix improper usage of ranges
 property
In-Reply-To: <561D902D.7020503@mleia.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <5493797.P10V9v7QAu@wuerfel> <561D902D.7020503@mleia.com>
Message-ID: <7163229.YtgKU9kxxJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 02:13:49 Vladimir Zapolskiy wrote:
> Ok, practically it should work for my purposes, but the change must be
> done along with added EMC device node description.
> 
> I'm not so confident that it is correct to add description of static
> memory banks to ahb node though, please give me a short confirmation,

The DT should reflect whichever memory ranges are accessible
on the bus. I've looked up the memory map in the data sheet, and
I think a reasonable representation would be

/ahb {
	ranges = <0x20000000 0x20000000 0x10000000>, /* AHB port 5 */
		 <0x30000000 0x30000000 0x10000000>, /* AHB port 6 */
		 <0x40000000 0x40000000 0x10000000>, /* AHB port 7 */
		 <0x80000000 0x80000000 0x40000000>, /* EMC DYCS0/1 */
		 <0xE0000000 0xE0000000 0x04000000>; /* EMC CS0-3 */

	apb {
		ranges = <0x20080000 0x20080000 0x00020000>;
	};

};

alternatively, each AHB port could be a separate node, with a
more direct translation like

/ahb5 {
	ranges = <0 0x20000000 0x10000000>;

	apb {
		ranges = <0 0x80000 0x20000>;
	};
};
/ahb6 {
	ranges = <0 0x30000000 0x10000000>,	      /* AHB registers */
		 <0x80000000 0x80000000 0x40000000>, /* EMC DYCS0/1 */
		 <0xE0000000 0xE0000000 0x04000000>; /* EMC CS0-3 */

	memory-controller at 1080000 {
		reg = <0x1080000 0x10000>;
	};
};
...

Does this make sense?

> then I'll send a change for inclusion of EMC description -- the one
> above excluding clocks and clock-names properties, work on CCF is in
> progress.

Ah, very nice! That should get us very close to multiplatform support!
I've just tried building lpc32xx without the headers to check for
other issues, and ended up with the patch below to get it building.
It's clearly wrong, but it highlights a number of issues.

	Arnd


 arch/arm/Kconfig                                   |  2 ++
 arch/arm/mach-lpc32xx/Makefile                     |  2 +-
 arch/arm/mach-lpc32xx/{include/mach => }/board.h   |  0
 arch/arm/mach-lpc32xx/clock.c                      |  4 +--
 arch/arm/mach-lpc32xx/common.c                     |  4 +--
 arch/arm/mach-lpc32xx/common.h                     |  2 +-
 .../gpio-lpc32xx.c => arch/arm/mach-lpc32xx/gpio.c |  6 ++--
 .../arm/mach-lpc32xx/{include/mach => }/hardware.h |  0
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S   | 37 ----------------------
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |  4 +--
 arch/arm/mach-lpc32xx/irq.c                        | 24 +++++++++++---
 arch/arm/mach-lpc32xx/{include/mach => }/irqs.h    |  2 +-
 arch/arm/mach-lpc32xx/phy3250.c                    |  8 +++--
 .../arm/mach-lpc32xx/{include/mach => }/platform.h |  0
 arch/arm/mach-lpc32xx/pm.c                         |  4 +--
 arch/arm/mach-lpc32xx/serial.c                     |  4 +--
 arch/arm/mach-lpc32xx/suspend.S                    |  4 +--
 arch/arm/mach-lpc32xx/timer.c                      |  5 +--
 drivers/gpio/Makefile                              |  1 -
 drivers/net/ethernet/nxp/lpc_eth.c                 | 14 ++++++--
 drivers/tty/serial/lpc32xx_hs.c                    |  8 +++--
 drivers/usb/gadget/udc/lpc32xx_udc.c               | 16 +++++++---
 drivers/usb/host/ohci-nxp.c                        | 18 ++++++++---
 drivers/watchdog/pnx4008_wdt.c                     |  1 -
 24 files changed, 88 insertions(+), 82 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fedbe63e4380..e5fa01ae2bf6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -499,6 +499,8 @@ config ARCH_LPC32XX
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	select USE_OF
 	help
 	  Support for the NXP LPC32XX family of processors
diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
index f5db805ab958..bd86fd4c3e5b 100644
--- a/arch/arm/mach-lpc32xx/Makefile
+++ b/arch/arm/mach-lpc32xx/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y	:= timer.o irq.o common.o serial.o clock.o
+obj-y	:= timer.o irq.o common.o serial.o clock.o gpio.o
 obj-y	+= pm.o suspend.o
 obj-y	+= phy3250.o
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/board.h b/arch/arm/mach-lpc32xx/board.h
similarity index 100%
rename from arch/arm/mach-lpc32xx/include/mach/board.h
rename to arch/arm/mach-lpc32xx/board.h
diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 661c8f4b2310..595980cafdce 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -94,8 +94,8 @@
 #include <linux/amba/clcd.h>
 #include <linux/clkdev.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "hardware.h"
+#include "platform.h"
 #include "clock.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 716e83eb1db8..e75cfed33d5e 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -28,8 +28,8 @@
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "hardware.h"
+#include "platform.h"
 #include "common.h"
 
 /*
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 1cd8853b2f9b..21a56653c5f6 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -19,7 +19,7 @@
 #ifndef __LPC32XX_COMMON_H
 #define __LPC32XX_COMMON_H
 
-#include <mach/board.h>
+#include "board.h"
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 
diff --git a/drivers/gpio/gpio-lpc32xx.c b/arch/arm/mach-lpc32xx/gpio.c
similarity index 99%
rename from drivers/gpio/gpio-lpc32xx.c
rename to arch/arm/mach-lpc32xx/gpio.c
index 47e2dde63734..8987b1af0044 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/arch/arm/mach-lpc32xx/gpio.c
@@ -27,9 +27,9 @@
 #include <linux/module.h>
 #include <linux/platform_data/gpio-lpc32xx.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
-#include <mach/irqs.h>
+#include "hardware.h"
+#include "platform.h"
+#include "irqs.h"
 
 #define LPC32XX_GPIO_P3_INP_STATE		_GPREG(0x000)
 #define LPC32XX_GPIO_P3_OUTP_SET		_GPREG(0x004)
diff --git a/arch/arm/mach-lpc32xx/include/mach/hardware.h b/arch/arm/mach-lpc32xx/hardware.h
similarity index 100%
rename from arch/arm/mach-lpc32xx/include/mach/hardware.h
rename to arch/arm/mach-lpc32xx/hardware.h
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
deleted file mode 100644
index 24ca11b377c8..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/entry-macro.S
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
-#define LPC32XX_INTC_MASKED_STATUS_OFS	0x8
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
-	.endm
-
-/*
- * Return IRQ number in irqnr. Also return processor Z flag status in CPSR
- * as set if an interrupt is pending.
- */
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\irqstat, [\base, #LPC32XX_INTC_MASKED_STATUS_OFS]
-	clz	\irqnr, \irqstat
-	rsb	\irqnr, \irqnr, #31
-	teq	\irqstat, #0
-	.endm
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index 1198a89183cd..6e4d072c6f66 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -21,8 +21,8 @@
 
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#define LPC32XX_UART5_BASE                     0x40090000
+
 
 /*
  * Uncompress output is hardcoded to standard UART 5
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index 2ae431e8bc1b..4c35196c7784 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -28,9 +28,11 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include <asm/exception.h>
+
+#include "irqs.h"
+#include "hardware.h"
+#include "platform.h"
 #include "common.h"
 
 /*
@@ -81,7 +83,7 @@ struct lpc32xx_event_info {
 /*
  * Maps an IRQ number to and event mask and register
  */
-static const struct lpc32xx_event_info lpc32xx_events[NR_IRQS] = {
+static const struct lpc32xx_event_info lpc32xx_events[LPC32XX_LEGACY_IRQS] = {
 	[IRQ_LPC32XX_GPI_08] = {
 		.event_group = &lpc32xx_event_pin_regs,
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_08_BIT,
@@ -370,6 +372,19 @@ static struct irq_chip lpc32xx_irq_chip = {
 	.irq_set_wake = lpc32xx_irq_wake
 };
 
+static void __exception_irq_entry lpc32xx_mic_handler(struct pt_regs *regs)
+{
+	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_MIC_BASE));
+
+	while (ints) {
+		int irqno = fls(ints) - 1;
+
+		ints &= ~(1 << irqno);
+
+		handle_IRQ(irqno, regs);
+	}
+}
+
 static void lpc32xx_sic1_handler(struct irq_desc *desc)
 {
 	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC1_BASE));
@@ -400,6 +415,7 @@ static int __init __lpc32xx_mic_of_init(struct device_node *node,
 					struct device_node *parent)
 {
 	lpc32xx_mic_np = node;
+	set_handle_irq(lpc32xx_mic_handler);
 
 	return 0;
 }
diff --git a/arch/arm/mach-lpc32xx/include/mach/irqs.h b/arch/arm/mach-lpc32xx/irqs.h
similarity index 99%
rename from arch/arm/mach-lpc32xx/include/mach/irqs.h
rename to arch/arm/mach-lpc32xx/irqs.h
index 9e3b90df32e1..006bd71dcbb3 100644
--- a/arch/arm/mach-lpc32xx/include/mach/irqs.h
+++ b/arch/arm/mach-lpc32xx/irqs.h
@@ -112,6 +112,6 @@
 #define IRQ_LPC32XX_GPI_06		LPC32XX_SIC2_IRQ(28)
 #define IRQ_LPC32XX_SYSCLK		LPC32XX_SIC2_IRQ(31)
 
-#define NR_IRQS				96
+#define LPC32XX_LEGACY_IRQS	96
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 77d6b1bab278..25b5548a6136 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -42,10 +42,11 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
-#include <mach/board.h>
+#include "hardware.h"
+#include "platform.h"
+#include "board.h"
 #include "common.h"
+#include "irqs.h"
 
 /*
  * Mapped GPIOLIB GPIOs
@@ -258,6 +259,7 @@ static const char *const lpc32xx_dt_compat[] __initconst = {
 
 DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
 	.atag_offset	= 0x100,
+	.nr_irqs	= LPC32XX_LEGACY_IRQS,
 	.map_io		= lpc32xx_map_io,
 	.init_irq	= lpc32xx_init_irq,
 	.init_time	= lpc32xx_timer_init,
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/platform.h
similarity index 100%
rename from arch/arm/mach-lpc32xx/include/mach/platform.h
rename to arch/arm/mach-lpc32xx/platform.h
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 207e81275ff0..b50faab808bc 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -70,8 +70,8 @@
 
 #include <asm/cacheflush.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "hardware.h"
+#include "platform.h"
 #include "common.h"
 #include "clock.h"
 
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index 05621a29fba2..065d6a82b5a2 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -25,8 +25,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "hardware.h"
+#include "platform.h"
 #include "common.h"
 
 #define LPC32XX_SUART_FIFO_SIZE	64
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index 374f9f07fe48..d7f8800d0087 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -11,8 +11,8 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/platform.h>
-#include <mach/hardware.h>
+#include "platform.h"
+#include "hardware.h"
 
 /* Using named register defines makes the code easier to follow */
 #define WORK1_REG			r0
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index ff3499d1fb1a..e6a27af37122 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -27,9 +27,10 @@
 
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-#include <mach/platform.h>
+#include "hardware.h"
+#include "platform.h"
 #include "common.h"
+#include "irqs.h"
 
 static int lpc32xx_clkevt_next_event(unsigned long delta,
     struct clock_event_device *dev)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 11fcf2cc4e92..f31e982a578f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -48,7 +48,6 @@ obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
 obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
-obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index b159ef8303cc..a157826600d3 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -44,9 +44,6 @@
 #include <linux/types.h>
 
 #include <linux/io.h>
-#include <mach/board.h>
-#include <mach/platform.h>
-#include <mach/hardware.h>
 
 #define MODNAME "lpc-eth"
 #define DRV_VERSION "1.00"
@@ -1312,9 +1309,12 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	struct phy_device *phydev;
 	dma_addr_t dma_handle;
 	int irq, ret;
+#if 0
 	u32 tmp;
 
 	/* Setup network interface for RMII or MII mode */
+	FIXME: use pinctrl
+
 	tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
 	tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
 	if (lpc_phy_interface_mode(&pdev->dev) == PHY_INTERFACE_MODE_MII)
@@ -1322,6 +1322,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	else
 		tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
 	__raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
+#endif
 
 	/* Get platform resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1387,6 +1388,8 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	pldat->dma_buff_base_v = 0;
 
 	if (use_iram_for_net(&pldat->pdev->dev)) {
+#if 0
+	/* FIXME: get iram from DT */
 		dma_handle = LPC32XX_IRAM_BASE;
 		if (pldat->dma_buff_size <= lpc32xx_return_iram_size())
 			pldat->dma_buff_base_v =
@@ -1394,6 +1397,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 		else
 			netdev_err(ndev,
 				"IRAM not big enough for net buffers, using SDRAM instead.\n");
+#endif
 	}
 
 	if (pldat->dma_buff_base_v == 0) {
@@ -1483,11 +1487,13 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 err_out_unregister_netdev:
 	unregister_netdev(ndev);
 err_out_dma_unmap:
+#if 0
 	if (!use_iram_for_net(&pldat->pdev->dev) ||
 	    pldat->dma_buff_size > lpc32xx_return_iram_size())
 		dma_free_coherent(&pldat->pdev->dev, pldat->dma_buff_size,
 				  pldat->dma_buff_base_v,
 				  pldat->dma_buff_base_p);
+#endif
 err_out_free_irq:
 	free_irq(ndev->irq, ndev);
 err_out_iounmap:
@@ -1509,11 +1515,13 @@ static int lpc_eth_drv_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 
+#if 0
 	if (!use_iram_for_net(&pldat->pdev->dev) ||
 	    pldat->dma_buff_size > lpc32xx_return_iram_size())
 		dma_free_coherent(&pldat->pdev->dev, pldat->dma_buff_size,
 				  pldat->dma_buff_base_v,
 				  pldat->dma_buff_base_p);
+#endif
 	free_irq(ndev->irq, ndev);
 	iounmap(pldat->net_base);
 	mdiobus_unregister(pldat->mii_bus);
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 7eb04ae71cc8..c0b609a5c78d 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -34,8 +34,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
-#include <mach/platform.h>
-#include <mach/hardware.h>
 
 /*
  * High Speed UART register offsets
@@ -447,9 +445,9 @@ static void serial_lpc32xx_break_ctl(struct uart_port *port,
 /* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
 static void lpc32xx_loopback_set(resource_size_t mapbase, int state)
 {
+#if 0
 	int bit;
 	u32 tmp;
-
 	switch (mapbase) {
 	case LPC32XX_HS_UART1_BASE:
 		bit = 0;
@@ -471,6 +469,7 @@ static void lpc32xx_loopback_set(resource_size_t mapbase, int state)
 	else
 		tmp &= ~(1 << bit);
 	writel(tmp, LPC32XX_UARTCTL_CLOOP);
+#endif
 }
 
 /* port->lock is not held.  */
@@ -700,7 +699,10 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 	p->port.irq = ret;
 
 	p->port.iotype = UPIO_MEM32;
+#if 0
+	/* FIXME: use clk_get_rate() */
 	p->port.uartclk = LPC32XX_MAIN_OSC_FREQ;
+#endif
 	p->port.regshift = 2;
 	p->port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_IOREMAP;
 	p->port.dev = &pdev->dev;
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 00b5006baf15..e3686bf02f5a 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -52,13 +52,9 @@
 #include <linux/usb/isp1301.h>
 
 #include <asm/byteorder.h>
-#include <mach/hardware.h>
 #include <linux/io.h>
 #include <asm/irq.h>
 
-#include <mach/platform.h>
-#include <mach/irqs.h>
-#include <mach/board.h>
 #ifdef CONFIG_USB_GADGET_DEBUG_FILES
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -652,8 +648,11 @@ static void isp1301_udc_configure(struct lpc32xx_udc *udc)
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_RISING, INT_VBUS_VLD);
 
+#if 0
+	/* FIXME: use clock interface */
 	/* Enable usb_need_clk clock after transceiver is initialized */
 	writel((readl(USB_CTRL) | USB_DEV_NEED_CLK_EN), USB_CTRL);
+#endif
 
 	dev_info(udc->dev, "ISP1301 Vendor ID  : 0x%04x\n",
 		 i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x00));
@@ -997,9 +996,11 @@ static void udc_clk_set(struct lpc32xx_udc *udc, int enable)
 		/* 48MHz PLL up */
 		clk_enable(udc->usb_pll_clk);
 
+#if 0
 		/* Enable the USB device clock */
 		writel(readl(USB_CTRL) | USB_DEV_NEED_CLK_EN,
 			     USB_CTRL);
+#endif
 
 		clk_enable(udc->usb_otg_clk);
 	} else {
@@ -1013,10 +1014,11 @@ static void udc_clk_set(struct lpc32xx_udc *udc, int enable)
 		/* 48MHz PLL dpwn */
 		clk_disable(udc->usb_pll_clk);
 
+#if 0
 		/* Disable the USB device clock */
 		writel(readl(USB_CTRL) & ~USB_DEV_NEED_CLK_EN,
 			     USB_CTRL);
-
+#endif
 		clk_disable(udc->usb_otg_clk);
 	}
 }
@@ -3138,8 +3140,10 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		goto io_map_fail;
 	}
 
+#if 0
 	/* Enable AHB slave USB clock, needed for further USB clock control */
 	writel(USB_SLAVE_HCLK_EN | (1 << 19), USB_CTRL);
+#endif
 
 	/* Get required clocks */
 	udc->usb_pll_clk = clk_get(&pdev->dev, "ck_pll5");
@@ -3174,7 +3178,9 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		goto pll_set_fail;
 	}
 
+#if 0
 	writel(readl(USB_CTRL) | USB_DEV_NEED_CLK_EN, USB_CTRL);
+#endif
 
 	/* Enable USB device clock */
 	retval = clk_enable(udc->usb_slv_clk);
diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index d9f0481d7258..8f01d04b8687 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -33,13 +33,10 @@
 #include "ohci.h"
 
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
 
-#include <mach/platform.h>
-#include <mach/irqs.h>
-
+#if 0
 #define USB_CONFIG_BASE		0x31020000
 #define PWRMAN_BASE		0x40004000
 
@@ -52,6 +49,7 @@
 #define PAD_CONTROL_LAST_DRIVEN	(1 << 19)
 
 #define USB_OTG_STAT_CONTROL	IO_ADDRESS(USB_CONFIG_BASE + 0x110)
+#endif
 
 /* USB_OTG_STAT_CONTROL bit defines */
 #define TRANSPARENT_I2C_EN	(1 << 7)
@@ -117,8 +115,10 @@ static void isp1301_configure_lpc32xx(void)
 	i2c_smbus_write_byte_data(isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
 
+#if 0
 	/* Enable usb_need_clk clock after transceiver is initialized */
 	__raw_writel(__raw_readl(USB_CTRL) | USB_HOST_NEED_CLK_EN, USB_CTRL);
+#endif
 
 	printk(KERN_INFO "ISP1301 Vendor ID  : 0x%04x\n",
 	      i2c_smbus_read_word_data(isp1301_i2c_client, 0x00));
@@ -148,17 +148,21 @@ static inline void isp1301_vbus_off(void)
 
 static void ohci_nxp_start_hc(void)
 {
+#if 0
 	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
+#endif
 	isp1301_vbus_on();
 }
 
 static void ohci_nxp_stop_hc(void)
 {
-	unsigned long tmp;
 	isp1301_vbus_off();
+#if 0
+	unsigned long tmp;
 	tmp = __raw_readl(USB_OTG_STAT_CONTROL) & ~HOST_EN;
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
+#endif
 }
 
 static int ohci_hcd_nxp_probe(struct platform_device *pdev)
@@ -192,8 +196,10 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 		goto fail_disable;
 	}
 
+#if 0
 	/* Enable AHB slave USB clock, needed for further USB clock control */
 	__raw_writel(USB_SLAVE_HCLK_EN | PAD_CONTROL_LAST_DRIVEN, USB_CTRL);
+#endif
 
 	/* Enable USB PLL */
 	usb_pll_clk = devm_clk_get(&pdev->dev, "ck_pll5");
@@ -237,7 +243,9 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 		goto fail_otg;
 	}
 
+#if 0
 	__raw_writel(__raw_readl(USB_CTRL) | USB_HOST_NEED_CLK_EN, USB_CTRL);
+#endif
 
 	ret = clk_enable(usb_otg_clk);
 	if (ret < 0) {
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4224b3ec83a5..1ad107ac78e9 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <mach/hardware.h>
 
 /* WatchDog Timer - Chapter 23 Page 207 */
 
