From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:31:33 +0200
Subject: [PATCH] mmc mxcmmc: fix falling back to PIO
In-Reply-To: <1314263172-18657-1-git-send-email-s.hauer@pengutronix.de>
References: <1314263172-18657-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110825093133.GA7526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 11:06:12AM +0200, Sascha Hauer wrote:
> When we can't configure the dma channel we want to fall
> back to PIO. We do this by setting host->do_dma to zero.
> This does not work as do_dma is used to see whether dma
> can be used for the current transfer. Instead, we have
> to set host->dma to NULL.

Sorry, forget this patch. We have to set host->do_dma to 0
also. Will send an updated patch.

Sascha

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> ---
>  drivers/mmc/host/mxcmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 14aa213..b050b2a 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -730,7 +730,7 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			dev_err(mmc_dev(host->mmc),
>  				"failed to config DMA channel. Falling back to PIO\n");
>  			dma_release_channel(host->dma);
> -			host->do_dma = 0;
> +			host->dma = NULL;
>  		}
>  	}
>  
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
