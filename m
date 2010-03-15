From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 15 Mar 2010 14:05:38 -0500
Subject: [spi-devel-general] [PATCH 3/3] ep93xx: SPI driver platform
	support	code
In-Reply-To: <7346460bf58ddd90037e92e70f44e60df64540fe.1268669236.git.mika.westerberg@iki.fi>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<7346460bf58ddd90037e92e70f44e60df64540fe.1268669236.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B02708426976368533454@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 15, 2010 9:26 AM, Mika Westerberg wrote:
> This patch adds platform side support code for EP93xx SPI driver. This
> includes clock, resources and muxing. There is a new function:
> ep93xx_register_spi() that can be used by board support code to
> register new SPI devices for the board.
>
> Patch depends on the previous patch which adds function ep93xx_chip_revision().
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>

Mika,

Some initial comments.

> ---
>  arch/arm/mach-ep93xx/clock.c                    |   21 +++++++++++
>  arch/arm/mach-ep93xx/core.c                     |   42 +++++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h    |    2 +
>  4 files changed, 66 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 5f80092..1dc22cc 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -100,6 +100,10 @@ static struct clk clk_pwm = {
>  	.parent		= &clk_xtali,
>  	.rate		= EP93XX_EXT_CLK_RATE,
>  };
> +static struct clk clk_spi = {
> +	.parent		= &clk_xtali,
> +	.rate		= EP93XX_EXT_CLK_RATE / 2,
> +};

Please put the clk_spi before the clk_pwm.
 
>  static struct clk clk_video = {
>  	.sw_locked	= 1,
> @@ -187,6 +191,7 @@ static struct clk_lookup clocks[] = {
>  	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
>  	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
>  	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
> +	INIT_CK(NULL,			"spi_clk",	&clk_spi),

Ditto.

Also, change the init so we can use dev_id matching.

+	INIT_CLK("ep93xx-spi",		NULL,		&clk_spi),

>  	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
>  	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
>  	INIT_CK(NULL,			"m2p2",		&clk_m2p2),
> @@ -480,6 +485,22 @@ static int __init ep93xx_clock_init(void)
>  		clk_p.rate / 1000000);
>  
>  	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
> +
> +	/*
> +	 * EP93xx SSP clock rate was doubled in version E2 and forwards. For
> +	 * more information see:
> +	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> +	 */
> +	if (ep93xx_chip_revision() >= EP93XX_CHIP_REV_E2) {
> +		struct clk *clk;
> +
> +		clk = clk_get(NULL, "spi_clk");
> +		if (!IS_ERR(clk)) {
> +			clk->rate *= 2;
> +			clk_put(clk);
> +		}
> +	}
> +

Please move this block before the pr_info's.

Also, no need to use clk_get/clk_put.  Just do:

+	if (ep93xx_chip_revision() >= EP93XX_CHIP_REV_E2)
+		clk_spi.rate *= 2;

>  	return 0;
>  }
>  arch_initcall(ep93xx_clock_init);
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 2e496c9..36a7833 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -31,6 +31,7 @@
>  #include <linux/amba/serial.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
> +#include <linux/clk.h>

Is this include necessary?

>  
>  #include <mach/hardware.h>
>  #include <mach/fb.h>
> @@ -389,6 +390,47 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
>  	platform_device_register(&ep93xx_eth_device);
>  }
>  
> +static struct resource ep93xx_spi_resources[] = {
> +	{
> +		.start	= EP93XX_SPI_PHYS_BASE,
> +		.end	= EP93XX_SPI_PHYS_BASE + SZ_4K - 1,

The spi resource is only + 0x18 - 1.

> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= IRQ_EP93XX_SSP,

Please add the .end value also:

+		.end		= IRQ_EP93XX_SSP,

> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device ep93xx_spi_device = {
> +	.name		= "ep93xx-spi",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(ep93xx_spi_resources),
> +	.resource	= ep93xx_spi_resources,
> +};
> +
> +/**
> + * ep93xx_register_spi() - registers spi platform device
> + * @info: ep93xx board specific spi info
> + *
> + * This function registers platform device for the EP93xx SPI controller and
> + * also makes sure that SPI pins are muxed so that I2S is not using those
> + * pins. Caller should allocate necessary GPIO lines and register any SPI
> + * devices before calling this (see also spi_register_board_info()).
> + *
> + * Returns %0 in success and negative value in case of failure.
> + */
> +int __init ep93xx_register_spi(struct ep93xx_spi_info *info)
> +{
> +	/*
> +	 * When SPI is used, we need to make sure that I2S is muxed off from
> +	 * SPI pins.
> +	 */
> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONSSP);
> +
> +	ep93xx_spi_device.dev.platform_data = info;
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
> index 8603837..1f02147 100644
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
> @@ -49,6 +50,7 @@ void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
>  			 struct i2c_board_info *devices, int num);
>  void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
>  void ep93xx_register_pwm(int pwm0, int pwm1);
> +int ep93xx_register_spi(struct ep93xx_spi_info *info);

Please move this up, above ep93xx_register_i2c, to match how it is in the
core.c file.

>  int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
>  void ep93xx_pwm_release_gpio(struct platform_device *pdev);
>  void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
