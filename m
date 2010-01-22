From: epeer@tmtservices.co.za (Edwin Peer)
Date: Fri, 22 Jan 2010 10:10:45 +0200
Subject: [PATCH - v5] support for Embedian MXM-8x10
Message-ID: <201001221010.45174.epeer@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This version of the patch has added support for our iControl platform, which is 
based on the same MXM-8x10 module as the CAPC-7117 development board.

For the most part, it just reuses all the stuff in mxm8x10.c and adds support 
for some CAN bus chips.

Patch is still against vanilla 2.6.33-rc4.

Would appreciate comments.

Thank you.

Regards,
Edwin Peer

Signed-off-by: Edwin Peer <epeer@tmtservices.co.za>
---
diff -Nurp linux-2.6.33-rc4/arch/arm/mach-pxa/Kconfig linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Kconfig
--- linux-2.6.33-rc4/arch/arm/mach-pxa/Kconfig	2010-01-21 10:41:53.000000000 +0200
+++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Kconfig	2010-01-21 10:21:33.000000000 +0200
@@ -115,6 +115,11 @@ config MACH_CM_X300
 	select CPU_PXA310
 	select HAVE_PWM
 
+config MACH_CAPC7117
+	bool "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM"
+	select CPU_PXA320
+	select PXA3xx
+
 config ARCH_GUMSTIX
 	bool "Gumstix XScale 255 boards"
 	select PXA25x
@@ -492,6 +497,11 @@ config MACH_TOSA
 	select PXA25x
 	select PXA_HAVE_BOARD_IRQS
 
+config MACH_ICONTROL
+	bool "TMT iControl/SafeTCam based on the MXM-8x10 CoM"
+	select CPU_PXA320
+	select PXA3xx
+
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
 	select PXA25x
diff -Nurp linux-2.6.33-rc4/arch/arm/mach-pxa/Makefile linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Makefile
--- linux-2.6.33-rc4/arch/arm/mach-pxa/Makefile	2010-01-21 10:41:53.000000000 +0200
+++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Makefile	2010-01-21 10:23:18.000000000 +0200
@@ -48,6 +48,7 @@ obj-$(CONFIG_MACH_ARMCORE)	+= cm-x2xx-pc
 endif
 obj-$(CONFIG_MACH_EM_X270)	+= em-x270.o
 obj-$(CONFIG_MACH_CM_X300)      += cm-x300.o
+obj-$(CONFIG_MACH_CAPC7117)     += capc7117.o mxm8x10.o
 obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
 obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
 obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
@@ -82,6 +83,7 @@ obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o
 obj-$(CONFIG_CORGI_SSP_DEPRECATED)	+= corgi_ssp.o corgi_lcd.o
 obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 obj-$(CONFIG_MACH_TOSA)		+= tosa.o
+obj-$(CONFIG_MACH_ICONTROL)     += icontrol.o mxm8x10.o
 obj-$(CONFIG_ARCH_PXA_ESERIES)	+= eseries.o
 obj-$(CONFIG_MACH_E330)		+= e330.o
 obj-$(CONFIG_MACH_E350)		+= e350.o
