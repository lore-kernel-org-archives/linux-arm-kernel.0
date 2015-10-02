From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 17:19:05 -0700
Subject: [PATCH 2/3] clk: bcm2835: Add a driver for the auxiliary
 peripheral clock gates.
In-Reply-To: <1441923750-19404-3-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
 <1441923750-19404-3-git-send-email-eric@anholt.net>
Message-ID: <20151002001905.GB12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10, Eric Anholt wrote:
> diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
> new file mode 100644
> index 0000000..1efa6fb
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm2835-aux.c
> @@ -0,0 +1,80 @@
> +/*
> + * Copyright (C) 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used?

> +#include <linux/clk/bcm2835.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/bcm2835-aux.h>
> +
> +static int bcm2835_aux_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk_onecell_data *onecell;
> +	const char *parent;
> +	struct clk *parent_clk;
> +	void __iomem *reg;
> +
> +	parent_clk = of_clk_get(dev->of_node, 0);
> +	if (IS_ERR(parent_clk))
> +		return PTR_ERR(parent_clk);

We have a device, any reason we can't use clk_get() directly?

> +	parent = __clk_get_name(parent_clk);
> +
> +	reg = of_iomap(dev->of_node, 0);

We have a platform device here, why aren't we using platform
device APIs like platform_get_resource() and
devm_ioremap_resource()?

> +	if (!reg)
> +		return -ENODEV;
> +
> +	onecell = kmalloc(sizeof(*onecell), GFP_KERNEL);
> +	if (!onecell)
> +		return -ENOMEM;
> +	onecell->clk_num = BCM2835_AUX_CLOCK_COUNT;
> +	onecell->clks = kzalloc(sizeof(*onecell->clks) *

kcalloc?

> +				BCM2835_AUX_CLOCK_COUNT, GFP_KERNEL);
> +	if (!onecell->clks)
> +		return -ENOMEM;
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
