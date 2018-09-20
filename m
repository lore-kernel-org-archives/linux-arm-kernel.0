From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 20 Sep 2018 16:45:49 -0700
Subject: [PATCH v7 2/5] clk: imx: add fractional PLL output clock
In-Reply-To: <1537438000-20313-3-git-send-email-abel.vesa@nxp.com>
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
 <1537438000-20313-3-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAHQ1cqHkp5-XyLAPTWPota6cxM79oaToZEQpa+tewH4CVt9XSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 3:07 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> This is a new clock type introduced on i.MX8.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile       |   1 +
>  drivers/clk/imx/clk-frac-pll.c | 230 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h          |   3 +
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-frac-pll.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 8c3baa7..4893c1f 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -6,6 +6,7 @@ obj-y += \
>         clk-cpu.o \
>         clk-fixup-div.o \
>         clk-fixup-mux.o \
> +       clk-frac-pll.o \
>         clk-gate-exclusive.o \
>         clk-gate2.o \
>         clk-pllv1.o \
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
> new file mode 100644
> index 0000000..c80c6ed
> --- /dev/null
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define PLL_CFG0               0x0
> +#define PLL_CFG1               0x4
> +
> +#define PLL_LOCK_STATUS                BIT(31)
> +#define PLL_PD                 19
> +#define PLL_PD_MASK            BIT(PLL_PD)
> +#define PLL_BYPASS             14
> +#define PLL_BYPASS_MASK                BIT(PLL_BYPASS)
> +#define PLL_NEWDIV_VAL         BIT(12)
> +#define PLL_NEWDIV_ACK         BIT(11)
> +#define PLL_FRAC_DIV_MASK      0xffffff
> +#define PLL_INT_DIV_MASK       0x7f
> +#define PLL_OUTPUT_DIV_MASK    0x1f
> +#define PLL_FRAC_DENOM         0x1000000
> +
> +struct clk_frac_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *base;
> +};
> +
> +#define to_clk_frac_pll(_hw) container_of(_hw, struct clk_frac_pll, hw)
> +
> +static int clk_wait_lock(struct clk_frac_pll *pll)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +       u32 val;
> +
> +       /* Wait for PLL to lock */
> +       do {
> +               if (readl_relaxed(pll->base) & PLL_LOCK_STATUS)
> +                       break;
> +               if (time_after(jiffies, timeout))
> +                       break;
> +       } while (1);
> +
> +       return readl_poll_timeout(pll->base, val,
> +                                       val & PLL_LOCK_STATUS, 0, 1000);

Is this code intentional? It seems to me those two are almost
identical wait loops, so it's a bit confusing to see without at least
a comment why it is done that way. If it is intentional, can the first
loop be replaced with readx_poll_timeout(readl_relaxed, ...) ?

> +}
> +
> +static int clk_wait_ack(struct clk_frac_pll *pll)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(50);
> +       u32 val;
> +
> +       /* return directly if the pll is in powerdown or in bypass */
> +       if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
> +               return 0;
> +
> +       /* Wait for the pll's divfi and divff to be reloaded */
> +       do {
> +               if (readl_relaxed(pll->base) & PLL_NEWDIV_ACK)
> +                       break;
> +               if (time_after(jiffies, timeout))
> +                       break;
> +       } while (1);
> +
> +       return readl_poll_timeout(pll->base, val,
> +                                       val & PLL_NEWDIV_ACK, 0, 1000);
> +}

Ditto.

> +
> +static int clk_pll_prepare(struct clk_hw *hw)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       val &= ~PLL_PD_MASK;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +       return clk_wait_lock(pll);
> +}
> +
> +static void clk_pll_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       val |= PLL_PD_MASK;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +}
> +
> +static int clk_pll_is_prepared(struct clk_hw *hw)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       return (val & PLL_PD_MASK) ? 0 : 1;
> +}
> +
> +static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val, divff, divfi, divq;
> +       u64 temp64;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
> +       val = readl_relaxed(pll->base + PLL_CFG1);
> +       divff = (val >> 7) & PLL_FRAC_DIV_MASK;

Just as a suggestion you can do:

#define PLL_FRAC_DIV GENMASK(30, 7)

divff = FIELD_GET(PLL_FRAC_DIV, val)

it's a bit nicer (IMHO, of course) because it allows you to avoid
having to encode shit and mask separately and mask definition can be
easily verified against the datasheet.

Thanks,
Andrey Smirnov
