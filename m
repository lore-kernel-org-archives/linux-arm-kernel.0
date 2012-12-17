From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Dec 2012 21:01:36 +0100
Subject: [PATCH] ARM: mach-imx6q: Do not run error code path in success
 case
In-Reply-To: <1355756147-24856-1-git-send-email-fabio.estevam@freescale.com>
References: <1355756147-24856-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121217200136.GR26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 12:55:47PM -0200, Fabio Estevam wrote:
> The 'put_clk' path should only run in the case of failure, so provide a 'return'
> to avoid it running in the success case.

Are you sure? It looks to me like it was intentional. The purpose of
this function is to set the parent/rate correctly. The references to
the clock are not needed later.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 4eb1b3a..61f50aa 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -134,6 +134,8 @@ static void __init imx6q_sabrelite_cko1_setup(void)
>  	clk_set_parent(cko1_sel, ahb);
>  	rate = clk_round_rate(cko1, 16000000);
>  	clk_set_rate(cko1, rate);
> +
> +	return;
>  put_clk:
>  	if (!IS_ERR(cko1_sel))
>  		clk_put(cko1_sel);
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
