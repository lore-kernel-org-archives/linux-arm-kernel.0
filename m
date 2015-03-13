From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 14:15:43 +0100
Subject: [RFC PATCH 04/18] mmc: msm: move clk-reset logic to platform
In-Reply-To: <1425497592-1831064-5-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <1425497592-1831064-5-git-send-email-arnd@arndb.de>
Message-ID: <CAPDyKFr7x8sqdvYgPDFh_KmMfOjiquhk=16kjkLDZVHZ1EjDKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 20:32, Arnd Bergmann <arnd@arndb.de> wrote:
> There is no generic interface for resetting a clock, and
> creating a reset driver for msm seems overkill, so this
> moves the reset logic from the msm_sdcc driver into
> a platform_data callback that calls into the clock driver.
>
> This follows the model that is used for all other devices
> on the msm platform that require a clk reset.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/mach-msm/board-qsd8x50.c          | 18 +++++++++++++++++-
>  arch/arm/mach-msm/board-trout-mmc.c        | 18 ++++++++++++++++++
>  arch/arm/mach-msm/clock.c                  |  2 +-
>  drivers/mmc/host/msm_sdcc.c                | 12 ++----------
>  include/linux/platform_data/mmc-msm_sdcc.h |  3 +++
>  5 files changed, 41 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
> index 4c748616ef47..9676a73683d2 100644
> --- a/arch/arm/mach-msm/board-qsd8x50.c
> +++ b/arch/arm/mach-msm/board-qsd8x50.c
> @@ -180,6 +180,21 @@ static uint32_t msm_sdcc_setup_power(struct device *dv, unsigned int vdd)
>         return 0;
>  }
>
> +static void msm_sdcc_clk_reset(struct clk *clk)
> +{
> +       int ret;
> +
> +       ret = clk_reset(clk, CLK_RESET_ASSERT);
> +       if (ret)
> +               pr_err("sdcc clock assert failed at %lu Hz with err %d\n",
> +                       clk_get_rate(clk), ret);
> +
> +       ret = clk_reset(clk, CLK_RESET_DEASSERT);
> +       if (ret)
> +               pr_err("sdcc clock deassert failed at %lu Hz with err %d\n",
> +                       clk_get_rate(clk), ret);
> +}
> +
>  static struct msm_mmc_gpio_data sdc1_gpio = {
>         .gpio = sdc1_gpio_cfg,
>         .size = ARRAY_SIZE(sdc1_gpio_cfg),
> @@ -188,7 +203,8 @@ static struct msm_mmc_gpio_data sdc1_gpio = {
>  static struct msm_mmc_platform_data qsd8x50_sdc1_data = {
>         .ocr_mask       = MMC_VDD_27_28 | MMC_VDD_28_29,
>         .translate_vdd  = msm_sdcc_setup_power,
> -       .gpio_data = &sdc1_gpio,
> +       .gpio_data      = &sdc1_gpio,
> +       .clk_reset      = msm_sdcc_clk_reset,
>  };
>
>  static void __init qsd8x50_init_mmc(void)
> diff --git a/arch/arm/mach-msm/board-trout-mmc.c b/arch/arm/mach-msm/board-trout-mmc.c
> index 3723e55819d6..2474bba71c8b 100644
> --- a/arch/arm/mach-msm/board-trout-mmc.c
> +++ b/arch/arm/mach-msm/board-trout-mmc.c
> @@ -2,6 +2,7 @@
>  ** Author: Brian Swetland <swetland@google.com>
>  */
>  #include <linux/gpio.h>
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> @@ -14,6 +15,7 @@
>  #include <asm/io.h>
>
>  #include <mach/vreg.h>
> +#include <mach/clk.h>
>
>  #include <linux/platform_data/mmc-msm_sdcc.h>
>
> @@ -154,6 +156,21 @@ static unsigned int trout_sdslot_status(struct device *dev)
>         return (!status);
>  }
>
> +static void trout_sdcc_clk_reset(struct clk *clk)
> +{
> +       int ret;
> +
> +       ret = clk_reset(clk, CLK_RESET_ASSERT);
> +       if (ret)
> +               pr_err("sdcc clock assert failed at %lu Hz with err %d\n",
> +                       clk_get_rate(clk), ret);
> +
> +       ret = clk_reset(clk, CLK_RESET_DEASSERT);
> +       if (ret)
> +               pr_err("sdcc clock deassert failed at %lu Hz with err %d\n",
> +                       clk_get_rate(clk), ret);
> +}
> +
>  #define TROUT_MMC_VDD  MMC_VDD_165_195 | MMC_VDD_20_21 | MMC_VDD_21_22 \
>                         | MMC_VDD_22_23 | MMC_VDD_23_24 | MMC_VDD_24_25 \
>                         | MMC_VDD_25_26 | MMC_VDD_26_27 | MMC_VDD_27_28 \
> @@ -163,6 +180,7 @@ static struct msm_mmc_platform_data trout_sdslot_data = {
>         .ocr_mask       = TROUT_MMC_VDD,
>         .status         = trout_sdslot_status,
>         .translate_vdd  = trout_sdslot_switchvdd,
> +       .clk_reset      = trout_sdcc_clk_reset,
>  };
>
>  int __init trout_init_mmc(unsigned int sys_rev)
> diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
> index 35ea02b52483..0b59ad5eb557 100644
> --- a/arch/arm/mach-msm/clock.c
> +++ b/arch/arm/mach-msm/clock.c
> @@ -23,6 +23,6 @@ int clk_reset(struct clk *clk, enum clk_reset_action action)
>  {
>         struct clk_hw *hw = __clk_get_hw(clk);
>         struct msm_clk *m = to_msm_clk(hw);
> +
>         return m->reset(hw, action);
>  }
> -EXPORT_SYMBOL(clk_reset);
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 3002e377e9f7..be5b9b3b3843 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -45,7 +45,6 @@
>  #include <asm/sizes.h>
>
>  #include <linux/platform_data/mmc-msm_sdcc.h>
> -#include <mach/clk.h>
>
>  /* data mover definitions */
>
> @@ -493,15 +492,8 @@ static void msmsdcc_reset_and_restore(struct msmsdcc_host *host)
>         mci_mask0 = readl(host->base + MMCIMASK0);
>
>         /* Reset the controller */
> -       ret = clk_reset(host->clk, CLK_RESET_ASSERT);
> -       if (ret)
> -               pr_err("%s: Clock assert failed at %u Hz with err %d\n",
> -                               mmc_hostname(host->mmc), host->clk_rate, ret);
> -
> -       ret = clk_reset(host->clk, CLK_RESET_DEASSERT);
> -       if (ret)
> -               pr_err("%s: Clock deassert failed at %u Hz with err %d\n",
> -                               mmc_hostname(host->mmc), host->clk_rate, ret);
> +       if (host->plat->clk_reset)
> +               host->plat->clk_reset(host->clk);
>
>         pr_info("%s: Controller has been re-initialiazed\n",
>                         mmc_hostname(host->mmc));
> diff --git a/include/linux/platform_data/mmc-msm_sdcc.h b/include/linux/platform_data/mmc-msm_sdcc.h
> index 55aa873c9396..6f1821a4bf93 100644
> --- a/include/linux/platform_data/mmc-msm_sdcc.h
> +++ b/include/linux/platform_data/mmc-msm_sdcc.h
> @@ -15,6 +15,8 @@ struct msm_mmc_gpio_data {
>         u8 size;
>  };
>
> +struct clk;
> +
>  struct msm_mmc_platform_data {
>         unsigned int ocr_mask;                  /* available voltages */
>         u32 (*translate_vdd)(struct device *, unsigned int);
> @@ -22,6 +24,7 @@ struct msm_mmc_platform_data {
>         int (*register_status_notify)(void (*callback)(int card_present, void *dev_id), void *dev_id);
>         struct msm_mmc_gpio_data *gpio_data;
>         void (*init_card)(struct mmc_card *card);
> +       void (*clk_reset)(struct clk *clk);
>  };
>
>  #endif
> --
> 2.1.0.rc2
>
