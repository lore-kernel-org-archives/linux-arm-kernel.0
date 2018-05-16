From: briannorris@chromium.org (Brian Norris)
Date: Wed, 16 May 2018 16:51:26 -0700
Subject: [PATCH v4 4/4] drm/rockchip: support dp training outside dp
 firmware
In-Reply-To: <1526354560-23135-4-git-send-email-hl@rock-chips.com>
References: <1526354560-23135-1-git-send-email-hl@rock-chips.com>
 <1526354560-23135-4-git-send-email-hl@rock-chips.com>
Message-ID: <20180516235125.GB219198@rodete-desktop-imager.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Kishon

Hi,

On Tue, May 15, 2018 at 11:22:40AM +0800, Lin Huang wrote:
> DP firmware uses fixed phy config values to do training, but some
> boards need to adjust these values to fit for their unique hardware
> design. So get phy config values from dts and use software link training
> instead of relying on firmware, if software training fail, keep firmware
> training as a fallback if sw training fails.
> 
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - update patch following Enric suggest
> Changes in v3:
> - use variable fw_training instead sw_training_success
> - base on DP SPCE, if training fail use lower link rate to retry training
> Changes in v4:
> - improve cdn_dp_get_lower_link_rate() and cdn_dp_software_train_link() follow Sean suggest
> 
>  drivers/gpu/drm/rockchip/Makefile               |   3 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
>  drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 420 ++++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  31 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
>  6 files changed, 505 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c

...

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-link-training.c b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> new file mode 100644
> index 0000000..7efd070
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author: Chris Zhong <zyw@rock-chips.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/phy/phy.h>
> +#include <soc/rockchip/rockchip_phy_typec.h>
> +
> +#include "cdn-dp-core.h"
> +#include "cdn-dp-reg.h"
> +
> +static void cdn_dp_set_signal_levels(struct cdn_dp_device *dp)
> +{
> +	struct cdn_dp_port *port = dp->port[dp->active_port];
> +	struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);

This is still antithetical to the PHY framework; you're assuming that
this is a particular type of PHY here.

> +
> +	int rate = drm_dp_bw_code_to_link_rate(dp->link.rate);
> +	u8 swing = (dp->train_set[0] & DP_TRAIN_VOLTAGE_SWING_MASK) >>
> +		   DP_TRAIN_VOLTAGE_SWING_SHIFT;
> +	u8 pre_emphasis = (dp->train_set[0] & DP_TRAIN_PRE_EMPHASIS_MASK)
> +			  >> DP_TRAIN_PRE_EMPHASIS_SHIFT;
> +
> +	tcphy->typec_phy_config(port->phy, rate, dp->link.num_lanes,
> +				swing, pre_emphasis);

Is this something generic that could be added as a new PHY API instead?

> +}

Brian
