From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Nov 2018 12:14:48 -0800
Subject: [PATCH V6 5/6] clk: imx: add lpcg clock support
In-Reply-To: <1541862894-8209-6-git-send-email-aisheng.dong@nxp.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
 <1541862894-8209-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154274488829.88331.14073987677874819400@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-11-10 07:20:04)
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> new file mode 100644
> index 0000000..54a1cb3
> --- /dev/null
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP
> + *     Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(imx_lpcg_scu_lock);
> +
> +#define CLK_GATE_SCU_LPCG_MASK         0x3
> +#define CLK_GATE_SCU_LPCG_HW_SEL       BIT(0)
> +#define CLK_GATE_SCU_LPCG_SW_SEL       BIT(1)
> +
> +struct clk_lpcg_scu {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       u8 bit_idx;
> +       bool hw_gate;

What does hw_gate mean? Can you add kernel-doc to this structure?

> +};
> +
> +#define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
> +
> +/* Write to the LPCG bits. */

Please remove this useless comment.

> +static int clk_lpcg_scu_enable(struct clk_hw *hw)
> +{
> +       struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> +       unsigned long flags = 0;

Don't initialize flags here.

> +       u32 reg;
> +
> +       spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
> +
> +       if (clk->reg) {
> +               reg = readl(clk->reg);
> +               reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> +               if (clk->hw_gate)
> +                       reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
> +                               CLK_GATE_SCU_LPCG_SW_SEL) << clk->bit_idx;
> +               else
> +                       reg |= (CLK_GATE_SCU_LPCG_SW_SEL << clk->bit_idx);
> +               writel(reg, clk->reg);
> +       }
> +
> +       spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
> +
> +       return 0;
> +}
> +
> +static void clk_lpcg_scu_disable(struct clk_hw *hw)
> +{
> +       struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> +       unsigned long flags = 0;

Same comment.

> +       u32 reg;
> +
> +       spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
> +
> +       if (clk->reg) {

Why do we even call this function if there isn't a clk->reg value?
Can't we just not assign the clk_ops in that case?

> +               reg = readl(clk->reg);
> +               reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> +               writel(reg, clk->reg);
> +       }
> +
> +       spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
> +}
> +
