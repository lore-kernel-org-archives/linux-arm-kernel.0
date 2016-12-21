From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 15:25:51 -0800
Subject: [PATCH 2/2] clk: hi3660: Clock driver support for Hisilicon
 hi3660 SoC
In-Reply-To: <1481781493-6188-3-git-send-email-zhangfei.gao@linaro.org>
References: <1481781493-6188-1-git-send-email-zhangfei.gao@linaro.org>
 <1481781493-6188-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20161221232551.GB8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15, Zhangfei Gao wrote:
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Add some commit text here?

> diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
> new file mode 100644
> index 0000000..42ca47d
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3660.c
> @@ -0,0 +1,601 @@
> +/*
> + * Copyright (c) 2016-2017 Linaro Ltd.
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <dt-bindings/clock/hi3660-clock.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>

This isn't needed.

> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk.h"
> +
[...]
> +
> +static int hi3660_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *of_id;
> +	enum hi3660_clk_type type;
> +
> +	of_id = of_match_device(hi3660_clk_match_table, dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	type = (enum hi3660_clk_type)of_id->data;

Use of_device_get_match_data() instead please.

> +
> +	switch (type) {
> +	case HI3660_CRGCTRL:
> +		hi3660_clk_crgctrl_init(np);
> +		break;
> +	case HI3660_PCTRL:
> +		hi3660_clk_pctrl_init(np);
> +		break;
> +	case HI3660_PMUCTRL:
> +		hi3660_clk_pmuctrl_init(np);
> +		break;
> +	case HI3660_SCTRL:
> +		hi3660_clk_sctrl_init(np);
> +		break;
> +	case HI3660_IOMCU:
> +		hi3660_clk_iomcu_init(np);
> +		break;

This "multi-device" driver design is sort of odd. Why not have
different files and struct drivers for the different devices in
the system that are clock controllers? I don't really understand
why we're controlling the devices with one struct driver
instance. Is something shared between the devices?

> +	default:
> +		break;
> +	}
> +	return 0;
> +}
[...]
> +
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:hi3660-clk");
> +MODULE_DESCRIPTION("HiSilicon Hi3660 Clock Driver");


You can drop these MODULE_* things as they're not going to be
used in builtin only code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
