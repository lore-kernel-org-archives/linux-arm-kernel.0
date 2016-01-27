From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 Jan 2016 15:15:47 +0100
Subject: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
In-Reply-To: <1452762920-2588-1-git-send-email-kishon@ti.com>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
Message-ID: <CAPDyKFohvK3B0jF+SU-MLpiJ-DwJqW1pRtayK3nyKwVQkR1nUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2016 at 10:15, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
> have PBIAS regulator) in order for MMC1 to work.
>
> Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
> using a olddefconfig or a custom .config.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks,applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 7fb0753..7086bd6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>         host->pbias = devm_regulator_get_optional(host->dev, "pbias");
>         if (IS_ERR(host->pbias)) {
>                 ret = PTR_ERR(host->pbias);
> -               if ((ret != -ENODEV) && host->dev->of_node)
> +               if ((ret != -ENODEV) && host->dev->of_node) {
> +                       dev_err(host->dev,
> +                       "SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
>                         return ret;
> +               }
>                 dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
>                         PTR_ERR(host->pbias));
>                 host->pbias = NULL;
> --
> 1.7.9.5
>
