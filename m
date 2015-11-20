From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 20 Nov 2015 16:25:29 +0100
Subject: [PATCH] mmc: fix mmc_{un,}register_pm_notifier prototypes
In-Reply-To: <7826361.qqKATxLhCV@wuerfel>
References: <7826361.qqKATxLhCV@wuerfel>
Message-ID: <CAPDyKFrakOWJy4_nxYHR40yR=yG=Z_E8_u=_fMp6uSOPjd72Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2015 at 11:28, Arnd Bergmann <arnd@arndb.de> wrote:
> The mmc pm notifiers were recently reworked, but the new
> code produces a lot of warnings when CONFIG_PM_SLEEP is disabled:
>
> In file included from ../drivers/mmc/core/sdio_bus.c:27:0:
> drivers/mmc/core/core.h:97:13: warning: 'mmc_register_pm_notifier' defined but not used [-Wunused-function]
>
> The obvious solution is to add the 'inline' keyword at the
> function definition, as it should be for any function defined
> in a header file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0e40be7c20e0 ("mmc: core: Refactor code to register the MMC PM notifier")

My bad. How could I even *not* notice those warnings.

Thanks for helping out Arnd, patch applied!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index bd00ac2cdc1b..0fa86a2afc26 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -94,8 +94,8 @@ int mmc_hs400_to_hs200(struct mmc_card *card);
>  void mmc_register_pm_notifier(struct mmc_host *host);
>  void mmc_unregister_pm_notifier(struct mmc_host *host);
>  #else
> -static void mmc_register_pm_notifier(struct mmc_host *host) { }
> -static void mmc_unregister_pm_notifier(struct mmc_host *host) { }
> +static inline void mmc_register_pm_notifier(struct mmc_host *host) { }
> +static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
>  #endif
>
>  #endif
>
