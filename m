From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 19:16:10 +0530
Subject: [PATCH v9 02/27] clk: davinci: da850-pll: change PLL0 to
 CLK_OF_DECLARE
In-Reply-To: <20180427001745.4116-3-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-3-david@lechnology.com>
Message-ID: <fe791ecf-ebd0-4e9e-722e-bfa07acc4ea2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> PLL0 on davinci/da850-type device needs to be registered early in boot
> because it is needed for clocksource/clockevent. Change the driver
> to use CLK_OF_DECLARE for this special case.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v9 changes:
> - new patch in v9
> 
> 
>  drivers/clk/davinci/pll-da850.c | 26 ++++++++++++++++++++++----
>  drivers/clk/davinci/pll.c       |  4 +++-
>  drivers/clk/davinci/pll.h       |  2 +-
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
> index 00a6ece7b524..743527de1da2 100644
> --- a/drivers/clk/davinci/pll-da850.c
> +++ b/drivers/clk/davinci/pll-da850.c
> @@ -12,6 +12,8 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/da8xx-cfgchip.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
>  #include <linux/of.h>
>  #include <linux/types.h>
>  
> @@ -135,11 +137,27 @@ static const struct davinci_pll_sysclk_info *da850_pll0_sysclk_info[] = {
>  	NULL
>  };
>  
> -int of_da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
> +void of_da850_pll0_init(struct device_node *node)
>  {
> -	return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
> -				   &da850_pll0_obsclk_info,
> -				   da850_pll0_sysclk_info, 7, base, cfgchip);
> +	void __iomem *base;
> +	struct regmap *cfgchip;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s: ioremap failed\n", __func__);
> +		return;
> +	}
> +
> +	cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
> +	if (IS_ERR(cfgchip)) {
> +		pr_warn("%s: failed to get cfgchip (%ld)\n", __func__,
> +			PTR_ERR(cfgchip));
> +		cfgchip = NULL;
> +	}

Is this error handling for cfgchip needed here considering
davinci_pll_clk_register() already checks and warns.

Thanks,
Sekhar
