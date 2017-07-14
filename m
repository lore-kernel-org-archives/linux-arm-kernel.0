From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 14 Jul 2017 11:26:32 +0200
Subject: [PATCH 05/11] mmc: sunxi: Support controllers that can use both
 old and new timings
In-Reply-To: <20170714064302.20383-6-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-6-wens@csie.org>
Message-ID: <CAPDyKFoLTXJ10EJRfPPggJBg8bh9BpdwTnew-WL0G7LpnO43Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2017 at 08:42, Chen-Yu Tsai <wens@csie.org> wrote:
> On the SoCs that introduced the new timing mode for MMC controllers,
> both the old (where the clock delays are set in the CCU) and new
> (where the clock delays are set in the MMC controller) timing modes
> are available, and we have to support them both. However there are
> two bits that control which mode is active. One is in the CCU, the
> other is in the MMC controller. The settings on both sides must be
> the same, or nothing will work.
>
> The CCU's get/set_phase callbacks return -ENOTSUPP when the new
> timing mode is active. This provides a way to know which mode is
> active on that side, and we can set the bit on the MMC controller
> side accordingly.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 0fb4e4c119e1..56e45c65b52d 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -22,6 +22,7 @@
>  #include <linux/err.h>
>
>  #include <linux/clk.h>
> +#include <linux/clk/sunxi-ng.h>

I don't like this. This looks like an SoC specific hack.

>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> @@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
>         /* Does DATA0 needs to be masked while the clock is updated */
>         bool mask_data0;
>
> -       bool needs_new_timings;
> +       bool has_new_timings;
>  };
>
>  struct sunxi_mmc_host {
> @@ -293,6 +294,9 @@ struct sunxi_mmc_host {
>
>         /* vqmmc */
>         bool            vqmmc_enabled;
> +
> +       /* timings */
> +       bool            use_new_timings;
>  };
>
>  static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
> @@ -714,7 +718,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  {
>         int index;
>
> -       if (!host->cfg->clk_delays)
> +       if (host->use_new_timings)
>                 return 0;
>
>         /* determine delays */
> @@ -765,6 +769,15 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>             ios->bus_width == MMC_BUS_WIDTH_8)
>                 clock <<= 1;
>
> +       if (host->use_new_timings) {
> +               ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);

Can't this be solved through some other generic API/interface?

> +               if (ret) {
> +                       dev_err(mmc_dev(mmc),
> +                               "error setting new timing mode\n");
> +                       return ret;
> +               }
> +       }
> +

[...]

Kind regards
Uffe
