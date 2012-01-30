From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 Jan 2012 13:32:52 -0700
Subject: [RFC PATCH 7/7] ARM: davinci: add support for the am1808 based
 enbw_cmc board
In-Reply-To: <1327308967-8092-8-git-send-email-hs@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-8-git-send-email-hs@denx.de>
Message-ID: <20120130203252.GX28397@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 09:56:07AM +0100, Heiko Schocher wrote:
> - AM1808 based board
> - 64 MiB DDR ram
> - 2 MiB Nor flash
> - 128 MiB NAND flash
> - use internal RTC
> - I2C support
> - hwmon lm75 support
> - UBI/UBIFS support
> - MMC support
> - USB OTG support
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-mtd at lists.infradead.org
> Cc: linux-i2c at vger.kernel.org
> Cc: netdev at vger.kernel.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> 
> ---
> - post this board support with USB support, even though
>   USB is only working with the 10 ms "workaround", posted here:
>   http://comments.gmane.org/gmane.linux.usb.general/54505
>   I see this issue also on the AM1808 TMDXEXP1808L evalboard.
> - MMC and USB are not using OF support yet, ideas how to port
>   this are welcome. I need for USB and MMC boards board
>   specific callbacks, how to solve this with OF support?
> 
>  arch/arm/boot/dts/enbw_cmc.dts                  |  286 +++++++++++++++++
>  arch/arm/configs/enbw_cmc_defconfig             |  125 ++++++++
>  arch/arm/mach-davinci/Kconfig                   |    8 +
>  arch/arm/mach-davinci/Makefile                  |    1 +
>  arch/arm/mach-davinci/board-enbw-cmc.c          |  384 +++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
>  6 files changed, 805 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/enbw_cmc.dts
>  create mode 100644 arch/arm/configs/enbw_cmc_defconfig
>  create mode 100644 arch/arm/mach-davinci/board-enbw-cmc.c
> 
> diff --git a/arch/arm/boot/dts/enbw_cmc.dts b/arch/arm/boot/dts/enbw_cmc.dts
> new file mode 100644
> index 0000000..e5995ce
> --- /dev/null
> +++ b/arch/arm/boot/dts/enbw_cmc.dts
> @@ -0,0 +1,286 @@
> +/*
> + * Device Tree for the EnBW CMC plattform
> + *
> + * Copyright 2011 DENX Software Engineering GmbH
> + * Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "EnBW CMC";
> +	compatible = "enbw,cmc";
> +
> +	aliases {
> +		ethernet0 = &eth0;
> +	};
> +
> +	arm {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0xfffee000 0x00020000>;
> +		intc: interrupt-controller at 1 {
> +			compatible = "ti,davinci-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			ti,intc-size = <101>;
> +			reg = <0x0 0x2000>;
> +		};
> +	};
> +	soc at 1c00000 {
> +		compatible = "ti,da8xx";

As previously mentioned, using wildcard ('x') characters in compatible
properties is bad practice.  Always be specific and use the compatible
list to make sure the correct driver gets bound (assuming the device
is 100% register level compatible with the older one).

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x01c00000 0x400000>;
> +
> +		serial0: serial at 1c42000 {
> +			cell-index = <2>;

As previously mentioned, don't use cell index.  If you *really* need
to assign a number to a device, then use a property in the /aliases
node and make sure pdev->id does *not* get modified.

> +			compatible = "ns16550a";

Should include a string for the specific device.  Something like:

	compatible = "ti,da800", "ns16550a";

> diff --git a/arch/arm/mach-davinci/board-enbw-cmc.c b/arch/arm/mach-davinci/board-enbw-cmc.c
> new file mode 100644
> index 0000000..4473c4a
> --- /dev/null
> +++ b/arch/arm/mach-davinci/board-enbw-cmc.c
> @@ -0,0 +1,384 @@
> +/*
> + * EnBW Communication Module Compact board
> + * Copyright 2011 DENX Software Engineering GmbH
> + * Author: Heiko Schocher <hs@denx.de>
> + *
> + * based on:
> + * TI DA850/OMAP-L138 EVM board
> + *
> + * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Derived from: arch/arm/mach-davinci/board-da850-evm.c
> + * Original Copyrights follow:
> + *
> + * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +#include <linux/console.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/of.h>
> +#include <linux/of_net.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/phy_fixed.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/flash.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/aemif.h>
> +#include <mach/cp_intc.h>
> +#include <mach/da8xx.h>
> +#include <mach/mux.h>
> +#include <mach/nand.h>
> +#include <mach/spi.h>
> +
> +#define ENBW_CMC_MMCSD_CD_PIN          GPIO_TO_PIN(3, 13)
> +
> +/*
> + * USB1 VBUS is controlled by GPIO7[12], over-current is reported on GPIO7[8].
> + */
> +#define DA850_USB_VBUS_PIN	GPIO_TO_PIN(7, 12)
> +#define ON_BD_USB_OVC		GPIO_TO_PIN(7, 8)
> +
> +#if defined(CONFIG_USB_OHCI_HCD)
> +static irqreturn_t enbw_cmc_usb_ocic_irq(int irq, void *dev_id);
> +static da8xx_ocic_handler_t enbw_cmc_usb_ocic_handler;
> +
> +static int enbw_cmc_usb_set_power(unsigned port, int on)
> +{
> +	gpio_set_value(DA850_USB_VBUS_PIN, on);
> +	return 0;
> +}
> +
> +static int enbw_cmc_usb_get_power(unsigned port)
> +{
> +	return gpio_get_value(DA850_USB_VBUS_PIN);
> +}
> +
> +static int enbw_cmc_usb_get_oci(unsigned port)
> +{
> +	return !gpio_get_value(ON_BD_USB_OVC);
> +}
> +
> +static irqreturn_t enbw_cmc_usb_ocic_irq(int, void *);
> +
> +static int enbw_cmc_usb_ocic_notify(da8xx_ocic_handler_t handler)
> +{
> +	int irq         = gpio_to_irq(ON_BD_USB_OVC);
> +	int error       = 0;
> +
> +	if (handler != NULL) {
> +		enbw_cmc_usb_ocic_handler = handler;
> +
> +		error = request_irq(irq, enbw_cmc_usb_ocic_irq,
> +					IRQF_DISABLED | IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING,
> +					"OHCI over-current indicator", NULL);
> +		if (error)
> +			pr_err("%s: could not request IRQ to watch "
> +				"over-current indicator changes\n", __func__);
> +	} else {
> +		free_irq(irq, NULL);
> +	}
> +	return error;
> +}
> +
> +static struct da8xx_ohci_root_hub enbw_cmc_usb11_pdata = {
> +	.set_power      = enbw_cmc_usb_set_power,
> +	.get_power      = enbw_cmc_usb_get_power,
> +	.get_oci        = enbw_cmc_usb_get_oci,
> +	.ocic_notify    = enbw_cmc_usb_ocic_notify,
> +	.potpgt         = (10 + 1) / 2,  /* 10 ms max */
> +};
> +
> +static irqreturn_t enbw_cmc_usb_ocic_irq(int irq, void *dev_id)
> +{
> +	enbw_cmc_usb_ocic_handler(&enbw_cmc_usb11_pdata, 1);
> +	return IRQ_HANDLED;
> +}
> +#endif
> +
> +#if defined(CONFIG_OF)
> +static __init void enbw_cmc_usb_init(void)

All the focus is on DT now.  How about making CONFIG_OF required for
this board?  Also, this is just another board file.  The focus should
be on creating a generic board support file for DT platforms.
