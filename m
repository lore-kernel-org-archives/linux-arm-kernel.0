From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 14 Jan 2010 10:29:33 +0800
Subject: [PATCH - 2nd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <201001131730.24535.epeer@tmtservices.co.za>
References: <201001131730.24535.epeer@tmtservices.co.za>
Message-ID: <f17812d71001131829v4b9de1f4ud4e4f8889422f5a2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 11:30 PM, Edwin Peer <epeer@tmtservices.co.za> wrote:
> Dear Russell,
>
> Here's another attempt at a patch for the MXM-8x10 development board -- this time against
> 2.6.33-rc4.
>
> The major difference between this and our previous attempt is that we don't do stupid stuff
> with the USB OHCI platform support any more. Aside from the Kconfig and Makefile, this patch
> doesn't touch any existing files now.There are also some minor defconfig changes.
>
> Please consider for inclusion.
>

Besides Russell's review comments, here're some more:

> Thank you.
>
> Regards,
> Edwin Peer
>
> Add support for the Embedian MXM-8x10 evaluation kit.
> Product URL: http://www.embedian.com/index.php?main_page=product_info&amp;cPath=68&amp;products_id=229
>
> Signed-off-by: Edwin Peer <epeer@tmtservices.co.za>
> ---
> diff -uNrp linux-2.6.33-rc4/arch/arm/configs/capc7117_defconfig linux-embedian-2.6.33-rc4/arch/arm/configs/capc7117_defconfig
> --- linux-2.6.33-rc4/arch/arm/configs/capc7117_defconfig ? ? ? ?1970-01-01 02:00:00.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/configs/capc7117_defconfig ? ? ? 2010-01-13 17:00:13.000000000 +0200

Since we are already able to build a single zImage for multiple boards,
I hope it's ok if this can be merged into pxa3xx_defconfig.

> diff -uNrp linux-2.6.33-rc4/arch/arm/mach-pxa/Kconfig linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Kconfig
> --- linux-2.6.33-rc4/arch/arm/mach-pxa/Kconfig ?2010-01-13 17:06:11.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Kconfig 2010-01-13 17:00:13.000000000 +0200
> @@ -115,6 +115,11 @@ config MACH_CM_X300
> ? ? ? ?select CPU_PXA310
> ? ? ? ?select HAVE_PWM
>
> +config MACH_CAPC7117
> + ? ? ? bool "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM"
> + ? ? ? select CPU_PXA320
> + ? ? ? select PXA3xx
> +
> ?config ARCH_GUMSTIX
> ? ? ? ?bool "Gumstix XScale 255 boards"
> ? ? ? ?select PXA25x
> diff -uNrp linux-2.6.33-rc4/arch/arm/mach-pxa/Kconfig.orig linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Kconfig.orig
> --- linux-2.6.33-rc4/arch/arm/mach-pxa/Kconfig.orig ? ? 1970-01-01 02:00:00.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Kconfig.orig ? ?2010-01-13 16:47:30.000000000 +0200

This isn't necessary here as Russell suggested.

> diff -uNrp linux-2.6.33-rc4/arch/arm/mach-pxa/Makefile linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Makefile
> --- linux-2.6.33-rc4/arch/arm/mach-pxa/Makefile 2010-01-13 17:06:11.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/Makefile ? ? ? ?2010-01-13 17:00:13.000000000 +0200
> @@ -48,6 +48,7 @@ obj-$(CONFIG_MACH_ARMCORE) ? ?+= cm-x2xx-pc
> ?endif
> ?obj-$(CONFIG_MACH_EM_X270) ? ? += em-x270.o
> ?obj-$(CONFIG_MACH_CM_X300) ? ? ?+= cm-x300.o
> +obj-$(CONFIG_MACH_CAPC7117) ? ? += capc7117.o mxm8x10.o
> ?obj-$(CONFIG_ARCH_GUMSTIX) ? ? += gumstix.o
> ?obj-$(CONFIG_GUMSTIX_AM200EPD) += am200epd.o
> ?obj-$(CONFIG_GUMSTIX_AM300EPD) += am300epd.o
> diff -uNrp linux-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c
> --- linux-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c ? ? ? 1970-01-01 02:00:00.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/capc7117.c ? ? ?2010-01-13 17:00:13.000000000 +0200
> @@ -0,0 +1,180 @@
> +/*
> + * linux/arch/arm/mach-pxa/capc7117.c
> + *
> + * Support for the Embedian CAPC-7117 Evaluation Kit
> + * based on the Embedian MXM-8x10 Computer on Module
> + *
> + * Copyright (C) 2009 Embedian Inc.
> + * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
> + *
> + * 2007-09-04: eric miao <eric.y.miao@gmail.com>
> + * ? ? ? ? ? ? rewrite to align with latest kernel
> + *
> + * 2010-01-09: Edwin Peer <epeer@tmtservices.co.za>
> + * ? ? ? ? ? ? Hennie van der Merwe <hvdmerwe@tmtservices.co.za>
> + * ? ? ? ? ? ? rework for upstream merge
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/ata_platform.h>
> +#include <linux/serial_8250.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/gpio.h>
> +#include <mach/mfp-pxa320.h>
> +#include <mach/mxm8x10.h>
> +
> +#include "generic.h"
> +
> +/* IDE (PATA) Support */
> +static struct pata_platform_info pata_platform_data = {
> + ? ? ? .ioport_shift = 1,
> +};
> +
> +static struct resource capc7117_ide_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ?.start = 0x11000020,
> + ? ? ? ? ? ? ?.end = 0x1100003f,
> + ? ? ? ? ? ? ?.flags = IORESOURCE_MEM,
> + ? ? ? ? ? ? ?},
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ?.start = 0x1100001c,
> + ? ? ? ? ? ? ?.end = 0x1100001c,
> + ? ? ? ? ? ? ?.flags = IORESOURCE_MEM,
> + ? ? ? ? ? ? ?},
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ?.start = 0,
> + ? ? ? ? ? ? ?.end = 0,
> + ? ? ? ? ? ? ?.flags = IORESOURCE_IRQ,
> + ? ? ? ? ? ? ?},
> +};
> +
> +struct platform_device capc7117_ide_device = {
> + ? ? ? .name = "pata_platform",
> + ? ? ? .num_resources = ARRAY_SIZE(capc7117_ide_resources),
> + ? ? ? .resource = capc7117_ide_resources,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &pata_platform_data,
> + ? ? ? ? ? ? ? .coherent_dma_mask = ~0, ? ? ? ?/* grumble */
> + ? ? ? ? ? ? ? },
> +};
> +
> +int capc7117_ide_mach_init(void)
> +{
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL(capc7117_ide_mach_init);

This isn't referenced anywhere, yet it's being exported even. And having
the body simply do a job of returning '0' doesn't sound interesting.  So
it looks like something wrong here, maybe this can just be removed until
the real requirement for this is clear?

> +
> +static void __init capc7117_ide_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO76, 0xa0c0); ? ? ? /* EXT_IRQ3 */

