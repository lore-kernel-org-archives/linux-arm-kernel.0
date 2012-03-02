From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Fri, 2 Mar 2012 17:44:11 +0000
Subject: [PATCH] Initial Device Tree system for Snowball
In-Reply-To: <1330703567-17925-1-git-send-email-niklas.hernaeus@stericsson.com>
References: <1330703567-17925-1-git-send-email-niklas.hernaeus@stericsson.com>
Message-ID: <201203021744.12088.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Niklas Hernaeus wrote:
> From: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> 
> This is the base system for using Device Tree for Snowball.
> The new boardfile is a slightly modified copy of the original board file,
> so new Device Tree stuff can simply be added and code removed, while
> functionality stays the same.
> 
> Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>

Hi Niklas,

Great to see this has finally worked.

As Jean-Christophe already commented, we should drastically limit
the amount of code duplication between this platform and the one
that is already there. I can see two ways out of here:

a) Make sure that all hardware that was working with the
existing code still works with this one, and just replace it
(or patch it to look like what you have), mandating the use
of device tree blobs on u8500 right away. We should get there
anyway over time, so we could just as well do it now.

b) keep using your patch as a work-in-progress copy of the
existing code, but when we get to merge it into upstream make sure
that any part of it that is just duplicated either gets replaced
with a device node and associated properties, or calls the respective
function from a common location.

In any case, I would suggest you remove the platform_device definitions
for all devices and just leave the platform_data that you can pass
using the auxdata mechanism.

> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index 52af004..be7e4fe 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -27,19 +27,22 @@ menu "Ux500 target platform (boards)"
>  config MACH_U8500
>  	bool "U8500 Development platform"
>  	depends on UX500_SOC_DB8500
> +	depends on !USE_OF
>  	select TPS6105X
>  	help
>  	  Include support for the mop500 development platform.
>  
>  config MACH_HREFV60
> -       bool "U85000 Development platform, HREFv60 version"
> -       depends on UX500_SOC_DB8500
> -       help
> -         Include support for the HREFv60 new development platform.
> +	bool "U85000 Development platform, HREFv60 version"
> +	depends on UX500_SOC_DB8500
> +	depends on !USE_OF
> +	help
> +	  Include support for the HREFv60 new development platform.
>  
>  config MACH_SNOWBALL
>  	bool "U8500 Snowball platform"
>  	depends on UX500_SOC_DB8500
> +	depends on !USE_OF
>  	select MACH_U8500
>  	help
>  	  Include support for the snowball development platform.
> @@ -49,6 +52,12 @@ config MACH_U5500
>  	depends on UX500_SOC_DB5500
>  	help
>  	  Include support for the U5500 development platform.
> +config MACH_UX500_DT
> +	def_bool y if USE_OF
> +	depends on UX500_SOC_DB8500 || UX500_SOC_DB5500
> +
> +config MACH_MOP500
> +	def_bool y if MACH_U8500 || MACH_UX500_DT
>  endmenu
>  

This change conflicts with some other patches that we have been discussing
recently. I'd suggest rebasing your change on top of the others as soon
as they are merged into arm-soc/next/fixes-non-critical.

> +
> +static struct gpio_led snowball_led_array[] = {
> +	{
> +		.name = "user_led",
> +		.default_trigger = "none",
> +		.gpio = 142,
> +	},
> +};
> +
> +static struct gpio_led_platform_data snowball_led_data = {
> +	.leds = snowball_led_array,
> +	.num_leds = ARRAY_SIZE(snowball_led_array),
> +};
> +
> +static struct platform_device snowball_led_dev = {
> +	.name = "leds-gpio",
> +	.dev = {
> +		.platform_data = &snowball_led_data,
> +	},
> +};

I would prefer if we could move those devices that have binding already
into the device tree right away and leave only the ones that are missing
in the initial merge of this.

gpio-leds has bindings according to
Documentation/devicetree/bindings/gpio/led.txt

Converting those should be straightforward as soon as the gpio node
is converted. The same is true for gpio-keys.