diff -Nurp linux-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c
--- linux-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c	2010-01-19 07:16:43.000000000 +0200
@@ -0,0 +1,158 @@
+/*
+ * linux/arch/arm/mach-pxa/capc7117.c
+ *
+ * Support for the Embedian CAPC-7117 Evaluation Kit
+ * based on the Embedian MXM-8x10 Computer on Module
+ *
+ * Copyright (C) 2009 Embedian Inc.
+ * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
+ *
+ * 2007-09-04: eric miao <eric.y.miao@gmail.com>
+ *             rewrite to align with latest kernel
+ *
+ * 2010-01-09: Edwin Peer <epeer@tmtservices.co.za>
+ *             Hennie van der Merwe <hvdmerwe@tmtservices.co.za>
+ *             rework for upstream merge
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+#include <linux/serial_8250.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/pxa320.h>
+#include <mach/mxm8x10.h>
+
+#include "generic.h"
+
+/* IDE (PATA) Support */
+static struct pata_platform_info pata_platform_data = {
+	.ioport_shift = 1
+};
+
+static struct resource capc7117_ide_resources[] = {
+	[0] = {
+	       .start = 0x11000020,
+	       .end = 0x1100003f,
+	       .flags = IORESOURCE_MEM
+	},
+	[1] = {
+	       .start = 0x1100001c,
+	       .end = 0x1100001c,
+	       .flags = IORESOURCE_MEM
+	},
+	[2] = {
+	       .start = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76)),
+	       .end = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76)),
+	       .flags = IORESOURCE_IRQ | IRQF_TRIGGER_RISING
+	}
+};
+
+static struct platform_device capc7117_ide_device = {
+	.name = "pata_platform",
+	.num_resources = ARRAY_SIZE(capc7117_ide_resources),
+	.resource = capc7117_ide_resources,
+	.dev = {
+		.platform_data = &pata_platform_data,
+		.coherent_dma_mask = ~0		/* grumble */
+	}
+};
+
+static void __init capc7117_ide_init(void)
+{
+	platform_device_register(&capc7117_ide_device);
+}
+
+/* TI16C752 UART support */
+#define	TI16C752_FLAGS		(UPF_BOOT_AUTOCONF | \
+					UPF_IOREMAP | \
+					UPF_BUGGY_UART | \
+					UPF_SKIP_TEST)
+#define	TI16C752_UARTCLK	(22118400)
+static struct plat_serial8250_port ti16c752_platform_data[] = {
+	[0] = {
+	       .mapbase = 0x14000000,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO78)),
+	       .irqflags = IRQF_TRIGGER_RISING,
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK
+	},
+	[1] = {
+	       .mapbase = 0x14000040,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO79)),
+	       .irqflags = IRQF_TRIGGER_RISING,
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK
+	},
+	[2] = {
+	       .mapbase = 0x14000080,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO80)),
+	       .irqflags = IRQF_TRIGGER_RISING,
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK
+	},
+	[3] = {
+	       .mapbase = 0x140000c0,
+	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO81)),
+	       .irqflags = IRQF_TRIGGER_RISING,
+	       .flags = TI16C752_FLAGS,
+	       .iotype = UPIO_MEM,
+	       .regshift = 1,
+	       .uartclk = TI16C752_UARTCLK
+	},
+	[4] = {
+	       /* end of array */
+	}
+};
+
+static struct platform_device ti16c752_device = {
+	.name = "serial8250",
+	.id = PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = ti16c752_platform_data
+	}
+};
+
+static void __init capc7117_uarts_init(void)
+{
+	platform_device_register(&ti16c752_device);
+}
+
+static void __init capc7117_init(void)
+{
+	/* Init CoM */
+	mxm_8x10_barebones_init();
+
+	/* Init evaluation board peripherals */
+	mxm_8x10_ac97_init();
+	mxm_8x10_usb_host_init();
+	mxm_8x10_mmc_init();
+
+	capc7117_uarts_init();
+	capc7117_ide_init();
+}
+
+MACHINE_START(CAPC7117,
+	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
+	.phys_io = 0x40000000,
+	.boot_params = 0xa0000100,
+	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.map_io = pxa_map_io,
+	.init_irq = pxa3xx_init_irq,
+	.timer = &pxa_timer,
+	.init_machine = capc7117_init
+MACHINE_END
diff -Nurp linux-2.6.33-rc4/arch/arm/mach-pxa/icontrol.c linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/icontrol.c
--- linux-2.6.33-rc4/arch/arm/mach-pxa/icontrol.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/icontrol.c	2010-01-22 10:03:25.000000000 +0200
@@ -0,0 +1,202 @@
+/*
+ * linux/arch/arm/mach-pxa/icontrol.c
+ *
+ * Support for the iControl and SafeTcam platforms from TMT Services
+ * using the Embedian MXM-8x10 Computer on Module
+ *
+ * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
+ *
+ * 2010-01-21 Hennie van der Merve <hvdmerwe@tmtservies.co.za>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/pxa320.h>
+#include <mach/mxm8x10.h>
+
+#include <linux/spi/spi.h>
+#include <mach/pxa2xx_spi.h>
+#include <linux/can/platform/mcp251x.h>
+
+#include "generic.h"
+
+#define ICONTROL_MCP251x_nCS1	(15)
+#define ICONTROL_MCP251x_nCS2	(16)
+#define ICONTROL_MCP251x_nCS3	(17)
+#define ICONTROL_MCP251x_nCS4	(24)
+
+#define ICONTROL_MCP251x_nIRQ1	(74)
+#define ICONTROL_MCP251x_nIRQ2	(75)
+#define ICONTROL_MCP251x_nIRQ3	(76)
+#define ICONTROL_MCP251x_nIRQ4	(77)
+
+static struct pxa2xx_spi_chip mcp251x_chip_info1 = {
+	.tx_threshold   = 8,
+	.rx_threshold   = 128,
+	.dma_burst_size = 8,
+	.timeout        = 235,
+	.gpio_cs        = ICONTROL_MCP251x_nCS1
+};
+
+static struct pxa2xx_spi_chip mcp251x_chip_info2 = {
+	.tx_threshold   = 8,
+	.rx_threshold   = 128,
+	.dma_burst_size = 8,
+	.timeout        = 235,
+	.gpio_cs        = ICONTROL_MCP251x_nCS2
+};
+
+static struct pxa2xx_spi_chip mcp251x_chip_info3 = {
+	.tx_threshold   = 8,
+	.rx_threshold   = 128,
+	.dma_burst_size = 8,
+	.timeout        = 235,
+	.gpio_cs        = ICONTROL_MCP251x_nCS3
+};
+
+static struct pxa2xx_spi_chip mcp251x_chip_info4 = {
+	.tx_threshold   = 8,
+	.rx_threshold   = 128,
+	.dma_burst_size = 8,
+	.timeout        = 235,
+	.gpio_cs        = ICONTROL_MCP251x_nCS4
+};
+
+static struct mcp251x_platform_data mcp251x_info = {
+	.oscillator_frequency = 16E6,
+	.model                = CAN_MCP251X_MCP2515,
+	.board_specific_setup = NULL,
+	.power_enable         = NULL,
+	.transceiver_enable   = NULL
+};
+
+static struct spi_board_info mcp251x_board_info[] = {
+	{
+		.modalias        = "mcp251x",
+		.max_speed_hz    = 65E5,
+		.bus_num         = 3,
+		.chip_select     = 0,
+		.platform_data   = &mcp251x_info,
+		.controller_data = &mcp251x_chip_info1,
+		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ1)
+	},
+	{
+		.modalias        = "mcp251x",
+		.max_speed_hz    = 65E5,
+		.bus_num         = 3,
+		.chip_select     = 1,
+		.platform_data   = &mcp251x_info,
+		.controller_data = &mcp251x_chip_info2,
+		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ2)
+	},
+	{
+		.modalias        = "mcp251x",
+		.max_speed_hz    = 65E5,
+		.bus_num         = 4,
+		.chip_select     = 0,
+		.platform_data   = &mcp251x_info,
+		.controller_data = &mcp251x_chip_info3,
+		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ3)
+	},
+	{
+		.modalias        = "mcp251x",
+		.max_speed_hz    = 65E5,
+		.bus_num         = 4,
+		.chip_select     = 1,
+		.platform_data   = &mcp251x_info,
+		.controller_data = &mcp251x_chip_info4,
+		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ4)
+	}
+};
+
+static struct pxa2xx_spi_master pxa_ssp3_spi_master_info = {
+	.clock_enable   = CKEN_SSP3,
+	.num_chipselect = 2,
+	.enable_dma     = 1
+};
+
+static struct pxa2xx_spi_master pxa_ssp4_spi_master_info = {
+	.clock_enable   = CKEN_SSP4,
+	.num_chipselect = 2,
+	.enable_dma     = 1
+};
+
+struct platform_device pxa_spi_ssp3 = {
+	.name          = "pxa2xx-spi",
+	.id            = 3,
+	.dev           = {
+		.platform_data = &pxa_ssp3_spi_master_info,
+	}
+};
+
+struct platform_device pxa_spi_ssp4 = {
+	.name          = "pxa2xx-spi",
+	.id            = 4,
+	.dev           = {
+		.platform_data = &pxa_ssp4_spi_master_info,
+	}
+};
+
+static struct platform_device *icontrol_spi_devices[] __initdata = {
+	&pxa_spi_ssp3,
+	&pxa_spi_ssp4,
+};
+
+static mfp_cfg_t mfp_can_cfg[] __initdata = {
+	/* CAN CS lines */
+	GPIO15_GPIO,
+	GPIO16_GPIO,
+	GPIO17_GPIO,
+	GPIO24_GPIO,
+
+	/* SPI (SSP3) lines */
+	GPIO89_SSP3_SCLK,
+	GPIO91_SSP3_TXD,
+	GPIO92_SSP3_RXD,
+
+	/* SPI (SSP4) lines */
+	GPIO93_SSP4_SCLK,
+	GPIO95_SSP4_TXD,
+	GPIO96_SSP4_RXD,
+
+	/* CAN nIRQ lines */
+	GPIO74_GPIO | MFP_LPM_EDGE_RISE,
+	GPIO75_GPIO | MFP_LPM_EDGE_RISE,
+	GPIO76_GPIO | MFP_LPM_EDGE_RISE,
+	GPIO77_GPIO | MFP_LPM_EDGE_RISE
+};
+
+static void __init icontrol_can_init(void)
+{
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(mfp_can_cfg));
+	platform_add_devices(ARRAY_AND_SIZE(icontrol_spi_devices));
+	spi_register_board_info(ARRAY_AND_SIZE(mcp251x_board_info));
+}
+
+static void __init icontrol_init(void)
+{
+	mxm_8x10_barebones_init();
+	mxm_8x10_usb_host_init();
+	mxm_8x10_mmc_init();
+
+	icontrol_can_init();
+}
+
+MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
+	.phys_io	= 0x40000000,
+	.boot_params	= 0xa0000100,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa3xx_init_irq,
+	.timer		= &pxa_timer,
+	.init_machine	= icontrol_init
+MACHINE_END
diff -Nurp linux-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h
--- linux-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h	2010-01-19 07:43:23.000000000 +0200
@@ -0,0 +1,22 @@
+#ifndef __MACH_MXM_8X10_H
+#define __MACH_MXM_8X10_H
+
+#define MXM_8X10_ETH_PHYS	0x13000000
+
+#define NAND_MMIO_START         0x43100000
+#define NAND_MMIO_END           0x43100080
+
+#define EXT_GPIO(x)     (128 + (x))
+
+#if defined(CONFIG_MMC)
+extern void mxm_8x10_mmc_init(void);
+#else
+static inline void mxm_8x10_mmc_init(void) {}
+#endif
+
+extern void mxm_8x10_usb_host_init(void);
+extern void mxm_8x10_ac97_init(void);
+
+extern void mxm_8x10_barebones_init(void);
+
+#endif /* __MACH_MXM_8X10_H */
diff -Nurp linux-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c
--- linux-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c	2010-01-19 07:43:21.000000000 +0200
@@ -0,0 +1,474 @@
+/*
+ * linux/arch/arm/mach-pxa/mxm8x10.c
+ *
+ * Support for the Embedian MXM-8x10 Computer on Module
+ *
+ * Copyright (C) 2006 Marvell International Ltd.
+ * Copyright (C) 2009 Embedian Inc.
+ * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
+ *
+ * 2007-09-04: eric miao <eric.y.miao@gmail.com>
+ *             rewrite to align with latest kernel
+ *
+ * 2010-01-09: Edwin Peer <epeer@tmtservices.co.za>
+ * 	       Hennie van der Merwe <hvdmerwe@tmtservices.co.za>
+ *             rework for upstream merge
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/serial_8250.h>
+#include <linux/dm9000.h>
+#include <linux/gpio.h>
+
+#include <plat/i2c.h>
+#include <plat/pxa3xx_nand.h>
+
+#include <mach/pxafb.h>
+#include <mach/mmc.h>
+#include <mach/ohci.h>
+#include <mach/pxa320.h>
+
+#include <mach/mxm8x10.h>
+
+#include "devices.h"
+#include "generic.h"
+
+/* GPIO pin definition
+
+External device stuff   - Leave unconfigured for now...
+---------------------
+GPIO0   -   DREQ    (External DMA Request)
+GPIO3   -   nGCS2   (External Chip Select) Where is nGCS0; nGCS1; nGCS4; nGCS5 ?
+GPIO4   -   nGCS3
+GPIO15  -   EXT_GPIO1
+GPIO16  -   EXT_GPIO2
+GPIO17  -   EXT_GPIO3
+GPIO24  -   EXT_GPIO4
+GPIO25  -   EXT_GPIO5
+GPIO26  -   EXT_GPIO6
+GPIO27  -   EXT_GPIO7
+GPIO28  -   EXT_GPIO8
+GPIO29  -   EXT_GPIO9
+GPIO30  -   EXT_GPIO10
+GPIO31  -   EXT_GPIO11
+GPIO57  -   EXT_GPIO12
+GPIO74  -   EXT_IRQ1
+GPIO75  -   EXT_IRQ2
+GPIO76  -   EXT_IRQ3
+GPIO77  -   EXT_IRQ4
+GPIO78  -   EXT_IRQ5
+GPIO79  -   EXT_IRQ6
+GPIO80  -   EXT_IRQ7
+GPIO81  -   EXT_IRQ8
+GPIO87  -   VCCIO_PWREN (External Device PWREN)
+
+Dallas 1-Wire   - Leave unconfigured for now...
+-------------
+GPIO0_2 -   DS - 1Wire
+
+Ethernet
+--------
+GPIO1   -   DM9000 PWR
+GPIO9   -   DM9K_nIRQ
+GPIO36  -   DM9K_RESET
+
+Keypad  - Leave unconfigured by for now...
+------
+GPIO1_2 -   KP_DKIN0
+GPIO5_2 -   KP_MKOUT7
+GPIO82  -   KP_DKIN1
+GPIO85  -   KP_DKIN2
+GPIO86  -   KP_DKIN3
+GPIO113 -   KP_MKIN0
+GPIO114 -   KP_MKIN1
+GPIO115 -   KP_MKIN2
+GPIO116 -   KP_MKIN3
+GPIO117 -   KP_MKIN4
+GPIO118 -   KP_MKIN5
+GPIO119 -   KP_MKIN6
+GPIO120 -   KP_MKIN7
+GPIO121 -   KP_MKOUT0
+GPIO122 -   KP_MKOUT1
+GPIO122 -   KP_MKOUT2
+GPIO123 -   KP_MKOUT3
+GPIO124 -   KP_MKOUT4
+GPIO125 -   KP_MKOUT5
+GPIO127 -   KP_MKOUT6
+
+Data Bus    - Leave unconfigured for now...
+--------
+GPIO2   -   nWait (Data Bus)
+
+USB Device
+----------
+GPIO4_2 -   USBD_PULLUP
+GPIO10  -   UTM_CLK (USB Device UTM Clk)
+GPIO49  -   USB 2.0 Device UTM_DATA0
+GPIO50  -   USB 2.0 Device UTM_DATA1
+GPIO51  -   USB 2.0 Device UTM_DATA2
+GPIO52  -   USB 2.0 Device UTM_DATA3
+GPIO53  -   USB 2.0 Device UTM_DATA4
+GPIO54  -   USB 2.0 Device UTM_DATA5
+GPIO55  -   USB 2.0 Device UTM_DATA6
+GPIO56  -   USB 2.0 Device UTM_DATA7
+GPIO58  -   UTM_RXVALID (USB 2.0 Device)
+GPIO59  -   UTM_RXACTIVE (USB 2.0 Device)
+GPIO60  -   UTM_RXERROR
+GPIO61  -   UTM_OPMODE0
+GPIO62  -   UTM_OPMODE1
+GPIO71  -   USBD_INT    (USB Device?)
+GPIO73  -   UTM_TXREADY (USB 2.0 Device)
+GPIO83  -   UTM_TXVALID (USB 2.0 Device)
+GPIO98  -   UTM_RESET   (USB 2.0 device)
+GPIO99  -   UTM_XCVR_SELECT
+GPIO100 -   UTM_TERM_SELECT
+GPIO101 -   UTM_SUSPENDM_X
+GPIO102 -   UTM_LINESTATE0
+GPIO103 -   UTM_LINESTATE1
+
+Card-Bus Interface  - Leave unconfigured for now...
+------------------
+GPIO5   -   nPIOR (I/O space output enable)
+GPIO6   -   nPIOW (I/O space write enable)
+GPIO7   -   nIOS16 (Input from I/O space telling size of data bus)
+GPIO8   -   nPWAIT (Input for inserting wait states)
+
+LCD
+---
+GPIO6_2     -   LDD0
+GPIO7_2     -   LDD1
+GPIO8_2     -   LDD2
+GPIO9_2     -   LDD3
+GPIO11_2    -   LDD5
+GPIO12_2    -   LDD6
+GPIO13_2    -   LDD7
+GPIO14_2    -   VSYNC
+GPIO15_2    -   HSYNC
+GPIO16_2    -   VCLK
+GPIO17_2    -   HCLK
+GPIO18_2    -   VDEN
+GPIO63      -   LDD8    (CPU LCD)
+GPIO64      -   LDD9    (CPU LCD)
+GPIO65      -   LDD10   (CPU LCD)
+GPIO66      -   LDD11   (CPU LCD)
+GPIO67      -   LDD12   (CPU LCD)
+GPIO68      -   LDD13   (CPU LCD)
+GPIO69      -   LDD14   (CPU LCD)
+GPIO70      -   LDD15   (CPU LCD)
+GPIO88      -   VCCLCD_PWREN (LCD Panel PWREN)
+GPIO97      -   BACKLIGHT_EN
+GPIO104     -   LCD_PWREN
+
+PWM   - Leave unconfigured for now...
+---
+GPIO11  -   PWM0
+GPIO12  -   PWM1
+GPIO13  -   PWM2
+GPIO14  -   PWM3
+
+SD-CARD
+-------
+GPIO18  -   SDDATA0
+GPIO19  -   SDDATA1
+GPIO20  -   SDDATA2
+GPIO21  -   SDDATA3
+GPIO22  -   SDCLK
+GPIO23  -   SDCMD
+GPIO72  -   SD_WP
+GPIO84  -   SD_nIRQ_CD  (SD-Card)
+
+I2C
+---
+GPIO32  -   I2CSCL
+GPIO33  -   I2CSDA
+
+AC97
+----
+GPIO35  -   AC97_SDATA_IN
+GPIO37  -   AC97_SDATA_OUT
+GPIO38  -   AC97_SYNC
+GPIO39  -   AC97_BITCLK
+GPIO40  -   AC97_nRESET
+
+UART1
+-----
+GPIO41  -   UART_RXD1
+GPIO42  -   UART_TXD1
+GPIO43  -   UART_CTS1
+GPIO44  -   UART_DCD1
+GPIO45  -   UART_DSR1
+GPIO46  -   UART_nRI1
+GPIO47  -   UART_DTR1
+GPIO48  -   UART_RTS1
+
+UART2
+-----
+GPIO109 -   RTS2
+GPIO110 -   RXD2
+GPIO111 -   TXD2
+GPIO112 -   nCTS2
+
+UART3
+-----
+GPIO105 -   nCTS3
+GPIO106 -   nRTS3
+GPIO107 -   TXD3
+GPIO108 -   RXD3
+
+SSP3    - Leave unconfigured for now...
+----
+GPIO89  -   SSP3_CLK
+GPIO90  -   SSP3_SFRM
+GPIO91  -   SSP3_TXD
+GPIO92  -   SSP3_RXD
+
+SSP4
+GPIO93  -   SSP4_CLK
+GPIO94  -   SSP4_SFRM
+GPIO95  -   SSP4_TXD
+GPIO96  -   SSP4_RXD
+*/
+
+static mfp_cfg_t mfp_cfg[] __initdata = {
+	/* USB */
+	GPIO10_UTM_CLK,
+	GPIO49_U2D_PHYDATA_0,
+	GPIO50_U2D_PHYDATA_1,
+	GPIO51_U2D_PHYDATA_2,
+	GPIO52_U2D_PHYDATA_3,
+	GPIO53_U2D_PHYDATA_4,
+	GPIO54_U2D_PHYDATA_5,
+	GPIO55_U2D_PHYDATA_6,
+	GPIO56_U2D_PHYDATA_7,
+	GPIO58_UTM_RXVALID,
+	GPIO59_UTM_RXACTIVE,
+	GPIO60_U2D_RXERROR,
+	GPIO61_U2D_OPMODE0,
+	GPIO62_U2D_OPMODE1,
+	GPIO71_GPIO, /* USBD_INT */
+	GPIO73_UTM_TXREADY,
+	GPIO83_U2D_TXVALID,
+	GPIO98_U2D_RESET,
+	GPIO99_U2D_XCVR_SEL,
+	GPIO100_U2D_TERM_SEL,
+	GPIO101_U2D_SUSPEND,
+	GPIO102_UTM_LINESTATE_0,
+	GPIO103_UTM_LINESTATE_1,
+	GPIO4_2_GPIO | MFP_PULL_HIGH, /* UTM_PULLUP */
+
+	/* DM9000 */
+	GPIO1_GPIO,
+	GPIO9_GPIO,
+	GPIO36_GPIO,
+
+	/* AC97 */
+	GPIO35_AC97_SDATA_IN_0,
+	GPIO37_AC97_SDATA_OUT,
+	GPIO38_AC97_SYNC,
+	GPIO39_AC97_BITCLK,
+	GPIO40_AC97_nACRESET,
+
+	/* UARTS */
+	GPIO41_UART1_RXD,
+	GPIO42_UART1_TXD,
+	GPIO43_UART1_CTS,
+	GPIO44_UART1_DCD,
+	GPIO45_UART1_DSR,
+	GPIO46_UART1_RI,
+	GPIO47_UART1_DTR,
+	GPIO48_UART1_RTS,
+
+	GPIO109_UART2_RTS,
+	GPIO110_UART2_RXD,
+	GPIO111_UART2_TXD,
+	GPIO112_UART2_CTS,
+
+	GPIO105_UART3_CTS,
+	GPIO106_UART3_RTS,
+	GPIO107_UART3_TXD,
+	GPIO108_UART3_RXD,
+
+	GPIO78_GPIO,
+	GPIO79_GPIO,
+	GPIO80_GPIO,
+	GPIO81_GPIO,
+
+	/* I2C */
+	GPIO32_I2C_SCL,
+	GPIO33_I2C_SDA,
+
+	/* MMC */
+	GPIO18_MMC1_DAT0,
+	GPIO19_MMC1_DAT1,
+	GPIO20_MMC1_DAT2,
+	GPIO21_MMC1_DAT3,
+	GPIO22_MMC1_CLK,
+	GPIO23_MMC1_CMD,
+	GPIO72_GPIO,
+	GPIO84_GPIO,
+
+	/* IRQ */
+	GPIO74_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ1 */
+	GPIO75_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ2 */
+	GPIO76_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ3 */
+	GPIO77_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ4 */
+	GPIO78_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ5 */
+	GPIO79_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ6 */
+	GPIO80_GPIO | MFP_LPM_EDGE_RISE, /* EXT_IRQ7 */
+	GPIO81_GPIO | MFP_LPM_EDGE_RISE  /* EXT_IRQ8 */
+};
+
+/* MMC/MCI Support */
+#if defined(CONFIG_MMC)
+static struct pxamci_platform_data mxm_8x10_mci_platform_data = {
+	.detect_delay = 20,
+	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_card_detect = EXT_GPIO(72),
+	.gpio_card_ro = EXT_GPIO(84),
+	.gpio_power = -1
+};
+
+void __init mxm_8x10_mmc_init(void)
+{
+	pxa_set_mci_info(&mxm_8x10_mci_platform_data);
+}
+#endif
+
+/* USB Open Host Controler Interface */
+static struct pxaohci_platform_data mxm_8x10_ohci_platform_data = {
+	.port_mode = PMM_NPS_MODE,
+	.flags = ENABLE_PORT_ALL
+};
+
+void __init mxm_8x10_usb_host_init(void)
+{
+	pxa_set_ohci_info(&mxm_8x10_ohci_platform_data);
+}
+
+/* AC97 Sound Support */
+static struct platform_device mxm_8x10_ac97_device = {
+	.name = "pxa2xx-ac97"
+};
+
+void __init mxm_8x10_ac97_init(void)
+{
+	platform_device_register(&mxm_8x10_ac97_device);
+}
+
+/* NAND flash Support */
+#if defined(CONFIG_MTD_NAND_PXA3xx) || defined(CONFIG_MTD_NAND_PXA3xx_MODULE)
+#define NAND_BLOCK_SIZE SZ_128K
+#define NB(x)           (NAND_BLOCK_SIZE * (x))
+static struct mtd_partition mxm_8x10_nand_partitions[] = {
+	[0] = {
+	       .name = "boot",
+	       .size = NB(0x002),
+	       .offset = NB(0x000),
+	       .mask_flags = MTD_WRITEABLE
+	},
+	[1] = {
+	       .name = "kernel",
+	       .size = NB(0x010),
+	       .offset = NB(0x002),
+	       .mask_flags = MTD_WRITEABLE
+	},
+	[2] = {
+	       .name = "root",
+	       .size = NB(0x36c),
+	       .offset = NB(0x012)
+	},
+	[3] = {
+	       .name = "bbt",
+	       .size = NB(0x082),
+	       .offset = NB(0x37e),
+	       .mask_flags = MTD_WRITEABLE
+	}
+};
+
+static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
+	.enable_arbiter = 1,
+	.keep_config = 1,
+	.parts = mxm_8x10_nand_partitions,
+	.nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions)
+};
+
+static void __init mxm_8x10_nand_init(void)
+{
+	pxa3xx_set_nand_info(&mxm_8x10_nand_info);
+}
+#else
+static inline void mxm_8x10_nand_init(void) {}
+#endif /* CONFIG_MTD_NAND_PXA3xx || CONFIG_MTD_NAND_PXA3xx_MODULE */
+
+/* Ethernet support: Davicom DM9000 */
+static struct resource dm9k_resources[] = {
+	[0] = {
+	       .start = MXM_8X10_ETH_PHYS + 0x300,
+	       .end = MXM_8X10_ETH_PHYS + 0x300,
+	       .flags = IORESOURCE_MEM
+	},
+	[1] = {
+	       .start = MXM_8X10_ETH_PHYS + 0x308,
+	       .end = MXM_8X10_ETH_PHYS + 0x308,
+	       .flags = IORESOURCE_MEM
+	},
+	[2] = {
+	       .start = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO9)),
+	       .end = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO9)),
+	       .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE
+	}
+};
+
+static struct dm9000_plat_data dm9k_plat_data = {
+	.flags = DM9000_PLATF_16BITONLY
+};
+
+static struct platform_device dm9k_device = {
+	.name = "dm9000",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(dm9k_resources),
+	.resource = dm9k_resources,
+	.dev = {
+		.platform_data = &dm9k_plat_data
+	}
+};
+
+static void __init mxm_8x10_ethernet_init(void)
+{
+	platform_device_register(&dm9k_device);
+}
+
+/* PXA UARTs */
+static void __init mxm_8x10_uarts_init(void)
+{
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+}
+
+/* I2C and Real Time Clock */
+static struct i2c_board_info __initdata mxm_8x10_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1337", 0x68)
+	}
+};
+
+static void __init mxm_8x10_i2c_init(void)
+{
+	i2c_register_board_info(0, mxm_8x10_i2c_devices,
+				ARRAY_SIZE(mxm_8x10_i2c_devices));
+	pxa_set_i2c_info(NULL);
+}
+
+void __init mxm_8x10_barebones_init(void)
+{
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(mfp_cfg));
+
+	mxm_8x10_uarts_init();
+	mxm_8x10_nand_init();
+	mxm_8x10_i2c_init();
+	mxm_8x10_ethernet_init();
+}
