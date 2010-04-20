From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 20 Apr 2010 11:35:42 -0500
Subject: [PATCH v4 2/2] ep93xx: SPI driver platform support code
In-Reply-To: <509a89ad62001de9de23129b4c34148aef28ef19.1271774845.git.mika.westerberg@iki.fi>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<509a89ad62001de9de23129b4c34148aef28ef19.1271774845.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B0270842697636D7F4D41@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 20, 2010 8:12 AM, Mika Westerberg wrote:
>
> This patch adds platform side support code for EP93xx SPI driver. This includes
> clock, resources and muxing. There is a new function: ep93xx_register_spi() that
> can be used by board support code to register new SPI devices for the board.
>
> This patch depends on following ARM patch:
> 	5998/1 ep93xx: added chip revision reading function
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>

Mika,

This is looking really good.  A couple comments below.

> ---
>  arch/arm/mach-ep93xx/clock.c                    |   14 +++++++
>  arch/arm/mach-ep93xx/core.c                     |   48 +++++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h    |    2 +
>  4 files changed, 65 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 5f80092..5986fae 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -96,6 +96,10 @@ static struct clk clk_keypad = {
>  	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
>  	.set_rate	= set_keytchclk_rate,
>  };
> +static struct clk clk_spi = {
> +	.parent		= &clk_xtali,
> +	.rate		= EP93XX_EXT_CLK_RATE,

Good.

> +};
>  static struct clk clk_pwm = {
>  	.parent		= &clk_xtali,
>  	.rate		= EP93XX_EXT_CLK_RATE,
> @@ -186,6 +190,7 @@ static struct clk_lookup clocks[] = {
>  	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
>  	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
>  	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
> +	INIT_CK("ep93xx-spi",		NULL,		&clk_spi),

Comment on this farther below...

>  	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
>  	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
>  	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
> @@ -473,6 +478,14 @@ static int __init ep93xx_clock_init(void)
>  	/* Initialize the pll2 derived clocks */
>  	clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
>  
> +	/*
> +	 * EP93xx SSP clock rate was doubled in version E2. For more information
> +	 * see:
> +	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> +	 */
> +	if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
> +		clk_spi.rate /= 2;

Good.

> +
>  	pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
>  		clk_pll1.rate / 1000000, clk_pll2.rate / 1000000);
>  	pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
> @@ -480,6 +493,7 @@ static int __init ep93xx_clock_init(void)
>  		clk_p.rate / 1000000);
>  
>  	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
> +
>  	return 0;
>  }
>  arch_initcall(ep93xx_clock_init);
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 90fb591..e237309 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -35,6 +35,7 @@
>  #include <mach/hardware.h>
>  #include <mach/fb.h>
>  #include <mach/ep93xx_keypad.h>
> +#include <mach/ep93xx_spi.h>
>  
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> @@ -363,6 +364,53 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
>  	platform_device_register(&ep93xx_eth_device);
>  }
>  
> +static struct ep93xx_spi_info ep93xx_spi_master_data;
> +
> +static struct resource ep93xx_spi_resources[] = {
> +	{
> +		.start	= EP93XX_SPI_PHYS_BASE,
> +		.end	= EP93XX_SPI_PHYS_BASE + 0x18 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= IRQ_EP93XX_SSP,
> +		.end	= IRQ_EP93XX_SSP,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device ep93xx_spi_device = {
> +	.name		= "ep93xx-spi",
> +	.id		= -1,

This field is normally copied to the 'master->bus_num' field in the spi driver.  In
the API a -1 bus_num indicates a dynamically assigned bus ID.  It would probably be
cleaner to set the id here to 0 and change the line in the driver from:

+	master->bus_num = 0;

To

+	master->bus_num = pdev->id;

This will change the dev_id for the spi clock to 'ep93xx-spi.0' so the INIT_CK above
will need to be changed also.

> +	.dev		= {
> +		.platform_data = &ep93xx_spi_master_data,
> +	},
> +	.num_resources	= ARRAY_SIZE(ep93xx_spi_resources),
> +	.resource	= ep93xx_spi_resources,
> +};
> +
> +/**
> + * ep93xx_register_spi() - registers spi platform device
> + * @info: ep93xx board specific spi master info (__initdata)
> + *
> + * This function registers platform device for the EP93xx SPI controller and
> + * also makes sure that SPI pins are muxed so that I2S is not using those
> + * pins. Caller should allocate necessary GPIO lines and register any SPI
> + * devices before calling this (see also spi_register_board_info()).

It will be a bit cleaner to just pass the spi_board_info to this function and
do the spi_register_board_info here.  Look at the ep93xx_register_i2c function.

> + *
> + * Returns %0 in success and negative value in case of failure.
> + */
> +int __init ep93xx_register_spi(struct ep93xx_spi_info *info)

I'm not sure if the return value is necessary since this is all during init.
None of the other registration routines bother checking the platform_device_register
return value.  You can probably just drop it here and make this a 'void'

> +{
> +	/*
> +	 * When SPI is used, we need to make sure that I2S is muxed off from
> +	 * SPI pins.
> +	 */
> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONSSP);
> +
> +	ep93xx_spi_master_data = *info;
> +	return platform_device_register(&ep93xx_spi_device);
> +}
>  
>  /*************************************************************************
>   * EP93xx i2c peripheral handling
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index 93e2ecc..b1e096f 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -106,6 +106,7 @@
>  
>  #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
>  
> +#define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
>  #define EP93XX_SPI_BASE			EP93XX_APB_IOMEM(0x000a0000)
>  
>  #define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index c6dc14d..5816581 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -9,6 +9,7 @@ struct i2c_board_info;
>  struct platform_device;
>  struct ep93xxfb_mach_info;
>  struct ep93xx_keypad_platform_data;
> +struct ep93xx_spi_info;
>  
>  struct ep93xx_eth_data
>  {
> @@ -34,6 +35,7 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
>  }
>  
>  void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
> +int ep93xx_register_spi(struct ep93xx_spi_info *info);
>  void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
>  			 struct i2c_board_info *devices, int num);
>  void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
