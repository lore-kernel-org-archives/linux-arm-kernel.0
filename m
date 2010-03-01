From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 01 Mar 2010 15:44:58 +0300
Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc
	callback
In-Reply-To: <618f0c911003010325q201fbcedr776da21c709ac421@mail.gmail.com>
References: <618f0c911003010325q201fbcedr776da21c709ac421@mail.gmail.com>
Message-ID: <4B8BB6CA.7000104@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Venkatraman S wrote:

> It is observed that sometimes the MMC Transfer Complete (TC) is not
> received when DMA completion callback is processed (or takes too long
> to process)
> This patch moves the releasing of DMA channel from dma callback to the
> mmc transfer complete handler.
> This is observed consistently when descriptor loading is used (see the
> rest of the series)
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 83f0aff..06337f6 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>
>  	if (end_cmd || ((status & CC) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
> -	if ((end_trans || (status & TC)) && host->mrq)
> +	if ((end_trans || (status & TC)) && host->mrq) {
>  		omap_hsmmc_xfer_done(host, data);
> +		if (host->dma_ch != -1) {
> +			omap_free_dma(host->dma_ch);
> +			host->dma_ch = -1;
> +		/*
> +		 * Callback: run in interrupt context.
> +		 * mutex_unlock will throw a kernel warning if used.
> +		 */
>   

   The comment should be aligned with the rest of the code.

> +			up(&host->sem);
> +		}
> +	}
>
>  	spin_unlock(&host->irq_lock);

WBR, Sergei
