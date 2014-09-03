From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Sep 2014 12:05:42 -0700
Subject: [PATCH v7 11/11] clk: rockchip: add restart handler
In-Reply-To: <1408495538-27480-12-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-12-git-send-email-linux@roeck-us.net>
Message-ID: <20140903190542.11368.20755@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Guenter Roeck (2014-08-19 17:45:38)
> From: Heiko St?bner <heiko@sntech.de>
> 
> Add infrastructure to write the correct value to the restart register and
> register the restart notifier for both rk3188 (including rk3066) and rk3288.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> v7: Added patch to series.
> 
>  drivers/clk/rockchip/clk-rk3188.c |  2 ++
>  drivers/clk/rockchip/clk-rk3288.c |  2 ++
>  drivers/clk/rockchip/clk.c        | 25 +++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.h        |  1 +
>  4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
> index a83a6d8..71b661a 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -631,6 +631,8 @@ static void __init rk3188_common_clk_init(struct device_node *np)
>  
>         rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
>                                   ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +       rockchip_register_restart_notifier(RK2928_GLB_SRST_FST);
>  }
>  
>  static void __init rk3066a_clk_init(struct device_node *np)
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 0d8c6c5..b604217 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -713,5 +713,7 @@ static void __init rk3288_clk_init(struct device_node *np)
>  
>         rockchip_register_softrst(np, 9, reg_base + RK3288_SOFTRST_CON(0),
>                                   ROCKCHIP_SOFTRST_HIWORD_MASK);
> +
> +       rockchip_register_restart_notifier(RK3288_GLB_SRST_FST);
>  }
>  CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 278cf9d..aa41433 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -25,6 +25,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/reboot.h>
>  #include "clk.h"
>  
>  /**
> @@ -242,3 +243,27 @@ void __init rockchip_clk_register_branches(
>                 rockchip_clk_add_lookup(clk, list->id);
>         }
>  }
> +
> +static unsigned int reg_restart;
> +static int rockchip_restart_notify(struct notifier_block *this,
> +                                  unsigned long mode, void *cmd)
> +{
> +       writel(0xfdb9, reg_base + reg_restart);
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rockchip_restart_handler = {
> +       .notifier_call = rockchip_restart_notify,
> +       .priority = 128,
> +};
> +
> +void __init rockchip_register_restart_notifier(unsigned int reg)
> +{
> +       int ret;
> +
> +       reg_restart = reg;
> +       ret = register_restart_handler(&rockchip_restart_handler);
> +       if (ret)
> +               pr_err("%s: cannot register restart handler, %d\n",
> +                      __func__, ret);
> +}
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 887cbde..0b5eab5 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -329,6 +329,7 @@ void rockchip_clk_register_branches(struct rockchip_clk_branch *clk_list,
>                                     unsigned int nr_clk);
>  void rockchip_clk_register_plls(struct rockchip_pll_clock *pll_list,
>                                 unsigned int nr_pll, int grf_lock_offset);
> +void rockchip_register_restart_notifier(unsigned int reg);
>  
>  #define ROCKCHIP_SOFTRST_HIWORD_MASK   BIT(0)
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