Please reference to other platforms, pxa3xx_mfp_write() isn't supposed to
be abusively used in such way. Having an array grouping all the relevant
pin usage would be recommended, and instead of having a magic number
'0xa0c0' here, you are suggested to use

	GPIO76_GPIO,	/* EXT_IRQ3 */

Believe me, this will work for you in most cases despite the drive strength
may be a little different from what you used here, that really matters in
few corner cases.

> +
> + ? ? ? capc7117_ide_resources[2].start =
> + ? ? ? ? ? gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76));
> + ? ? ? capc7117_ide_resources[2].end =
> + ? ? ? ? ? gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76));
> + ? ? ? set_irq_type(capc7117_ide_resources[2].start, IRQ_TYPE_EDGE_RISING);
> + ? ? ? platform_device_register(&capc7117_ide_device);
> +}

gpio_to_irq(), mfp_to_gpio() are actually applicable to constants, so having
them directly in the resource definition is just OK, you don't need to write
it like this. Besides, the IRQ_TYPE* can really be specified in the resource's
'flags' attribute.

> +
> +/* TI16C752 UART support */
> +#define ? ? ? ?TI16C752_FLAGS ? ? ? ? ?(UPF_BOOT_AUTOCONF | \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_IOREMAP | \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_BUGGY_UART | \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? UPF_SKIP_TEST)
> +#define ? ? ? ?TI16C752_UARTCLK ? ? ? ?(22118400)
> +static struct plat_serial8250_port ti16c752_platform_data[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ?.mapbase = 0x14000000,
> + ? ? ? ? ? ? ?.irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO78)),
> + ? ? ? ? ? ? ?.flags = TI16C752_FLAGS,
> + ? ? ? ? ? ? ?.iotype = UPIO_MEM,
> + ? ? ? ? ? ? ?.regshift = 1,
> + ? ? ? ? ? ? ?.uartclk = TI16C752_UARTCLK,
> + ? ? ? ? ? ? ?},
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ?.mapbase = 0x14000040,
> + ? ? ? ? ? ? ?.irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO79)),
> + ? ? ? ? ? ? ?.flags = TI16C752_FLAGS,
> + ? ? ? ? ? ? ?.iotype = UPIO_MEM,
> + ? ? ? ? ? ? ?.regshift = 1,
> + ? ? ? ? ? ? ?.uartclk = TI16C752_UARTCLK,
> + ? ? ? ? ? ? ?},
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ?.mapbase = 0x14000080,
> + ? ? ? ? ? ? ?.irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO80)),
> + ? ? ? ? ? ? ?.flags = TI16C752_FLAGS,
> + ? ? ? ? ? ? ?.iotype = UPIO_MEM,
> + ? ? ? ? ? ? ?.regshift = 1,
> + ? ? ? ? ? ? ?.uartclk = TI16C752_UARTCLK,
> + ? ? ? ? ? ? ?},
> + ? ? ? [3] = {
> + ? ? ? ? ? ? ?.mapbase = 0x140000c0,
> + ? ? ? ? ? ? ?.irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO81)),
> + ? ? ? ? ? ? ?.flags = TI16C752_FLAGS,
> + ? ? ? ? ? ? ?.iotype = UPIO_MEM,
> + ? ? ? ? ? ? ?.regshift = 1,
> + ? ? ? ? ? ? ?.uartclk = TI16C752_UARTCLK,
> + ? ? ? ? ? ? ?},
> + ? ? ? [4] = {
> + ? ? ? ? ? ? ?.flags = 0,
> + ? ? ? ? ? ? ?},

I guess this signals the end of the array? so you may just write this as:

	[4] = {
		/* end of array */
	},

or something, and this will be initialized to zero anyway, you don't have
to even specify a single field 'flags' like this, it looks confusing.

> +};
> +
> +static struct platform_device ti16c752_device = {
> + ? ? ? .name = "serial8250",
> + ? ? ? .id = PLAT8250_DEV_PLATFORM,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = ti16c752_platform_data,
> + ? ? ? ? ? ? ? },
> +};
> +
> +static void __init capc7117_uarts_init(void)
> +{
> + ? ? ? int i;
> +
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO78, 0xa090); ? ? ? /* EXT_IRQ5 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO79, 0xa090); ? ? ? /* EXT_IRQ6 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO80, 0xa090); ? ? ? /* EXT_IRQ7 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO81, 0xa090); ? ? ? /* EXT_IRQ8 */

I'll read these magic number as: pulldown, input during sleep, and
wakeup on edge rise, what about:

	GPIO78_GPIO | MFP_LPM_PULL_LOW | MFP_LPM_EDGE_RISE,

and grouping them in an array please.

> +
> + ? ? ? for (i = 0; i < 4; i++)
> + ? ? ? ? ? ? ? set_irq_type(ti16c752_platform_data[i].irq,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?IRQ_TYPE_EDGE_RISING);
> +

set_irq_type() isn't recommended to be used directly like this, use the
field 'irqflags' in 'struct plat_serial8250_port' instead.

> + ? ? ? platform_device_register(&ti16c752_device);
> +}
> +
> +static void __init capc7117_init(void)
> +{
> + ? ? ? if (cpu_is_pxa320()) {
> + ? ? ? ? ? ? ? mxm_8x10_barebones_init();
> +
> + ? ? ? ? ? ? ? mxm_8x10_lcd_init();
> + ? ? ? ? ? ? ? mxm_8x10_ac97_init();
> + ? ? ? ? ? ? ? mxm_8x10_usb_host_init();
> + ? ? ? ? ? ? ? mxm_8x10_mmc_init();
> +
> + ? ? ? ? ? ? ? capc7117_uarts_init();
> + ? ? ? ? ? ? ? capc7117_ide_init();
> + ? ? ? } else {
> + ? ? ? ? ? ? ? panic("Unsupported processor. Platform must be pxa320\n");
> + ? ? ? }
> +}

