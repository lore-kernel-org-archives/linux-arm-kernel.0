From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jun 2016 09:42:19 +0200
Subject: [PATCH v2 14/15] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160607204154.31967-15-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-15-maxime.ripard@free-electrons.com>
Message-ID: <20160609094219.6b4153aed49fb5ab6ccd7f74@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 22:41:53 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Add the list of clocks and resets found in the H3 CCU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> ---
> Changes from v1:
>   - Only build the H3 clocks description when MACH_SUN8I is set
> ---
>  drivers/clk/sunxi-ng/Makefile        |   2 +
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 703 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
>  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
>  4 files changed, 970 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
>  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index ddcf456df719..cafabf0e8060 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -13,3 +13,5 @@ obj-y += ccu_nkm.o
>  obj-y += ccu_nkmp.o
>  obj-y += ccu_nm.o
>  obj-y += ccu_phase.o
> +
> +obj-$(CONFIG_MACH_SUN8I) += ccu-sun8i-h3.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> new file mode 100644
> index 000000000000..41102ac020d9
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
	[snip]
> +static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
> +	.clks		= sun8i_h3_ccu_clks,
> +	.num_clks	= ARRAY_SIZE(sun8i_h3_ccu_clks),
> +
> +	.resets		= sun8i_h3_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun8i_h3_ccu_resets),
> +};
> +
> +#define SUN8I_H3_PLL2_REG	0x008

SUN8I_H3_PLL_AUDIO_REG would be clearer.

This definition could go near the audio PLL description with some
comments.

> +
> +static void __init sun8i_h3_ccu_setup(struct device_node *node)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n",
> +		       of_node_full_name(node));
> +		return;
> +	}
> +
> +	/* Force the PLL2-1x divider to 4 */
> +	val = readl(reg + SUN8I_H3_PLL2_REG);
> +	val &= ~GENMASK(4, 0);
> +	writel(val | 3, reg + SUN8I_H3_PLL2_REG);
> +
> +	sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
> +}
> +CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
> +	       sun8i_h3_ccu_setup);
> diff --git a/include/dt-bindings/clock/sun8i-h3.h b/include/dt-bindings/clock/sun8i-h3.h
> new file mode 100644
> index 000000000000..96eced56e7a2
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun8i-h3.h
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
