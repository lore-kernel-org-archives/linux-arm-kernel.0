From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 11 Oct 2010 08:39:25 +1300
Subject: [PATCH 3/4] ARM: ep93xx: add AC97 platform support
In-Reply-To: <d63475d15634d7ffa4c4167cbead782a5aa1cfc9.1286707213.git.mika.westerberg@iki.fi>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<d63475d15634d7ffa4c4167cbead782a5aa1cfc9.1286707213.git.mika.westerberg@iki.fi>
Message-ID: <4CB2166D.5080706@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2010 11:54 PM, Mika Westerberg wrote:
> Add platform support for the EP93xx AC97 controller driver.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  arch/arm/mach-ep93xx/core.c                     |   32 +++++++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
>  3 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 4cb55d3..6f514c4 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -826,6 +826,38 @@ void ep93xx_i2s_release(void)
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
> +	platform_device_register(&ep93xx_ac97_device);
> +}

The other ep93xx device support functions do this with acquire/release
functions. However, it is quite unlikely that a board will ever need to
switch from i2s to ac97 audio at runtime. Will see what Hartley thinks.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
