From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 24 Jul 2016 11:54:25 +0530
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
Message-ID: <20160724062425.GW9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 09:00:52PM -0400, Sinan Kaya wrote:
> Hi Vinod,
> 
> On 7/13/2016 10:57 PM, Sinan Kaya wrote:
> > There is a race condition between data transfer callback and descriptor
> > free code. The callback routine may decide to clear the resources even
> > though the descriptor has not yet been freed.
> > 
> > Instead of calling the callback first and then releasing the memory,
> > this code is changing the order to return the descriptor back to the
> > free pool and then call the user provided callback.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > ---
> >  drivers/dma/qcom/hidma.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> > index 41b5c6d..c41696e 100644
> > --- a/drivers/dma/qcom/hidma.c
> > +++ b/drivers/dma/qcom/hidma.c
> > @@ -111,6 +111,7 @@ static void hidma_process_completed(struct hidma_chan *mchan)
> >  	struct dma_async_tx_descriptor *desc;
> >  	dma_cookie_t last_cookie;
> >  	struct hidma_desc *mdesc;
> > +	struct hidma_desc *next;
> >  	unsigned long irqflags;
> >  	struct list_head list;
> >  
> > @@ -122,28 +123,31 @@ static void hidma_process_completed(struct hidma_chan *mchan)
> >  	spin_unlock_irqrestore(&mchan->lock, irqflags);
> >  
> >  	/* Execute callbacks and run dependencies */
> > -	list_for_each_entry(mdesc, &list, node) {
> > -		enum dma_status llstat;
> > +	list_for_each_entry_safe(mdesc, next, &list, node) {
> > +		dma_async_tx_callback callback;
> > +		void *param;
> >  
> >  		desc = &mdesc->desc;
> >  
> >  		spin_lock_irqsave(&mchan->lock, irqflags);
> > -		dma_cookie_complete(desc);
> > +		if (hidma_ll_status(mdma->lldev, mdesc->tre_ch)
> > +			== DMA_COMPLETE)
> > +			dma_cookie_complete(desc);
> 
> It looks like I introduced a behavioral change while refactoring the code.
> The previous one would call the callback only if the transfer was successful
> but it would always call dma_cookie_complete.
> 
> The new behavior is to call dma_cookie_complete only if the transfer is successful
> and it calls the callback even in the case of error cases. Then, the client has
> to query if transfer was successful.
> 
> Which one is the correct behavior?

Hi Sinan,

Cookie is always completed. That simply means trasactions was completed and
has no indication if the transaction was successfull or not.

Uptill now we had no way of reporting error, Dave's series adds that up, so
you can use it.

Callback is optional for users. Again we didnt convey success of
transaction, but a callback for reporting that trasaction was completed. So
invoking callback makes sense everytime.

HTH

-- 
~Vinod
