From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Aug 2010 09:06:27 +0200
Subject: [PATCH|RESEND 1/4] clock-imx35: use get_3_3_div helper for
	get_rate_ipg_per
In-Reply-To: <1281966847-553-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1281966847-553-1-git-send-email-m.grzeschik@pengutronix.de>
	<1281966847-553-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20100817070627.GV27749@pengutronix.de>
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

This is wrong. According to newer Datasheets this field contains a plain
6bit divider not to cascaded 3bit dividers.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
