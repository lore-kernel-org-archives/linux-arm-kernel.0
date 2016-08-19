From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Aug 2016 12:46:08 -0700
Subject: [PATCH v11 5/9] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1471584896-9986-6-git-send-email-erin.lo@mediatek.com>
References: <1471584896-9986-1-git-send-email-erin.lo@mediatek.com>
 <1471584896-9986-6-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160819194608.GA6502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19, Erin Lo wrote:
> diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
> new file mode 100644
> index 0000000..45a102e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
> +
> +static const struct mtk_gate vdec_clks[] = {
> +	GATE_VDEC0(CLK_VDEC_CKGEN, "vdec_cken", "vdec_sel", 0),
> +	GATE_VDEC1(CLK_VDEC_LARB, "vdec_larb_cken", "mm_sel", 0),
> +};
> +
> +static void mtk_vdecsys_init(struct device_node *node)

Please return errors to driver probe.

> +{
> +	struct clk_onecell_data *clk_data;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR);
> +
> +	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
> +						clk_data);
> +
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		pr_err("%s(): could not register clock provider: %d\n",
> +			__func__, r);
> +}
> +
> +static const struct of_device_id of_match_clk_mt2701_vdec[] = {
> +	{ .compatible = "mediatek,mt2701-vdecsys", },
> +	{}
> +};
> +
> +static int clk_mt2701_vdec_probe(struct platform_device *pdev)
> +{
> +	mtk_vdecsys_init(pdev->dev.of_node);
> +	return 0;

	return mtk_vdecsys_init()?

> +}
> +
> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> new file mode 100644
> index 0000000..f64dc4e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -0,0 +1,1033 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Shunli Wang <shunli.wang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt2701-clk.h>
> +
> +/*
> + * For some clocks, we don't care what their actual rates are. And these
> + * clocks may change their rate on different products or different scenarios.
> + * So we model these clocks' rate as 0, to denote it's not an actual rate.
> + */
> +#define DUMMY_RATE		0

This doesn't sound great... Wouldn't we want to get those rates
from the dts files then?

> +
> +static DEFINE_SPINLOCK(lock);

Please use a better name than lock. mtk2701_clk_lock?

> +
> +static int clk_mt2701_probe(struct platform_device *pdev)
> +{
> +	void (*clk_init)(struct device_node *);

Please return errors from clk_init() callbacks.

> +	const struct of_device_id *of_id;
> +
> +	pr_warn("%s():%d: %s\n", __func__, __LINE__, pdev->name);
> +

This is noise, please remove.

> +	of_id = of_match_node(of_match_clk_mt2701, pdev->dev.of_node);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;

We can use of_device_get_match_data() here to simplify things.

> +
> +	clk_init = of_id->data;
> +	clk_init(pdev->dev.of_node);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt2701_drv = {
> +	.probe = clk_mt2701_probe,
> +	.driver = {
> +		.name = "clk-mt2701",
> +		.owner = THIS_MODULE,

This isn't needed because of how platform_driver_register() works.

> +		.of_match_table = of_match_clk_mt2701,
> +	},
> +};
> +
> +static int __init clk_mt2701_init(void)
> +{
> +	return platform_driver_register(&clk_mt2701_drv);
> +}
> +
> +arch_initcall(clk_mt2701_init);
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index bb30f70..6a015a8 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -244,3 +256,31 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  			clk_data->clks[mc->id] = clk;
>  	}
>  }
> +
> +void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> +			int num, void __iomem *base, spinlock_t *lock,
> +				struct clk_onecell_data *clk_data)
> +{
> +	struct clk *clk;
> +	int i;
> +
> +	for (i = 0; i <  num; i++) {
> +		const struct mtk_clk_divider *mcd = &mcds[i];
> +
> +		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> +			continue;

We dereference clk_data here...

> +
> +		clk = clk_register_divider(NULL, mcd->name, mcd->parent_name,
> +			mcd->flags, base +  mcd->div_reg, mcd->div_shift,
> +			mcd->div_width, mcd->clk_divider_flags, lock);
> +
> +		if (IS_ERR(clk)) {
> +			pr_err("Failed to register clk %s: %ld\n",
> +				mcd->name, PTR_ERR(clk));
> +			continue;
> +		}
> +
> +		if (clk_data)

But then we check it for NULL here? This happens quite often now
after this patch.

> +			clk_data->clks[mcd->id] = clk;
> +	}
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
