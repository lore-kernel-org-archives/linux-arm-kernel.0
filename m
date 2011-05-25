From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 May 2011 21:44:03 +0200
Subject: [PATCH] imx: mach-bug: add sdio platform data
In-Reply-To: <1306351943-7963-1-git-send-email-GNUtoo@no-log.org>
References: <1306351943-7963-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <20110525194403.GD22361@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Denis,

On Wed, May 25, 2011 at 09:32:23PM +0200, Denis 'GNUtoo' Carikli wrote:
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> ---
>  arch/arm/mach-imx/mach-bug.c |  106 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 106 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
> index 42e4f07..b0d1536 100644
> --- a/arch/arm/mach-imx/mach-bug.c
> +++ b/arch/arm/mach-imx/mach-bug.c
> @@ -22,6 +22,8 @@
>  #include <mach/iomux-mx3.h>
>  #include <mach/hardware.h>
>  #include <mach/common.h>
> +#include <mach/gpio.h>
> +#include <mach/mx31.h>
>  
>  #include <asm/mach/time.h>
>  #include <asm/mach/arch.h>
> @@ -40,11 +42,115 @@ static const unsigned int bug_pins[] __initconst = {
>  	MX31_PIN_PC_BVD1__RXD5,
>  };
>  
> +static int sdhc1_pins[] = {
> +	MX31_PIN_SD1_DATA3__SD1_DATA3,
> +	MX31_PIN_SD1_DATA2__SD1_DATA2,
> +	MX31_PIN_SD1_DATA1__SD1_DATA1,
> +	MX31_PIN_SD1_DATA0__SD1_DATA0,
> +	MX31_PIN_SD1_CLK__SD1_CLK,
> +	MX31_PIN_SD1_CMD__SD1_CMD,
> +};
> +
> +static int sdhc2_pins[] = {
> +	MX31_PIN_PC_PWRON__SD2_DATA3,
> +	MX31_PIN_PC_VS1__SD2_DATA2,
> +	MX31_PIN_PC_READY__SD2_DATA1,
> +	MX31_PIN_PC_WAIT_B__SD2_DATA0,
> +	MX31_PIN_PC_CD2_B__SD2_CLK,
> +	MX31_PIN_PC_CD1_B__SD2_CMD,
> +};
> +
> +static int mxc_bug_sdhc1_init(struct device *dev, irq_handler_t h, void *data)
> +{
> +	return mxc_iomux_setup_multiple_pins(sdhc1_pins, ARRAY_SIZE(sdhc1_pins),
> +					     "sdhc-1");
Why not adding these to the static list and just make init and exit
empty?

> +}
> +
> +static void mxc_bug_sdhc1_exit(struct device *dev, void *data)
> +{
> +	mxc_iomux_release_multiple_pins(sdhc1_pins, ARRAY_SIZE(sdhc1_pins));
> +}
> +
> +static int mxc_bug_sdhc2_init(struct device *dev, irq_handler_t h, void *data)
> +{
> +	return mxc_iomux_setup_multiple_pins(sdhc2_pins, ARRAY_SIZE(sdhc2_pins),
> +					     "sdhc-2");
> +}
> +
> +static void mxc_bug_sdhc2_exit(struct device *dev, void *data)
> +{
> +	mxc_iomux_release_multiple_pins(sdhc2_pins, ARRAY_SIZE(sdhc2_pins));
> +}
> +
> +/* No card and rw detection at the moment */
> +static struct imxmmc_platform_data sdhc1_pdata = {
> +	.init = mxc_bug_sdhc1_init,
> +	.exit = mxc_bug_sdhc1_exit,
> +	.ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
> +	MMC_VDD_32_33 | MMC_VDD_33_34,
Please indent this line a bit further.  Should be const and __initconst.

> +};
> +
> +static struct imxmmc_platform_data sdhc2_pdata = {
> +	.init = mxc_bug_sdhc2_init,
> +	.exit = mxc_bug_sdhc2_exit,
> +};
const and __initconst

> +
> +
one nl is enough.

> +static struct resource mxcsdhc0_resources[] = {
> +	{
> +		.start = MX31_SDHC1_BASE_ADDR,
> +		.end = MX31_SDHC1_BASE_ADDR + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = MX31_INT_SDHC1,
> +		.end = MX31_INT_SDHC1,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct resource mxcsdhc1_resources[] = {
> +	{
> +		.start = MX31_SDHC2_BASE_ADDR,
> +		.end = MX31_SDHC2_BASE_ADDR + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = MX31_INT_SDHC2,
> +		.end = MX31_INT_SDHC2,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device mxcsdhc_device0 = {
> +	.name = "mxc-mmc",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(mxcsdhc0_resources),
> +	.resource = mxcsdhc0_resources,
> +};
> +
> +struct platform_device mxcsdhc_device1 = {
> +	.name = "mxc-mmc",
> +	.id = 1,
> +	.num_resources = ARRAY_SIZE(mxcsdhc1_resources),
> +	.resource = mxcsdhc1_resources,
> +};
Nooooooooooooooooooooooooooooooooooooooo ...

> +
>  static void __init bug_board_init(void)
>  {
>  	mxc_iomux_setup_multiple_pins(bug_pins,
>  				      ARRAY_SIZE(bug_pins), "uart-4");
>  	imx31_add_imx_uart4(&uart_pdata);
> +
> +	/* Turn off Wifi by default */
> +	if ( !mxc_iomux_alloc_pin(
> +		IOMUX_MODE(MX31_PIN_USB_BYP, IOMUX_CONFIG_GPIO), "bug-wifi")
> +		){
> +		if (!gpio_request(IOMUX_TO_GPIO(MX31_PIN_USB_BYP),
> +				   "bug-wifi"))
> +			gpio_direction_output(IOMUX_TO_GPIO(
> +						      MX31_PIN_USB_BYP), 0);
> +	}
> +	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
imx31_add_mxc_mmc(0, &sdhc1_pdata); please
> +	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
>  }
>  
>  static void __init bug_timer_init(void)
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
