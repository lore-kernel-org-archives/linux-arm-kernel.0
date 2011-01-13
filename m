From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Jan 2011 15:49:00 +0100
Subject: [PATCH v5] ARM: mx28: add the second fec device registration
In-Reply-To: <1294747764-4499-1-git-send-email-shawn.guo@freescale.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294747764-4499-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110113144900.GT24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 08:09:24PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v5:
>  - Do not use CONFIG_FEC2 which is a fec driver configration
> 
>  arch/arm/mach-mxs/mach-mx28evk.c |   26 +++++++++++++++++++++++---
>  1 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index d162e95..8e2c597 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -57,6 +57,19 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
>  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
>  	MX28_PAD_ENET_CLK__CLKCTRL_ENET |
>  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> +	/* fec1 */
> +	MX28_PAD_ENET0_CRS__ENET1_RX_EN |
> +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> +	MX28_PAD_ENET0_RXD2__ENET1_RXD0 |
> +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> +	MX28_PAD_ENET0_RXD3__ENET1_RXD1 |
> +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> +	MX28_PAD_ENET0_COL__ENET1_TX_EN |
> +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> +	MX28_PAD_ENET0_TXD2__ENET1_TXD0 |
> +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> +	MX28_PAD_ENET0_TXD3__ENET1_TXD1 |
> +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
>  	/* phy power line */
>  	MX28_PAD_SSP1_DATA3__GPIO_2_15 |
>  		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> @@ -106,8 +119,14 @@ static void __init mx28evk_fec_reset(void)
>  	gpio_set_value(MX28EVK_FEC_PHY_RESET, 1);
>  }
>  
> -static const struct fec_platform_data mx28_fec_pdata __initconst = {
> -	.phy = PHY_INTERFACE_MODE_RMII,
> +static struct fec_platform_data mx28_fec_pdata[] = {
this can still be initdata, doesn't it?

> +	{
> +		/* fec0 */
> +		.phy = PHY_INTERFACE_MODE_RMII,
> +	}, {
> +		/* fec1 */
> +		.phy = PHY_INTERFACE_MODE_RMII,
> +	},
>  };
>  
>  static void __init mx28evk_init(void)
> @@ -117,7 +136,8 @@ static void __init mx28evk_init(void)
>  	mx28_add_duart();
>  
>  	mx28evk_fec_reset();
> -	mx28_add_fec(0, &mx28_fec_pdata);
> +	mx28_add_fec(0, &mx28_fec_pdata[0]);
> +	mx28_add_fec(1, &mx28_fec_pdata[1]);
>  }
>  
>  static void __init mx28evk_timer_init(void)
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
