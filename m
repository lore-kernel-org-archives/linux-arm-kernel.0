From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 11 Dec 2017 10:46:00 +0100
Subject: [PATCH v6 3/6] clk: meson-axg: add clock controller drivers
In-Reply-To: <20171211064853.32111-4-yixun.lan@amlogic.com>
References: <20171211064853.32111-1-yixun.lan@amlogic.com>
 <20171211064853.32111-4-yixun.lan@amlogic.com>
Message-ID: <1512985560.334.17.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 14:48 +0800, Yixun Lan wrote:
> From: Qiufang Dai <qiufang.dai@amlogic.com>
> 
> Add clock controller drivers for Amlogic Meson-AXG SoC.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/Kconfig.platforms |   1 +
>  drivers/clk/meson/Kconfig    |   8 +
>  drivers/clk/meson/Makefile   |   1 +
>  drivers/clk/meson/axg.c      | 944
> +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h      | 126 ++++++
>  5 files changed, 1080 insertions(+)
>  create mode 100644 drivers/clk/meson/axg.c
>  create mode 100644 drivers/clk/meson/axg.h

Overall, the changes looks good to me.
I still have a few comments which I'd like to see addressed quickly after this
series is merged

[...]

> 
> +static struct meson_clk_pll axg_fixed_pll = {
> +	.m = {
> +		.reg_off = HHI_MPLL_CNTL,
> +		.shift   = 0,
> +		.width   = 9,
> +	},
> +	.n = {
> +		.reg_off = HHI_MPLL_CNTL,
> +		.shift   = 9,
> +		.width   = 5,
> +	},
> +	.od = {
> +		.reg_off = HHI_MPLL_CNTL,
> +		.shift   = 16,
> +		.width   = 2,
> +	},
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_names = (const char *[]){ "xtal" },
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,

Is the rate of this clock supposed to changed by something else than
the CCF after boot ?

If not, you should drop this flag.
Same comment goes for axg_sys_pll and axg_gp0_pll

> +	},
> +};

[...]

> +/*
> + * FIXME The legacy composite clocks (e.g. clk81) are both PLL post-dividers
> + * and should be modeled with their respective PLLs via the forthcoming
> + * coordinated clock rates feature
> + */
> +static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
> +static const char * const clk81_parent_names[] = {
> +	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
> +	"fclk_div3", "fclk_div5"
> +};
> +
> +static struct clk_mux axg_mpeg_clk_sel = {
> +	.reg = (void *)HHI_MPEG_CLK_CNTL,
> +	.mask = 0x7,
> +	.shift = 12,
> +	.flags = CLK_MUX_READ_ONLY,
> +	.table = mux_table_clk81,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpeg_clk_sel",
> +		.ops = &clk_mux_ro_ops,
> +		/*
> +		 * bits 14:12 selects from 8 possible parents:
> +		 * xtal, 1'b0 (wtf), fclk_div7, mpll_clkout1, mpll_clkout2,
> +		 * fclk_div4, fclk_div3, fclk_div5
> +		 */

This comment is not necessary with table above.

> +		.parent_names = clk81_parent_names,
> +		.num_parents = ARRAY_SIZE(clk81_parent_names),
> +		.flags = CLK_SET_RATE_NO_REPARENT,

With ro_ops, this flag is not necessary, consider removing it.

> +	},
> +};
> +
> 