Now, it looks to me the CAPC-7117 is a baseboard, where MXM_8x10 or possibly
other core modules can be installed. So it doesn't really deserve a machine
structure, we have many such examples within mach-pxa/, e.g. pcm990-baseboard.c

I'd recommend to have a better structure layout so to be extensible.

> +
> +MACHINE_START(CAPC7117,
> + ? ? ? ? ? ? "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
> + ? ?.phys_io = 0x40000000,
> + ? ?.boot_params = 0xa0000100,
> + ? ?.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
> + ? ?.map_io = pxa_map_io,
> + ? ?.init_irq = pxa3xx_init_irq,
> + ? ?.timer = &pxa_timer,
> + ? ?.init_machine = capc7117_init,
> +MACHINE_END
> diff -uNrp linux-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h
> --- linux-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h ? 1970-01-01 02:00:00.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/include/mach/mxm8x10.h ?2010-01-13 17:00:13.000000000 +0200
> @@ -0,0 +1,28 @@
> +#ifndef __MACH_MXM_8X10_H
> +#define __MACH_MXM_8X10_H
> +
> +#define MXM_8X10_ETH_PHYS ? ? ?0x13000000
> +
> +#define NAND_MMIO_START ? ? ? ? 0x43100000
> +#define NAND_MMIO_END ? ? ? ? ? 0x43100080
> +
> +#define EXT_GPIO(x) ? ? (128 + (x))
> +
> +struct platform_mmc_slot {
> + ? ? ? int gpio_cd;
> + ? ? ? int gpio_wp;
> +};
> +
> +extern void mxm_8x10_mmc_init(void);
> +extern void mxm_8x10_usb_host_init(void);
> +extern void mxm_8x10_ac97_init(void);
> +extern void mxm_8x10_nand_init(void);
> +extern void mxm_8x10_ethernet_init(void);
> +extern void mxm_8x10_ide_init(void);
> +extern void mxm_8x10_uart_init(void);
> +extern void mxm_8x10_lcd_init(void);
> +extern void mxm_8x10_i2c_init(void);
> +
> +extern void mxm_8x10_barebones_init(void);
> +
> +#endif /* __MACH_MXM_8X10_H */
> diff -uNrp linux-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c
> --- linux-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c ? ? ? ?1970-01-01 02:00:00.000000000 +0200
> +++ linux-embedian-2.6.33-rc4/arch/arm/mach-pxa/mxm8x10.c ? ? ? 2010-01-13 17:00:13.000000000 +0200
> @@ -0,0 +1,842 @@
> +/*
> + * linux/arch/arm/mach-pxa/mxm8x10.c
> + *
> + * Support for the Embedian MXM-8x10 Computer on Module
> + *
> + * Copyright (C) 2006 Marvell International Ltd.
> + * Copyright (C) 2009 Embedian Inc.
> + * Copyright (C) 2009 TMT Services & Supplies (Pty) Ltd.
> + *
> + * 2007-09-04: eric miao <eric.y.miao@gmail.com>
> + * ? ? ? ? ? ? rewrite to align with latest kernel
> + *
> + * 2010-01-09: Edwin Peer <epeer@tmtservices.co.za>
> + * ? ? ? ? ? ?Hennie van der Merwe <hvdmerwe@tmtservices.co.za>
> + * ? ? ? ? ? ? rework for upstream merge
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/serial_8250.h>
> +#include <linux/dm9000.h>
> +
> +#include <plat/i2c.h>
> +#include <plat/pxa3xx_nand.h>
> +
> +#include <mach/gpio.h>
> +#include <mach/pxafb.h>
> +#include <mach/mmc.h>
> +#include <mach/mfp-pxa320.h>
> +#include <mach/ohci.h>
> +#include <mach/pxa3xx-regs.h>

Nah, you only need to #include <mach/pxa320.h> now.

> +
> +#include <mach/mxm8x10.h>
> +
> +#include "devices.h"
> +#include "generic.h"
> +
> +/* GPIO pin definition
> +
> +External device stuff ? - Leave unconfigured for now...
> +---------------------
> +GPIO0 ? - ? DREQ ? ?(External DMA Request)
> +GPIO3 ? - ? nGCS2 ? (External Chip Select) Where is nGCS0; nGCS1; nGCS4; nGCS5 ?
> +GPIO4 ? - ? nGCS3
> +GPIO15 ?- ? EXT_GPIO1
> +GPIO16 ?- ? EXT_GPIO2
> +GPIO17 ?- ? EXT_GPIO3
> +GPIO24 ?- ? EXT_GPIO4
> +GPIO25 ?- ? EXT_GPIO5
> +GPIO26 ?- ? EXT_GPIO6
> +GPIO27 ?- ? EXT_GPIO7
> +GPIO28 ?- ? EXT_GPIO8
> +GPIO29 ?- ? EXT_GPIO9
> +GPIO30 ?- ? EXT_GPIO10
> +GPIO31 ?- ? EXT_GPIO11
> +GPIO57 ?- ? EXT_GPIO12
> +GPIO74 ?- ? EXT_IRQ1
> +GPIO75 ?- ? EXT_IRQ2
> +GPIO76 ?- ? EXT_IRQ3
> +GPIO77 ?- ? EXT_IRQ4
> +GPIO78 ?- ? EXT_IRQ5
> +GPIO79 ?- ? EXT_IRQ6
> +GPIO80 ?- ? EXT_IRQ7
> +GPIO81 ?- ? EXT_IRQ8
> +GPIO87 ?- ? VCCIO_PWREN (External Device PWREN)
> +
> +Dallas 1-Wire ? - Leave unconfigured for now...
> +-------------
> +GPIO0_2 - ? DS - 1Wire
> +
> +Ethernet
> +--------
> +GPIO1 ? - ? DM9000 PWR
> +GPIO9 ? - ? DM9K_nIRQ
> +GPIO36 ?- ? DM9K_RESET
> +
> +Keypad ?- Leave unconfigured by for now...
> +------
> +GPIO1_2 - ? KP_DKIN0
> +GPIO5_2 - ? KP_MKOUT7
> +GPIO82 ?- ? KP_DKIN1
> +GPIO85 ?- ? KP_DKIN2
> +GPIO86 ?- ? KP_DKIN3
> +GPIO113 - ? KP_MKIN0
> +GPIO114 - ? KP_MKIN1
> +GPIO115 - ? KP_MKIN2
> +GPIO116 - ? KP_MKIN3
> +GPIO117 - ? KP_MKIN4
> +GPIO118 - ? KP_MKIN5
> +GPIO119 - ? KP_MKIN6
> +GPIO120 - ? KP_MKIN7
> +GPIO121 - ? KP_MKOUT0
> +GPIO122 - ? KP_MKOUT1
> +GPIO122 - ? KP_MKOUT2
> +GPIO123 - ? KP_MKOUT3
> +GPIO124 - ? KP_MKOUT4
> +GPIO125 - ? KP_MKOUT5
> +GPIO127 - ? KP_MKOUT6
> +
> +Data Bus ? ?- Leave unconfigured for now...
> +--------
> +GPIO2 ? - ? nWait (Data Bus)
> +
> +USB Device
> +----------
> +GPIO4_2 - ? USBD_PULLUP
> +GPIO10 ?- ? UTM_CLK (USB Device UTM Clk)
> +GPIO49 ?- ? USB 2.0 Device UTM_DATA0
> +GPIO50 ?- ? USB 2.0 Device UTM_DATA1
> +GPIO51 ?- ? USB 2.0 Device UTM_DATA2
> +GPIO52 ?- ? USB 2.0 Device UTM_DATA3
> +GPIO53 ?- ? USB 2.0 Device UTM_DATA4
> +GPIO54 ?- ? USB 2.0 Device UTM_DATA5
> +GPIO55 ?- ? USB 2.0 Device UTM_DATA6
> +GPIO56 ?- ? USB 2.0 Device UTM_DATA7
> +GPIO58 ?- ? UTM_RXVALID (USB 2.0 Device)
> +GPIO59 ?- ? UTM_RXACTIVE (USB 2.0 Device)
> +GPIO60 ?- ? UTM_RXERROR
> +GPIO61 ?- ? UTM_OPMODE0
> +GPIO62 ?- ? UTM_OPMODE1
> +GPIO71 ?- ? USBD_INT ? ?(USB Device?)
> +GPIO73 ?- ? UTM_TXREADY (USB 2.0 Device)
> +GPIO83 ?- ? UTM_TXVALID (USB 2.0 Device)
> +GPIO98 ?- ? UTM_RESET ? (USB 2.0 device)
> +GPIO99 ?- ? UTM_XCVR_SELECT
> +GPIO100 - ? UTM_TERM_SELECT
> +GPIO101 - ? UTM_SUSPENDM_X
> +GPIO102 - ? UTM_LINESTATE0
> +GPIO103 - ? UTM_LINESTATE1
> +
> +Card-Bus Interface ?- Leave unconfigured for now...
> +------------------
> +GPIO5 ? - ? nPIOR (I/O space output enable)
> +GPIO6 ? - ? nPIOW (I/O space write enable)
> +GPIO7 ? - ? nIOS16 (Input from I/O space telling size of data bus)
> +GPIO8 ? - ? nPWAIT (Input for inserting wait states)
> +
> +LCD
> +---
> +GPIO6_2 ? ? - ? LDD0
> +GPIO7_2 ? ? - ? LDD1
> +GPIO8_2 ? ? - ? LDD2
> +GPIO9_2 ? ? - ? LDD3
> +GPIO11_2 ? ?- ? LDD5
> +GPIO12_2 ? ?- ? LDD6
> +GPIO13_2 ? ?- ? LDD7
> +GPIO14_2 ? ?- ? VSYNC
> +GPIO15_2 ? ?- ? HSYNC
> +GPIO16_2 ? ?- ? VCLK
> +GPIO17_2 ? ?- ? HCLK
> +GPIO18_2 ? ?- ? VDEN
> +GPIO63 ? ? ?- ? LDD8 ? ?(CPU LCD)
> +GPIO64 ? ? ?- ? LDD9 ? ?(CPU LCD)
> +GPIO65 ? ? ?- ? LDD10 ? (CPU LCD)
> +GPIO66 ? ? ?- ? LDD11 ? (CPU LCD)
> +GPIO67 ? ? ?- ? LDD12 ? (CPU LCD)
> +GPIO68 ? ? ?- ? LDD13 ? (CPU LCD)
> +GPIO69 ? ? ?- ? LDD14 ? (CPU LCD)
> +GPIO70 ? ? ?- ? LDD15 ? (CPU LCD)
> +GPIO88 ? ? ?- ? VCCLCD_PWREN (LCD Panel PWREN)
> +GPIO97 ? ? ?- ? BACKLIGHT_EN
> +GPIO104 ? ? - ? LCD_PWREN
> +
> +PWM ? - Leave unconfigured for now...
> +---
> +GPIO11 ?- ? PWM0
> +GPIO12 ?- ? PWM1
> +GPIO13 ?- ? PWM2
> +GPIO14 ?- ? PWM3
> +
> +SD-CARD
> +-------
> +GPIO18 ?- ? SDDATA0
> +GPIO19 ?- ? SDDATA1
> +GPIO20 ?- ? SDDATA2
> +GPIO21 ?- ? SDDATA3
> +GPIO22 ?- ? SDCLK
> +GPIO23 ?- ? SDCMD
> +GPIO72 ?- ? SD_WP
> +GPIO84 ?- ? SD_nIRQ_CD ?(SD-Card)
> +
> +I2C
> +---
> +GPIO32 ?- ? I2CSCL
> +GPIO33 ?- ? I2CSDA
> +
> +AC97
> +----
> +GPIO35 ?- ? AC97_SDATA_IN
> +GPIO37 ?- ? AC97_SDATA_OUT
> +GPIO38 ?- ? AC97_SYNC
> +GPIO39 ?- ? AC97_BITCLK
> +GPIO40 ?- ? AC97_nRESET
> +
> +UART1
> +-----
> +GPIO41 ?- ? UART_RXD1
> +GPIO42 ?- ? UART_TXD1
> +GPIO43 ?- ? UART_CTS1
> +GPIO44 ?- ? UART_DCD1
> +GPIO45 ?- ? UART_DSR1
> +GPIO46 ?- ? UART_nRI1
> +GPIO47 ?- ? UART_DTR1
> +GPIO48 ?- ? UART_RTS1
> +
> +UART2
> +-----
> +GPIO109 - ? RTS2
> +GPIO110 - ? RXD2
> +GPIO111 - ? TXD2
> +GPIO112 - ? nCTS2
> +
> +UART3
> +-----
> +GPIO105 - ? nCTS3
> +GPIO106 - ? nRTS3
> +GPIO107 - ? TXD3
> +GPIO108 - ? RXD3
> +
> +SSP3 ? ?- Leave unconfigured for now...
> +----
> +GPIO89 ?- ? SSP3_CLK
> +GPIO90 ?- ? SSP3_SFRM
> +GPIO91 ?- ? SSP3_TXD
> +GPIO92 ?- ? SSP3_RXD
> +
> +SSP4
> +GPIO93 ?- ? SSP4_CLK
> +GPIO94 ?- ? SSP4_SFRM
> +GPIO95 ?- ? SSP4_TXD
> +GPIO96 ?- ? SSP4_RXD
> +
> +Original Definition from Embedian:
> +----------------------------------
> +#include <mach/mfp-pxa3xx.h>
> +
> +void xpc8100_mfp_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO0 ? ? ? ? ?, 0xa0c0);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO1 ? ? ? ? ?, 0xa0c0);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO2 ? ? ? ? ?, 0x20c1);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO3 ? ? ? ? ?, 0x0801);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO4 ? ? ? ? ?, 0x0801);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO5 ? ? ? ? ?, 0x00c3);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO6 ? ? ? ? ?, 0x00c3);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO7 ? ? ? ? ?, 0x00c3);

....

> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO15_2 ? ? ? , 0x1c01);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO16_2 ? ? ? , 0x1c01);
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO17_2 ? ? ? , 0x1c01);
> +}

As said, this isn't supposed to be like this, please group them with array,
and use standard MFP defintions.

> +*/
> +
> +/* MMC/MCI Support */
> +#define MAX_MMC_SLOTS ?3
> +
> +#if defined(CONFIG_MMC)
> +struct platform_mmc_slot mxm_8x10_mmc_slot[MAX_MMC_SLOTS];
> +
> +static int mxm_8x10_mci_ro(struct device *dev)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> +
> + ? ? ? return gpio_get_value(mxm_8x10_mmc_slot[pdev->id].gpio_wp);
> +}
> +
> +static int mxm_8x10_mci_init(struct device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?irq_handler_t mxm_8x10_detect_int, void *data)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? int err, cd_irq, gpio_cd, gpio_wp;
> +
> + ? ? ? cd_irq = gpio_to_irq(mxm_8x10_mmc_slot[pdev->id].gpio_cd);
> + ? ? ? gpio_cd = mxm_8x10_mmc_slot[pdev->id].gpio_cd;
> + ? ? ? gpio_wp = mxm_8x10_mmc_slot[pdev->id].gpio_wp;
> +
> + ? ? ? /*
> + ? ? ? ?* setup GPIO for Zylonite MMC controller
> + ? ? ? ?*/
> + ? ? ? err = gpio_request(gpio_cd, "mmc card detect");
> + ? ? ? if (err)
> + ? ? ? ? ? ? ? goto err_request_cd;
> + ? ? ? gpio_direction_input(gpio_cd);
> +
> + ? ? ? err = gpio_request(gpio_wp, "mmc write protect");
> + ? ? ? if (err)
> + ? ? ? ? ? ? ? goto err_request_wp;
> + ? ? ? gpio_direction_input(gpio_wp);
> +
> + ? ? ? err = request_irq(cd_irq, mxm_8x10_detect_int,
> + ? ? ? ? ? ? ? ? ? ? ? ? IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> + ? ? ? ? ? ? ? ? ? ? ? ? "MMC card detect", data);
> + ? ? ? if (err) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "%s: MMC/SD/SDIO: "
> + ? ? ? ? ? ? ? ? ? ? ?"can't request card detect IRQ\n", __func__);
> + ? ? ? ? ? ? ? goto err_request_irq;
> + ? ? ? }
> +
> + ? ? ? return 0;
> +
> +err_request_irq:
> + ? ? ? gpio_free(gpio_wp);
> +err_request_wp:
> + ? ? ? gpio_free(gpio_cd);
> +err_request_cd:
> + ? ? ? return err;
> +}
> +
> +static void mxm_8x10_mci_exit(struct device *dev, void *data)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? int cd_irq, gpio_cd, gpio_wp;
> +
> + ? ? ? cd_irq = gpio_to_irq(xpc8100_mmc_slot[pdev->id].gpio_cd);
> + ? ? ? gpio_cd = mxm_8x10_mmc_slot[pdev->id].gpio_cd;
> + ? ? ? gpio_wp = mxm_8x10_mmc_slot[pdev->id].gpio_wp;
> +
> + ? ? ? free_irq(cd_irq, data);
> + ? ? ? gpio_free(gpio_cd);
> + ? ? ? gpio_free(gpio_wp);
> +}
> +
> +static struct pxamci_platform_data mxm_8x10_mci_platform_data = {
> + ? ? ? .detect_delay = 20,
> + ? ? ? .ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
> + ? ? ? .init = mxm_8x10_mci_init,
> + ? ? ? .exit = mxm_8x10_mci_exit,
> + ? ? ? .get_ro = mxm_8x10_mci_ro,

We now have .gpio_card_detect, .gpio_card_ro and .gpio_power, please
use these to simplify the above code.

> +};
> +
> +static struct pxamci_platform_data mxm_8x10_mci2_platform_data = {
> + ? ? ? .detect_delay = 20,
> + ? ? ? .ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34,
> +};
> +
> +void __init mxm_8x10_mmc_init(void)
> +{
> + ? ? ? /* Seems a bit insane - GPIO1 and GPIO5 has nothing to do with MMC
> + ? ? ? ?* according to the docs, but they are used here as Card Detect and
> + ? ? ? ?* Write Protect. What is going on on pins 72 and 83?
> + ? ? ? ?* Note: Embedian docs say that SD-Card does not work under linux.
> + ? ? ? ?*/
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO1, 0xa0c0); ? ? ? ?/* Card Detect */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO5, 0x00c3); ? ? ? ?/* Write Protect */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO18, 0xa0c0); ? ? ? /* SD_DATA0 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO19, 0xa0c0); ? ? ? /* SD_DATA1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO20, 0xa0c0); ? ? ? /* SD_DATA2 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO21, 0xa0c0); ? ? ? /* SD_DATA3 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO22, 0xa0c0); ? ? ? /* SD_CLK */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO23, 0xa0c0); ? ? ? /* SD_CMD */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO72, 0x1c01); ? ? ? /* SD_WP */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO83, 0xa0c0); ? ? ? /* SD_CD_nIRQ */
> +
> + ? ? ? /* MMC card detect & write protect for controller 0 */
> + ? ? ? mxm_8x10_mmc_slot[0].gpio_cd = mfp_to_gpio(MFP_PIN_GPIO1);
> + ? ? ? mxm_8x10_mmc_slot[0].gpio_wp = mfp_to_gpio(MFP_PIN_GPIO5);
> +
> + ? ? ? pxa_set_mci_info(&mxm_8x10_mci_platform_data);
> + ? ? ? pxa3xx_set_mci2_info(&mxm_8x10_mci2_platform_data);
> + ? ? ? if (cpu_is_pxa310())
> + ? ? ? ? ? ? ? pxa3xx_set_mci3_info(&mxm_8x10_mci_platform_data);
> +}
> +#else
> +inline void mxm_8x10_mmc_init(void)
> +{
> +}
> +#endif
> +
> +/* USB Open Host Controler Interface */
> +static struct pxaohci_platform_data mxm_8x10_ohci_platform_data = {
> + ? ? ? .port_mode = PMM_NPS_MODE,
> + ? ? ? .flags = ENABLE_PORT_ALL,
> +};
> +
> +void __init mxm_8x10_usb_host_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO10, 0xa0c0); ? ? ? /* UTM_CLK */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO49, 0xa0c0); ? ? ? /* UTM_DATA0 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO50, 0xa0c0); ? ? ? /* UTM_DATA1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO51, 0xa0c0); ? ? ? /* UTM_DATA2 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO52, 0xa0c0); ? ? ? /* UTM_DATA3 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO53, 0xa0c0); ? ? ? /* UTM_DATA4 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO54, 0xa0c0); ? ? ? /* UTM_DATA5 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO55, 0xa0c0); ? ? ? /* UTM_DATA6 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO56, 0xa0c0); ? ? ? /* UTM_DATA7 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO58, 0xa0c0); ? ? ? /* UTM_RXVALID */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO59, 0xa0c0); ? ? ? /* UTM_RXACTIVE */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO60, 0xa0c0); ? ? ? /* UTM_RXERROR */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO61, 0xa0c0); ? ? ? /* UTM_OPMODE0 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO62, 0xa0c0); ? ? ? /* UTM_OPMODE1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO71, 0x1c01); ? ? ? /* USBD_INT */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO73, 0xa0c0); ? ? ? /* UTM_TXREADY */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO83, 0xa0c0); ? ? ? /* UTM_TXVALID */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO98, 0xa0c0); ? ? ? /* UTM_RESET */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO99, 0xa0c0); ? ? ? /* UTM_XCVR_SELECT */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO100, 0xa0c0); ? ? ?/* UTM_TERM_SELECT */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO101, 0xa0c0); ? ? ?/* UTM_SUSPENDM_X */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO102, 0xa0c0); ? ? ?/* UTM_LINESTATE0 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO103, 0xa0c0); ? ? ?/* UTM_LINESTATE1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO4_2, 0xc0c0); ? ? ?/* UTM_PULLUP */
> +
> + ? ? ? pxa_set_ohci_info(&mxm_8x10_ohci_platform_data);
> +}
> +
> +/* AC97 Sound Support */
> +static struct platform_device mxm_8x10_ac97_device = {
> + ? ? ? .name = "pxa2xx-ac97",
> +};
> +
> +void __init mxm_8x10_ac97_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO35, 0x0801); ? ? ? /* AC97_SDATA_IN */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO37, 0x0801); ? ? ? /* AC97_SDATA_OUT */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO38, 0x0801); ? ? ? /* AC97_SYNC */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO39, 0x0801); ? ? ? /* AC97_BITCLK */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO40, 0x0801); ? ? ? /* AC97_nRESET */
> +
> + ? ? ? platform_device_register(&mxm_8x10_ac97_device);
> +}
> +
> +/* NAND flash Support */
> +#if defined(CONFIG_MTD_NAND_PXA3xx) || defined(CONFIG_MTD_NAND_PXA3xx_MODULE)
> +#define NAND_BLOCK_SIZE SZ_128K
> +#define NB(x) ? ? ? ? ? (NAND_BLOCK_SIZE * (x))
> +struct mtd_partition mxm_8x10_nand_partitions[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ?.name = "boot",
> + ? ? ? ? ? ? ?.size = NB(0x002),
> + ? ? ? ? ? ? ?.offset = NB(0x000),
> + ? ? ? ? ? ? ?.mask_flags = MTD_WRITEABLE,
> + ? ? ? ? ? ? ?},
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ?.name = "kernel",
> + ? ? ? ? ? ? ?.size = NB(0x010),
> + ? ? ? ? ? ? ?.offset = NB(0x002),
> + ? ? ? ? ? ? ?.mask_flags = MTD_WRITEABLE,
> + ? ? ? ? ? ? ?},
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ?.name = "root",
> + ? ? ? ? ? ? ?.size = NB(0x36c),
> + ? ? ? ? ? ? ?.offset = NB(0x012),
> + ? ? ? ? ? ? ?},
> + ? ? ? [3] = {
> + ? ? ? ? ? ? ?.name = "bbt",
> + ? ? ? ? ? ? ?.size = NB(0x082),
> + ? ? ? ? ? ? ?.offset = NB(0x37e),
> + ? ? ? ? ? ? ?.mask_flags = MTD_WRITEABLE,
> + ? ? ? ? ? ? ?},
> +};
> +
> +static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
> + ? ? ? .enable_arbiter = 1,
> + ? ? ? .keep_config = 1,
> + ? ? ? .parts = mxm_8x10_nand_partitions,
> + ? ? ? .nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions),
> +};
> +
> +void __init mxm_8x10_nand_init(void)
> +{
> + ? ? ? pxa3xx_set_nand_info(&mxm_8x10_nand_info);
> +}
> +#else
> +inline mxm_8x10_nand_init(void)
> +{
> +}
> +#endif /* CONFIG_MTD_NAND_PXA3xx || CONFIG_MTD_NAND_PXA3xx_MODULE */
> +
> +/* Ethernet support: Davicom DM9000 */
> +int gpio_eth_irq;
> +
> +static struct resource dm9k_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ?.start = MXM_8X10_ETH_PHYS + 0x300,
> + ? ? ? ? ? ? ?.end = MXM_8X10_ETH_PHYS + 0x300,
> + ? ? ? ? ? ? ?.flags = IORESOURCE_MEM,
> + ? ? ? ? ? ? ?},
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ?.start = MXM_8X10_ETH_PHYS + 0x308,
> + ? ? ? ? ? ? ?.end = MXM_8X10_ETH_PHYS + 0x308,
> + ? ? ? ? ? ? ?.flags = IORESOURCE_MEM,
> + ? ? ? ? ? ? ?},
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ?.start = -1, ? ? /* for run-time assignment */
> + ? ? ? ? ? ? ?.end = -1,
> + ? ? ? ? ? ? ?.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
> + ? ? ? ? ? ? ?}
> +};
> +
> +static struct dm9000_plat_data dm9k_plat_data = {
> + ? ? ? .flags = DM9000_PLATF_16BITONLY,
> +};
> +
> +static struct platform_device dm9k_device = {
> + ? ? ? .name = "dm9000",
> + ? ? ? .id = 0,
> + ? ? ? .num_resources = ARRAY_SIZE(dm9k_resources),
> + ? ? ? .resource = dm9k_resources,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &dm9k_plat_data,
> + ? ? ? ? ? ? ? }
> +};
> +
> +void __init mxm_8x10_ethernet_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO1, 0xa0c0); ? ? ? ?/* DM9000_PWR ? */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO9, 0xa0c0); ? ? ? ?/* DM9000_nIRQ */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO36, 0xc0c0); ? ? ? /* DM9000_RESET */
> +
> + ? ? ? gpio_eth_irq = mfp_to_gpio(MFP_PIN_GPIO9);

