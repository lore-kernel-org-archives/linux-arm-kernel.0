From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 13:04:53 -0800
Subject: [PATCH 2/2] clk: zte: add audio clocks for zx296718
In-Reply-To: <1481189157-8995-2-git-send-email-shawnguo@kernel.org>
References: <1481189157-8995-1-git-send-email-shawnguo@kernel.org>
 <1481189157-8995-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20161208210453.GH5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08, Shawn Guo wrote:
> +
> +static int __init audio_clocks_init(struct device_node *np)
> +{
> +	void __iomem *reg_base;
> +	int i, ret;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		pr_err("%s: Unable to map audio clk base\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(audio_mux_clk); i++) {
> +		if (audio_mux_clk[i].id)
> +			audio_hw_onecell_data.hws[audio_mux_clk[i].id] =
> +					&audio_mux_clk[i].mux.hw;
> +
> +		audio_mux_clk[i].mux.reg += (u64)reg_base;
> +		ret = clk_hw_register(NULL, &audio_mux_clk[i].mux.hw);
> +		if (ret) {
> +			pr_warn("audio clk %s init error!\n",
> +				audio_mux_clk[i].mux.hw.init->name);
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(audio_adiv_clk); i++) {
> +		if (audio_adiv_clk[i].id)
> +			audio_hw_onecell_data.hws[audio_adiv_clk[i].id] =
> +					&audio_adiv_clk[i].hw;
> +
> +		audio_adiv_clk[i].reg_base += (u64)reg_base;
> +		ret = clk_hw_register(NULL, &audio_adiv_clk[i].hw);
> +		if (ret) {
> +			pr_warn("audio clk %s init error!\n",
> +				audio_adiv_clk[i].hw.init->name);
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(audio_div_clk); i++) {
> +		if (audio_div_clk[i].id)
> +			audio_hw_onecell_data.hws[audio_div_clk[i].id] =
> +					&audio_div_clk[i].div.hw;
> +
> +		audio_div_clk[i].div.reg += (u64)reg_base;
> +		ret = clk_hw_register(NULL, &audio_div_clk[i].div.hw);
> +		if (ret) {
> +			pr_warn("audio clk %s init error!\n",
> +				audio_div_clk[i].div.hw.init->name);
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(audio_gate_clk); i++) {
> +		if (audio_gate_clk[i].id)
> +			audio_hw_onecell_data.hws[audio_gate_clk[i].id] =
> +					&audio_gate_clk[i].gate.hw;
> +
> +		audio_gate_clk[i].gate.reg += (u64)reg_base;
> +		ret = clk_hw_register(NULL, &audio_gate_clk[i].gate.hw);
> +		if (ret) {
> +			pr_warn("audio clk %s init error!\n",
> +				audio_gate_clk[i].gate.hw.init->name);
> +		}
> +	}
> +
> +	if (of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &audio_hw_onecell_data))
> +		panic("could not register clk provider\n");

Why don't we return error? We returned errors before if we
couldn't map the ioregion.

> +	pr_info("audio-clk init over, nr:%d\n", AUDIO_NR_CLKS);

debug noise?

> +
> +	return 0;
> +}
> +
>  static const struct of_device_id zx_clkc_match_table[] = {
>  	{ .compatible = "zte,zx296718-topcrm", .data = &top_clocks_init },
>  	{ .compatible = "zte,zx296718-lsp0crm", .data = &lsp0_clocks_init },
>  	{ .compatible = "zte,zx296718-lsp1crm", .data = &lsp1_clocks_init },
> +	{ .compatible = "zte,zx296718-audiocrm", .data = &audio_clocks_init },
>  	{ }
>  };
>  
> diff --git a/drivers/clk/zte/clk.c b/drivers/clk/zte/clk.c
> index c4c1251bc1e7..ea97024b37aa 100644
> --- a/drivers/clk/zte/clk.c
> +++ b/drivers/clk/zte/clk.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> +#include <linux/gcd.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
> @@ -310,3 +311,151 @@ struct clk *clk_register_zx_audio(const char *name,
>  
>  	return clk;
>  }
> +
> +#define CLK_AUDIO_DIV_FRAC	BIT(0)
> +#define CLK_AUDIO_DIV_INT	BIT(1)
> +#define CLK_AUDIO_DIV_UNCOMMON	BIT(1)
> +
> +#define CLK_AUDIO_DIV_FRAC_NSHIFT	16
> +#define CLK_AUDIO_DIV_INT_FRAC_RE	BIT(16)
> +#define CLK_AUDIO_DIV_INT_FRAC_MAX	(0xffff)
> +#define CLK_AUDIO_DIV_INT_FRAC_MIN	(0x2)
> +#define CLK_AUDIO_DIV_INT_INT_SHIFT	24
> +#define CLK_AUDIO_DIV_INT_INT_WIDTH	4
> +
> +#define to_clk_zx_audio_div(_hw) container_of(_hw, struct clk_zx_audio_divider, hw)
> +
> +static unsigned long audio_calc_rate(struct clk_zx_audio_divider *audio_div,
> +				     u32 reg_frac, u32 reg_int,
> +				     unsigned long parent_rate)
> +{
> +	unsigned long rate, m, n;
> +
> +	if (audio_div->table) {
> +		const struct zx_clk_audio_div_table *divt = audio_div->table;
> +
> +		for (; divt->rate; divt++) {
> +			if ((divt->int_reg == reg_int) && (divt->frac_reg == reg_frac))

Please remove extra parenthesis here.

> +				return divt->rate;
> +		}
> +	}
> +	if (audio_div->table)
> +		pr_warn("cannot found the config(int_reg:0x%x, frac_reg:0x%x) in table, we will caculate it\n",
> +			reg_int, reg_frac);
> +
> +	m = reg_frac & 0xffff;
> +	n = (reg_frac >> 16) & 0xffff;
> +
> +	m = (reg_int & 0xffff) * n + m;
> +	rate = (parent_rate * n) / m;
> +
> +	return rate;
> +}
> +
> +static void audio_calc_reg(struct clk_zx_audio_divider *audio_div,
> +			   struct zx_clk_audio_div_table *div_table,
> +			   unsigned long rate, unsigned long parent_rate)
> +{
> +	unsigned int reg_int, reg_frac;
> +	unsigned long m, n, div;
> +
> +	if (audio_div->table) {
> +		const struct zx_clk_audio_div_table *divt = audio_div->table;
> +
> +		for (; divt->rate; divt++) {
> +			if (divt->rate == rate) {
> +				div_table->rate = divt->rate;
> +				div_table->int_reg = divt->int_reg;
> +				div_table->frac_reg = divt->frac_reg;
> +				return;
> +			}
> +		}
> +	}
> +	if (audio_div->table)
> +		pr_warn("cannot found the rate(%ld) in table, we will caculate the config\n",
> +			rate);
> +
> +	reg_int = parent_rate / rate;
> +
> +	if (reg_int > CLK_AUDIO_DIV_INT_FRAC_MAX)
> +		reg_int = CLK_AUDIO_DIV_INT_FRAC_MAX;
> +	else if (reg_int < CLK_AUDIO_DIV_INT_FRAC_MIN)
> +		reg_int = 0;
> +	m = parent_rate - rate * reg_int;
> +	n = rate;
> +
> +	div = gcd(m, n);
> +	m = m / div;
> +	n = n / div;
> +
> +	if ((m >> 16) || (n >> 16)) {
> +		if (m > n) {
> +			n = n * 0xffff / m;
> +			m = 0xffff;
> +		} else {
> +			m = m * 0xffff / n;
> +			n = 0xffff;
> +		}
> +	}
> +	reg_frac = m | (n << 16);
> +
> +	div_table->rate = (ulong)(parent_rate * n) / ((ulong)reg_int * n + m);

Please don't use ulong, use unsigned long. Also consider using
local variables so the line isn't overly long.

> +	div_table->int_reg = reg_int;
> +	div_table->frac_reg = reg_frac;
> +}
[...]
> +
> +static int zx_audio_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct clk_zx_audio_divider *zx_audio_div = to_clk_zx_audio_div(hw);
> +	struct zx_clk_audio_div_table divt;
> +	unsigned int val;
> +
> +	audio_calc_reg(zx_audio_div, &divt, rate, parent_rate);
> +	if (divt.rate != rate)
> +		pr_info("the real rate is:%ld", divt.rate);

Debug noise?

> +
> +	writel_relaxed(divt.frac_reg, zx_audio_div->reg_base);
> +
> +	val = readl_relaxed(zx_audio_div->reg_base + 0x4);
> +	val &= ~0xffff;
> +	val |= divt.int_reg | CLK_AUDIO_DIV_INT_FRAC_RE;
> +	writel_relaxed(val, zx_audio_div->reg_base + 0x4);
> +
> +	mdelay(1);
> +
> +	val = readl_relaxed(zx_audio_div->reg_base + 0x4);
> +	val &= ~CLK_AUDIO_DIV_INT_FRAC_RE;
> +	writel_relaxed(val, zx_audio_div->reg_base + 0x4);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops zx_audio_div_ops = {
> +	.recalc_rate = zx_audio_div_recalc_rate,
> +	.round_rate = zx_audio_div_round_rate,
> +	.set_rate = zx_audio_div_set_rate,
> +};
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
