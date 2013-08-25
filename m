From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 22:03:37 +0530
Subject: [PATCH v5 4/5] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1377086938-29145-5-git-send-email-zonque@gmail.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
 <1377086938-29145-5-git-send-email-zonque@gmail.com>
Message-ID: <20130825163337.GD2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 02:08:57PM +0200, Daniel Mack wrote:
> In order to report the channel's residue, we walk the list of running
> descriptors, look for those which match the cookie, and then try to find
> the descriptor which defines upper and lower boundaries that embrace the
> current transport pointer.

> 
> +		/*
> +		 * 'passed' will be latched once we found the descriptor which
> +		 * lies inside the boundaries of the curr pointer. All
> +		 * descriptors that occur in the list _after_ we found that
> +		 * partially handled descriptor are still to be processed and
> +		 * are hence added to the residual bytes counter.
> +		 */
do you have multiple descriptors for one transaction? Should be No.

The cookie is assigned to a transaction when it is submitted. so when you see
descriptor cookie is less than completed one, then it already completed and
should not be in pending list.

>  static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>  			dma_cookie_t cookie, struct dma_tx_state *txstate)
>  {
> @@ -750,6 +822,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>  
>  	spin_lock_irqsave(&chan->desc_lock, flags);
>  	ret = dma_cookie_status(dchan, cookie, txstate);
> +	txstate->residue = mmp_pdma_residue(chan, cookie);
here you check ret value first, if descriptor is completed then you will get
DMA_SUCCESS and just return that, no need to check the residue. If it is
pending, then also just return size of transaction. Only when it is progress you
need to calculate and check

~Vinod
