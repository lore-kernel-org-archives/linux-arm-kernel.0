From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 30 Oct 2013 23:36:36 +0100
Subject: [PATCH v2 6/6] mmc: core: mmc DDR mode should not depend on
 UHS_DDR50
In-Reply-To: <1383142193-24950-7-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
 <1383142193-24950-7-git-send-email-b29396@freescale.com>
Message-ID: <CAPDyKFpu-HEZ_YRX-2-g1vqww3v9-NObrBvg6pYnKbtn7ZyN8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2013 15:09, Dong Aisheng <b29396@freescale.com> wrote:
> The MMC_CAP_UHS_DDR50 must work on 1.8v.
> However, the eMMC DDR mode can work on either 1.8v or 3.3v and
> should not depend on UHS_DDR50.
> So get rid of this limitation to let controller without 1.8v
> signal voltage support can also work for eMMC DDR mode if it claims.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/mmc.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f631f5a..98e9eb0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1119,14 +1119,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          */
>         if (mmc_card_highspeed(card)) {
>                 if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
> -                       && ((host->caps & (MMC_CAP_1_8V_DDR |
> -                            MMC_CAP_UHS_DDR50))
> -                               == (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
> +                       && (host->caps & MMC_CAP_1_8V_DDR))
>                                 ddr = MMC_1_8V_DDR_MODE;
>                 else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
> -                       && ((host->caps & (MMC_CAP_1_2V_DDR |
> -                            MMC_CAP_UHS_DDR50))
> -                               == (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
> +                       && (host->caps & MMC_CAP_1_2V_DDR))
>                                 ddr = MMC_1_2V_DDR_MODE;
>         }
>
> --
> 1.7.2.rc3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
