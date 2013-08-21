From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 21 Aug 2013 14:18:23 -0700
Subject: [PATCH v7 03/11] clk: gate: add CLK_GATE_SEPERATED_REG flag
In-Reply-To: <1376965873-14431-4-git-send-email-haojian.zhuang@linaro.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130821211823.8231.86712@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Haojian Zhuang (2013-08-19 19:31:05)
> In Hisilicon Hi3620 SoC, there're two kinds of clock gates.
> 
> 1. The same bit in one register controls enabling, disabling or reading status
> of the clock gate. It's the normal clock gate register.
> 
> 2. The same bit in three continuous registers control enabling,
> disabling or reading status of the clock gate. Since these three
> registers are enabling, disabling and reading status of clock gate.
> 
> Now reuse common clock gate driver to support the second case with the new
> CLK_GATE_SEPERATED_REG flag.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Hi Haojian,

This is too implementation-specific to be pushed into the common gate
clock. Instead you should write a custom gate implementation that uses
these three registers without any flag. Your DT binding for this new
clock type should list those three register addresses via the 'reg'
property.

Regards,
Mike

> ---
>  drivers/clk/clk-gate.c       | 18 +++++++++++++++---
>  include/linux/clk-provider.h |  7 +++++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index 790306e..5dedfb3 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -58,7 +58,10 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
>                 if (set)
>                         reg |= BIT(gate->bit_idx);
>         } else {
> -               reg = readl(gate->reg);
> +               if (gate->flags & CLK_GATE_SEPERATED_REG)
> +                       reg = 0;
> +               else
> +                       reg = readl(gate->reg);
>  
>                 if (set)
>                         reg |= BIT(gate->bit_idx);
> @@ -66,7 +69,13 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
>                         reg &= ~BIT(gate->bit_idx);
>         }
>  
> -       writel(reg, gate->reg);
> +       if (gate->flags & CLK_GATE_SEPERATED_REG) {
> +               if (enable)
> +                       writel(reg, gate->reg + CLK_GATE_ENABLE_REG);
> +               else
> +                       writel(reg, gate->reg + CLK_GATE_DISABLE_REG);
> +       } else
> +               writel(reg, gate->reg);
>  
>         if (gate->lock)
>                 spin_unlock_irqrestore(gate->lock, flags);
> @@ -89,7 +98,10 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
>         u32 reg;
>         struct clk_gate *gate = to_clk_gate(hw);
>  
> -       reg = readl(gate->reg);
> +       if (gate->flags & CLK_GATE_SEPERATED_REG)
> +               reg = readl(gate->reg + CLK_GATE_STATUS_REG);
> +       else
> +               reg = readl(gate->reg);
>  
>         /* if a set bit disables this clk, flip it before masking */
>         if (gate->flags & CLK_GATE_SET_TO_DISABLE)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 9487b96..0fdc13f 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -214,6 +214,8 @@ void of_fixed_clk_setup(struct device_node *np);
>   *   of this register, and mask of gate bits are in higher 16-bit of this
>   *   register.  While setting the gate bits, higher 16-bit should also be
>   *   updated to indicate changing gate bits.
> + * CLK_GATE_SEPERATED_REG - The enable, disable & status register are three
> + *     seperated registers.
>   */
>  struct clk_gate {
>         struct clk_hw hw;
> @@ -225,6 +227,11 @@ struct clk_gate {
>  
>  #define CLK_GATE_SET_TO_DISABLE                BIT(0)
>  #define CLK_GATE_HIWORD_MASK           BIT(1)
> +#define CLK_GATE_SEPERATED_REG         BIT(2)
> +
> +#define CLK_GATE_ENABLE_REG            (0x00)
> +#define CLK_GATE_DISABLE_REG           (0x04)
> +#define CLK_GATE_STATUS_REG            (0x08)
>  
>  extern const struct clk_ops clk_gate_ops;
>  struct clk *clk_register_gate(struct device *dev, const char *name,
> -- 
> 1.8.1.2
