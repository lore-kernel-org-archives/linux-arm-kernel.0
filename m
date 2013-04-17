From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Apr 2013 21:57:44 +0200
Subject: [PATCH] ARM: mach-imx6q: Remove code for setting up cko clock
In-Reply-To: <1366224182-29285-1-git-send-email-festevam@gmail.com>
References: <1366224182-29285-1-git-send-email-festevam@gmail.com>
Message-ID: <20130417195744.GX1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 03:43:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Let the bootloader setup the cko clock that drives the audio codec.
> 

I really don't like such stuff. Where is documented what's expected from
the bootloader? Which versions of which bootloader do implement this?

The code you remove is not particularly nice, but just removing it is no
solution to the problem.


> This simplifies a lot the code and when a new board needs to add audio support,
> it will not have to add all this amount of code again. 

It shouldn't be necessary to duplicate the code for each board.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |   25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 5536fd8..fe896a8 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -113,36 +113,11 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
>  	return 0;
>  }
>  
> -static void __init imx6q_sabrelite_cko1_setup(void)
> -{
> -	struct clk *cko1_sel, *ahb, *cko1;
> -	unsigned long rate;
> -
> -	cko1_sel = clk_get_sys(NULL, "cko1_sel");
> -	ahb = clk_get_sys(NULL, "ahb");
> -	cko1 = clk_get_sys(NULL, "cko1");
> -	if (IS_ERR(cko1_sel) || IS_ERR(ahb) || IS_ERR(cko1)) {
> -		pr_err("cko1 setup failed!\n");
> -		goto put_clk;
> -	}
> -	clk_set_parent(cko1_sel, ahb);
> -	rate = clk_round_rate(cko1, 16000000);
> -	clk_set_rate(cko1, rate);
> -put_clk:
> -	if (!IS_ERR(cko1_sel))
> -		clk_put(cko1_sel);
> -	if (!IS_ERR(ahb))
> -		clk_put(ahb);
> -	if (!IS_ERR(cko1))
> -		clk_put(cko1);
> -}
> -
>  static void __init imx6q_sabrelite_init(void)
>  {
>  	if (IS_BUILTIN(CONFIG_PHYLIB))
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>  				ksz9021rn_phy_fixup);
> -	imx6q_sabrelite_cko1_setup();
>  }
>  
>  static void __init imx6q_1588_init(void)
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
