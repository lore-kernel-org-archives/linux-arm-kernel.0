From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 8 Oct 2015 19:35:52 +0200
Subject: [PATCH 2/8] mmc: sdhci-pxav3: disable clock inversion for HS MMC
 cards
In-Reply-To: <1444094562-31165-3-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-3-git-send-email-mw@semihalf.com>
Message-ID: <CAPDyKFrfQJbg9qJmethK2NEzi-crS1vstozYAFR5nRuyM0Hv_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2015 at 03:22, Marcin Wojtas <mw@semihalf.com> wrote:
> From: Nadav Haklai <nadavh@marvell.com>
>
> According to 'FE-2946959' erratum the clock inversion option is
> needed to support slow frequencies when the card input hold time
> requirement is high. This setting is not required for high speed
> MMC and might cause timing violation.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Cc: <stable@vger.kernel.org> # v4.2

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 976cddd..89a9e49 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -291,6 +291,9 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>                     uhs == MMC_TIMING_UHS_DDR50) {
>                         reg_val &= ~SDIO3_CONF_CLK_INV;
>                         reg_val |= SDIO3_CONF_SD_FB_CLK;
> +               } else if (uhs == MMC_TIMING_MMC_HS) {
> +                       reg_val &= ~SDIO3_CONF_CLK_INV;
> +                       reg_val &= ~SDIO3_CONF_SD_FB_CLK;
>                 } else {
>                         reg_val |= SDIO3_CONF_CLK_INV;
>                         reg_val &= ~SDIO3_CONF_SD_FB_CLK;
> --
> 1.8.3.1
>
