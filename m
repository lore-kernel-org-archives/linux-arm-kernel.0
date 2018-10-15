From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Oct 2018 09:32:07 +0200
Subject: [PATCH V4 05/11] clk: imx: scu: add scu clock gate
In-Reply-To: <1539504194-28289-6-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181015073207.66npcgegibl2rybb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2018 at 08:07:56AM +0000, A.s. Dong wrote:
> +/* Write to the LPCG bits. */
> +static int clk_gate_scu_enable(struct clk_hw *hw)
> +{
> +	struct clk_gate_scu *gate = to_clk_gate_scu(hw);
> +	u32 reg;
> +
> +	if (gate->reg) {
> +		reg = readl(gate->reg);
> +		reg &= ~(CLK_GATE_SCU_LPCG_MASK << gate->bit_idx);
> +		if (gate->hw_gate)
> +			reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
> +				CLK_GATE_SCU_LPCG_SW_SEL) << gate->bit_idx;
> +		else
> +			reg |= (CLK_GATE_SCU_LPCG_SW_SEL << gate->bit_idx);
> +		writel(reg, gate->reg);
> +	}

These register manipulations look like they need locking.

> +
> +	return 0;
> +}
> +
> +struct clk_hw *clk_register_gate_scu(const char *name, const char *parent_name,
> +				     unsigned long flags, u32 rsrc_id,
> +				     u8 clk_type, void __iomem *reg,
> +				     u8 bit_idx, bool hw_gate)
> +{
> +	struct clk_gate_scu *gate;
> +	struct clk_init_data init;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	gate->rsrc_id = rsrc_id;
> +	gate->clk_type = clk_type;
> +	if (reg) {
> +		gate->reg = ioremap((phys_addr_t)reg, SZ_64K);

ioremap never takes a void __iomem * as argument. Given that you have to
cast it here to another type and to void __iomem * when calling this
function is a clear sign that the type of this variable is poorly
chosen.

> +		if (!gate->reg) {
> +			kfree(gate);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	gate->bit_idx = bit_idx;
> +	gate->hw_gate = hw_gate;
> +
> +	init.name = name;
> +	init.ops = &clk_gate_scu_ops;
> +	init.flags = flags;
> +	init.parent_names = parent_name ? &parent_name : NULL;
> +	init.num_parents = parent_name ? 1 : 0;
> +
> +	gate->hw.init = &init;
> +
> +	hw = &gate->hw;
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		iounmap(gate->reg);

Is iounmap on a NULL pointer allowed? Otherwise the error path is wrong
here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