This is hardcoded, why leave this for run-time assignment? You can just make
this into the resource definition of dm9000.

> +
> + ? ? ? dm9k_resources[2].start = gpio_to_irq(gpio_eth_irq);
> + ? ? ? dm9k_resources[2].end = gpio_to_irq(gpio_eth_irq);
> + ? ? ? platform_device_register(&dm9k_device);
> +}
> +
> +/* PXA UARTs */
> +static void __init mxm_8x10_uarts_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO41, 0x08a2); ? ? ? /* UART_RXD1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO42, 0x0882); ? ? ? /* UART_TXD1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO43, 0x0882); ? ? ? /* UART_CTS1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO44, 0x0882); ? ? ? /* UART_DCD1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO45, 0x08a2); ? ? ? /* UART_DSR1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO46, 0x0882); ? ? ? /* UART_nRI1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO47, 0x0882); ? ? ? /* UART_DTR1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO48, 0x0882); ? ? ? /* UART_RTS1 */
> +
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO109, 0x0801); ? ? ?/* UART_RTS2 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO110, 0x0801); ? ? ?/* UART_RXD2 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO111, 0x0801); ? ? ?/* UART_TXD2 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO112, 0x0801); ? ? ?/* UART_nCTS2 */
> +
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO105, 0x0801); ? ? ?/* UART_nCTS3 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO106, 0x0801); ? ? ?/* UART_nRTS3 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO107, 0x0801); ? ? ?/* UART_TXD3 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO108, 0x0801); ? ? ?/* UART_RXD3 */
> +
> + ? ? ? pxa_set_ffuart_info(NULL);
> + ? ? ? pxa_set_btuart_info(NULL);
> + ? ? ? pxa_set_stuart_info(NULL);
> +}
> +
> +/* Backlight, LCD and Frame-Buffer */
> +#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> +int gpio_backlight;
> +
> +int lcd_id;
> +int lcd_orientation;
> +
> +#define NUM_LCD_DETECT_PINS ? ?7
> +
> +static int lcd_detect_pins[] __initdata = {
> + ? ? ? MFP_PIN_GPIO72, ? ? ? ? /* LCD_LDD_17 - ORIENT */
> + ? ? ? MFP_PIN_GPIO71, ? ? ? ? /* LCD_LDD_16 - LCDID[5] */
> + ? ? ? MFP_PIN_GPIO17_2, ? ? ? /* LCD_BIAS ? - LCDID[4] */
> + ? ? ? MFP_PIN_GPIO15_2, ? ? ? /* LCD_LCLK ? - LCDID[3] */
> + ? ? ? MFP_PIN_GPIO14_2, ? ? ? /* LCD_FCLK ? - LCDID[2] */
> + ? ? ? MFP_PIN_GPIO73, ? ? ? ? /* LCD_CS_N ? - LCDID[1] */
> + ? ? ? MFP_PIN_GPIO74, ? ? ? ? /* LCD_VSYNC ?- LCDID[0] */
> + ? ? ? /*
> + ? ? ? ?* set the MFP_PIN_GPIO 14/15/17 to alternate function other than
> + ? ? ? ?* GPIO to avoid input level confliction with 14_2, 15_2, 17_2
> + ? ? ? ?*/
> + ? ? ? MFP_PIN_GPIO14,
> + ? ? ? MFP_PIN_GPIO15,
> + ? ? ? MFP_PIN_GPIO17,
> +};
> +
> +static int lcd_detect_mfpr[] __initdata = {
> + ? ? ? /* AF0, DS 1X, Pull Neither, Edge Clear */
> + ? ? ? 0x8440, 0x8440, 0x8440, 0x8440, 0x8440, 0x8440, 0x8440,
> + ? ? ? 0xc442, ? ? ? ? ? ? ? ? /* Backlight, Pull-Up, AF2 */
> + ? ? ? 0x8445, ? ? ? ? ? ? ? ? /* AF5 */
> + ? ? ? 0x8445, ? ? ? ? ? ? ? ? /* AF5 */
> +};
> +
> +static void __init mxm_8x10_detect_lcd_panel(void)
> +{
> + ? ? ? unsigned long mfpr_save[ARRAY_SIZE(lcd_detect_pins)];
> + ? ? ? int i, gpio, id = 0;
> +
> + ? ? ? /* save the original MFP settings of these pins and configure them
> + ? ? ? ?* as GPIO Input, DS01X, Pull Neither, Edge Clear
> + ? ? ? ?*/
> + ? ? ? for (i = 0; i < ARRAY_SIZE(lcd_detect_pins); i++) {
> + ? ? ? ? ? ? ? mfpr_save[i] = pxa3xx_mfp_read(lcd_detect_pins[i]);
> + ? ? ? ? ? ? ? pxa3xx_mfp_write(lcd_detect_pins[i], lcd_detect_mfpr[i]);
> + ? ? ? }
> +
> + ? ? ? for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
> + ? ? ? ? ? ? ? id = id << 1;
> + ? ? ? ? ? ? ? gpio = mfp_to_gpio(lcd_detect_pins[i]);
> + ? ? ? ? ? ? ? gpio_request(gpio, "LCD_ID_PINS");
> + ? ? ? ? ? ? ? gpio_direction_input(gpio);
> +
> + ? ? ? ? ? ? ? if (gpio_get_value(gpio))
> + ? ? ? ? ? ? ? ? ? ? ? id = id | 0x1;
> + ? ? ? ? ? ? ? gpio_free(gpio);
> + ? ? ? }
> +
> + ? ? ? /* lcd id, flush out bit 1 */
> + ? ? ? lcd_id = id & 0x3d;
> +
> + ? ? ? /* lcd orientation, portrait or landscape */
> + ? ? ? lcd_orientation = (id >> 6) & 0x1;
> +
> + ? ? ? printk(KERN_INFO "%s: lcd_id = %d, orientation = %d \n", __func__,
> + ? ? ? ? ? ? ?lcd_id, lcd_orientation);
> +
> + ? ? ? /* restore the original MFP settings */
> + ? ? ? for (i = 0; i < ARRAY_SIZE(lcd_detect_pins); i++)
> + ? ? ? ? ? ? ? pxa3xx_mfp_write(lcd_detect_pins[i], mfpr_save[i]);
> +}

