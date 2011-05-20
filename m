From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2011 13:37:03 +0200
Subject: [PATCH 4/4] clk: Add simple gated clock
In-Reply-To: <1305876469.327589.409938867568.4.gpush@pororo>
References: <1305876469.327589.409938867568.4.gpush@pororo>
Message-ID: <201105201337.03501.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2011 09:27:49 Jeremy Kerr wrote:
> +static int clk_gate_enable(struct clk_hw *clk)
> +{
> +       struct clk_gate *gate = to_clk_gate(clk);
> +       u32 reg;
> +
> +       reg = __raw_readl(gate->reg);
> +       reg |= 1 << gate->bit_idx;
> +       __raw_writel(reg, gate->reg);
> +
> +       return 0;
> +}

__raw_readl/__raw_writel is a rather bad choice for a common driver,
it might not do what you need. Unfortunately, readl() also wouldn't
do the right thing on all architectures, because it might only
be available on PCI buses. Maybe iowrite32 would be best here?

Instead of the bit_idx, a mask value might be better to avoid
confusion with the different ways of counting bits from one or
the other end.

	Arnd
