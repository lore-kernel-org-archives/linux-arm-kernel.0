From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 12:22:31 -0600
Subject: [PATCH 07/12] clk: tegra: move audio clk to common file
In-Reply-To: <1379515331-19427-8-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-8-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <524086E7.3020903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:40 AM, Peter De Schrijver wrote:
> Move audio clocks and PLLA initialization to a common file so it can be used by
> multiple Tegra SoCs.

> diff --git a/drivers/clk/tegra/clk-tegra-audio.c b/drivers/clk/tegra/clk-tegra-audio.c

> +static struct div_nmp pllp_nmp = {
> +	.divm_shift = 0,
> +	.divm_width = 5,
> +	.divn_shift = 8,
> +	.divn_width = 10,
> +	.divp_shift = 20,
> +	.divp_width = 3,
> +};
> +
> +static struct tegra_clk_pll_freq_table pll_a_freq_table[] = {
> +	{9600000, 282240000, 147, 5, 0, 4},
> +	{9600000, 368640000, 192, 5, 0, 4},
> +	{9600000, 240000000, 200, 8, 0, 8},
> +
> +	{28800000, 282240000, 245, 25, 0, 8},
> +	{28800000, 368640000, 320, 25, 0, 8},
> +	{28800000, 240000000, 200, 24, 0, 8},
> +	{0, 0, 0, 0, 0, 0},
> +};
> +
> +static struct tegra_clk_pll_params pll_a_params = {
> +	.input_min = 2000000,
> +	.input_max = 31000000,
> +	.cf_min = 1000000,
> +	.cf_max = 6000000,
> +	.vco_min = 200000000,
> +	.vco_max = 700000000,
> +	.base_reg = PLLA_BASE,
> +	.misc_reg = PLLA_MISC,
> +	.lock_mask = PLL_BASE_LOCK,
> +	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
> +	.lock_delay = 300,
> +	.div_nmp = &pllp_nmp,
> +};

I'm not convinced any of those tables are common across SoCs. In fact, I
can see definite differences in those tables between the 3 SoCs we
already have upstream... How will this be handled once you've enhanced
this series to handle all supported SoCs?