Errrr.... this is AFAIK specific to zylonite, unless this MXM-8x10 is using
the same mechansim to differentiate between multiple LCD panels and oritenation?

> +
> +static void mxm_8x10_backlight_power(int on)
> +{
> + ? ? ? gpio_set_value(gpio_backlight, on);
> +}
> +
> +static struct pxafb_mode_info toshiba_ltm04c380k_mode = {
> + ? ? ? .pixclock = 30000,
> + ? ? ? .xres = 640,
> + ? ? ? .yres = 480,
> + ? ? ? .bpp = 16,
> + ? ? ? .hsync_len = 40,
> + ? ? ? .left_margin = 128,
> + ? ? ? .right_margin = 24,
> + ? ? ? .vsync_len = 3,
> + ? ? ? .upper_margin = 28,
> + ? ? ? .lower_margin = 9,
> + ? ? ? .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +};
> +
> +static struct pxafb_mach_info mxm_8x10_toshiba_lcd_info = {
> + ? ? ? .num_modes = 1,
> + ? ? ? .lccr0 = LCCR0_Act,
> + ? ? ? .lccr3 = LCCR3_PCP,
> + ? ? ? .pxafb_backlight_power = mxm_8x10_backlight_power,
> +};
> +
> +void __init mxm_8x10_lcd_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO6_2, 0x1c01); ? ? ?/* LDD0 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO7_2, 0x1c01); ? ? ?/* LDD1 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO8_2, 0x1c01); ? ? ?/* LDD2 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO9_2, 0x1c01); ? ? ?/* LDD3 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO10_2, 0x1c01); ? ? /* LDD4 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO11_2, 0x1c01); ? ? /* LDD5 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO12_2, 0x1c01); ? ? /* LDD6 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO13_2, 0x1c01); ? ? /* LDD7 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO63, 0x1c01); ? ? ? /* LDD8 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO64, 0x1c01); ? ? ? /* LDD9 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO65, 0x1c01); ? ? ? /* LDD10 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO66, 0x1c01); ? ? ? /* LDD11 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO67, 0x1c01); ? ? ? /* LDD12 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO68, 0x1c01); ? ? ? /* LDD13 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO69, 0x1c01); ? ? ? /* LDD14 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO70, 0x1c01); ? ? ? /* LDD15 */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO14_2, 0x1c01); ? ? /* VSYNC */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO15_2, 0x1c01); ? ? /* HSYNC */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO16_2, 0x1c01); ? ? /* VCLK */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO17_2, 0x1c01); ? ? /* HCLK */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO88, 0xa0c0); ? ? ? /* VCCLCD_PWREN */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO104, 0xc0c0); ? ? ?/* LCD_PWREN */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO97, 0xa0c0); ? ? ? /* BACKLIGHT_EN */
> +
> + ? ? ? gpio_backlight = mfp_to_gpio(MFP_PIN_GPIO14);
> +
> + ? ? ? mxm_8x10_detect_lcd_panel();
> +
> + ? ? ? /* backlight GPIO: output, default on */
> + ? ? ? gpio_direction_output(gpio_backlight, 1);
> +
> + ? ? ? mxm_8x10_toshiba_lcd_info.modes = &toshiba_ltm04c380k_mode;
> + ? ? ? set_pxa_fb_info(&mxm_8x10_toshiba_lcd_info);
> +}
> +#else
> +inline void mxm_8x10_lcd_init(void)
> +{
> +}
> +#endif
> +
> +/* I2C and Real Time Clock */
> +static struct i2c_board_info __initdata mxm_8x10_i2c_devices[] = {
> + ? ? ? {
> + ? ? ? ?I2C_BOARD_INFO("ds1337", 0x68),
> + ? ? ? ?},
> +};
> +
> +void __init mxm_8x10_i2c_init(void)
> +{
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO32, 0x4981); ? ? ? /* I2CSCL */
> + ? ? ? pxa3xx_mfp_write(MFP_PIN_GPIO33, 0x4981); ? ? ? /* I2CSDA */
> +
> + ? ? ? i2c_register_board_info(0, mxm_8x10_i2c_devices,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(mxm_8x10_i2c_devices));
> + ? ? ? pxa_set_i2c_info(NULL);
> +}
> +
> +void __init mxm_8x10_barebones_init(void)
> +{
> + ? ? ? mxm_8x10_uarts_init();
> + ? ? ? mxm_8x10_nand_init();
> + ? ? ? mxm_8x10_i2c_init();
> + ? ? ? mxm_8x10_ethernet_init();
> +}
>

Giving the structure, I don't think zylonite is good reference, maybe you
can take a look into colibri-pxa3* as well. The problem with zylonite is
only one machine ID is registered while supporting both pxa300 and pxa320,
we should really register two instead of one, and make the base board as
common shared code.
