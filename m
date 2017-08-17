From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 17 Aug 2017 12:06:17 +0530
Subject: [PATCH v2 09/16] dmaengine: bcm-sba-raid: Improve
 sba_issue_pending() run duration
In-Reply-To: <1501583880-32072-10-git-send-email-anup.patel@broadcom.com>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-10-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170817063614.GZ3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 04:07:53PM +0530, Anup Patel wrote:
> The pending sba_request list can become very long in real-life usage
> (e.g. setting up RAID array) which can cause sba_issue_pending() to
> run for long duration.

that raises the warning flags.. Even if we have a long pending list why
would issue_pending run for long. The purpose of the issue_pending() is to
submit a txn if idle and return. The interrupt and tasklet shall push the
subsequent txn to hardware...


> 
> This patch adds common sba_process_deferred_requests() to process
> few completed and pending requests so that it finishes in short
> duration. We use this common sba_process_deferred_requests() in
> both sba_issue_pending() and sba_receive_message().
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/dma/bcm-sba-raid.c | 234 ++++++++++++++++++++++++---------------------
>  1 file changed, 125 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
> index af6cc8e..f6616da 100644
> --- a/drivers/dma/bcm-sba-raid.c
> +++ b/drivers/dma/bcm-sba-raid.c
> @@ -277,38 +277,28 @@ static void _sba_free_request(struct sba_device *sba,
>  		sba->reqs_fence = false;
>  }
>  
> -static void sba_received_request(struct sba_request *req)
> +/* Note: Must be called with sba->reqs_lock held */
> +static void _sba_complete_request(struct sba_device *sba,
> +				  struct sba_request *req)
>  {
> -	unsigned long flags;
> -	struct sba_device *sba = req->sba;
> -
> -	spin_lock_irqsave(&sba->reqs_lock, flags);
> +	lockdep_assert_held(&sba->reqs_lock);
>  	req->flags &= ~SBA_REQUEST_STATE_MASK;
> -	req->flags |= SBA_REQUEST_STATE_RECEIVED;
> -	list_move_tail(&req->node, &sba->reqs_received_list);
> -	spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +	req->flags |= SBA_REQUEST_STATE_COMPLETED;
> +	list_move_tail(&req->node, &sba->reqs_completed_list);
> +	if (list_empty(&sba->reqs_active_list))
> +		sba->reqs_fence = false;
>  }
>  
> -static void sba_complete_chained_requests(struct sba_request *req)
> +/* Note: Must be called with sba->reqs_lock held */
> +static void _sba_received_request(struct sba_device *sba,
> +				  struct sba_request *req)
>  {
> -	unsigned long flags;
> -	struct sba_request *nreq;
> -	struct sba_device *sba = req->sba;
> -
> -	spin_lock_irqsave(&sba->reqs_lock, flags);
> -
> +	lockdep_assert_held(&sba->reqs_lock);
>  	req->flags &= ~SBA_REQUEST_STATE_MASK;
> -	req->flags |= SBA_REQUEST_STATE_COMPLETED;
> -	list_move_tail(&req->node, &sba->reqs_completed_list);
> -	list_for_each_entry(nreq, &req->next, next) {
> -		nreq->flags &= ~SBA_REQUEST_STATE_MASK;
> -		nreq->flags |= SBA_REQUEST_STATE_COMPLETED;
> -		list_move_tail(&nreq->node, &sba->reqs_completed_list);
> -	}
> +	req->flags |= SBA_REQUEST_STATE_RECEIVED;
> +	list_move_tail(&req->node, &sba->reqs_received_list);
>  	if (list_empty(&sba->reqs_active_list))
>  		sba->reqs_fence = false;
> -
> -	spin_unlock_irqrestore(&sba->reqs_lock, flags);
>  }
>  
>  static void sba_free_chained_requests(struct sba_request *req)
> @@ -386,26 +376,6 @@ static void sba_cleanup_pending_requests(struct sba_device *sba)
>  	spin_unlock_irqrestore(&sba->reqs_lock, flags);
>  }
>  
> -/* ====== DMAENGINE callbacks ===== */
> -
> -static void sba_free_chan_resources(struct dma_chan *dchan)
> -{
> -	/*
> -	 * Channel resources are pre-alloced so we just free-up
> -	 * whatever we can so that we can re-use pre-alloced
> -	 * channel resources next time.
> -	 */
> -	sba_cleanup_nonpending_requests(to_sba_device(dchan));
> -}
> -
> -static int sba_device_terminate_all(struct dma_chan *dchan)
> -{
> -	/* Cleanup all pending requests */
> -	sba_cleanup_pending_requests(to_sba_device(dchan));
> -
> -	return 0;
> -}
> -
>  static int sba_send_mbox_request(struct sba_device *sba,
>  				 struct sba_request *req)
>  {
> @@ -431,17 +401,27 @@ static int sba_send_mbox_request(struct sba_device *sba,
>  	return 0;
>  }
>  
> -static void sba_issue_pending(struct dma_chan *dchan)
> +static void sba_process_deferred_requests(struct sba_device *sba)
>  {
>  	int ret;
> +	u32 count;
>  	unsigned long flags;
> -	struct sba_request *req, *req1;
> -	struct sba_device *sba = to_sba_device(dchan);
> +	struct sba_request *req;
> +	struct dma_async_tx_descriptor *tx;
>  
>  	spin_lock_irqsave(&sba->reqs_lock, flags);
>  
> -	/* Process all pending request */
> -	list_for_each_entry_safe(req, req1, &sba->reqs_pending_list, node) {
> +	/* Count pending requests */
> +	count = 0;
> +	list_for_each_entry(req, &sba->reqs_pending_list, node)
> +		count++;
> +
> +	/* Process pending requests */
> +	while (!list_empty(&sba->reqs_pending_list) && count) {
> +		/* Get the first pending request */
> +		req = list_first_entry(&sba->reqs_pending_list,
> +				       struct sba_request, node);
> +
>  		/* Try to make request active */
>  		if (!_sba_active_request(sba, req))
>  			break;
> @@ -456,11 +436,102 @@ static void sba_issue_pending(struct dma_chan *dchan)
>  			_sba_pending_request(sba, req);
>  			break;
>  		}
> +
> +		count--;
> +	}
> +
> +	/* Count completed requests */
> +	count = 0;
> +	list_for_each_entry(req, &sba->reqs_completed_list, node)
> +		count++;
> +
> +	/* Process completed requests */
> +	while (!list_empty(&sba->reqs_completed_list) && count) {
> +		req = list_first_entry(&sba->reqs_completed_list,
> +					struct sba_request, node);
> +		list_del_init(&req->node);
> +		tx = &req->tx;
> +
> +		spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +
> +		WARN_ON(tx->cookie < 0);
> +		if (tx->cookie > 0) {
> +			dma_cookie_complete(tx);
> +			dmaengine_desc_get_callback_invoke(tx, NULL);
> +			dma_descriptor_unmap(tx);
> +			tx->callback = NULL;
> +			tx->callback_result = NULL;
> +		}
> +
> +		dma_run_dependencies(tx);
> +
> +		spin_lock_irqsave(&sba->reqs_lock, flags);
> +
> +		/* If waiting for 'ack' then move to completed list */
> +		if (!async_tx_test_ack(&req->tx))
> +			_sba_complete_request(sba, req);
> +		else
> +			_sba_free_request(sba, req);
> +
> +		count--;
>  	}
>  
> +	/* Re-check pending and completed work */
> +	count = 0;
> +	if (!list_empty(&sba->reqs_pending_list) ||
> +	    !list_empty(&sba->reqs_completed_list))
> +		count = 1;
> +
>  	spin_unlock_irqrestore(&sba->reqs_lock, flags);
>  }
>  
> +static void sba_process_received_request(struct sba_device *sba,
> +					 struct sba_request *req)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sba->reqs_lock, flags);
> +
> +	/* Mark request as received */
> +	_sba_received_request(sba, req);
> +
> +	/* Update request */
> +	if (!atomic_dec_return(&req->first->next_pending_count))
> +		_sba_complete_request(sba, req->first);
> +	if (req->first != req)
> +		_sba_free_request(sba, req);
> +
> +	spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +}
> +
> +/* ====== DMAENGINE callbacks ===== */
> +
> +static void sba_free_chan_resources(struct dma_chan *dchan)
> +{
> +	/*
> +	 * Channel resources are pre-alloced so we just free-up
> +	 * whatever we can so that we can re-use pre-alloced
> +	 * channel resources next time.
> +	 */
> +	sba_cleanup_nonpending_requests(to_sba_device(dchan));
> +}
> +
> +static int sba_device_terminate_all(struct dma_chan *dchan)
> +{
> +	/* Cleanup all pending requests */
> +	sba_cleanup_pending_requests(to_sba_device(dchan));
> +
> +	return 0;
> +}
> +
> +static void sba_issue_pending(struct dma_chan *dchan)
> +{
> +	struct sba_device *sba = to_sba_device(dchan);
> +
> +	/* Process deferred requests */
> +	sba_process_deferred_requests(sba);
> +}
> +
>  static dma_cookie_t sba_tx_submit(struct dma_async_tx_descriptor *tx)
>  {
>  	unsigned long flags;
> @@ -1382,40 +1453,10 @@ sba_prep_dma_pq(struct dma_chan *dchan, dma_addr_t *dst, dma_addr_t *src,
>  
>  /* ====== Mailbox callbacks ===== */
>  
> -static void sba_dma_tx_actions(struct sba_request *req)
> -{
> -	struct dma_async_tx_descriptor *tx = &req->tx;
> -
> -	WARN_ON(tx->cookie < 0);
> -
> -	if (tx->cookie > 0) {
> -		dma_cookie_complete(tx);
> -
> -		/*
> -		 * Call the callback (must not sleep or submit new
> -		 * operations to this channel)
> -		 */
> -		if (tx->callback)
> -			tx->callback(tx->callback_param);
> -
> -		dma_descriptor_unmap(tx);
> -	}
> -
> -	/* Run dependent operations */
> -	dma_run_dependencies(tx);
> -
> -	/* If waiting for 'ack' then move to completed list */
> -	if (!async_tx_test_ack(&req->tx))
> -		sba_complete_chained_requests(req);
> -	else
> -		sba_free_chained_requests(req);
> -}
> -
>  static void sba_receive_message(struct mbox_client *cl, void *msg)
>  {
> -	unsigned long flags;
>  	struct brcm_message *m = msg;
> -	struct sba_request *req = m->ctx, *req1;
> +	struct sba_request *req = m->ctx;
>  	struct sba_device *sba = req->sba;
>  
>  	/* Error count if message has error */
> @@ -1423,36 +1464,11 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
>  		dev_err(sba->dev, "%s got message with error %d",
>  			dma_chan_name(&sba->dma_chan), m->error);
>  
> -	/* Mark request as received */
> -	sba_received_request(req);
> -
> -	/* Wait for all chained requests to be completed */
> -	if (atomic_dec_return(&req->first->next_pending_count))
> -		goto done;
> -
> -	/* Point to first request */
> -	req = req->first;
> -
> -	/* Update request */
> -	if (req->flags & SBA_REQUEST_STATE_RECEIVED)
> -		sba_dma_tx_actions(req);
> -	else
> -		sba_free_chained_requests(req);
> -
> -	spin_lock_irqsave(&sba->reqs_lock, flags);
> -
> -	/* Re-check all completed request waiting for 'ack' */
> -	list_for_each_entry_safe(req, req1, &sba->reqs_completed_list, node) {
> -		spin_unlock_irqrestore(&sba->reqs_lock, flags);
> -		sba_dma_tx_actions(req);
> -		spin_lock_irqsave(&sba->reqs_lock, flags);
> -	}
> -
> -	spin_unlock_irqrestore(&sba->reqs_lock, flags);
> +	/* Process received request */
> +	sba_process_received_request(sba, req);
>  
> -done:
> -	/* Try to submit pending request */
> -	sba_issue_pending(&sba->dma_chan);
> +	/* Process deferred requests */
> +	sba_process_deferred_requests(sba);
>  }
>  
>  /* ====== Platform driver routines ===== */
> -- 
> 2.7.4
> 

-- 
~Vinod
