From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 14 May 2017 17:51:58 +0530
Subject: [PATCH RESEND] dmaengine: pl330: Fix data race on TX transferred
 bytes reporting
In-Reply-To: <20170302125710.14483-1-romain.perier@collabora.com>
References: <20170302125710.14483-1-romain.perier@collabora.com>
Message-ID: <20170514122158.GG6263@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 01:57:10PM +0100, Romain Perier wrote:
> When a transfer completes there is a small window between the descriptor
> being unset as the current active one in the thread and it being marked
> as done. This causes the residue to be incorrectly set and the
> corresponding size to be wrongly reported when pl330_tx_status is run in
> that window. This can be reproduced in different ways, the main we have
> found is with audio playback when the system load is high. When the
> residue goes up during a transfer, it makes the audio ringbuffer wrapped
> around and thus does a sudden jump forward. It can also be detected by
> sudden sound disruptions.
> 
> This bug was partially solved by commit a40235a2278a ("dmaengine: pl330:
> Acquire dmac's spinlock in pl330_tx_status"), as it reduces the window
> where it can happen, but the issue still exists.

IIUC, the fix is not to drop the lock and sadly the log talks about the
issue but not the fix. The patch is supposed to also describe the changes


> 
> This patch is a re-worked version of the one wrote by Sjoerd Simons
> https://patchwork.kernel.org/patch/7568251.
> 
> Original-author: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>

Please see Documentation/process/submitting-patches.rst

The patch author is still the original author and not you..

> ---
> 
> Note: Due to an email configuration issue, some of my patches were not
> received on infradead.org or vger.kernel.org. It is now fixed, so I
> resend this patch for this reason.

And somehow this slipped, don't know if it was delivered, but somehow was
pending in patchworks (yaaay) so I pulled from that

> 
>  drivers/dma/pl330.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 740bbb9..4046737 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1640,6 +1640,7 @@ static int pl330_update(struct pl330_dmac *pl330)
>  
>  			/* Detach the req */
>  			descdone = thrd->req[active].desc;
> +			descdone->status = DONE;
>  			thrd->req[active].desc = NULL;
>  
>  			thrd->req_running = -1;
> @@ -1654,9 +1655,18 @@ static int pl330_update(struct pl330_dmac *pl330)
>  
>  	/* Now that we are in no hurry, do the callbacks */
>  	list_for_each_entry_safe(descdone, tmp, &pl330->req_done, rqd) {
> +		struct dma_pl330_chan *pch;
> +
>  		list_del(&descdone->rqd);
> +
>  		spin_unlock_irqrestore(&pl330->lock, flags);
> -		dma_pl330_rqcb(descdone, PL330_ERR_NONE);
> +		pch = descdone->pchan;
> +		/* If desc aborted */
> +		if (!pch) {
> +			spin_lock_irqsave(&pl330->lock, flags);
> +			continue;
> +		}
> +		tasklet_schedule(&pch->task);
>  		spin_lock_irqsave(&pl330->lock, flags);
>  	}
>  
> -- 
> 2.9.3
> 

-- 
~Vinod
