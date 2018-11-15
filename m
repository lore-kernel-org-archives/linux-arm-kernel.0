From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Nov 2018 10:46:15 +0100
Subject: [RFC v1 7/7] clk: meson: meson8b: allow changing the CPU clock
 tree
In-Reply-To: <20181114225725.2821-8-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
 <20181114225725.2821-8-martin.blumenstingl@googlemail.com>
Message-ID: <223b47cc5077db7176e5d8c013f1a76091c3d70c.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> Currently all clocks in the CPU clock tree are marked as read-only
> (using the corresponding _ro_ clk_ops). This was correct since changing
> the clock tree could cause the system to lock up.
> Switch all clocks to their corresponding clk_ops variant which is not
> read-only to allow changing the CPU clock tree since the bug which
> locked up the system is now fixed (by switching the CPU clock temporary
> to run off XTAL while changing the CPU clock tree).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index c06a1a7faa4c..b3bdc7e05441 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -203,7 +203,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sys_pll_dco",
> -		.ops = &meson_clk_pll_ro_ops,
> +		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
>  	},
> @@ -218,7 +218,7 @@ static struct clk_regmap meson8b_sys_pll = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sys_pll",
> -		.ops = &clk_regmap_divider_ro_ops,
> +		.ops = &clk_regmap_divider_ops,
>  		.parent_names = (const char *[]){ "sys_pll_dco" },
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,
> @@ -552,7 +552,7 @@ static struct clk_regmap meson8b_cpu_in_sel = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_in_sel",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		.parent_names = (const char *[]){ "xtal", "sys_pll" },
>  		.num_parents = 2,
>  		.flags = (CLK_SET_RATE_PARENT |
> @@ -606,7 +606,7 @@ static struct clk_regmap meson8b_cpu_scale_div = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_scale_div",
> -		.ops = &clk_regmap_divider_ro_ops,
> +		.ops = &clk_regmap_divider_ops,
>  		.parent_names = (const char *[]){ "cpu_in_sel" },
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,
> @@ -623,7 +623,7 @@ static struct clk_regmap meson8b_cpu_scale_out_sel = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_scale_out_sel",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		/*
>  		 * NOTE: We are skipping the parent with value 0x2 (which is
>  		 * "cpu_div3") because it results in a duty cycle of 33% which
> @@ -646,7 +646,7 @@ static struct clk_regmap meson8b_cpu_clk = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_clk",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		.parent_names = (const char *[]){ "xtal",
>  						  "cpu_scale_out_sel" },
>  		.num_parents = 2,

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
