From: pavel@denx.de (Pavel Machek)
Date: Sun, 17 Mar 2013 19:35:08 +0100
Subject: [PATCHv1 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <1363211722-27237-3-git-send-email-dinguyen@altera.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
 <1363211722-27237-3-git-send-email-dinguyen@altera.com>
Message-ID: <20130317183508.GD4394@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Adds the main PLL clock groups for SOCFPGA into device tree file
> so that the clock framework to query the clock and clock rates

insert "works" here?

> appropriately.
> 

> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
> new file mode 100644
> index 0000000..38cf62b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
> @@ -0,0 +1,11 @@
> +Altera SOCFPGA Clock Manager
> +
> +Required properties:
> +- compatible : "altr,clk-mgr"
> +- reg : Should contain 1 register ranges(address and length)

"1 register range (address"... ?

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> @@ -0,0 +1,15 @@
> +- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
> +- clocks : shall be the input parent clock phandle for the clock. This is
> +	either an oscillator or a pll output.
> +- #clock-cells : from common clock binding; shall be set to 0.
> \ No newline at end of file

Newline would be nice :-).

> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index 2c855a6..9379b1c 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -1,5 +1,5 @@
>  /*
> - *  Copyright (C) 2012 Altera Corporation <www.altera.com>
> + *  Copyright (C) 2012-2013 Altera Corporation <www.altera.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -11,41 +11,173 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> + * Based from clk-highbank.c

"Based on"? Does it make sense to add
 * Copyright 2011-2012 Calxeda, Inc.
?

> +extern void __iomem *clk_mgr_base_addr;
> +
> +struct socfpga_clk {
> +	struct clk_hw hw;
> +	void __iomem	*reg;
> +	char *parent_name;
> +};

Either align all fields using tabs, or none. This looks weird.

> +static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
> +					 unsigned long parent_rate)
> +{
> +	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> +	unsigned long divf, divq, vco_freq, reg;
> +	unsigned long bypass;
> +
> +	reg = readl(socfpgaclk->reg);
> +	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);

Would it make sense to create structure for clk_mgr_base_addr, too? At
least code would be consistent that way.

> +static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
> +					     unsigned long parent_rate)
> +{
> +	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> +	u32 div;
> +
> +	/* mpuclk, mainclk, and dbg_base_clk divisors are fixed.*/
> +	if (strcmp(hwclk->init->name, "mpuclk") == 0)
> +		div = 2;
> +	else if ((strcmp(hwclk->init->name, "mainclk") == 0) ||
> +			(strcmp(hwclk->init->name, "dbg_base_clk") == 0))
> +		div = 4;
> +	else
> +		div = ((readl(socfpgaclk->reg) & 0x1ff) + 1);

Would it make sense to cache have div value in struct socfpga_clk
... so that it does not have to be recomputed based on strcmp?

Otherwise it looks good to me.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
