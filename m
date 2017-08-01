From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 1 Aug 2017 14:19:38 +0200
Subject: [PATCH v3 2/2] clk: meson: gxbb: Add sd_emmc clk0 clocks
In-Reply-To: <20170731115603.29720-3-jbrunet@baylibre.com>
References: <20170731115603.29720-1-jbrunet@baylibre.com>
 <20170731115603.29720-3-jbrunet@baylibre.com>
Message-ID: <127b2dd8-72bf-1e44-9244-a539a0414c75@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2017 01:56 PM, Jerome Brunet wrote:
> Input source 0 of the mmc controllers is not directly xtal, as currently
> described in DT. Each controller is fed by a composite clock (the usual
> mux, divider and gate). The muxes inputs are the xtal (default) and the
> fclk_div clocks. These parents, along with the divider, should be able to
> provide the necessary rates for mmc and nand operation.
> 
> The input muxes should also be able to take mpll2, mpll3 and gp0_pll but
> these are precious clocks, needed for other usage. It is better if the
> mmc does not use these them. For this reason, mpll2, mpll3 and gp0_pll is
> not listed among the possible parents.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/gxbb.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 8409d86cda24..dd78c5a1ce4b 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -974,6 +974,156 @@ static struct clk_mux gxbb_32k_clk_sel = {
>  	},
>  };
>  
> +static const char * const gxbb_sd_emmc_clk0_parent_names[] = {
> +	"xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
> +
> +	/*
> +	 * Following these parent clocks, we should also have had mpll2, mpll3
> +	 * and gp0_pll but these clocks are too precious to be used here. All
> +	 * the necessary rates for MMC and NAND operation can be acheived using
> +	 * xtal or fclk_div clocks
> +	 */
> +};
> +
> +/* SDIO clock */
> +static struct clk_mux gxbb_sd_emmc_a_clk0_sel = {
> +	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
> +	.mask = 0x7,
> +	.shift = 9,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_clk0_sel",
> +		.ops = &clk_mux_ops,
> +		.parent_names = gxbb_sd_emmc_clk0_parent_names,
> +		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_divider gxbb_sd_emmc_a_clk0_div = {
> +	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
> +	.shift = 0,
> +	.width = 7,
> +	.lock = &clk_lock,
> +	.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_clk0_div",
> +		.ops = &clk_divider_ops,
> +		.parent_names = (const char *[]){ "sd_emmc_a_clk0_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_gate gxbb_sd_emmc_a_clk0 = {
> +	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
> +	.bit_idx = 7,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sd_emmc_a_clk0",
> +		.ops = &clk_gate_ops,
> +		.parent_names = (const char *[]){ "sd_emmc_a_clk0_div" },
> +		.num_parents = 1,
> +
> +		/*
> +		 * FIXME:
> +		 * We need CLK_IGNORE_UNUSED because mmc DT node point to xtal
> +		 * instead of this clock. CCF would gate this on boot, killing
> +		 * the mmc controller. Please remove this flag once DT properly
> +		 * point to this clock instead of xtal
> +		 *
> +		 * Same goes for emmc B and C clocks
> +		 */
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +/* SDcard clock */
> +static struct clk_mux gxbb_sd_emmc_b_clk0_sel = {
> +	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
> +	.mask = 0x7,
> +	.shift = 25,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b_clk0_sel",
> +		.ops = &clk_mux_ops,
> +		.parent_names = gxbb_sd_emmc_clk0_parent_names,
> +		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_divider gxbb_sd_emmc_b_clk0_div = {
> +	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
> +	.shift = 16,
> +	.width = 7,
> +	.lock = &clk_lock,
> +	.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b_clk0_div",
> +		.ops = &clk_divider_ops,
> +		.parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_gate gxbb_sd_emmc_b_clk0 = {
> +	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
> +	.bit_idx = 23,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sd_emmc_b_clk0",
> +		.ops = &clk_gate_ops,
> +		.parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +/* EMMC/NAND clock */
> +static struct clk_mux gxbb_sd_emmc_c_clk0_sel = {
> +	.reg = (void *)HHI_NAND_CLK_CNTL,
> +	.mask = 0x7,
> +	.shift = 9,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_clk0_sel",
> +		.ops = &clk_mux_ops,
> +		.parent_names = gxbb_sd_emmc_clk0_parent_names,
> +		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_divider gxbb_sd_emmc_c_clk0_div = {
> +	.reg = (void *)HHI_NAND_CLK_CNTL,
> +	.shift = 0,
> +	.width = 7,
> +	.lock = &clk_lock,
> +	.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_clk0_div",
> +		.ops = &clk_divider_ops,
> +		.parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_gate gxbb_sd_emmc_c_clk0 = {
> +	.reg = (void *)HHI_NAND_CLK_CNTL,
> +	.bit_idx = 7,
> +	.lock = &clk_lock,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "sd_emmc_c_clk0",
> +		.ops = &clk_gate_ops,
> +		.parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
>  /* Everything Else (EE) domain gates */
>  static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
>  static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
> @@ -1183,6 +1333,15 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
>  		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
>  		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
>  		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
> +		[CLKID_SD_EMMC_A_CLK0_SEL]  = &gxbb_sd_emmc_a_clk0_sel.hw,
> +		[CLKID_SD_EMMC_A_CLK0_DIV]  = &gxbb_sd_emmc_a_clk0_div.hw,
> +		[CLKID_SD_EMMC_A_CLK0]	    = &gxbb_sd_emmc_a_clk0.hw,
> +		[CLKID_SD_EMMC_B_CLK0_SEL]  = &gxbb_sd_emmc_b_clk0_sel.hw,
> +		[CLKID_SD_EMMC_B_CLK0_DIV]  = &gxbb_sd_emmc_b_clk0_div.hw,
> +		[CLKID_SD_EMMC_B_CLK0]	    = &gxbb_sd_emmc_b_clk0.hw,
> +		[CLKID_SD_EMMC_C_CLK0_SEL]  = &gxbb_sd_emmc_c_clk0_sel.hw,
> +		[CLKID_SD_EMMC_C_CLK0_DIV]  = &gxbb_sd_emmc_c_clk0_div.hw,
> +		[CLKID_SD_EMMC_C_CLK0]	    = &gxbb_sd_emmc_c_clk0.hw,
>  		[NR_CLKS]		    = NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -1306,6 +1465,15 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>  		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
>  		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
>  		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
> +		[CLKID_SD_EMMC_A_CLK0_SEL]  = &gxbb_sd_emmc_a_clk0_sel.hw,
> +		[CLKID_SD_EMMC_A_CLK0_DIV]  = &gxbb_sd_emmc_a_clk0_div.hw,
> +		[CLKID_SD_EMMC_A_CLK0]	    = &gxbb_sd_emmc_a_clk0.hw,
> +		[CLKID_SD_EMMC_B_CLK0_SEL]  = &gxbb_sd_emmc_b_clk0_sel.hw,
> +		[CLKID_SD_EMMC_B_CLK0_DIV]  = &gxbb_sd_emmc_b_clk0_div.hw,
> +		[CLKID_SD_EMMC_B_CLK0]	    = &gxbb_sd_emmc_b_clk0.hw,
> +		[CLKID_SD_EMMC_C_CLK0_SEL]  = &gxbb_sd_emmc_c_clk0_sel.hw,
> +		[CLKID_SD_EMMC_C_CLK0_DIV]  = &gxbb_sd_emmc_c_clk0_div.hw,
> +		[CLKID_SD_EMMC_C_CLK0]	    = &gxbb_sd_emmc_c_clk0.hw,
>  		[NR_CLKS]		    = NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -1422,6 +1590,9 @@ static struct clk_gate *const gxbb_clk_gates[] = {
>  	&gxbb_cts_amclk,
>  	&gxbb_cts_mclk_i958,
>  	&gxbb_32k_clk,
> +	&gxbb_sd_emmc_a_clk0,
> +	&gxbb_sd_emmc_b_clk0,
> +	&gxbb_sd_emmc_c_clk0,
>  };
>  
>  static struct clk_mux *const gxbb_clk_muxes[] = {
> @@ -1434,6 +1605,9 @@ static struct clk_mux *const gxbb_clk_muxes[] = {
>  	&gxbb_cts_mclk_i958_sel,
>  	&gxbb_cts_i958,
>  	&gxbb_32k_clk_sel,
> +	&gxbb_sd_emmc_a_clk0_sel,
> +	&gxbb_sd_emmc_b_clk0_sel,
> +	&gxbb_sd_emmc_c_clk0_sel,
>  };
>  
>  static struct clk_divider *const gxbb_clk_dividers[] = {
> @@ -1443,6 +1617,9 @@ static struct clk_divider *const gxbb_clk_dividers[] = {
>  	&gxbb_mali_1_div,
>  	&gxbb_cts_mclk_i958_div,
>  	&gxbb_32k_clk_div,
> +	&gxbb_sd_emmc_a_clk0_div,
> +	&gxbb_sd_emmc_b_clk0_div,
> +	&gxbb_sd_emmc_c_clk0_div,
>  };
>  
>  static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
> 

Applied to clk-meson's next/drivers.
