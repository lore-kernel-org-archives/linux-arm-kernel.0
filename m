From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 16 Aug 2010 17:25:45 +0200
Subject: [PATCH|RESEND 1/4] clock-imx35: use get_3_3_div helper for
	get_rate_ipg_per
In-Reply-To: <1281966847-553-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1281966847-553-1-git-send-email-m.grzeschik@pengutronix.de>
	<1281966847-553-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20100816152545.GB1060@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, Aug 16, 2010 at 03:54:04PM +0200, Michael Grzeschik wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/mach-mx3/clock-imx35.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> index d3af0fd..4b10f46 100644
> --- a/arch/arm/mach-mx3/clock-imx35.c
> +++ b/arch/arm/mach-mx3/clock-imx35.c
> @@ -290,12 +290,10 @@ static unsigned long get_rate_ipg_per(struct clk *clk)
>  {
>  	unsigned long pdr0 = __raw_readl(CCM_BASE + CCM_PDR0);
>  	unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
> -	unsigned long div1, div2;
> +	unsigned long div1;
>  
>  	if (pdr0 & (1 << 26)) {
> -		div1 = (pdr4 >> 19) & 0x7;
> -		div2 = (pdr4 >> 16) & 0x7;
> -		return get_rate_arm() / ((div1 + 1) * (div2 + 1));
> +		return get_rate_arm() / get_3_3_div(pdr4 >> 16);
>  	} else {
>  		div1 = (pdr0 >> 12) & 0x7;
>  		return get_rate_ahb(NULL) / div1;
> -- 
> 1.7.1
> 

This one is probably not necessary/possible anymore
when we look into this tree [1] in branch imx-for-2.6.36
for following patch:

5e05cb09aede7e3571673b142143f68575590136 i.MX35: remove get_3_3_div helper function

[1] git://git.pengutronix.de/git/imx/linux-2.6.git

Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
