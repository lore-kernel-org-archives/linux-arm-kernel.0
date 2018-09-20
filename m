From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 20 Sep 2018 16:53:57 -0700
Subject: [PATCH v7 3/5] clk: imx: add SCCG PLL type
In-Reply-To: <1537438000-20313-4-git-send-email-abel.vesa@nxp.com>
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
 <1537438000-20313-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <CAHQ1cqHBHB3HywTFvQAxsCEKhSWq5+E3oxTzBx2f3voK3sj4cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 3:07 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> The driver currently misses the PLL lock check, as the preliminary
> documentation mentions lock configurations, but is quiet about where
> to find the actual lock status signal.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile       |   3 +-
>  drivers/clk/imx/clk-sccg-pll.c | 246 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h          |   9 ++
>  3 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-sccg-pll.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 4893c1f..b87513c 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -12,7 +12,8 @@ obj-y += \
>         clk-pllv1.o \
>         clk-pllv2.o \
>         clk-pllv3.o \
> -       clk-pfd.o
> +       clk-pfd.o \
> +       clk-sccg-pll.o
>
>  obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
> diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
> new file mode 100644
> index 0000000..8d87ba5
> --- /dev/null
> +++ b/drivers/clk/imx/clk-sccg-pll.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +
> +#include "clk.h"
> +
> +/* PLL CFGs */
> +#define PLL_CFG0       0x0
> +#define PLL_CFG1       0x4
> +#define PLL_CFG2       0x8
> +
> +#define PLL_DIVF1_SHIFT        13
> +#define PLL_DIVF2_SHIFT        7
> +#define PLL_DIVF_MASK  0x3f
> +
> +#define PLL_DIVR1_SHIFT        25
> +#define PLL_DIVR2_SHIFT        19
> +#define PLL_DIVR1_MASK 0x3
> +#define PLL_DIVR2_MASK 0x3f
> +#define PLL_REF_SHIFT  0
> +#define PLL_REF_MASK   0x3
> +

Similar to previous patch, I'd suggest using FILED_GET()/GENMAKS for
the above fields

> +#define PLL_LOCK_MASK  BIT(31)
> +#define PLL_PD_MASK    BIT(7)
> +
> +#define OSC_25M                25000000
> +#define OSC_27M                27000000
> +
> +struct clk_sccg_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *base;
> +};
> +
> +#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
> +
> +static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
> +{
> +       /* max lock time is 70us */
> +       int retry = 7;
> +
> +       /* Wait for PLL to lock */
> +       do {
> +               if (readl_relaxed(pll->base) & PLL_LOCK_MASK)
> +                       break;
> +               udelay(10);
> +               retry--;
> +       } while (retry);
> +

Can readx_poll_timeout_atomic() be used here instead?

Thanks,
Andrey Smirnov
