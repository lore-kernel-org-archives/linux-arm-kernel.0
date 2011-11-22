From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 22 Nov 2011 13:11:00 +0000
Subject: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
In-Reply-To: <1321926047-14211-5-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-5-git-send-email-mturquette@linaro.org>
Message-ID: <201111221311.00117.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 November 2011, Mike Turquette wrote:
> +static void clk_hw_gate_set_bit(struct clk *clk)
> +{
> +       struct clk_hw_gate *gate = to_clk_hw_gate(clk);
> +       u32 reg;
> +
> +       reg = __raw_readl(gate->reg);
> +       reg |= BIT(gate->bit_idx);
> +       __raw_writel(reg, gate->reg);
> +}

You cannot rely on __raw_readl() to do the right thing, especially
in architecture independent code. The safe (but slightly inefficient)
solution would be readl/writel. For ARM-only code, it would be best
to use readl_relaxed()/writel_relaxed(), but most architectures do
not implement that. We can probably add a set of helpers in asm-generic/
to define them to the default functions, like "#define readl_relaxed(x)
readl(x)", which I think is a good idea anyway.

	Arnd
