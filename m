From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 6 Jun 2011 18:49:46 +0200
Subject: [RFC] mmc: Enable the ADMA on esdhc imx driver
In-Reply-To: <1307005930-10935-1-git-send-email-richard.zhu@linaro.org>
References: <1307005930-10935-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <20110606164946.GA14126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 05:12:10PM +0800, Richard Zhu wrote:
> Eanble the ADMA mode on freescale esdhc imx driver,
> tested on MX51 and MX53.

Please describe a little bit why the patch helps. Does it also work on mx25/35?
What does the new bit cover what the old one didn't cover? Why does the new one
even exist?

> 
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   40 ++++++++++++++++++++++++++++++-----
>  1 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a19967d..64f33cb 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,8 @@
>  #define SDHCI_VENDOR_SPEC		0xC0
>  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
>  
> +#define  SDHCI_VENDOR_SPEC_INT_ADMA_ERR	0x10000000
> +

>From the code below, this name is wrong because the bit is not in VENDOR_SPEC.

> @@ -166,12 +189,16 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  	case SDHCI_HOST_CONTROL:
>  		/* FSL messed up here, so we can just keep those two */
>  		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
> -		/* ensure the endianess */
> +		/* ensure the endi1ness */

Ehrm?

> -		/* DMA mode bits are shifted */
> -		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
> +		if (val & SDHCI_CTRL_DMA_MASK) {
> +			/* DMA mode bits are shifted */
> +			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
> +
> +			esdhc_clrset_le(host, 0xffff, new_val, reg);
> +		} else
> +			esdhc_clrset_le(host, 0xff, val, reg);

Why can't we always write 16-bit? (and else-block needs braces)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110606/b65ae423/attachment.sig>
