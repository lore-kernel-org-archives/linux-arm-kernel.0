From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 29 Jun 2012 14:35:22 -0600 (MDT)
Subject: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
In-Reply-To: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Beno?t who is the maintainer of this file

+ the linux-arm-kernel mailing list, which should be cc'ed on all OMAP 
patches

On Fri, 29 Jun 2012, Ruslan Bilovol wrote:

> From: Wenbiao Wang <wwang@ti.com>
> 
> OTG clock usb_otg_hs_ick used a incorrect parent l3_div_ck.
> Correct it to use the right colck otg_60m_gfclk as its
> parent.
> 
> Signed-off-by: Wenbiao Wang <wwang@ti.com>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index b825049..fd43214 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -199,12 +199,6 @@ static struct clk tie_low_clock_ck = {
>  	.ops		= &clkops_null,
>  };
>  
> -static struct clk utmi_phy_clkout_ck = {
> -	.name		= "utmi_phy_clkout_ck",
> -	.rate		= 60000000,
> -	.ops		= &clkops_null,
> -};
> -
>  static struct clk xclk60mhsp1_ck = {
>  	.name		= "xclk60mhsp1_ck",
>  	.rate		= 60000000,
> @@ -992,6 +986,13 @@ static struct clk dpll_usb_clkdcoldo_ck = {
>  	.recalc		= &followparent_recalc,
>  };
>  
> +static struct clk utmi_phy_clkout_ck = {
> +	.name		= "utmi_phy_clkout_ck",
> +	.ops		= &clkops_null,
> +	.parent		= &dpll_usb_clkdcoldo_ck,
> +	.recalc		= &followparent_recalc,
> +};
> +
>  static const struct clksel dpll_usb_m2_div[] = {
>  	{ .parent = &dpll_usb_ck, .rates = div31_1to31_rates },
>  	{ .parent = NULL },
> @@ -2685,7 +2686,7 @@ static struct clk usb_otg_hs_ick = {
>  	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
>  	.clkdm_name	= "l3_init_clkdm",
> -	.parent		= &l3_div_ck,
> +	.parent		= &otg_60m_gfclk,
>  	.recalc		= &followparent_recalc,
>  };

Beno?t should have a look at this one, I think.


- Paul
