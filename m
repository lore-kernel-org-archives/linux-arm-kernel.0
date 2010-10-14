From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 14 Oct 2010 16:46:58 -0500
Subject: [PATCH v3 2/3] ARM: ep93xx: add AC97 platform support
In-Reply-To: <14a8c7ea0482375fa32a022ea7e318ea4feae6f1.1287066937.git.mika.westerberg@iki.fi>
References: <cover.1287066937.git.mika.westerberg@iki.fi>
	<14a8c7ea0482375fa32a022ea7e318ea4feae6f1.1287066937.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B02708426976450C42B0E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 14, 2010 7:49 AM, Mika Westerberg wrote:
>
> Add platform support for the EP93xx AC97 controller driver.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  arch/arm/mach-ep93xx/core.c                     |   34 +++++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
>  3 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 1990e22..ffdf87b 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -832,6 +832,40 @@ void ep93xx_i2s_release(void)
>  }
>  EXPORT_SYMBOL(ep93xx_i2s_release);
>  
> +/*************************************************************************
> + * EP93xx AC97 audio peripheral handling
> + *************************************************************************/
> +static struct resource ep93xx_ac97_resources[] = {
> +	{
> +		.start	= EP93XX_AAC_PHYS_BASE,
> +		.end	= EP93XX_AAC_PHYS_BASE + 0xb0 - 1,

The last register in the AC97 peripheral is AC97GCIS at offset 0xa8.  So the
end address should be:

	.end	= EP93XX_AAC_PHYS_BASE + 0xac - 1,

> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= IRQ_EP93XX_AACINTR,
> +		.end	= IRQ_EP93XX_AACINTR,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device ep93xx_ac97_device = {
> +	.name		= "ep93xx-ac97",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(ep93xx_ac97_resources),
> +	.resource	= ep93xx_ac97_resources,
> +};
> +
> +void __init ep93xx_register_ac97(void)
> +{
> +	/*
> +	 * Make sure that the AC97 pins are not used by I2S.
> +	 */
> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);

This is fine for now.

Eventually some thought should go into a proper iomux to prevent
loading drivers with conflicting pin requirements.  Currently, depending
on the configuration, this could break if a user should try to use the
ac97 and i2s audio at the same time (I2SONAC97 mode).  But, the same
problem already exists if a user tries using spi and i2s audio (I2SONSSP
mode).

> +
> +	platform_device_register(&ep93xx_ac97_device);
> +	platform_device_register(&ep93xx_pcm_device);
> +}
> +
>  extern void ep93xx_gpio_init(void);
>  
>  void __init ep93xx_init_devices(void)
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index c54b3e5..9ac4d10 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -105,6 +105,7 @@
>  #define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
>  #define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
>  
> +#define EP93XX_AAC_PHYS_BASE		EP93XX_APB_PHYS(0x00080000)
>  #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
>  
>  #define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index 3330b36..5066045 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -61,6 +61,7 @@ void ep93xx_keypad_release_gpio(struct platform_device *pdev);
>  void ep93xx_register_i2s(void);
>  int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config);
>  void ep93xx_i2s_release(void);
> +void ep93xx_register_ac97(void);
>  
>  void ep93xx_init_devices(void);
>  extern struct sys_timer ep93xx_timer;

Other than the end resource this all looks fine.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
