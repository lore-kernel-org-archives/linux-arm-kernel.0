From: pavel@denx.de (Pavel Machek)
Date: Fri, 17 May 2013 13:09:40 +0200
Subject: [PATCHv2 3/6] ARM: socfpga: Add support to gate peripheral clocks
In-Reply-To: <1368731117-4749-3-git-send-email-dinguyen@altera.com>
References: <1368731117-4749-1-git-send-email-dinguyen@altera.com>
 <1368731117-4749-3-git-send-email-dinguyen@altera.com>
Message-ID: <20130517110940.GA3466@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add support to gate the clocks that directly feed peripherals. For clocks
> with multiple parents, add the ability to determine the correct parent,
> and also set parents. Also add support to calculate and set the clocks'
> rate.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> CC: Mike Turquette <mturquette@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> CC: <linux@arm.linux.org.uk>
> 
> v2:
> - Fix space/indent errors
> - Add streq for strcmp == 0
> ---

> +static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
> +{
> +	u32 l4_src;
> +	u32 perpll_src;
> +	u8 parent;
> +
> +	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
> +		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> +		l4_src &= 0x1;
> +		parent = l4_src;
> +	} else if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
> +		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
> +		l4_src = ((l4_src & 0x2) >> 1);
> +		parent = l4_src;
> +	} else {
> +		perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
> +		if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
> +			perpll_src &= 0x3;
> +		else if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
> +			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
> +			perpll_src = ((perpll_src & 0xC) >> 2);
> +		else /*QSPI clock */
> +			perpll_src = ((perpll_src & 0x30) >> 4);
> +		parent = perpll_src;

I really don't like the "else" here. If some new clock name appears in
hwclk->init->name or if there's problem somewhere, it will just
silently operate wrong clock. WARN_ON(!streq(...))?

(I tried to append patch to previous email, with suggested
cleanups....)

> +		} else {/*QSPI clock */
> +			src_reg &= ~0x30;
> +			src_reg |= (parent << 4);
> +		}

Same here. (And there should be space after /* ).

> +	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
> +	if (WARN_ON(!socfpga_clk))
> +		return;
> +
> +	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
> +	if (rc)
> +		clk_gate[0] = 0;
> +
> +	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
> +	if (rc)
> +		socfpga_clk->fixed_div = 0;
> +	else
> +		socfpga_clk->fixed_div = fixed_div;
> +
> +	if (clk_gate[0]) {
> +		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
> +		socfpga_clk->hw.bit_idx = clk_gate[1];
> +
> +		gateclk_ops.enable = clk_gate_ops.enable;
> +		gateclk_ops.disable = clk_gate_ops.disable;
> +	}
> +

Could if (clk_gate[]) be moved one block above? It uses
partially-initialized array, so it would be nice to have code as clear
as possible.


> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	init.name = clk_name;
> +	init.ops = ops;
> +	init.flags = 0;
> +	while (i < SOCFGPA_MAX_PARENTS && (parent_name[i] =
> +			of_clk_get_parent_name(node, i)) != NULL)
> +		i++;

I'd suggest explicit loop, like

+       while (i < SOCFGPA_MAX_PARENTS) {
+               char *name = of_clk_get_parent_name(node, i);
+               parent_name[i] = name;
+               if (name == NULL)
+                       break;
                i++;
+       }

This is a bit too subtle.

> +	init.parent_names = parent_name;
> +	init.num_parents = i;
> +	socfpga_clk->hw.hw.init = &init;
> +
> +	clk = clk_register(NULL, &socfpga_clk->hw.hw);

init is local variable, yet pointer passed to it is in globally
alocated structure. What is going on there? Are there some comments
needed?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
