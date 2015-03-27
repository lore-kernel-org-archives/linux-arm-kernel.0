From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 27 Mar 2015 19:44:03 +0800
Subject: [RFC] i.MX25/35/SDHCI: switch off DMA usage
In-Reply-To: <201503271152.04348.jbe@pengutronix.de>
References: <201503271152.04348.jbe@pengutronix.de>
Message-ID: <20150327114400.GA20277@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 11:52:04AM +0100, Juergen Borleis wrote:
> DMA and the required overhead on very small data blocks seems an expensive
> operation. Due to erratum ENGCM07207 for i.MX25 and i.MX35 SoCs the
> support for multiblock transfers is disabled which results into a huge
> amount of single 512 byte sector transfers and interrupts. This slows down
> the transmission speed to below 500 kiB/s (even at 50 MHz SD card clock).
> Using PIO instead of DMA to avoid ENGCM07207 happens and re-enabling
> multiblock transfers again improve the transmission capability up to about
> 2.5 MiB/s.
> 
> I'm still not sure if ENGCM07207 is related to DMA only and can not happen
> when PIO is used instead. Someone out there with experience regarding this
> topic?

The errata does not state it's related to DMA only.
http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
I could double check with our IC guys to confirm it.

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 10ef8244a239..f5fd569a17c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -976,8 +976,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
> -		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> -			| SDHCI_QUIRK_BROKEN_ADMA;
> +		host->quirks |=
> +			SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_DMA;
>  
>  	/*
>  	 * The imx6q ROM code will change the default watermark level setting
> -- 
> 1.7.10.4
> 
> Juergen
