From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Jul 2018 00:36:09 -0700
Subject: [RFC 3/5] ARM: OMAP2+: Add AM3517 MUSB setup to pdata quirks.
In-Reply-To: <20180625001233.9785-4-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
 <20180625001233.9785-4-aford173@gmail.com>
Message-ID: <20180703073609.GP112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [180625 00:15]:
> The pin muxing and clock definitions for the MUSB controller are
> not done through the same registers/pin mux options, so this
> explicitly configures the registers and pin-mux options for MUSB
> on AM3517-EVM
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 7f02743edbe4..e0c7ac2c87c1 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -258,9 +258,28 @@ static void __init omap3_sbc_t3517_legacy_init(void)
>  	omap3_sbc_t3517_wifi_init();
>  }
>  
> +/* The pin muxing for AM3517 OTG isn't done through the normal means */
> +static __init void am3517_evm_musb_init(void)
> +{
> +	u32 devconf2;
> +
> +	/*
> +	 * Set up USB clock/mode in the DEVCONF2 register.
> +	 */
> +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> +
> +	/* USB2.0 PHY reference clock is 13 MHz */
> +	devconf2 &= ~(CONF2_REFFREQ | CONF2_OTGMODE | CONF2_PHY_GPIOMODE);
> +	devconf2 |=  CONF2_REFFREQ_13MHZ | CONF2_SESENDEN | CONF2_VBDTCTEN
> +			| CONF2_DATPOL;
> +
> +	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> +}
> +
>  static void __init am3517_evm_legacy_init(void)
>  {
>  	am35xx_emac_reset();
> +	am3517_evm_musb_init();
>  }

To me it seems you should do this with a simple drivers/phy driver.
There might be already something similar that you can use, see the
da and dm related drivers under drivers/phy/ti.

Regards,

Tony
