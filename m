From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Mar 2013 11:17:07 +0100
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <20130319170933.28337.50448.stgit@localhost>
References: <20130319170933.28337.50448.stgit@localhost>
Message-ID: <20130325101707.GZ1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 06:09:33PM +0100, Martin Fuzzey wrote:
> Even on platforms where the entire clock tree is not represented in the DT
> it can still be useful to allow parents and rates to be set from the DT.
> 
> An example of such a case is when a multiplexable clock output from a SOC
> is used to supply external chips (eg an audio codec connected to the i.MX53
> cko1 pin).
> 
> The cko1 pin can output various internal clock signals but, in
> order to obtain a suitable frequency for the codec, an appropriate parent must
> be selected.
> 
> Another example is setting root clock dividers.
> 
> This is board specific rather than device driver or platform clock framework
> specific information and thus would be better in the DT.

I see what the patch does and that it could be very useful, but there's
a problem: The devicetree is for hardware *description*, not
*configuration*.

> +For example:
> +	clock-configuration {
> +		compatible = "clock-configuration";
> +		clko1 {
> +			clocks = <&clks 160>; /* cko1_sel */
> +			parent = <&clks 114>; /* pll3_sw */
> +		};
> +
> +		esdhca {
> +			clocks = <&clks 102>; /* esdhc_a_podf */
> +			clock-frequency = <200000000>;
> +		};

This example shows this. For some reason we adjust the esdhc frequency
to 200MHz in the code currently, but this is because it matches our
current usecase. Once you move this into devicetree, we can't change
this anymore in the kernel, even if we find a much better way to adjust
the frequency in the future (i.e. smaller values might be good for power
savings, higher values might increase performance, we even might
dynamically change this frequency).


So no, this shouldn't be in the devicetree, even though it's very
tempting to do so.

I wonder when someone comes up with a 'configtree' where we could put in
such stuff.

Sascha

> +
> +		esdhcb {
> +			clocks = <&clks 103>; /* esdhc_b_podf */
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
> +
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 872a7bc..fd74795 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -432,7 +432,7 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  	val |= 1 << 23;
>  	writel(val, MXC_CCM_CLPCR);
>  
> -	return 0;
> +	return of_clk_configure();
>  }
>  
>  int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
> @@ -523,10 +523,6 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx53.3");
>  	clk_register_clkdev(clk[esdhc4_per_gate], "per", "sdhci-esdhc-imx53.3");
>  
> -	/* set SDHC root clock to 200MHZ*/
> -	clk_set_rate(clk[esdhc_a_podf], 200000000);
> -	clk_set_rate(clk[esdhc_b_podf], 200000000);
> -
>  	/* System timer */
>  	mxc_timer_init(MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR), MX53_INT_GPT);
>  
> @@ -536,8 +532,7 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
>  
>  	r = clk_round_rate(clk[usboh3_per_gate], 54000000);
>  	clk_set_rate(clk[usboh3_per_gate], r);
> -
> -	return 0;
> +	return of_clk_configure();
>  }
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 300d477..bf364dd 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
>  obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
> +obj-$(CONFIG_COMMON_CLK)	+= clk-configuration.o
>  
>  # SoCs specific
>  obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
> diff --git a/drivers/clk/clk-configuration.c b/drivers/clk/clk-configuration.c
> new file mode 100644
> index 0000000..ee70619
> --- /dev/null
> +++ b/drivers/clk/clk-configuration.c
> @@ -0,0 +1,79 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Device tree clock parent, rate configuration
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +
> +
> +static int configure_one_clock(struct clk *clk, struct device_node *np)
> +{
> +	int ret;
> +	struct of_phandle_args clkspec;
> +	struct clk *parent;
> +	u32 rate;
> +
> +	ret = of_parse_phandle_with_args(np, "parent", "#clock-cells", 0,
> +					&clkspec);
> +	if (!ret) {
> +		parent = of_clk_get_from_provider(&clkspec);
> +		if (!IS_ERR(parent)) {
> +			ret = clk_set_parent(clk, parent);
> +			clk_put(parent);
> +		}
> +		of_node_put(clkspec.np);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = 0;
> +	if (!of_property_read_u32(np, "clock-frequency", &rate))
> +		ret = clk_set_rate(clk, rate);
> +
> +err:
> +	return ret;
> +
> +}
> +
> +/**
> + * of_clk_configure - configure clocks from device tree
> + *
> + * Allows parent and rate to be set from nodes having
> + * clock-configuration compatible property.
> + *
> + * See binding documentation for example
> + *
> + * Returns 0 on success, -EERROR otherwise.
> + */
> +int of_clk_configure()
> +{
> +	struct device_node *config_node, *np;
> +	struct clk *clk;
> +	int err_count = 0;
> +	int ret = 0;
> +
> +	for_each_compatible_node(config_node, NULL, "clock-configuration") {
> +		for_each_child_of_node(config_node, np) {
> +			clk = of_clk_get(np, 0);
> +			if (IS_ERR(clk)) {
> +				pr_warn("%s: Failed to obtain clock configuration for %s : %d\n", __func__, np->name);
> +				err_count++;
> +			} else {
> +				if (configure_one_clock(clk, np))
> +					err_count++;
> +				clk_put(clk);
> +			}
> +		}
> +	}
> +
> +	if (err_count) {
> +		pr_warn("%s: Failed %d clocks\n", __func__, err_count);
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_clk_configure);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index b3ac22d..4f7f605 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -368,6 +368,7 @@ struct of_phandle_args;
>  struct clk *of_clk_get(struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
> +int of_clk_configure(void);
>  #else
>  static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
> @@ -378,6 +379,10 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
>  {
>  	return ERR_PTR(-ENOENT);
>  }
> +static inline int of_clk_configure(void)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
