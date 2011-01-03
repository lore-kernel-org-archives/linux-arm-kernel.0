From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Jan 2011 21:17:56 +0100
Subject: [PATCH] ARM: imx/mx27_3ds: Add PMIC support
In-Reply-To: <1294060599-30309-1-git-send-email-fabio.estevam@freescale.com>
References: <1294060599-30309-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110103201756.GB25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jan 03, 2011 at 11:16:39AM -0200, Fabio Estevam wrote:
> MX27_3DS board has a MC13783 PMIC connected to the CSPI2 port.
> 
> Add support for the PMIC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig         |    1 +
>  arch/arm/mach-imx/mach-mx27_3ds.c |   77 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0449b80..17d2e60 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -242,6 +242,7 @@ config MACH_MX27_3DS
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_MXC_EHCI
>  	select IMX_HAVE_PLATFORM_MXC_MMC
> +	select IMX_HAVE_PLATFORM_SPI_IMX
>  	select MXC_ULPI if USB_ULPI
>  	help
>  	  Include support for MX27PDK platform. This includes specific
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index 0ee7a73..6fd0f8f 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -26,6 +26,9 @@
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
>  #include <linux/delay.h>
> +#include <linux/mfd/mc13783.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regulator/machine.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -39,6 +42,7 @@
>  
>  #define SD1_EN_GPIO (GPIO_PORTB + 25)
>  #define OTG_PHY_RESET_GPIO (GPIO_PORTB + 23)
> +#define SPI2_SS0 (GPIO_PORTD + 21)
>  
>  static const int mx27pdk_pins[] __initconst = {
>  	/* UART1 */
> @@ -87,6 +91,10 @@ static const int mx27pdk_pins[] __initconst = {
>  	PE2_PF_USBOTG_DIR,
>  	PE24_PF_USBOTG_CLK,
>  	PE25_PF_USBOTG_DATA7,
> +	/* CSPI2 */
> +	PD22_PF_CSPI2_SCLK,
> +	PD23_PF_CSPI2_MISO,
> +	PD24_PF_CSPI2_MOSI,
>  };
>  
>  static const struct imxuart_platform_data uart_pdata __initconst = {
> @@ -176,6 +184,72 @@ static int __init mx27_3ds_otg_mode(char *options)
>  }
>  __setup("otg_mode=", mx27_3ds_otg_mode);
>  
> +/* Regulators */
> +static struct regulator_consumer_supply vmmc1_consumers[] = {
> +	REGULATOR_SUPPLY("lcd_2v8", NULL),
> +};
> +
> +static struct regulator_init_data vmmc1_init = {
> +	.constraints = {
> +		.min_uV	= 2800000,
> +		.max_uV = 2800000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +	},
> +	.num_consumer_supplies = ARRAY_SIZE(vmmc1_consumers),
> +	.consumer_supplies = vmmc1_consumers,
> +};
> +
> +static struct regulator_consumer_supply vgen_consumers[] = {
> +	REGULATOR_SUPPLY("vdd_lcdio", NULL),
> +};
> +
> +static struct regulator_init_data vgen_init = {
> +	.constraints = {
> +		.min_uV	= 1800000,
> +		.max_uV = 1800000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +	},
> +	.num_consumer_supplies = ARRAY_SIZE(vgen_consumers),
> +	.consumer_supplies = vgen_consumers,
> +};
> +
> +static struct mc13783_regulator_init_data mx27_3ds_regulators[] = {
> +	{
> +		.id = MC13783_REGU_VMMC1,
> +		.init_data = &vmmc1_init,
> +	}, {
> +		.id = MC13783_REGU_VGEN,
> +		.init_data = &vgen_init,
> +	},
> +};
> +
> +/* MC13783 */
> +static struct mc13783_platform_data mc13783_pdata __initdata = {
> +	.regulators = mx27_3ds_regulators,
> +	.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
> +	.flags  = MC13783_USE_REGULATOR,
> +};
> +
> +/* SPI */
> +static int spi2_internal_chipselect[] = {SPI2_SS0};
I didn't check what CodingStyle says here, but I'd say

	... = { SPI2_SS0 };

(and maybe add a comma between 0 and }).

> +
> +static const struct spi_imx_master spi2_pdata __initconst = {
> +	.chipselect	= spi2_internal_chipselect,
> +	.num_chipselect	= ARRAY_SIZE(spi2_internal_chipselect),
> +};
> +
> +static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
> +	{
> +		.modalias	= "mc13783",
> +		.max_speed_hz	= 1000000,
> +		.bus_num	= 1,
> +		.chip_select	= 0, /* SS0 */
> +		.platform_data	= &mc13783_pdata,
> +		.irq = IRQ_GPIOC(14),
> +		.mode = SPI_CS_HIGH,
> +	},
> +};
> +
>  
>  static void __init mx27pdk_init(void)
>  {
> @@ -199,6 +273,9 @@ static void __init mx27pdk_init(void)
>  	if (!otg_mode_host)
>  		imx27_add_fsl_usb2_udc(&otg_device_pdata);
>  
> +	imx27_add_spi_imx1(&spi2_pdata);
> +	spi_register_board_info(mx27_3ds_spi_devs,
> +						ARRAY_SIZE(mx27_3ds_spi_devs));
>  }
>  
>  static void __init mx27pdk_timer_init(void)
Other than that I looks OK for me.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