> +static struct ab8500_gpio_platform_data ab8500_gpio_pdata = {
> +	.gpio_base		= MOP500_AB8500_GPIO(0),
> +	.irq_base		= MOP500_AB8500_VIR_GPIO_IRQ_BASE,
> +	/* config_reg is the initial configuration of ab8500 pins.
> +	 * The pins can be configured as GPIO or alt functions based
> +	 * on value present in GpioSel1 to GpioSel6 and AlternatFunction
> +	 * register. This is the array of 7 configuration settings.
> +	 * One has to compile time decide these settings. Below is the
> +	 * explanation of these setting
> +	 * GpioSel1 = 0x00 => Pins GPIO1 to GPIO8 are not used as GPIO
> +	 * GpioSel2 = 0x1E => Pins GPIO10 to GPIO13 are configured as GPIO
> +	 * GpioSel3 = 0x80 => Pin GPIO24 is configured as GPIO
> +	 * GpioSel4 = 0x01 => Pin GPIo25 is configured as GPIO
> +	 * GpioSel5 = 0x7A => Pins GPIO34, GPIO36 to GPIO39 are conf as GPIO
> +	 * GpioSel6 = 0x00 => Pins GPIO41 & GPIo42 are not configured as GPIO
> +	 * AlternaFunction = 0x00 => If Pins GPIO10 to 13 are not configured
> +	 * as GPIO then this register selectes the alternate fucntions
> +	 */
> +	.config_reg		= {0x00, 0x1E, 0x80, 0x01,
> +					0x7A, 0x00, 0x00},
> +};
> +
> +static struct smsc911x_platform_config snowball_sbnet_cfg = {
> +	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
> +	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
> +	.flags = SMSC911X_USE_16BIT | SMSC911X_FORCE_INTERNAL_PHY,
> +	.shift = 1,
> +};
> +
> +static struct resource sbnet_res[] = {
> +	{
> +		.name = "smsc911x-memory",
> +		.start = (0x5000 << 16),
> +		.end  =  (0x5000 << 16) + 0xffff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = NOMADIK_GPIO_TO_IRQ(140),
> +		.end = NOMADIK_GPIO_TO_IRQ(140),
> +		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
> +	},
> +};
> +
> +static struct platform_device snowball_sbnet_dev = {
> +	.name           = "smsc911x",
> +	.num_resources  = ARRAY_SIZE(sbnet_res),
> +	.resource       = sbnet_res,
> +	.dev            = {
> +		.platform_data = &snowball_sbnet_cfg,
> +	},
> +};

This one does not have bindings yet, so let's leave it for now.

> +static struct ab8500_platform_data ab8500_platdata = {
> +	.irq_base	= MOP500_AB8500_IRQ_BASE,
> +	.regulator_reg_init = ab8500_regulator_reg_init,
> +	.num_regulator_reg_init	= ARRAY_SIZE(ab8500_regulator_reg_init),
> +	.regulator	= ab8500_regulators,
> +	.num_regulator	= ARRAY_SIZE(ab8500_regulators),
> +	.gpio		= &ab8500_gpio_pdata,
> +};
> +
> +static struct resource ab8500_resources[] = {
> +	[0] = {
> +		.start	= IRQ_DB8500_AB8500,
> +		.end	= IRQ_DB8500_AB8500,
> +		.flags	= IORESOURCE_IRQ
> +	}
> +};
> +
> +struct platform_device ab8500_device = {
> +	.name = "ab8500-i2c",
> +	.id = 0,
> +	.dev = {
> +		.platform_data = &ab8500_platdata,
> +	},
> +	.num_resources = 1,
> +	.resource = ab8500_resources,
> +};

Converting ab8500 to device tree is key here, because almost everything
else is located below it. I'd suggest you use auxdata to replace the
get the platform_data in unmodified as a start and then change the
ab8500 mfd driver to scan its child buses.


> +#ifdef CONFIG_STE_DMA40
> +static struct stedma40_chan_cfg uart0_dma_cfg_rx = {
> +	.mode = STEDMA40_MODE_LOGICAL,
> +	.dir = STEDMA40_PERIPH_TO_MEM,
> +	.src_dev_type =  DB8500_DMA_DEV13_UART0_RX,
> +	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
> +	.src_info.data_width = STEDMA40_BYTE_WIDTH,
> +	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
> +};

It looks like the uart device could just as well work without DMA support,
right? How about leaving the dma out for now, until we have bindings for
it? That will also remove the need for platform_data in most of the uart
devices.

> +static const char * snowball_dt_board_compat[] = {
> +	"calaosystems,snowball-a9500",
> +	NULL
> +};
>
> +MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
> +	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
> +	.atag_offset	= 0x100,
> +	.map_io		= u8500_map_io,
> +	.init_irq	= ux500_init_irq,
> +	/* we re-use nomadik timer here */
> +	.timer		= &ux500_timer,
> +	.handle_irq	= gic_handle_irq,
> +	.init_machine	= mop500_init_machine,
> +MACHINE_END
> +
> +MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
> +	.atag_offset	= 0x100,
> +	.map_io		= u8500_map_io,
> +	.init_irq	= ux500_init_irq,
> +	.timer		= &ux500_timer,
> +	.handle_irq	= gic_handle_irq,
> +	.init_machine	= hrefv60_init_machine,
> +MACHINE_END
> +
> +DT_MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
> +	.atag_offset	= 0x100,
> +	.map_io		= u8500_map_io,
> +	.init_irq	= ux500_init_irq,
> +	/* we re-use nomadik timer here */
> +	.timer		= &ux500_timer,
> +	.handle_irq	= gic_handle_irq,
> +	.init_machine	= snowball_init_machine,
> +	.dt_compat      = snowball_dt_board_compat,
> +MACHINE_END

Here, you should really have only one DT_MACHINE_START for all three, and
use a common init_machine function but a dt_compat list for all three.

Inside of the init_machine function, you can use of_machine_is_compatible()
to find out which one you are on, and call the machine specific functions.

	Arnd
