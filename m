From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 18 May 2010 13:26:50 -0500
Subject: [RFC PATCH 2/3] ep93xx i2s core support
In-Reply-To: <4BF21D74.206@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com> <4BF21D74.206@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B0270842697636F14EC3F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 17, 2010 9:54 PM, Ryan Mallon wrote:
> Add ep93xx core support for i2s audio
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 5f80092..df88233 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -108,6 +108,16 @@ static struct clk clk_video = {
>  	.set_rate	= set_div_rate,
>  };
>  
> +static struct clk clk_i2s = {
> +	.sw_locked	= 1,
> +	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
> +	.enable_mask	= (EP93XX_SYSCON_CLKDIV_ENABLE  |
> +			   EP93XX_SYSCON_I2SCLKDIV_SENA |
> +			   EP93XX_SYSCON_I2SCLKDIV_SPOL |
> +			   EP93XX_SYSCON_I2SCLKDIV_ORIDE),
> +	.set_rate	= set_div_rate,
> +};

This clock should not be enabling the slave clocks.

Not sure about the SPOL and ORIDE bits... Maybe they should be
part of the platform_data (see below) for the i2s driver.

> +
>  /* DMA Clocks */
>  static struct clk clk_m2p0 = {
>  	.parent		= &clk_h,
> @@ -186,6 +196,7 @@ static struct clk_lookup clocks[] = {
>  	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
>  	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
>  	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
> +	INIT_CK("ep93xx-i2s",		NULL,		&clk_i2s),
>  	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
>  	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
>  	INIT_CK(NULL,			"m2p1",		&clk_m2p1),


For the pseudo clocks mentioned in PATCH 1/3, how about this?

static struct clk clk_i2s = {
	.sw_locked	= 1,
	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
	.enable_mask	= EP93XX_SYSCON_CLKDIV_ENABLE,
	.set_rate	= set_i2s_rate,
};
static struct clk clk_sclk = {
	.sw_locked	= 1,
	.parent		= &clk_i2s,
	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
	.enable_mask	= EP93XX_SYSCON_I2SCLKDIV_SENA,
	.set_rate	= set_sclk_rate,
};
static struct clk clk_lrclk = {
	.sw_locked	= 1,
	.parent		= &clk_sclk,
	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
	.enable_mask	= EP93XX_SYSCON_I2SCLKDIV_SENA,
	.set_rate	= set_lrclk_rate,
};

	INIT_CK("ep93xx-i2s",		NULL,		&clk_i2s),
	INIT_CK("ep93xx-i2s",		"sclk",		&clk_sclk),
	INIT_CK("ep93xx-i2s",		"lrclk",	&clk_lrclk),

static int set_i2s_rate(struct clk *clk, unsigned long rate)
{
	u32 val;
	int ret;

	/* First set the I2S master clock to the desired rate */
	ret = set_div_rate(clk, rate);
	if (ret)
		return ret;

	/* Now update the child clock rates based on the current setting */
	val = __raw_readl(clk->enable_reg);

	if (val & EP93XX_SYSCON_I2SCLKDIV_SDIV)
		clk_sclk.rate = clk->rate / 4;
	else
		clk_sclk.rate = clk->rate / 2;

	val &= EP93XX_SYSCON_I2SCLKDIV_LRDIV_MASK;
	switch (val >> EP93XX_SYSCON_I2SCLKDIV_LRDIV_SHIFT) {
	case 0:
		clk_lrclk.rate = clk_sclk.rate / 32;
		break;
	case 1:
		clk_lrclk.rate = clk_sclk.rate / 64;
		break;
	case 2:
		clk_lrclk.rate = clk_sclk.rate / 128;
		break;
	default:
		return -EINVAL;
	}

	return 0;
}

static int set_sclk_rate(struct clk *clk, unsigned long rate)
{
	unsigned long i2s_rate = clk_get_rate(clk->parent);
	u32 val;

	val = __raw_readl(clk->enable_reg);

	if (rate == i2s_rate / 2)
		val &= ~EP93XX_SYSCON_I2SCLKDIV_SDIV;
	else if (rate == i2s_rate / 4)
		val |= EP93XX_SYSCON_I2SCLKDIV_SDIV;
	else
		return -EINVAL;

	ep93xx_syscon_swlocked_write(val, clk->enable_reg);
	clk->rate = rate;
	return 0;
}

static int set_lrclk_rate(struct clk *clk, unsigned long rate)
{
	unsigned long sclk_rate = clk_get_rate(clk->parent);
	u32 val;

	val = __raw_readl(clk->enable_reg);
	val &= ~EP93XX_SYSCON_I2SCLKDIV_LRDIV_MASK;

	if (rate == sclk_rate / 32)
		val |= 0x0 << EP93XX_SYSCON_I2SCLKDIV_LRDIV_SHIFT;
	else if (rate == sclk_rate / 64)
		val |= 0x1 << EP93XX_SYSCON_I2SCLKDIV_LRDIV_SHIFT;
	else if (rate == sclk_rate / 128)
		val |= 0x2 << EP93XX_SYSCON_I2SCLKDIV_LRDIV_SHIFT;
	else
		return -EINVAL;

	ep93xx_syscon_swlocked_write(val, clk->enable_reg);
	clk->rate = rate;
	return 0;
}

I know, it's not a patch ;-), but hopefully you get the idea.

I'm not sure about the INIT_CK definitions for the sclk and lrclk.
They might need a NULL dev_id and just get matched based on the con_id.

> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 90fb591..cceeac2 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -617,6 +617,37 @@ void ep93xx_keypad_release_gpio(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
>  
> +/*************************************************************************
> + * EP93xx I2S audio peripheral handling
> + *************************************************************************/
> +static struct resource ep93xx_i2s_resource[] = {
> +	{
> +		.start	= EP93XX_I2S_PHYS_BASE,
> +		.end	= EP93XX_I2S_PHYS_BASE + 0x100 - 1,

The last I2S register is at + 0x6C, so this should be + 0x70 - 1

> +		.flags	= IORESOURCE_MEM,
> +	},

What about the interrupt?  Is there any reason not to make the driver use it?

> +};
> +
> +static struct platform_device ep93xx_i2s_device = {
> +	.name		= "ep93xx-i2s",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(ep93xx_i2s_resource),
> +	.resource	= ep93xx_i2s_resource,

Should the dma_mask and coherent_dma_mask be defined here instead of in the
driver?

> +};
> +
> +void __init ep93xx_register_i2s(unsigned pins)
> +{
> +	if (pins != EP93XX_SYSCON_DEVCFG_I2SONSSP &&
> +	    pins != EP93XX_SYSCON_DEVCFG_I2SONAC97) {
> +		pr_err("Invalid I2S pin configuration - not registering\n");
> +		return;
> +	}
> +
> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97 |
> +				 EP93XX_SYSCON_DEVCFG_I2SONAC97);
> +	ep93xx_devcfg_set_bits(pins);
> +	platform_device_register(&ep93xx_i2s_device);
> +}

Hmm.. Not sure if the registration function is the correct place to mess with
the Syscon bits.  Since the driver "could" be built as a module it might be
better to just register the device here.

And, since the i2s port 1 use egpio[5:4] and i2s port 2 use egpio[13,6] you
probably should add an ep93xx_acquire_i2s and ep93xx_release_i2s function.

This probably needs some sort of platform_data that can be passed to the
driver to establish the configuration.  Then the acquire function can setup
the proper configuration at runtime. 

>  
>  extern void ep93xx_gpio_init(void);
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index 93e2ecc..074d99b 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -93,6 +93,7 @@
>  /* APB peripherals */
>  #define EP93XX_TIMER_BASE		EP93XX_APB_IOMEM(0x00010000)
>  
> +#define EP93XX_I2S_PHYS_BASE		EP93XX_APB_PHYS(0x00020000)
>  #define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
>  
>  #define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
> @@ -193,6 +194,10 @@
>  #define EP93XX_SYSCON_CLKDIV_ESEL	(1<<14)
>  #define EP93XX_SYSCON_CLKDIV_PSEL	(1<<13)
>  #define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
> +#define EP93XX_SYSCON_I2SCLKDIV		EP93XX_SYSCON_REG(0x8c)
> +#define EP93XX_SYSCON_I2SCLKDIV_SENA	(1<<31)
> +#define EP93XX_SYSCON_I2SCLKDIV_ORIDE   (1<<29)
> +#define EP93XX_SYSCON_I2SCLKDIV_SPOL	(1<<19)

Please reorder these a bit.

Put the *_REG define after the *_VIDCLKDIV one (since they share the *_CLKDIV_*
defines).  Then put the bit defines in decending order like the reset of the
file (i.e. the _I2SCLKDIV_* specific ones come right before the *_CLKDIV_* ones).

>  #define EP93XX_SYSCON_KEYTCHCLKDIV	EP93XX_SYSCON_REG(0x90)
>  #define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1<<31)
>  #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index c6dc14d..9252adf 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -43,6 +43,7 @@ void ep93xx_pwm_release_gpio(struct platform_device *pdev);
>  void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
>  int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
>  void ep93xx_keypad_release_gpio(struct platform_device *pdev);
> +void ep93xx_register_i2s(unsigned pins);
>  
>  void ep93xx_init_devices(void);
>  extern struct sys_timer ep93xx_timer;

I need to figure out a way to test this on the EDB9307A board.  I'll try
to get more feedback to you later.

Regards,
Hartley
