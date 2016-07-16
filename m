From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 15 Jul 2016 21:00:52 -0400
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
Message-ID: <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 7/13/2016 10:57 PM, Sinan Kaya wrote:
> There is a race condition between data transfer callback and descriptor
> free code. The callback routine may decide to clear the resources even
> though the descriptor has not yet been freed.
> 
> Instead of calling the callback first and then releasing the memory,
> this code is changing the order to return the descriptor back to the
> free pool and then call the user provided callback.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/dma/qcom/hidma.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index 41b5c6d..c41696e 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -111,6 +111,7 @@ static void hidma_process_completed(struct hidma_chan *mchan)
>  	struct dma_async_tx_descriptor *desc;
>  	dma_cookie_t last_cookie;
>  	struct hidma_desc *mdesc;
> +	struct hidma_desc *next;
>  	unsigned long irqflags;
>  	struct list_head list;
>  
> @@ -122,28 +123,31 @@ static void hidma_process_completed(struct hidma_chan *mchan)
>  	spin_unlock_irqrestore(&mchan->lock, irqflags);
>  
>  	/* Execute callbacks and run dependencies */
> -	list_for_each_entry(mdesc, &list, node) {
> -		enum dma_status llstat;
> +	list_for_each_entry_safe(mdesc, next, &list, node) {
> +		dma_async_tx_callback callback;
> +		void *param;
>  
>  		desc = &mdesc->desc;
>  
>  		spin_lock_irqsave(&mchan->lock, irqflags);
> -		dma_cookie_complete(desc);
> +		if (hidma_ll_status(mdma->lldev, mdesc->tre_ch)
> +			== DMA_COMPLETE)
> +			dma_cookie_complete(desc);

It looks like I introduced a behavioral change while refactoring the code.
The previous one would call the callback only if the transfer was successful
but it would always call dma_cookie_complete.

The new behavior is to call dma_cookie_complete only if the transfer is successful
and it calls the callback even in the case of error cases. Then, the client has
to query if transfer was successful.

Which one is the correct behavior?


>  		spin_unlock_irqrestore(&mchan->lock, irqflags);
>  
> -		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
> -		if (desc->callback && (llstat == DMA_COMPLETE))
> -			desc->callback(desc->callback_param);
> +		callback = desc->callback;
> +		param = desc->callback_param;
>  
>  		last_cookie = desc->cookie;
>  		dma_run_dependencies(desc);
> -	}
>  
> -	/* Free descriptors */
> -	spin_lock_irqsave(&mchan->lock, irqflags);
> -	list_splice_tail_init(&list, &mchan->free);
> -	spin_unlock_irqrestore(&mchan->lock, irqflags);
> +		spin_lock_irqsave(&mchan->lock, irqflags);
> +		list_move(&mdesc->node, &mchan->free);
> +		spin_unlock_irqrestore(&mchan->lock, irqflags);
>  
> +		if (callback)
> +			callback(param);
> +	}
>  }
>  
>  /*
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
