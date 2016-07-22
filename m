From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 22 Jul 2016 16:28:53 -0400
Subject: [PATCH v3 5/7] PM / devfreq: event: support rockchip dfi
 controller
In-Reply-To: <1469178440-4668-6-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
 <1469178440-4668-6-git-send-email-hl@rock-chips.com>
Message-ID: <CAP=VYLo6ZH+Vc+3N0Ed6XyLdy-rc9tKnjiACDnovcqv2CnE0Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 5:07 AM, Lin Huang <hl@rock-chips.com> wrote:
> on rk3399 platform, there is dfi conroller can monitor
> ddr load, base on this result, we can do ddr freqency
> scaling.
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v3:
> - None
>
> Changes in v2:
> - use clk_disable_unprepare and clk_enable_prepare
> - remove clk_enable_prepare in probe
> - remove rockchip_dfi_remove function
>
> Changes in v1:
> - None
>
>  drivers/devfreq/event/Kconfig        |   7 +
>  drivers/devfreq/event/Makefile       |   1 +
>  drivers/devfreq/event/rockchip-dfi.c | 253 +++++++++++++++++++++++++++++++++++
>  3 files changed, 261 insertions(+)
>  create mode 100644 drivers/devfreq/event/rockchip-dfi.c
>
> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
> index eb6f74a..0d32d68 100644
> --- a/drivers/devfreq/event/Kconfig
> +++ b/drivers/devfreq/event/Kconfig
> @@ -30,4 +30,11 @@ config DEVFREQ_EVENT_EXYNOS_PPMU
>           (Platform Performance Monitoring Unit) counters to estimate the
>           utilization of each module.
>
> +config DEVFREQ_EVENT_ROCKCHIP_DFI
> +       bool "ROCKCHIP DFI DEVFREQ event Driver"
> +       depends on ARCH_ROCKCHIP
> +       help
> +         This add the devfreq-event driver for Rockchip SoC. It provides DFI
> +         (DDR Monitor Module) driver to count ddr load.
> +
>  endif # PM_DEVFREQ_EVENT
> diff --git a/drivers/devfreq/event/Makefile b/drivers/devfreq/event/Makefile
> index 3d6afd3..dda7090 100644
> --- a/drivers/devfreq/event/Makefile
> +++ b/drivers/devfreq/event/Makefile
> @@ -2,3 +2,4 @@
>
>  obj-$(CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP) += exynos-nocp.o
>  obj-$(CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU) += exynos-ppmu.o
> +obj-$(CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI) += rockchip-dfi.o
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> new file mode 100644
> index 0000000..96a0307
> --- /dev/null
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -0,0 +1,253 @@
> +/*
> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
> + * Author: Lin Huang <hl@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq-event.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>

Same comment applies here.   Also might want to check any instances
of "IS_ENABLED" being used on bool items, as that is overkill too.

Thanks,
Paul.
