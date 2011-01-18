From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 22:41:59 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <1295389518-6249-1-git-send-email-dwalker@codeaurora.org>
References: <1295389518-6249-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20110118224159.GO16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 02:25:18PM -0800, Daniel Walker wrote:
> This doesn't work yet. I tried booting with this patch, and the boot
> stops after detecting the MMC partitions. It won't actually boot off
> the MMC. Without this patch and with the page_to_dma/pfn_to_dma changes
> it does work.
> 
> Not-Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> ---
>  drivers/mmc/host/msm_sdcc.c |   46 +++++++++++++++++-------------------------
>  1 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 5decfd0..1f1c7cb 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -383,14 +383,27 @@ static int msmsdcc_config_dma(struct msmsdcc_host *host, struct mmc_data *data)
>  	host->curr.user_pages = 0;
>  
>  	box = &nc->cmd[0];
> -	for (i = 0; i < host->dma.num_ents; i++) {
> -		box->cmd = CMD_MODE_BOX;

It probably happens because this line got dropped (due to the random
formatting in this file, it makes it harder to read.)

>  
> -	/* Initialize sg dma address */
> -	sg->dma_address = page_to_dma(mmc_dev(host->mmc), sg_page(sg))
> -				+ sg->offset;
> +	/* location of command block must be 64 bit aligned */
> +	BUG_ON(host->dma.cmd_busaddr & 0x07);
>  
> -	if (i == (host->dma.num_ents - 1))
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

+		box->cmd = CMD_MODE_BOX;

needs to be here.
