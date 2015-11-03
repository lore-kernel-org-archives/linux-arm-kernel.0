From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 2 Nov 2015 20:38:27 -0800
Subject: [PATCH v9 10/17] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <1446083918-30809-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446083918-30809-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20151103043827.GA17261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

On Thu, Oct 29, 2015 at 09:58:38AM +0800, Yakir Yang wrote:
> Add phy driver for the Rockchip DisplayPort PHY module. This
> is required to get DisplayPort working in Rockchip SoCs.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
...
> diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/phy-rockchip-dp.c
> new file mode 100644
> index 0000000..f3e0058
> --- /dev/null
> +++ b/drivers/phy/phy-rockchip-dp.c
> @@ -0,0 +1,151 @@
> +/*
> + * Rockchip DP PHY driver
> + *
> + * Copyright (C) 2015 FuZhou Rockchip Co., Ltd.
> + * Author: Yakir Yang <ykk@@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/clk.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +
> +#define GRF_SOC_CON12                           0x0274
> +
> +#define GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK   BIT(4)
> +#define GRF_EDP_REF_CLK_SEL_INTER               BIT(4)

Why are the above two macros the same? Judging by the RK3288 manual and
other downstream drivers, it seems like you want the _MASK one to be
shifted left by 16 (i.e., BIT(20)).

> +
> +#define GRF_EDP_PHY_SIDDQ_HIWORD_MASK           BIT(21)
> +#define GRF_EDP_PHY_SIDDQ_ON                    0
> +#define GRF_EDP_PHY_SIDDQ_OFF                   BIT(5)
> +

...

> +	ret = regmap_write(dp->grf, GRF_SOC_CON12, GRF_EDP_REF_CLK_SEL_INTER |
> +			   GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK);

IOW, the above is writing:

	BIT(4) | BIT(4)

whereas I think you want:

	BIT(4) | BIT(20)

> +	if (ret != 0) {
> +		dev_err(dp->dev, "Could not config GRF edp ref clk: %d\n", ret);
> +		return ret;
> +	}
> +

...

(FYI, I came across this by inspection when comparing Heiko's
'somewhat-stable' branch [1] with this series. The former brings up eDP
fine on veyron-jaq, whereas this one doesn't yet, even with the above
change. Still debugging the issue.)

Brian

[1] https://github.com/mmind/linux-rockchip/tree/devel/somewhat-stable
