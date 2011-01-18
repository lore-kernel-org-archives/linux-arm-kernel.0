From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 23:05:56 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20110118230556.GP16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 03:03:25PM -0800, Daniel Walker wrote:
> Remove parts of this driver which use internal API calls. This
> replaces the calls as suggested by Russell King.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  drivers/mmc/host/msm_sdcc.c |   49 +++++++++++++++++++-----------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 5decfd0..733d233 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -383,14 +383,30 @@ static int msmsdcc_config_dma(struct msmsdcc_host *host, struct mmc_data *data)
>  	host->curr.user_pages = 0;
>  
>  	box = &nc->cmd[0];
> -	for (i = 0; i < host->dma.num_ents; i++) {
> -		box->cmd = CMD_MODE_BOX;
>  
> -	/* Initialize sg dma address */
> -	sg->dma_address = page_to_dma(mmc_dev(host->mmc), sg_page(sg))
> -				+ sg->offset;
> +	/* location of command block must be 64 bit aligned */
> +	BUG_ON(host->dma.cmd_busaddr & 0x07);
> +
> +	nc->cmdptr = (host->dma.cmd_busaddr >> 3) | CMD_PTR_LP;
> +	host->dma.hdr.cmdptr = DMOV_CMD_PTR_LIST |
> +			       DMOV_CMD_ADDR(host->dma.cmdptr_busaddr);
> +	host->dma.hdr.complete_func = msmsdcc_dma_complete_func;
> +
> +	n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
> +			host->dma.num_ents, host->dma.dir);
> +	if (n == 0) {
> +		printk(KERN_ERR "%s: Unable to map in all sg elements\n",
> +			mmc_hostname(host->mmc));
> +		host->dma.sg = NULL;
> +		host->dma.num_ents = 0;
> +		return -ENOMEM;
> +	}
> +
> +	for_each_sg(host->dma.sg, sg, n, i) {
> +
> +		box->cmd = CMD_MODE_BOX;
>  
> -	if (i == (host->dma.num_ents - 1))
> +		if (i == n - 1)
>  			box->cmd |= CMD_LC;
>  		rows = (sg_dma_len(sg) % MCI_FIFOSIZE) ?
>  			(sg_dma_len(sg) / MCI_FIFOSIZE) + 1 :
> @@ -418,27 +434,6 @@ static int msmsdcc_config_dma(struct msmsdcc_host *host, struct mmc_data *data)
>  			box->cmd |= CMD_DST_CRCI(crci);
>  		}
>  		box++;
> -		sg++;
> -	}
> -
> -	/* location of command block must be 64 bit aligned */
> -	BUG_ON(host->dma.cmd_busaddr & 0x07);
> -
> -	nc->cmdptr = (host->dma.cmd_busaddr >> 3) | CMD_PTR_LP;
> -	host->dma.hdr.cmdptr = DMOV_CMD_PTR_LIST |
> -			       DMOV_CMD_ADDR(host->dma.cmdptr_busaddr);
> -	host->dma.hdr.complete_func = msmsdcc_dma_complete_func;
> -
> -	n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
> -			host->dma.num_ents, host->dma.dir);
> -/* dsb inside dma_map_sg will write nc out to mem as well */
> -
> -	if (n != host->dma.num_ents) {
> -		printk(KERN_ERR "%s: Unable to map in all sg elements\n",
> -			mmc_hostname(host->mmc));
> -		host->dma.sg = NULL;
> -		host->dma.num_ents = 0;
> -		return -ENOMEM;
>  	}
>  
>  	return 0;
> -- 
> 1.7.0.4
> 
> -- 
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
