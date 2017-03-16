From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 16 Mar 2017 13:55:20 +0100
Subject: [PATCH 1/4] mmc: core: Add post_ios_power_on callback for power
 sequences
In-Reply-To: <20170301145310.22813-2-romain.perier@collabora.com>
References: <20170301145310.22813-1-romain.perier@collabora.com>
 <20170301145310.22813-2-romain.perier@collabora.com>
Message-ID: <CAPDyKFo_OxMizZPmmiL8Uo3r35vfY9arJjoWisAJCvB7VTsUdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2017 at 15:53, Romain Perier <romain.perier@collabora.com> wrote:
> Currently, ->pre_power_on() callback is called at the beginning of the
> mmc_power_up() function before MMC_POWER_UP and MMC_POWER_ON sequences.
> The callback ->post_power_on() is called at the end of the
> mmc_power_up() function. Some SDIO Chipsets require to gate the clock

Just to make sure we get things right here. mmc_pwrseq_post_power_on()
is actually called when MMC_POWER_UP is completed but before
MMC_POWER_ON is done.

When ->set_ios() host ops callback is invoked with MMC_POWER_ON state,
the mmc core expects the mmc host to power on vqmmc (which is the I/O
voltage for the interface bus).

I would like to understand what clock you really are referring to here
as well, is that the clock for SDIO interface or some other peripheral
clock to SDIO chipset.

> after than the vqmmc supply is powered on and then toggle the reset
> line. Currently, there is no way for doing this.

True.

Let me just ask about vqmmc to be sure. This is about the I/O voltage
to SDIO chipset?

>
> This commit introduces a new callback ->post_ios_power_on(), that is
> called at the end of the mmc_power_up() function after the mmc_set_ios()
> operation. In this way the entire power sequences can be done from this
> function after the enablement of the power supply.

This may be a way forward, however, first I want to be sure of what
kind of clocks/regulators etc we have to deal with.

Kind regards
Uffe

>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/mmc/core/core.c   | 1 +
>  drivers/mmc/core/pwrseq.c | 8 ++++++++
>  drivers/mmc/core/pwrseq.h | 2 ++
>  3 files changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1076b9d..d73a050 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1831,6 +1831,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>          * time required to reach a stable voltage.
>          */
>         mmc_delay(10);
> +       mmc_pwrseq_post_ios_power_on(host);
>  }
>
>  void mmc_power_off(struct mmc_host *host)
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index 9386c47..98f50b7 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -68,6 +68,14 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host)
>                 pwrseq->ops->post_power_on(host);
>  }
>
> +void mmc_pwrseq_post_ios_power_on(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq *pwrseq = host->pwrseq;
> +
> +       if (pwrseq && pwrseq->ops->post_ios_power_on)
> +               pwrseq->ops->post_ios_power_on(host);
> +}
> +
>  void mmc_pwrseq_power_off(struct mmc_host *host)
>  {
>         struct mmc_pwrseq *pwrseq = host->pwrseq;
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index d69e751..2053ebd 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -13,6 +13,7 @@
>  struct mmc_pwrseq_ops {
>         void (*pre_power_on)(struct mmc_host *host);
>         void (*post_power_on)(struct mmc_host *host);
> +       void (*post_ios_power_on)(struct mmc_host *host);
>         void (*power_off)(struct mmc_host *host);
>  };
>
> @@ -31,6 +32,7 @@ void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
>  int mmc_pwrseq_alloc(struct mmc_host *host);
>  void mmc_pwrseq_pre_power_on(struct mmc_host *host);
>  void mmc_pwrseq_post_power_on(struct mmc_host *host);
> +void mmc_pwrseq_post_ios_power_on(struct mmc_host *host);
>  void mmc_pwrseq_power_off(struct mmc_host *host);
>  void mmc_pwrseq_free(struct mmc_host *host);
>
> --
> 2.9.3
>
