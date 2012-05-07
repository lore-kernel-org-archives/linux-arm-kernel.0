From: marex@denx.de (Marek Vasut)
Date: Tue, 8 May 2012 01:51:44 +0200
Subject: [PATCH 06/10] mmc: mxs-mmc: have dma_channel than dma_res in
 mxs_mmc_host
In-Reply-To: <1336401793-13753-7-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205080151.44883.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> It replaces dma_res with dma_channel in struct mxs_mmc_host, so that
> the device tree support will be a little easier, since dma channel
> can not be retrieved from "struct resource *dma_res".
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/mmc/host/mxs-mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 1a8ba314..e905721 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -146,7 +146,7 @@ struct mxs_mmc_host {
>  	struct mmc_data			*data;
> 
>  	void __iomem			*base;
> -	struct resource			*dma_res;
> +	int				dma_channel;
>  	struct clk			*clk;
>  	unsigned int			clk_rate;
> 
> @@ -668,7 +668,7 @@ static bool mxs_mmc_dma_filter(struct dma_chan *chan,
> void *param) if (!mxs_dma_is_apbh(chan))
>  		return false;
> 
> -	if (chan->chan_id != host->dma_res->start)
> +	if (chan->chan_id != host->dma_channel)
>  		return false;
> 
>  	chan->private = &host->dma_data;
> @@ -719,7 +719,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
> 
>  	host->devid = pdev->id_entry->driver_data;
>  	host->mmc = mmc;
> -	host->dma_res = dmares;
> +	host->dma_channel = dmares->start;
>  	host->sdio_irq_en = 0;
> 
>  	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);

Best regards,
Marek Vasut
