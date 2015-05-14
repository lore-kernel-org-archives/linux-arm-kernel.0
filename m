From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 May 2015 16:41:31 -0700
Subject: [PATCH v2] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <1428848090-14638-1-git-send-email-21cnbao@gmail.com>
References: <1428848090-14638-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150514234131.GB31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
> 
> the hardware node includes both clock and reset support, so it
> is named as "car".
> this patch implements Flexible clocks(mux, divider, gate), Selectable
> clock(mux, divider, gate), root clock(gate),leaf clock(gate), others.
> it also implements the reset controller functionality.
> 
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Sorry for late review. I wasn't Cc'ed on the patch.

> +
> +
> +static void *sirfsoc_clk_vbase, *sirfsoc_clk_vbase;

Missing __iomem and duplicate sirfsoc_clk_vbase.

> +static struct clk_onecell_data clk_data;
> +
> +static const struct clk_div_table pll_div_table[] = {
> +	{ .val = 0, .div = 1 },
> +	{ .val = 1, .div = 2 },
> +	{ .val = 2, .div = 4 },
> +	{ .val = 3, .div = 8 },
> +	{ .val = 4, .div = 16 },
> +	{ .val = 5, .div = 32 },
> +};
> +
> +struct clk_pll {
> +	struct clk_hw hw;
> +	unsigned short regofs;  /* register offset */
> +};
> +#define to_pllclk(_hw) container_of(_hw, struct clk_pll, hw)
> +
> +struct clk_dto {
> +	struct clk_hw hw;
> +	unsigned short inc_offset;  /* dto increment offset */
> +	unsigned short src_offset;  /* dto src offset */

Why not use u16 instead of unsigned short?

> +};
> +#define to_dtoclk(_hw) container_of(_hw, struct clk_dto, hw)
> +
[...]
> +
> +/*
> +  ABPLL
> +  interger_n mode: Fvco = Fin * 2 * NF / NR

s/interger_n/integer_n/ ?

> +  Spread Spectrum mode: Fvco = Fin * SSN / NR
> +  SSN = 2^24 / (256 * ((ssdiv >> ssdepth) << ssdepth) + (ssmod << ssdepth))
> + */
> +static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
> +	unsigned long parent_rate)
[...]
> +
> +/*
> +   DTO in clkc, default enable double resolution mode
> +   double resolution mode:fout = fin * finc / 2^29
> +   normal mode:fout = fin * finc / 2^28
> + */

Nitpick: Comments should have a '*' at the beginning of each
line.

> +static int dto_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_dto *clk = to_dtoclk(hw);
> +	int reg;
> +
> +	reg = clk->src_offset + SIRFSOC_CLKC_AUDIO_DTO_ENA - SIRFSOC_CLKC_AUDIO_DTO_SRC;
> +
> +	return !!(clkc_readl(reg) & BIT(0));
> +
[...]
> +static struct clk_dto clk_audio_dto = {
> +	.inc_offset = SIRFSOC_CLKC_AUDIO_DTO_INC,
> +	.src_offset = SIRFSOC_CLKC_AUDIO_DTO_SRC,
> +	.hw = {
> +		.init = &clk_audiodto_init,
> +	},
> +};
> +
> +static const char *disp0dto_clk_parents[] = {

If you rebase onto clk-next you can make all these parent string
arrays const char * const so that checkpatch doesn't complain.

> +	"sys0pll_clk1",
> +	"sys1pll_clk1",
> +	"sys3pll_clk1",
> +};
> +
[...]
> +
> +static int unit_clk_enable(struct clk_hw *hw)
> +{
> +	u32 reg;
> +	struct clk_unit *clk = to_unitclk(hw);
> +	unsigned long flags = 0;

Unnecessary initialization.

> +
> +	reg = clk->regofs;
> +
> +	spin_lock_irqsave(clk->lock, flags);
> +	clkc_writel(BIT(clk->bit), reg);
> +	spin_unlock_irqrestore(clk->lock, flags);
> +	return 0;
> +}
> +
> +static void unit_clk_disable(struct clk_hw *hw)
> +{
> +	u32  reg;
> +	struct clk_unit *clk = to_unitclk(hw);
> +	unsigned long flags = 0;

Unnecessary initialization.

> +
> +	reg = clk->regofs + SIRFSOC_CLKC_ROOT_CLK_EN0_CLR - SIRFSOC_CLKC_ROOT_CLK_EN0_SET;
> +
> +	spin_lock_irqsave(clk->lock, flags);
> +	clkc_writel(BIT(clk->bit), reg);
> +	spin_unlock_irqrestore(clk->lock, flags);
> +}
> +
> +static struct clk_ops unit_clk_ops = {
> +	.is_enabled = unit_clk_is_enabled,
> +	.enable = unit_clk_enable,
> +	.disable = unit_clk_disable,
> +};
> +
> +static struct clk * __init
> +atlas7_unit_clk_register(struct device *dev, const char *name,
> +		 const char *parent_name, unsigned long flags,
> +		 u32 regofs, u8 bit, spinlock_t *lock)
> +{
> +	struct clk *clk;
> +	struct clk_unit *unit;
> +	struct clk_init_data init;
> +
> +	unit = kzalloc(sizeof(*unit), GFP_KERNEL);
> +	if (!unit) {
> +		pr_err("could not alloc unit clock %s\n",
> +			name);

Useless error message. Please run checkpatch.


> +		return ERR_PTR(-ENOMEM);
> +	}
> +	init.name = name;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);

Why the parenthesis?

