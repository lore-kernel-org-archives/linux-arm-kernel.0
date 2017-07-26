From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 26 Jul 2017 22:45:55 +0530
Subject: [PATCH 4/6] dma: bcm-sba-raid: Break
 sba_process_deferred_requests() into two parts
In-Reply-To: <1501047404-14456-5-git-send-email-anup.patel@broadcom.com>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
 <1501047404-14456-5-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170726171554.GK3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 11:06:42AM +0530, Anup Patel wrote:
> This patch breaks sba_process_deferred_requests() into two parts
> sba_process_received_request() and _sba_process_pending_requests()
> for readability.
> 
> In addition, 

that should be a separate patch then... no?

> we remove redundant SBA_REQUEST_STATE_RECEIVED state

this should be one more...

> and ensure that all requests in a chained request should be freed
> only after all have been received.

and then this, right?

> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/dma/bcm-sba-raid.c | 130 ++++++++++++++++-----------------------------
>  1 file changed, 47 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
> index db5e3db..b92c756 100644
> --- a/drivers/dma/bcm-sba-raid.c
> +++ b/drivers/dma/bcm-sba-raid.c
> @@ -97,9 +97,8 @@ enum sba_request_flags {
>  	SBA_REQUEST_STATE_ALLOCED	= 0x002,
>  	SBA_REQUEST_STATE_PENDING	= 0x004,
>  	SBA_REQUEST_STATE_ACTIVE	= 0x008,
> -	SBA_REQUEST_STATE_RECEIVED	= 0x010,
> -	SBA_REQUEST_STATE_COMPLETED	= 0x020,
> -	SBA_REQUEST_STATE_ABORTED	= 0x040,
> +	SBA_REQUEST_STATE_COMPLETED     = 0x010,
> +	SBA_REQUEST_STATE_ABORTED	= 0x020,

so we changed this is patch 1, only to change it here. why....!!!!

so let me stop here again and repeat myself again about splitting stuff up,
blah blah, good patches, blah blah, read the Documentation blah blah.. and
hope someones listening :(


>  	SBA_REQUEST_STATE_MASK		= 0x0ff,
>  	SBA_REQUEST_FENCE		= 0x100,
>  };
> @@ -159,7 +158,6 @@ struct sba_device {
>  	struct list_head reqs_alloc_list;
>  	struct list_head reqs_pending_list;
>  	struct list_head reqs_active_list;
> -	struct list_head reqs_received_list;
>  	struct list_head reqs_completed_list;
>  	struct list_head reqs_aborted_list;
>  	struct list_head reqs_free_list;
> @@ -306,17 +304,6 @@ static void _sba_complete_request(struct sba_device *sba,
>  		sba->reqs_fence = false;
>  }
>  
> -/* Note: Must be called with sba->reqs_lock held */
> -static void _sba_received_request(struct sba_device *sba,
> -				  struct sba_request *req)
> -{
> -	lockdep_assert_held(&sba->reqs_lock);
> -	req->flags = SBA_REQUEST_STATE_RECEIVED;
> -	list_move_tail(&req->node, &sba->reqs_received_list);
> -	if (list_empty(&sba->reqs_active_list))
> -		sba->reqs_fence = false;
> -}
> -
>  static void sba_free_chained_requests(struct sba_request *req)
>  {
>  	unsigned long flags;
> @@ -358,10 +345,6 @@ static void sba_cleanup_nonpending_requests(struct sba_device *sba)
>  	list_for_each_entry_safe(req, req1, &sba->reqs_alloc_list, node)
>  		_sba_free_request(sba, req);
>  
> -	/* Freeup all received request */
> -	list_for_each_entry_safe(req, req1, &sba->reqs_received_list, node)
> -		_sba_free_request(sba, req);
> -
>  	/* Freeup all completed request */
>  	list_for_each_entry_safe(req, req1, &sba->reqs_completed_list, node)
>  		_sba_free_request(sba, req);
> @@ -417,22 +400,20 @@ static int sba_send_mbox_request(struct sba_device *sba,
>  	return 0;
>  }
>  
> -static void sba_process_deferred_requests(struct sba_device *sba)
> +/* Note: Must be called with sba->reqs_lock held */
> +static void _sba_process_pending_requests(struct sba_device *sba)
>  {
>  	int ret;
>  	u32 count;
> -	unsigned long flags;
>  	struct sba_request *req;
> -	struct dma_async_tx_descriptor *tx;
> -
> -	spin_lock_irqsave(&sba->reqs_lock, flags);
> -
> -	/* Count pending requests */
> -	count = 0;
> -	list_for_each_entry(req, &sba->reqs_pending_list, node)
> -		count++;
>  
> -	/* Process pending requests */
> +	/*
> +	 * Process few pending requests
> +	 *
> +	 * For now, we process (<number_of_mailbox_channels> * 8)
> +	 * number of requests at a time.
> +	 */
> +	count = sba->mchans_count * 8;
>  	while (!list_empty(&sba->reqs_pending_list) && count) {
>  		/* Get the first pending request */
>  		req = list_first_entry(&sba->reqs_pending_list,
> @@ -443,11 +424,7 @@ static void sba_process_deferred_requests(struct sba_device *sba)
>  			break;
>  
>  		/* Send request to mailbox channel */
> -		spin_unlock_irqrestore(&sba->reqs_lock, flags);
>  		ret = sba_send_mbox_request(sba, req);
> -		spin_lock_irqsave(&sba->reqs_lock, flags);
> -
> -		/* If something went wrong then keep request pending */
>  		if (ret < 0) {
>  			_sba_pending_request(sba, req);
>  			break;
> @@ -455,20 +432,18 @@ static void sba_process_deferred_requests(struct sba_device *sba)
>  
>  		count--;
>  	}
> +}
>  
> -	/* Count completed requests */
> -	count = 0;
> -	list_for_each_entry(req, &sba->reqs_completed_list, node)
> -		count++;
> -
> -	/* Process completed requests */
> -	while (!list_empty(&sba->reqs_completed_list) && count) {
> -		req = list_first_entry(&sba->reqs_completed_list,
> -					struct sba_request, node);
> -		list_del_init(&req->node);
> -		tx = &req->tx;
> +static void sba_process_received_request(struct sba_device *sba,
> +					 struct sba_request *req)
> +{
> +	unsigned long flags;
> +	struct dma_async_tx_descriptor *tx;
> +	struct sba_request *nreq, *first = req->first;
>  
> -		spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +	/* Process only after all chained requests are received */
> +	if (!atomic_dec_return(&first->next_pending_count)) {
> +		tx = &first->tx;
>  
>  		WARN_ON(tx->cookie < 0);
>  		if (tx->cookie > 0) {
> @@ -483,41 +458,31 @@ static void sba_process_deferred_requests(struct sba_device *sba)
>  
>  		spin_lock_irqsave(&sba->reqs_lock, flags);
>  
> -		/* If waiting for 'ack' then move to completed list */
> -		if (!async_tx_test_ack(&req->tx))
> -			_sba_complete_request(sba, req);
> -		else
> -			_sba_free_request(sba, req);
> -
> -		count--;
> -	}
> -
> -	/* Re-check pending and completed work */
> -	count = 0;
> -	if (!list_empty(&sba->reqs_pending_list) ||
> -	    !list_empty(&sba->reqs_completed_list))
> -		count = 1;
> -
> -	spin_unlock_irqrestore(&sba->reqs_lock, flags);
> -}
> -
> -static void sba_process_received_request(struct sba_device *sba,
> -					 struct sba_request *req)
> -{
> -	unsigned long flags;
> +		/* Free all requests chained to first request */
> +		list_for_each_entry(nreq, &first->next, next)
> +			_sba_free_request(sba, nreq);
> +		INIT_LIST_HEAD(&first->next);
>  
> -	spin_lock_irqsave(&sba->reqs_lock, flags);
> +		/* The client is allowed to attach dependent operations
> +		 * until 'ack' is set
> +		 */
> +		if (!async_tx_test_ack(tx))
> +			_sba_complete_request(sba, first);
> +		else
> +			_sba_free_request(sba, first);
>  
> -	/* Mark request as received */
> -	_sba_received_request(sba, req);
> +		/* Cleanup completed requests */
> +		list_for_each_entry_safe(req, nreq,
> +					 &sba->reqs_completed_list, node) {
> +			if (async_tx_test_ack(&req->tx))
> +				_sba_free_request(sba, req);
> +		}
>  
> -	/* Update request */
> -	if (!atomic_dec_return(&req->first->next_pending_count))
> -		_sba_complete_request(sba, req->first);
> -	if (req->first != req)
> -		_sba_free_request(sba, req);
> +		/* Process pending requests */
> +		_sba_process_pending_requests(sba);
>  
> -	spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +		spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +	}
>  }
>  
>  /* ====== DMAENGINE callbacks ===== */
> @@ -542,10 +507,13 @@ static int sba_device_terminate_all(struct dma_chan *dchan)
>  
>  static void sba_issue_pending(struct dma_chan *dchan)
>  {
> +	unsigned long flags;
>  	struct sba_device *sba = to_sba_device(dchan);
>  
> -	/* Process deferred requests */
> -	sba_process_deferred_requests(sba);
> +	/* Process pending requests */
> +	spin_lock_irqsave(&sba->reqs_lock, flags);
> +	_sba_process_pending_requests(sba);
> +	spin_unlock_irqrestore(&sba->reqs_lock, flags);
>  }
>  
>  static dma_cookie_t sba_tx_submit(struct dma_async_tx_descriptor *tx)
> @@ -1480,9 +1448,6 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
>  
>  	/* Process received request */
>  	sba_process_received_request(sba, req);
> -
> -	/* Process deferred requests */
> -	sba_process_deferred_requests(sba);
>  }
>  
>  /* ====== Platform driver routines ===== */
> @@ -1511,7 +1476,6 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
>  	INIT_LIST_HEAD(&sba->reqs_alloc_list);
>  	INIT_LIST_HEAD(&sba->reqs_pending_list);
>  	INIT_LIST_HEAD(&sba->reqs_active_list);
> -	INIT_LIST_HEAD(&sba->reqs_received_list);
>  	INIT_LIST_HEAD(&sba->reqs_completed_list);
>  	INIT_LIST_HEAD(&sba->reqs_aborted_list);
>  	INIT_LIST_HEAD(&sba->reqs_free_list);
> -- 
> 2.7.4
> 

-- 
~Vinod
