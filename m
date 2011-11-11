From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 Nov 2011 15:48:15 +0100
Subject: [PATCH v2] mmc mxcmmc: fix falling back to PIO
In-Reply-To: <1314264785-19224-1-git-send-email-s.hauer@pengutronix.de>
References: <1314264785-19224-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20111111144815.GW16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Can you take this one please?

Sascha

On Thu, Aug 25, 2011 at 11:33:05AM +0200, Sascha Hauer wrote:
> When we can't configure the dma channel we want to fall
> back to PIO. We do this by setting host->do_dma to zero.
> This does not work as do_dma is used to see whether dma
> can be used for the current transfer. Instead, we have
> to set host->dma to NULL.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> ---
>  drivers/mmc/host/mxcmmc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 14aa213..4dc9008 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -730,7 +730,8 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			dev_err(mmc_dev(host->mmc),
>  				"failed to config DMA channel. Falling back to PIO\n");
>  			dma_release_channel(host->dma);
> -			host->do_dma = 0;
> +			host->dma = NULL;
> +			host->dma = 0;
>  		}
>  	}
>  
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
