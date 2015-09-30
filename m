From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 30 Sep 2015 15:01:31 +0300
Subject: [PATCH] mmc: core: fix dead loop of mmc_retune
In-Reply-To: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
References: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <560BCF1B.7050302@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/15 12:37, Chaotian Jing wrote:
> When get a CRC error, start the mmc_retune, it will issue CMD19/CMD21
> to do tune, assume there were 10 clock phase need to try, phase 0 to
> phase 6 is ok, phase 7 to phase 9 is NG, we try it from 0 to 9, so
> the last CMD19/CMD21 will get CRC error, host->need_retune was set and
> cause mmc_retune was called, then dead loop of mmc_retune
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Wasn't my idea to have this CRC checking in the core ;-) and sdhci
doesn't put it's tuning commands through a mmc request so it doesn't
see this issue.

But definitely the CRC logic is not meant for the tuning commands, so

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0520064..a3eb20b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -134,9 +134,11 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  	int err = cmd->error;
>  
>  	/* Flag re-tuning needed on CRC errors */
> -	if (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
> +	if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
> +	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> +	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
>  	    (mrq->data && mrq->data->error == -EILSEQ) ||
> -	    (mrq->stop && mrq->stop->error == -EILSEQ))
> +	    (mrq->stop && mrq->stop->error == -EILSEQ)))
>  		mmc_retune_needed(host);
>  
>  	if (err && cmd->retries && mmc_host_is_spi(host)) {
> 
