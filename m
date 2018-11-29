From: aisheng.dong@nxp.com (Aisheng DONG)
Date: Thu, 29 Nov 2018 07:46:41 +0000
Subject: [PATCH v13 0/5] Add i.MX8MQ clock driver
In-Reply-To: <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
[...]
> >
> > Changes since v12:
> >  * replaced the division in clk_pll_recalc_rate in clk-frac
> >    with do_div as suggested by Stephen
> >
> > Abel Vesa (2):
> >   clk: imx: Add imx composite clock
> >   clk: imx: Add clock driver for i.MX8MQ CCM
> >
> > Lucas Stach (3):
> >   dt-bindings: add binding for i.MX8MQ CCM
> >   clk: imx: add fractional PLL output clock
> >   clk: imx: Add SCCG PLL type
> >
> 
> I had to apply this set of fixes to silence sparse and smatch warnings about
> things that are not right. Please take a look over things and see if it's sane.
> 

The change looks good to me and tested ok.
I did not see this patch series in your tree.
Do you want us to apply your changes and re-send for easy pick up?

Regards
Dong Aisheng

> diff --git a/drivers/clk/imx/clk-composite-8m.c
> b/drivers/clk/imx/clk-composite-8m.c
> index bcd31d889584..6d9d3714b4df 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -127,8 +127,8 @@ struct clk *imx8m_clk_composite_flags(const char
> *name,
>  					int num_parents, void __iomem *reg,
>  					unsigned long flags)
>  {
> -	struct clk_hw *hw = NULL, *mux_hw = NULL;
> -	struct clk_hw *div_hw = NULL, *gate_hw = NULL;
> +	struct clk_hw *hw = ERR_PTR(-ENOMEM), *mux_hw;
> +	struct clk_hw *div_hw, *gate_hw;
>  	struct clk_divider *div = NULL;
>  	struct clk_gate *gate = NULL;
>  	struct clk_mux *mux = NULL;
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c index
> a3732be5ad7f..98726206f3c4 100644
> --- a/drivers/clk/imx/clk-frac-pll.c
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -14,6 +14,8 @@
>  #include <linux/slab.h>
>  #include <linux/bitfield.h>
> 
> +#include "clk.h"
> +
>  #define PLL_CFG0		0x0
>  #define PLL_CFG1		0x4
> 
> @@ -214,7 +216,7 @@ struct clk *imx_clk_frac_pll(const char *name, const
> char *parent_name,
>  	ret = clk_hw_register(NULL, hw);
>  	if (ret) {
>  		kfree(pll);
> -		return ERR_CAST(hw);
> +		return ERR_PTR(ret);
>  	}
> 
>  	return hw->clk;
> diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c index
> 4666b96bdb3f..ee7752bace89 100644
> --- a/drivers/clk/imx/clk-sccg-pll.c
> +++ b/drivers/clk/imx/clk-sccg-pll.c
> @@ -249,7 +249,7 @@ struct clk *imx_clk_sccg_pll(const char *name,
>  	ret = clk_hw_register(NULL, hw);
>  	if (ret) {
>  		kfree(pll);
> -		return ERR_CAST(hw);
> +		return ERR_PTR(ret);
>  	}
> 
>  	return hw->clk;
