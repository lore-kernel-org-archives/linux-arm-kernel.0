From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 22 Jan 2013 09:55:52 -0800
Subject: [PATCH] clk: Add axi-clkgen driver
In-Reply-To: <1357755120-32735-1-git-send-email-lars@metafoo.de>
References: <1357755120-32735-1-git-send-email-lars@metafoo.de>
Message-ID: <20130122175552.24671.27893@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lars-Peter Clausen (2013-01-09 10:12:00)
<snip>
> +static void axi_clkgen_write(struct axi_clkgen *axi_clkgen,
> +       unsigned int reg, unsigned int val)
> +{
> +       iowrite32(val, axi_clkgen->base + reg);

Silly question: any reason to use this over readl()?  This is more for
my understanding than a real criticism.

> +}
> +
> +static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
> +       unsigned int reg, unsigned int *val)
> +{
> +       *val = ioread32(axi_clkgen->base + reg);

Same as above, any reason to use this over writel?

<snip>
> +static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
> +       unsigned long parent_rate)
> +{
> +       struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
> +       unsigned int d, m, dout;
> +       unsigned int reg;
> +
> +       axi_clkgen_read(axi_clkgen, AXI_CLKGEN_REG_CLK_OUT1, &reg);
> +       dout = (reg & 0x3f) + ((reg >> 6) & 0x3f);
> +       axi_clkgen_read(axi_clkgen, AXI_CLKGEN_REG_CLK_DIV, &reg);
> +       d = (reg & 0x3f) + ((reg >> 6) & 0x3f);
> +       axi_clkgen_read(axi_clkgen, AXI_CLKGEN_REG_CLK_FB1, &reg);
> +       m = (reg & 0x3f) + ((reg >> 6) & 0x3f);
> +
> +       if (d == 0 || dout == 0)
> +               return 0;
> +
> +       return parent_rate / d * m / dout;

Any chance of overflow here?  Maybe do_div should be used?

Regards,
Mike
