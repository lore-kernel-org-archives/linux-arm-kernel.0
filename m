From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Mar 2014 20:43:52 +0530
Subject: [PATCH RESEND] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1392636546-15541-1-git-send-email-zonque@gmail.com>
References: <1392636546-15541-1-git-send-email-zonque@gmail.com>
Message-ID: <20140319151352.GJ1976@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 12:29:06PM +0100, Daniel Mack wrote:
> A channel can accommodate more than one transaction, each consisting of
> multiple descriptors, the last of which has the DCMD_ENDIRQEN bit set.
> 
> In order to report the channel's residue, we hence have to walk the
> list of running descriptors, look for those which match the cookie,
> and then try to find the descriptor which defines upper and lower
> boundaries that embrace the current transport pointer. Once it is found,
> walk forward until we find the descriptor that tells us about the end of
> a transaction via a set DCMD_ENDIRQEN bit.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> 
> Hi Vinod, everyone,
> 
> I'd like to get the disussion regarding this patch started again
> which left off here:
Sorry for delay, This hit my inboxwhen my vacation started...

> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/217429.html
> 
> I think the biggest issue in the previous discussion was a confusion
> about the term 'descriptor', as it refers to both the internal pdma
> implementation detail as well as the handle used in the dma subsystem.
> 
> I hope I explained that well enough in the link above.
> 
> 
> Many thanks,
> Daniel
> 
>  drivers/dma/mmp_pdma.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index b439679..2eb1c10 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -29,8 +29,8 @@
>  #define DALGN		0x00a0
>  #define DINT		0x00f0
>  #define DDADR		0x0200
> -#define DSADR		0x0204
> -#define DTADR		0x0208
> +#define DSADR(n)	(0x0204 + ((n) << 4))
> +#define DTADR(n)	(0x0208 + ((n) << 4))
>  #define DCMD		0x020c
>  
>  #define DCSR_RUN	BIT(31)	/* Run Bit (read / write) */
> @@ -748,11 +748,92 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>  	return 0;
>  }
>  
> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
> +				     dma_cookie_t cookie)
> +{
> +	struct mmp_pdma_desc_sw *sw;
> +	u32 curr, residue = 0;
> +	bool passed = false;
> +	bool cyclic = chan->cyclic_first != NULL;
> +
> +	/*
> +	 * If the channel does not have a phy pointer anymore, it has already
> +	 * been completed. Therefore, its residue is 0.
> +	 */
> +	if (!chan->phy)
> +		return 0;
> +
> +	if (chan->dir == DMA_DEV_TO_MEM)
> +		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
> +	else
> +		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
> +
> +	list_for_each_entry(sw, &chan->chain_running, node) {
> +		u32 start, end, len;
> +
> +		if (chan->dir == DMA_DEV_TO_MEM)
> +			start = sw->desc.dtadr;
> +		else
> +			start = sw->desc.dsadr;
> +
> +		len = sw->desc.dcmd & DCMD_LENGTH;
> +		end = start + len;
> +
> +		/*
> +		 * 'passed' will be latched once we found the descriptor which
> +		 * lies inside the boundaries of the curr pointer. All
> +		 * descriptors that occur in the list _after_ we found that
> +		 * partially handled descriptor are still to be processed and
> +		 * are hence added to the residual bytes counter.
> +		 */
> +
> +		if (passed) {
> +			residue += len;
> +		} else if (curr >= start && curr <= end) {
> +			residue += end - curr;
> +			passed = true;
> +		}
> +
> +		/*
> +		 * Descriptors that have the ENDIRQEN bit set mark the end of a
> +		 * transaction chain, and the cookie assigned with it has been
> +		 * returned previously from mmp_pdma_tx_submit().
> +		 *
> +		 * In case we have multiple transactions in the running chain,
> +		 * and the cookie does not match the one the user asked us
> +		 * about, reset the state variables and start over.
> +		 *
> +		 * This logic does not apply to cyclic transactions, where all
> +		 * descriptors have the ENDIRQEN bit set, and for which we
> +		 * can't have multiple transactions on one channel anyway.
> +		 */
> +		if (cyclic || !(sw->desc.dcmd & DCMD_ENDIRQEN))
> +			continue;
> +
> +		if (sw->async_tx.cookie == cookie) {
> +			return residue;
> +		} else {
> +			residue = 0;
> +			passed = false;
> +		}
for cookie in queue, the residue is not 0 but complete length of transaction.
Possibly you should check this in mmp_pdma_tx_status and only invoke current
function for current transaction.

Secondly, if you have 3 descriptor in the chain_running, the residue on last
will add all lengths till last one, that is not something we wnat. Perhpas when
you fix above it should be okay 
> +	}
> +
> +	/* We should only get here in case of cyclic transactions */
> +	return residue;
> +}
> +
>  static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>  					  dma_cookie_t cookie,
>  					  struct dma_tx_state *txstate)
>  {
> -	return dma_cookie_status(dchan, cookie, txstate);
> +	struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(dchan, cookie, txstate);
> +	if (likely(ret != DMA_ERROR))
> +		dma_set_residue(txstate, mmp_pdma_residue(chan, cookie));
Pls check if resuide is not NULL, then only invoke mmp_pdma_residue()

-- 
~Vinod
