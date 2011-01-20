From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 20 Jan 2011 03:20:21 -0800
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1295522421.4366.34.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 15:03 -0800, Daniel Walker wrote:
> Remove parts of this driver which use internal API calls. This
> replaces the calls as suggested by Russell King.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
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

It would seem there was a reason for this change.. The person that added
this was Brent Degraaf (who is CC'd) ..

Quoting him below speaking about why dma_map_sg() isn't just used,

"Previous version of msm_sdcc.c had a cache coherency problem for
precisely this reason. The dma_map_sg is what cleans the caches for
these commands and so must be done AFTER the commands are populated. If
this entry is left until the map function is called, the
box->dst_row_addr will not be filled properly for reads."

Daniel


-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
