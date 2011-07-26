From: vkoul@infradead.org (Vinod Koul)
Date: Tue, 26 Jul 2011 15:05:33 +0530
Subject: [PATCH] Improve slave/cyclic DMA engine documentation (was:
	[PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability)
In-Reply-To: <20110726075720.GL9653@n2100.arm.linux.org.uk>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-5-git-send-email-boojin.kim@samsung.com>
	<20110725092749.GB9653@n2100.arm.linux.org.uk>
	<002001cc4ab6$0d7cd590$287680b0$%kim@samsung.com>
	<20110725103629.GF9653@n2100.arm.linux.org.uk>
	<1311590884.29703.2.camel@vkoul-mobl4>
	<20110725105754.GG9653@n2100.arm.linux.org.uk>
	<1311591717.29703.7.camel@vkoul-mobl4>
	<20110725113926.GH9653@n2100.arm.linux.org.uk>
	<1311595303.29703.31.camel@vkoul-mobl4>
	<20110726075720.GL9653@n2100.arm.linux.org.uk>
Message-ID: <1311672933.24316.1.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-07-26 at 08:57 +0100, Russell King - ARM Linux wrote:
> Here's an updated patch.
> 
> 8<----------
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> DMAEngine: Improve slave/cyclic documentation
> 
> Improve the documentation for the slave and cyclic DMA engine support
> reformatting it for easier reading, adding further APIs, splitting it
> into five steps, and including references to the documentation in
> dmaengine.h.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/dmaengine.txt |  211 ++++++++++++++++++++++++++++++-------------
>  1 files changed, 146 insertions(+), 65 deletions(-)
> 
> diff --git a/Documentation/dmaengine.txt b/Documentation/dmaengine.txt
> index 5a0cb1e..8c2e888 100644
> --- a/Documentation/dmaengine.txt
> +++ b/Documentation/dmaengine.txt
> @@ -10,87 +10,168 @@
>  Below is a guide to device driver writers on how to use the Slave-DMA API of the
>  DMA Engine. This is applicable only for slave DMA usage only.
>  
> -The slave DMA usage consists of following steps
> +The slave DMA usage consists of following steps:
>  1. Allocate a DMA slave channel
>  2. Set slave and controller specific parameters
>  3. Get a descriptor for transaction
>  4. Submit the transaction and wait for callback notification
> +5. Issue pending requests
Thanks Russell,

Applied with change to 4 above. Moved "and wait for callback
notification" to 5.

>  
>  1. Allocate a DMA slave channel
> -Channel allocation is slightly different in the slave DMA context, client
> -drivers typically need a channel from a particular DMA controller only and even
> -in some cases a specific channel is desired. To request a channel
> -dma_request_channel() API is used.
> -
> -Interface:
> -struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
> -		dma_filter_fn filter_fn,
> -		void *filter_param);
> -where dma_filter_fn is defined as:
> -typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *filter_param);
> -
> -When the optional 'filter_fn' parameter is set to NULL dma_request_channel
> -simply returns the first channel that satisfies the capability mask.  Otherwise,
> -when the mask parameter is insufficient for specifying the necessary channel,
> -the filter_fn routine can be used to disposition the available channels in the
> -system. The filter_fn routine is called once for each free channel in the
> -system.  Upon seeing a suitable channel filter_fn returns DMA_ACK which flags
> -that channel to be the return value from dma_request_channel.  A channel
> -allocated via this interface is exclusive to the caller, until
> -dma_release_channel() is called.
> +
> +   Channel allocation is slightly different in the slave DMA context,
> +   client drivers typically need a channel from a particular DMA
> +   controller only and even in some cases a specific channel is desired.
> +   To request a channel dma_request_channel() API is used.
> +
> +   Interface:
> +	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
> +			dma_filter_fn filter_fn,
> +			void *filter_param);
> +   where dma_filter_fn is defined as:
> +	typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *filter_param);
> +
> +   The 'filter_fn' parameter is optional, but highly recommended for
> +   slave and cyclic channels as they typically need to obtain a specific
> +   DMA channel.
> +
> +   When the optional 'filter_fn' parameter is NULL, dma_request_channel()
> +   simply returns the first channel that satisfies the capability mask.
> +
> +   Otherwise, the 'filter_fn' routine will be called once for each free
> +   channel which has a capability in 'mask'.  'filter_fn' is expected to
> +   return 'true' when the desired DMA channel is found.
> +
> +   A channel allocated via this interface is exclusive to the caller,
> +   until dma_release_channel() is called.
>  
>  2. Set slave and controller specific parameters
> -Next step is always to pass some specific information to the DMA driver. Most of
> -the generic information which a slave DMA can use is in struct dma_slave_config.
> -It allows the clients to specify DMA direction, DMA addresses, bus widths, DMA
> -burst lengths etc. If some DMA controllers have more parameters to be sent then
> -they should try to embed struct dma_slave_config in their controller specific
> -structure. That gives flexibility to client to pass more parameters, if
> -required.
> -
> -Interface:
> -int dmaengine_slave_config(struct dma_chan *chan,
> -					  struct dma_slave_config *config)
> +
> +   Next step is always to pass some specific information to the DMA
> +   driver.  Most of the generic information which a slave DMA can use
> +   is in struct dma_slave_config.  This allows the clients to specify
> +   DMA direction, DMA addresses, bus widths, DMA burst lengths etc
> +   for the peripheral.
> +
> +   If some DMA controllers have more parameters to be sent then they
> +   should try to embed struct dma_slave_config in their controller
> +   specific structure. That gives flexibility to client to pass more
> +   parameters, if required.
> +
> +   Interface:
> +	int dmaengine_slave_config(struct dma_chan *chan,
> +				  struct dma_slave_config *config)
> +
> +   Please see the dma_slave_config structure definition in dmaengine.h
> +   for a detailed explaination of the struct members.  Please note
> +   that the 'direction' member will be going away as it duplicates the
> +   direction given in the prepare call.
>  
>  3. Get a descriptor for transaction
> -For slave usage the various modes of slave transfers supported by the
> -DMA-engine are:
> -slave_sg	- DMA a list of scatter gather buffers from/to a peripheral
> -dma_cyclic	- Perform a cyclic DMA operation from/to a peripheral till the
> +
> +   For slave usage the various modes of slave transfers supported by the
> +   DMA-engine are:
> +
> +   slave_sg	- DMA a list of scatter gather buffers from/to a peripheral
> +   dma_cyclic	- Perform a cyclic DMA operation from/to a peripheral till the
>  		  operation is explicitly stopped.
> -The non NULL return of this transfer API represents a "descriptor" for the given
> -transaction.
>  
> -Interface:
> -struct dma_async_tx_descriptor *(*chan->device->device_prep_dma_sg)(
> +   A non-NULL return of this transfer API represents a "descriptor" for
> +   the given transaction.
> +
> +   Interface:
> +	struct dma_async_tx_descriptor *(*chan->device->device_prep_dma_sg)(
>  		struct dma_chan *chan,
>  		struct scatterlist *dst_sg, unsigned int dst_nents,
>  		struct scatterlist *src_sg, unsigned int src_nents,
>  		unsigned long flags);
> -struct dma_async_tx_descriptor *(*chan->device->device_prep_dma_cyclic)(
> +
> +	struct dma_async_tx_descriptor *(*chan->device->device_prep_dma_cyclic)(
>  		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  		size_t period_len, enum dma_data_direction direction);
>  
> -4. Submit the transaction and wait for callback notification
> -To schedule the transaction to be scheduled by dma device, the "descriptor"
> -returned in above (3) needs to be submitted.
> -To tell the dma driver that a transaction is ready to be serviced, the
> -descriptor->submit() callback needs to be invoked. This chains the descriptor to
> -the pending queue.
> -The transactions in the pending queue can be activated by calling the
> -issue_pending API. If channel is idle then the first transaction in queue is
> -started and subsequent ones queued up.
> -On completion of the DMA operation the next in queue is submitted and a tasklet
> -triggered. The tasklet would then call the client driver completion callback
> -routine for notification, if set.
> -Interface:
> -void dma_async_issue_pending(struct dma_chan *chan);
> -
> -==============================================================================
> -
> -Additional usage notes for dma driver writers
> -1/ Although DMA engine specifies that completion callback routines cannot submit
> -any new operations, but typically for slave DMA subsequent transaction may not
> -be available for submit prior to callback routine being called. This requirement
> -is not a requirement for DMA-slave devices. But they should take care to drop
> -the spin-lock they might be holding before calling the callback routine
> +   Once a descriptor has been obtained, the callback information can be
> +   added and must then be submitted.  Some DMA engine drivers may hold a
> +   spinlock between a successful preparation and submission so it is
> +   important that these two operations are closely paired.
> +
> +   Note:
> +	Although the async_tx API specifies that completion callback
> +	routines cannot submit any new operations, this is not the
> +	case for slave/cyclic DMA.
> +
> +	For slave DMA, the subsequent transaction may not be available
> +	for submission prior to callback function being invoked, so
> +	slave DMA callbacks are permitted to prepare and submit a new
> +	transaction.
> +
> +	For cyclic DMA, a callback function may wish to terminate the
> +	DMA via dmaengine_terminate_all().
> +
> +	Therefore, it is important that DMA engine drivers drop any
> +	locks before calling the callback function which may cause a
> +	deadlock.
> +
> +	Note that callbacks will always be invoked from the DMA
> +	engines tasklet, never from interrupt context.
> +
> +4. Submit the transaction
> +
> +   Once the descriptor has been prepared and the callback information
> +   added, it must be placed on the DMA engine drivers pending queue.
> +
> +   Interface:
> +	dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
> +
> +   This returns a cookie can be used to check the progress of DMA engine
> +   activity via other DMA engine calls not covered in this document.
> +
> +   dmaengine_submit() will not start the DMA operation, it merely adds
> +   it to the pending queue.  For this, see step 5, dma_async_issue_pending.
> +
> +5. Issue pending DMA requests and wait for callback notification
> +
> +   The transactions in the pending queue can be activated by calling the
> +   issue_pending API. If channel is idle then the first transaction in
> +   queue is started and subsequent ones queued up.
> +
> +   On completion of each DMA operation, the next in queue is started and
> +   a tasklet triggered. The tasklet will then call the client driver
> +   completion callback routine for notification, if set.
> +
> +   Interface:
> +	void dma_async_issue_pending(struct dma_chan *chan);
> +
> +Further APIs:
> +
> +1. int dmaengine_terminate_all(struct dma_chan *chan)
> +
> +   This causes all activity for the DMA channel to be stopped, and may
> +   discard data in the DMA FIFO which hasn't been fully transferred.
> +   No callback functions will be called for any incomplete transfers.
> +
> +2. int dmaengine_pause(struct dma_chan *chan)
> +
> +   This pauses activity on the DMA channel without data loss.
> +
> +3. int dmaengine_resume(struct dma_chan *chan)
> +
> +   Resume a previously paused DMA channel.  It is invalid to resume a
> +   channel which is not currently paused.
> +
> +4. enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
> +        dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
> +
> +   This can be used to check the status of the channel.  Please see
> +   the documentation in include/linux/dmaengine.h for a more complete
> +   description of this API.
> +
> +   This can be used in conjunction with dma_async_is_complete() and
> +   the cookie returned from 'descriptor->submit()' to check for
> +   completion of a specific DMA transaction.
> +
> +   Note:
> +	Not all DMA engine drivers can return reliable information for
> +	a running DMA channel.  It is recommended that DMA engine users
> +	pause or stop (via dmaengine_terminate_all) the channel before
> +	using this API.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
~Vinod Koul
Intel Corp.
