From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Mar 2016 09:42:38 +0530
Subject: [PATCH] dmaengine: pl330: Fix some race conditions in residue
 calculation
In-Reply-To: <1456319674.2867.15.camel@linaro.org>
References: <1456319674.2867.15.camel@linaro.org>
Message-ID: <20160308041238.GL11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 01:14:34PM +0000, Jon Medhurst (Tixy) wrote:
> The residue calculation in pl330_tx_status doesn't handle transitional
> states that occur at the time one descriptor (A) is completed and the
> next (B) is started. Specifically, both A and B can simultaneously be in
> the BUSY state and at this time the thread's 'req_running' may (or may
> not) be -1.

you are under lock so descriptor state wont be update while we are it.

Also the query for residue is for "a descriptor" not whatever is the current
running descriptor...

> 
> To cope with this situation we change the code to ensure A is treated as
> complete and B as having not yet started. Prior to the change, the code
> would calculate a transferred byte count as if both A and B had
> completed.

You query for either A or B not both!

> 
> Fixes: aee4d1fac887 ("dmaengine: pl330: improve pl330_tx_status() function")
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
> 
> I discovered this issue when trying to work out why audio stopped
> working on ARM's Juno platform and bisected it to commit aee4d1fac887.
> Whilst this patch seems to fix the problems I was seeing, I can't help
> but think there are more race conditions with this code. E.g. if the
> running descriptor changes under us, pl330_get_current_xferred_count
> can end up reading values from hardware that relate to a different
> descriptor. And if we're really unlucky, the reading of the 'val' and
> 'addr' values in pl330_get_current_xferred_count can come from different
> descriptors. I don't know if there is any locks we can use to prevent
> such races or if we need to try and detect when things have changed and
> redo/abort the residue calculation...
> 
>  drivers/dma/pl330.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 17ee758..55e3c5f 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2240,6 +2240,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  	struct dma_pl330_desc *desc, *running = NULL;
>  	struct dma_pl330_chan *pch = to_pchan(chan);
>  	unsigned int transferred, residual = 0;
> +	bool first_busy;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
>  
> @@ -2253,16 +2254,31 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  
>  	if (pch->thread->req_running != -1)
>  		running = pch->thread->req[pch->thread->req_running].desc;
> +	first_busy = true;
>  
>  	/* Check in pending list */
>  	list_for_each_entry(desc, &pch->work_list, node) {
>  		if (desc->status == DONE)
>  			transferred = desc->bytes_requested;
> -		else if (running && desc == running)
> -			transferred =
> -				pl330_get_current_xferred_count(pch, desc);
> -		else
> +		else if (desc->status == BUSY && first_busy) {
> +			first_busy = false;
> +			if (running && desc == running) {
> +				transferred =
> +					pl330_get_current_xferred_count(pch, desc);
> +			} else {
> +				/* BUSY but not running means it's just completed */
> +				transferred = desc->bytes_requested;
> +			}
> +		} else {
> +			/*
> +			 * Descriptor is either in PREP state queued for future
> +			 * transfer or it is the second BUSY descriptor we have
> +			 * seen. The latter case means it has just, or is about
> +			 * to be, started, so treat it as having not yet
> +			 * transferred any bytes, the same as PREP.
> +			 */
>  			transferred = 0;
> +		}
>  		residual += desc->bytes_requested - transferred;
>  		if (desc->txd.cookie == cookie) {
>  			switch (desc->status) {
> -- 
> 2.1.4
> 
> 

-- 
~Vinod
