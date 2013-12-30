From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Mon, 30 Dec 2013 09:55:50 +0000
Subject: [PATCH 1/3] dma: mv_xor: take channel spinlock in mv_xor_status()
In-Reply-To: <1388144314-1581-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388144314-1581-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388397319.1871.251.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-12-27 at 12:38 +0100, Thomas Petazzoni wrote:
> The mv_xor_status() function accesses the mv_xor_chan structure, but
> was not taking the corresponding spinlock. This patch fixes this
> problem.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/dma/mv_xor.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 53fb0c8..526ab27 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -701,14 +701,20 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
>  	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
>  	enum dma_status ret;
>  
> +	spin_lock_bh(&mv_chan->lock);
> +

I don't think it's a proper place for this spinlock since
dma_cookie_status is independent to that.

>  	ret = dma_cookie_status(chan, cookie, txstate);
>  	if (ret == DMA_COMPLETE) {

If you are caring about mv_chan access, better to take it here...

>  		mv_xor_clean_completed_slots(mv_chan);
> +		spin_unlock_bh(&mv_chan->lock);
>  		return ret;
>  	}

...and here.

> -	mv_xor_slot_cleanup(mv_chan);
> +	__mv_xor_slot_cleanup(mv_chan);
>  
> -	return dma_cookie_status(chan, cookie, txstate);
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	spin_unlock_bh(&mv_chan->lock);
> +
> +	return ret;
>  }
>  
>  static void mv_dump_xor_regs(struct mv_xor_chan *chan)

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