> +	init.ops = &unit_clk_ops;
> +	init.flags = flags;
> +
> +	unit->hw.init = &init;
> +	unit->regofs = regofs;
> +	unit->bit = bit;
> +	unit->lock = lock;
> +
> +	clk = clk_register(dev, &unit->hw);
> +	if (IS_ERR(clk))
> +		kfree(unit);
> +
> +	return clk;
> +}
> +
> +static struct atlas7_reset_desc atlas7_reset_unit[] = {
> +	{"PWM", 0x0244, 0, 0x0320, 0, &leaf0_gate_lock}, /*0-5*/

Style nitpick: Please put some space around the braces here.

> +	{"THCGUM", 0x0244, 3, 0x0320, 1, &leaf0_gate_lock},
> +	{"CVD", 0x04A0, 0, 0x032C, 0, &leaf1_gate_lock},
> +	{"TIMER", 0x04A0, 1, 0x032C, 1, &leaf1_gate_lock},
> +	{"PULSEC", 0x04A0, 2, 0x032C, 2, &leaf1_gate_lock},
[...]
> +
> +static int atlas7_reset_module(struct reset_controller_dev *rcdev,
> +					unsigned long reset_idx)
> +{
> +	struct atlas7_reset_desc *reset = &atlas7_reset_unit[reset_idx];
> +	unsigned long flags = 0;

Unnecessary initialization.

> +
> +	if (reset_idx >= rcdev->nr_resets)
> +		return -EINVAL;

Does this actually happen? Seems like the reset framework should
be checking this.

> +	/*
> +	 * HW suggest unit reset sequence:
> +	 * assert sw reset (0)
> +	 * setting sw clk_en to if the clock was disabled before reset
> +	 * delay 16 clocks
> +	 * disable clock (sw clk_en = 0)
> +	 * de-assert reset (1)
> +	 * after this sequence, restore clock or not is decided by SW
> +	 */
> +
> +	spin_lock_irqsave(reset->lock, flags);
> +	/* clock enable or not */
> +	if (clkc_readl(reset->clk_ofs + 8) & (1 << reset->clk_bit)) {
> +		clkc_writel(1 << reset->rst_bit, reset->rst_ofs + 4);
> +		udelay(2);
> +		clkc_writel(1 << reset->clk_bit, reset->clk_ofs + 4);
> +		clkc_writel(1 << reset->rst_bit, reset->rst_ofs);
> +		/* restore clock enable */
> +		clkc_writel(1 << reset->clk_bit, reset->clk_ofs);
> +	} else {
> +		clkc_writel(1 << reset->rst_bit, reset->rst_ofs + 4);
> +		clkc_writel(1 << reset->clk_bit, reset->clk_ofs);
> +		udelay(2);
> +		clkc_writel(1 << reset->clk_bit, reset->clk_ofs + 4);
> +		clkc_writel(1 << reset->rst_bit, reset->rst_ofs);
> +	}
> +	spin_unlock_irqrestore(reset->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct reset_control_ops atlas7_rst_ops = {

const?

> +	.reset = atlas7_reset_module,
> +};
> +
> +
> +void __init atlas7_clk_init(struct device_node *np)

static

> +{
> +	struct clk *clk;
> +	struct atlas7_div_init_data *div;
> +	struct atlas7_mux_init_data *mux;
> +	struct atlas7_unit_init_data *unit;
> +	int i;
> +	int ret;
> +
> +	sirfsoc_clk_vbase = of_iomap(np, 0);
> +	if (!sirfsoc_clk_vbase)
> +		panic("unable to map clkc registers\n");
> +
> +	of_node_put(np);
> +	/* These are always available (32k osc xinw and 26MHz osc xin) */
> +	clk_register_fixed_rate(NULL, "xinw", NULL,
> +		CLK_IS_ROOT, 32768);
> +	clk_register_fixed_rate(NULL, "xin", NULL,
> +		CLK_IS_ROOT, 26000000);

Should these be in DT? I don't imagine they're part of the SoC?

> +
> +
> +	for (i = 0; i < ARRAY_SIZE(divider_list); i++) {
> +		div = &divider_list[i];
> +		clk = clk_register_divider(NULL, div->div_name,
> +			div->parent_name, div->divider_flags, sirfsoc_clk_vbase + div->div_offset,
> +			div->shift, div->width, 0, div->lock);
> +		BUG_ON(!clk);
> +		clk = clk_register_gate(NULL, div->gate_name, div->div_name,
> +			div->gate_flags, sirfsoc_clk_vbase + div->gate_offset,
> +				div->gate_bit, 0, div->lock);
> +		BUG_ON(!clk);
> +	}
> +	/* ignore selector status register check */
> +	for (i = 0; i < ARRAY_SIZE(mux_list); i++) {
> +		mux = &mux_list[i];
> +		clk = clk_register_mux(NULL, mux->mux_name, mux->parent_names,
> +			       mux->parent_num, mux->flags,
> +			       sirfsoc_clk_vbase + mux->mux_offset,
> +			       mux->shift, mux->width,
> +			       mux->mux_flags, NULL);
> +		BUG_ON(!clk);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(unit_list); i++) {
> +		unit = &unit_list[i];
> +		atlas7_clks[i] = atlas7_unit_clk_register(NULL, unit->unit_name, unit->parent_name,
> +				unit->flags, unit->regofs, unit->bit, unit->lock);
> +		BUG_ON(!atlas7_clks[i]);
> +	}
> +
> +	clk_data.clks = atlas7_clks;
> +	clk_data.clk_num = ARRAY_SIZE(unit_list);
> +
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +	BUG_ON(ret);
> +
> +	atlas7_rst_ctlr.of_node = np;
> +	atlas7_rst_ctlr.nr_resets = ARRAY_SIZE(atlas7_reset_unit);
> +	reset_controller_register(&atlas7_rst_ctlr);
> +	arm_pm_restart = atlas7_restart;

arm_pm_restart can be hooked generically with
register_restart_handler(). Can you please use that instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
