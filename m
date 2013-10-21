From: john.tobias.ph@gmail.com (John Tobias)
Date: Mon, 21 Oct 2013 09:01:59 -0700
Subject: [PATCH 2/7] mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read
 function
In-Reply-To: <1382365627-26816-3-git-send-email-b29396@freescale.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
 <1382365627-26816-3-git-send-email-b29396@freescale.com>
Message-ID: <CACUGKYPo2zWDTbmyksiwmJY8tghkYjr=dKD8pDzxugeOoojCNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

I compiled my kernel after applying your patch but it didn't compile
it correctly due to esdhc_is_usdhc function. It should be
is_imx6_usdhc?

Regards,

john

On Mon, Oct 21, 2013 at 7:27 AM, Dong Aisheng <b29396@freescale.com> wrote:
> Used to read out the correct value of SDHCI_TRANSFER_MODE register
> for upper layer.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 461a4c3..2be77e0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -385,6 +385,22 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
>                 return ret;
>         }
>
> +       if (unlikely(reg == SDHCI_TRANSFER_MODE)) {
> +               if (esdhc_is_usdhc(imx_data)) {
> +                       u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +                       ret = m & ESDHC_MIX_CTRL_SDHCI_MASK;
> +                       /* Swap AC23 bit */
> +                       if (m & ESDHC_MIX_CTRL_AC23EN) {
> +                               ret &= ~ESDHC_MIX_CTRL_AC23EN;
> +                               ret |= SDHCI_TRNS_AUTO_CMD23;
> +                       }
> +               } else {
> +                       ret = readw(host->ioaddr + SDHCI_TRANSFER_MODE);
> +               }
> +
> +               return ret;
> +       }
> +
>         return readw(host->ioaddr + reg);
>  }
>
> --
> 1.7.2.rc3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
