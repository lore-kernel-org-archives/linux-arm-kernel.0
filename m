From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 21 Aug 2013 14:43:00 -0700
Subject: [PATCH v7 10/11] ARM: hi3xxx: add clk-hi3716
In-Reply-To: <1376965873-14431-11-git-send-email-haojian.zhuang@linaro.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130821214300.8231.81515@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Haojian Zhuang (2013-08-19 19:31:12)
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Zhang Mingjun <zhang.mingjun@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/hi3716.txt | 121 ++++++++++
>  drivers/clk/Makefile                               |   2 +-
>  drivers/clk/clk-hi3716.c                           | 268 +++++++++++++++++++++
>  3 files changed, 390 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3716.txt
>  create mode 100644 drivers/clk/clk-hi3716.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/hi3716.txt b/Documentation/devicetree/bindings/clock/hi3716.txt
> new file mode 100644
> index 0000000..60af61e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hi3716.txt
> @@ -0,0 +1,121 @@
> +Device Tree Clock bindings for hi3716
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Clock control register
> +Required properties:
> +- compatible : "hisilicon,clkbase"
> +- reg : Address and size of clkbase.
> +
> +Device Clocks
> +
> +Device clocks are required to have one or both of the following sets of
> +properties:
> +
> +
> +Gated device clocks:
> +
> +Required properties:
> +- compatible : "hisilicon,hi3716-clk-gate"
> +- gate-reg : shall be the register offset from clkbase and enable bit, reset bit

The 'reg' property is standard and well understood. Best not to try and
re-invent that with gate-reg.

Instead put the register address in the 'reg' property and the other
bits in separate properties.

The same goes for the *-reg properties below.

<snip>
> +static int hi3716_clkgate_prepare(struct clk_hw *hw)
> +{
> +       struct hi3716_clk *clk = to_clk_hi3716(hw);
> +       unsigned long flags = 0;
> +       u32 reg;
> +
> +       spin_lock_irqsave(&_lock, flags);
> +
> +       reg = readl_relaxed(clk->reg);
> +       reg &= ~BIT(clk->reset_bit);
> +       writel_relaxed(reg, clk->reg);
> +
> +       spin_unlock_irqrestore(&_lock, flags);
> +
> +       return 0;
> +}
> +
> +static void hi3716_clkgate_unprepare(struct clk_hw *hw)
> +{
> +       struct hi3716_clk *clk = to_clk_hi3716(hw);
> +       unsigned long flags = 0;
> +       u32 reg;
> +
> +       spin_lock_irqsave(&_lock, flags);
> +
> +       reg = readl_relaxed(clk->reg);
> +       reg |= BIT(clk->reset_bit);
> +       writel_relaxed(reg, clk->reg);
> +
> +       spin_unlock_irqrestore(&_lock, flags);
> +}
> +
> +static struct clk_ops hi3716_clkgate_ops = {
> +       .prepare        = hi3716_clkgate_prepare,
> +       .unprepare      = hi3716_clkgate_unprepare,
> +};

Why .prepare & .unprepare instead of .enable & .disable?

Regards,
Mike
