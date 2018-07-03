From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 03 Jul 2018 11:24:22 +0200
Subject: [PATCH v2 2/2] clk: meson-axg: add clocks required by pcie driver
In-Reply-To: <20180702213118.19222-3-yixun.lan@amlogic.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
 <20180702213118.19222-3-yixun.lan@amlogic.com>
Message-ID: <1530609862.2900.187.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-02 at 21:31 +0000, Yixun Lan wrote:
> Adding clocks for the pcie driver. Due to the ASIC design,
> the pcie controller re-use part of the mipi clock logic,
> so the mipi clock is also added.
> 
> Tested-by: Jianxin Qin <jianxin.qin@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/axg.c | 148 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h |   6 +-
>  2 files changed, 153 insertions(+), 1 deletion(-)
> 
> 

[...]

> +
> +/* skip the partent 0, it's for debug only */
> +static u32 mux_table_pcie_ref[]	= { 1 };
> +static const char * const pcie_ref_parent_names[] = { "pcie_mux" };

Dropped these symbols.

> +
> +static struct clk_regmap axg_pcie_ref = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_PCIE_PLL_CNTL6,
> +		.mask = 0x1,
> +		.shift = 1,
> +		.table = mux_table_pcie_ref,

Replaced with the table itself

> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "pcie_ref",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = pcie_ref_parent_names,
> +		.num_parents = ARRAY_SIZE(pcie_ref_parent_names),

Replaced with the table itself and applied. Thx

> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> 
