From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 17 Apr 2012 20:53:24 +0200
Subject: [patch 1/1] kirkwood: Add iconnect support
In-Reply-To: <20120417142710.GF15711@titan.lakedaemon.net> (Jason Cooper's
 message of "Tue, 17 Apr 2012 10:27:10 -0400")
References: <20120416220505.002573737@rtp-net.org>
 <20120416221210.088620090@rtp-net.org>
 <20120417142710.GF15711@titan.lakedaemon.net>
Message-ID: <8762cyyyu3.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> On Tue, Apr 17, 2012 at 12:05:06AM +0200, Arnaud Patard wrote:
>> Add support for Iomega Iconnect system.
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>
> Thanks for the patch, comments below.
>
>> Index: arm-soc/arch/arm/mach-kirkwood/Kconfig
>> ===================================================================
>> --- arm-soc.orig/arch/arm/mach-kirkwood/Kconfig	2012-04-16 08:50:58.321398110 +0200
>> +++ arm-soc/arch/arm/mach-kirkwood/Kconfig	2012-04-16 14:07:10.440563405 +0200
>> @@ -58,6 +58,12 @@ config MACH_DREAMPLUG_DT
>>  	  Say 'Y' here if you want your kernel to support the
>>  	  Marvell DreamPlug (Flattened Device Tree).
>>  
>> +config MACH_ICONNECT_DT
>> +	bool "Iomega Iconnect (Flattened Device Tree)"
>> +	select ARCH_KIRKWOOD_DT
>> +	help
>> +	  Say 'Y' here to enable Iomega Iconnect support.
>> +
>>  config MACH_TS219
>>  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
>>  	help
>> Index: arm-soc/arch/arm/mach-kirkwood/Makefile
>> ===================================================================
>> --- arm-soc.orig/arch/arm/mach-kirkwood/Makefile	2012-04-16 08:50:58.349398109 +0200
>> +++ arm-soc/arch/arm/mach-kirkwood/Makefile	2012-04-16 14:04:50.660569553 +0200
>> @@ -22,3 +22,4 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup
>>  obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
>>  obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
>>  obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
>> +obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
>> Index: arm-soc/arch/arm/mach-kirkwood/board-iconnect.c
>> ===================================================================
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ arm-soc/arch/arm/mach-kirkwood/board-iconnect.c	2012-04-16 14:05:51.304566885 +0200
>> @@ -0,0 +1,187 @@
>> +/*
>> + * arch/arm/mach-kirkwood/board-iconnect.c
>> + *
>> + * Iomega i-connect Board Setup
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <linux/gpio.h>
>> +#include <linux/leds.h>
>> +#include <linux/spi/flash.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/spi/orion_spi.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/gpio_keys.h>
>> +#include <asm/mach/arch.h>
>> +#include <mach/kirkwood.h>
>> +#include "common.h"
>> +#include "mpp.h"
>> +
>> +static struct mv643xx_eth_platform_data iconnect_ge00_data = {
>> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
>> +};
>> +
>> +static struct gpio_led iconnect_led_pins[] = {
>> +	{
>> +		.name		= "led_level",
>
> This name sounds like a led attribute, not it's name.  Is it correct?
>

I know. In fact, this gpio allows to change the brightness of all leds
(either low luminosity or high luminosity). I'm not sure how to handle
it in a better way so I've reproduced what the vendor did. Better ideas
are welcomed :)

>> +		.gpio		= 41,
>> +		.default_trigger = "default-on",
>> +	}, {
>> +		.name		= "power:blue",
>> +		.gpio		= 42,
>> +		.default_trigger = "timer",
>> +	}, {
>> +		.name		= "power:red",
>> +		.gpio		= 43,
>> +	}, {
>> +		.name		= "usb1",
>> +		.gpio		= 44,
>> +	}, {
>> +		.name		= "usb2",
>> +		.gpio		= 45,
>> +	}, {
>> +		.name		= "usb3",
>> +		.gpio		= 46,
>> +	}, {
>> +		.name		= "usb4",
>> +		.gpio		= 47,
>> +	}, {
>> +		.name		= "otb",
>> +		.gpio		= 48,
>> +	},
>> +};
>
> Are usb[1-4] different hcis? are they all ehci?  what color are they?

There are 4 usb ports and each port has a (blue) led near it, that's why
they're called usb{1,2,3,4}. Will add the color for next patch version.

>
>> +
>> +#define ICONNECT_BLINK_HALF_PERIOD	100
>> +
>> +static int iconnect_blink_set(unsigned gpio, int state,
>
> __init ?
>

I don't think so. The leds-gpio driver can be module so putting it as
__init will make it unavalaible for the module.

>> +	unsigned long *delay_on, unsigned long *delay_off)
>> +{
>> +	if (delay_on && delay_off && !*delay_on && !*delay_off)
>> +		*delay_on = *delay_off = ICONNECT_BLINK_HALF_PERIOD;
>> +
>> +	switch (state) {
>> +	case GPIO_LED_NO_BLINK_LOW:
>> +	case GPIO_LED_NO_BLINK_HIGH:
>> +		orion_gpio_set_blink(gpio, 0);
>> +		gpio_set_value(gpio, state);
>> +		break;
>> +	case GPIO_LED_BLINK:
>> +		orion_gpio_set_blink(gpio, 1);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct gpio_led_platform_data iconnect_led_data = {
>> +	.leds		= iconnect_led_pins,
>> +	.num_leds	= ARRAY_SIZE(iconnect_led_pins),
>> +	.gpio_blink_set	= iconnect_blink_set,
>> +};
>> +
>> +static struct platform_device iconnect_leds = {
>> +	.name	= "leds-gpio",
>> +	.id	= -1,
>> +	.dev	= {
>> +		.platform_data	= &iconnect_led_data,
>> +	}
>> +};
>> +
>> +static unsigned int iconnect_mpp_config[] __initdata = {
>> +	MPP12_GPIO,
>> +	MPP35_GPIO,
>> +	MPP41_GPIO,
>> +	MPP42_GPIO,
>> +	MPP43_GPIO,
>> +	MPP44_GPIO,
>> +	MPP45_GPIO,
>> +	MPP46_GPIO,
>> +	MPP47_GPIO,
>> +	MPP48_GPIO,
>> +	0
>> +};
>
> Some comments here would be helpful, 41-48 are gpio_led, what are 12 and
> 35?

They're used as buttons. See gpio-keys stuff declared later.
 
>
>> +
>> +static struct i2c_board_info __initdata iconnect_board_info[] = {
>> +	{
>> +		I2C_BOARD_INFO("lm63", 0x4c),
>> +	},
>> +};
>> +
>> +static struct mtd_partition iconnect_nand_parts[] = {
>> +	{
>> +		.name = "flash",
>> +		.offset = 0,
>> +		.size = MTDPART_SIZ_FULL,
>> +	},
>> +};
>
> I was going to suggest moving the partition definitions to here, but
> once orion_nand is fdt aware, we'll specify the partitions in the dts
> anyway.

I put the partitions in the dts as it's where it'll be defined in the end.

>
> Unless someone has an objection, I say we leave the hackish commandline
> part table in the dtb and convert it in the dtb once orion_nand had
> devicetree bindings.
>
>> +
>> +/* yikes... theses are the original input buttons */
>> +/* but I'm not convinced by the sw event choices  */
>> +static struct gpio_keys_button iconnect_buttons[] = {
>> +	{
>> +		.type		= EV_SW,
>> +		.code		= SW_LID,
>> +		.gpio		= 12,
>> +		.desc		= "Reset Button",
>> +		.active_low	= 1,
>> +		.debounce_interval = 100,
>> +	}, {
>> +		.type		= EV_SW,
>> +		.code		= SW_TABLET_MODE,
>> +		.gpio		= 35,
>> +		.desc		= "OTB Button",
>> +		.active_low	= 1,
>> +		.debounce_interval = 100,
>> +	},
>> +};
>> +
>> +static struct gpio_keys_platform_data iconnect_button_data = {
>> +	.buttons	= iconnect_buttons,
>> +	.nbuttons	= ARRAY_SIZE(iconnect_buttons),
>> +};
>> +
>> +static struct platform_device iconnect_button_device = {
>> +	.name		= "gpio-keys",
>> +	.id		= -1,
>> +	.num_resources	= 0,
>> +	.dev        = {
>> +		.platform_data  = &iconnect_button_data,
>> +	},
>> +};
>> +
>> +void __init iconnect_init(void)
>> +{
>> +	kirkwood_mpp_conf(iconnect_mpp_config);
>> +	kirkwood_nand_init(ARRAY_AND_SIZE(iconnect_nand_parts), 25);
>> +	kirkwood_i2c_init();
>> +	i2c_register_board_info(0, iconnect_board_info,
>> +		ARRAY_SIZE(iconnect_board_info));
>> +
>> +	kirkwood_ehci_init();
>> +	kirkwood_ge00_init(&iconnect_ge00_data);
>> +
>> +	platform_device_register(&iconnect_button_device);
>> +	platform_device_register(&iconnect_leds);
>> +}
>> +
>> +static int __init iconnect_pci_init(void)
>> +{
>> +	if (of_machine_is_compatible("iomega,iconnect"))
>> +		kirkwood_pcie_init(KW_PCIE0);
>> +	return 0;
>> +}
>> +subsys_initcall(iconnect_pci_init);
>> +
>> Index: arm-soc/arch/arm/boot/dts/kirkwood-iconnect.dts
>> ===================================================================
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ arm-soc/arch/arm/boot/dts/kirkwood-iconnect.dts	2012-04-16 08:59:12.033376388 +0200
>> @@ -0,0 +1,26 @@
>> +/dts-v1/;
>> +
>> +/include/ "kirkwood.dtsi"
>> +
>> +/ {
>> +	model = "Iomega Iconnect";
>> +	compatible = "iomega,iconnect", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
>
> This should be "iom,iconnect-MODELNUM", "iom,iconnect", "mrvl,...
>
> And, correct elsewhere as needed.

ok. fixed.

>
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x10000000>;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200n8 earlyprintk mtdparts=orion_nand:0xc0000 at 0x0(uboot),0x20000 at 0xa0000(env),0x300000 at 0x100000(zImage),0x300000 at 0x540000(initrd),0x1f400000 at 0x980000(boot)";
>> +		linux,initrd-start = <0x4500040>;
>> +		linux,initrd-end   = <0x4800000>;
>
> does this need to be specified?  why doesn't the bootloader pass the
> initrd properly?

oh, I does give the right values. I was wondering if the system was
still booting without CONFIG_ARM_ATAG_DTB_COMPAT set and with theses
values set here.

Thanks,
Arnaud
