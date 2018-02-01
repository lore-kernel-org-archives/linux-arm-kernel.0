From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Feb 2018 13:31:02 +0530
Subject: [PATCH v6 02/41] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <1516468460-4908-3-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-3-git-send-email-david@lechnology.com>
Message-ID: <ff3a0549-2f76-9a8d-21bc-164649e8a6be@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> This adds a new driver for mach-davinci PLL clocks. This is porting the
> code from arch/arm/mach-davinci/clock.c to the common clock framework.
> Additionally, it adds device tree support for these clocks.
> 
> The ifeq ($(CONFIG_COMMON_CLK), y) in the Makefile is needed to prevent
> compile errors until the clock code in arch/arm/mach-davinci is removed.
> 
> Note: although there are similar clocks for TI Keystone we are not able
> to share the code for a few reasons. The keystone clocks are device tree
> only and use legacy one-node-per-clock bindings. Also the register
> layouts are a bit different, which would add even more if/else mess
> to the keystone clocks. And the keystone PLL driver doesn't support
> setting clock rates.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Looks nice and clean to me. There is still some feedback though.

One thing missing is DIV4.5 clock. It will be nice to add that too,
mostly just because it will make the binding complete.

> +void of_davinci_pll_init(struct device_node *node,
> +			 const struct davinci_pll_clk_info *info,
> +			 const struct davinci_pll_obsclk_info *obsclk_info,
> +			 const struct davinci_pll_sysclk_info *div_info,
> +			 u8 max_sysclk_id)
> +{
> +	struct device_node *child;
> +	const char *parent_name;
> +	void __iomem *base;
> +	struct clk *clk;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("ioremap failed");
> +		return;
> +	}
> +
> +	if (info->flags & PLL_HAS_OSCIN)
> +		parent_name = of_clk_get_parent_name(node, 0);
> +	else
> +		parent_name = OSCIN_CLK_NAME;

I don't think the reference clock input handling is fully correct/flexible.

There are two ways to provide input clock (ref_clk) to PLL. Either use
the internal oscillator with a crystal connected between OSCIN and
OSCOUT (CLKMODE = 0) or a clean clock input (CLKMODE = 1) connected to
OSCIN (OSCOUT disconnected).

This is a board specific decision. On the LogicPD EVM, the former option
is used, on the LCDK board, the later.

So, I think what we need is a DT property like
"ti,davinci-use-internal-osc" for the PLL. Boards can set or ignore it
and you can switch CLKMODE on or off based on that.

Setting CLKMODE = 1 will switch off the internal oscillator (and
presumably save power), but it does not act as a mux. This explains why
not worrying about setting this correctly in current mainline still works.

I am also not sure if we really need PLL_HAS_OSCIN since all DaVinci
SoCs set it anyway.

Thanks,
Sekhar
