From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 14 Nov 2018 15:28:39 -0800
Subject: [PATCH V6 6/6] clk: imx: add imx8qxp lpcg driver
In-Reply-To: <1541862894-8209-7-git-send-email-aisheng.dong@nxp.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
 <1541862894-8209-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154223811948.88331.8860718270277533070@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-11-10 07:20:08)
> Add imx8qxp lpcg driver support
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

I like it!

> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> new file mode 100644
> index 0000000..7b318d7
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP
> + *     Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <dt-bindings/clock/imx8qxp-clock.h>

Include this after <linux/*> and before locals please.

> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "clk-scu.h"
> +#include "clk-imx8qxp-lpcg.h"
> +
> +struct imx8qxp_lpcg_data {
> +       int id;
> +       char *name;
> +       char *parent;
> +       unsigned long flags;
> +       u32 offset;
> +       u8 bit_idx;
> +       bool hw_gate;
> +};
> +
> +struct imx8qxp_ss_lpcg {
> +       const struct imx8qxp_lpcg_data *lpcg;
> +       u8 num_lpcg;
> +       u8 num_max;
> +};

Any chance we can get kernel-doc on these structs and members of the
structs?

> +
> +static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[] = {
> +       { IMX8QXP_ADMA_LPCG_UART0_IPG_CLK, "uart0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_0_LPCG, 16, 0, },
> +       { IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK, "uart0_lpcg_baud_clk", "uart0_clk", 0, ADMA_LPUART_0_LPCG, 0, 0, },
> +       { IMX8QXP_ADMA_LPCG_UART1_IPG_CLK, "uart1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_1_LPCG, 16, 0, },
> +       { IMX8QXP_ADMA_LPCG_UART1_BAUD_CLK, "uart1_lpcg_baud_clk", "uart1_clk", 0, ADMA_LPUART_1_LPCG, 0, 0, },
[...]
> +
> +static int imx8qxp_lpcg_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct clk_hw_onecell_data *clk_data;
> +       const struct imx8qxp_ss_lpcg *ss_lpcg;
> +       const struct imx8qxp_lpcg_data *lpcg;
> +       struct resource *res;
> +       struct clk_hw **clks;
> +       void __iomem *base;
> +       int i;

That's a good amount of local variables!

> +
> +       ss_lpcg = of_device_get_match_data(dev);
> +       if (!ss_lpcg)
> +               return -ENODEV;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap(dev, res->start, resource_size(res));

Why not devm_ioremap_resource()?

> +       if (!base)
> +               return -ENOMEM;

And then return the error code out of it?

> +
> +       clk_data = devm_kzalloc(&pdev->dev, sizeof(*clk_data) +
> +                               sizeof(*clk_data->hws) * ss_lpcg->num_max,

Can you use struct_size() here?

> +                               GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->num = ss_lpcg->num_max;
> +       clks = clk_data->hws;
> +
> +       for (i = 0; i < ss_lpcg->num_lpcg; i++) {
> +               lpcg = ss_lpcg->lpcg + i;
> +               clks[lpcg->id] = imx_clk_lpcg_scu(lpcg->name, lpcg->parent,
> +                                                 lpcg->flags, base + lpcg->offset,
> +                                                 lpcg->bit_idx, lpcg->hw_gate);
> +       }
> +
> +       for (i = 0; i < clk_data->num; i++) {
> +               if (IS_ERR(clks[i]))
> +                       pr_err("i.MX clk %u: register failed with %ld\n",
> +                               i, PTR_ERR(clks[i]));

But we're OK to continue? Alright...

> +       }
> +
> +       return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);

Why not use devm_? Or can the driver never be unbound from sysfs?

> +}
> +
> +static const struct of_device_id imx8qxp_lpcg_match[] = {
> +       { .compatible = "fsl,imx8qxp-lpcg-adma", &imx8qxp_ss_adma, },
> +       { .compatible = "fsl,imx8qxp-lpcg-conn", &imx8qxp_ss_conn, },
> +       { .compatible = "fsl,imx8qxp-lpcg-lsio", &imx8qxp_ss_lsio, },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver imx8qxp_lpcg_clk_driver = {
> +       .driver = {
> +               .name = "imx8qxp-lpcg-clk",
> +               .of_match_table = imx8qxp_lpcg_match,
> +       },
> +       .probe = imx8qxp_lpcg_clk_probe,
> +};
> +
> +builtin_platform_driver(imx8qxp_lpcg_clk_driver);
> +
> +MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
> +MODULE_DESCRIPTION("IMX8QXP LPCG Clock driver");
> +MODULE_LICENSE("GPL v2");

If the module is builtin all the time because of
builtin_platform_driver() I think we don't need these MODULE_ macros.
