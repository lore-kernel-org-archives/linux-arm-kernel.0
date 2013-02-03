From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 3 Feb 2013 18:46:38 +0800
Subject: [PATCH 2/2] ARM: imx: set CKO1 parent clock source in imx6q
 sabresd
In-Reply-To: <1359701217-23931-1-git-send-email-b13634@freescale.com>
References: <1359701217-23931-1-git-send-email-b13634@freescale.com>
Message-ID: <20130203104636.GB26233@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 02:46:57PM +0800, Gary Zhang wrote:
> in imx6q sabresd board, set ahb as CKO1 parent clock sourrce
> 
> Signed-off-by: Gary Zhang <b13634@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 4eb1b3a..860e272 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -119,7 +119,7 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
>  	return 0;
>  }
>  
> -static void __init imx6q_sabrelite_cko1_setup(void)
> +static void __init cko1_setup(unsigned long freq)
>  {
>  	struct clk *cko1_sel, *ahb, *cko1;
>  	unsigned long rate;
> @@ -132,8 +132,10 @@ static void __init imx6q_sabrelite_cko1_setup(void)
>  		goto put_clk;
>  	}
>  	clk_set_parent(cko1_sel, ahb);
> -	rate = clk_round_rate(cko1, 16000000);
> +	rate = clk_round_rate(cko1, freq);
>  	clk_set_rate(cko1, rate);
> +
> +	return;

Why does this "return" needs to be added here?

Shawn

>  put_clk:
>  	if (!IS_ERR(cko1_sel))
>  		clk_put(cko1_sel);
> @@ -148,7 +150,12 @@ static void __init imx6q_sabrelite_init(void)
>  	if (IS_BUILTIN(CONFIG_PHYLIB))
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>  				ksz9021rn_phy_fixup);
> -	imx6q_sabrelite_cko1_setup();
> +	cko1_setup(16000000);
> +}
> +
> +static void __init imx6q_sabresd_init(void)
> +{
> +	cko1_setup(24000000);
>  }
>  
>  static void __init imx6q_1588_init(void)
> @@ -193,6 +200,8 @@ static void __init imx6q_init_machine(void)
>  {
>  	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
>  		imx6q_sabrelite_init();
> +	else if (of_machine_is_compatible("fsl,imx6q-sabresd"))
> +		imx6q_sabresd_init();
>  
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  
> -- 
> 1.7.0.4
> 
> 
