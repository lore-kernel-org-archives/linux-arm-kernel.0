From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 08 Mar 2016 15:50:41 +0000
Subject: [PATCH] dmaengine: pl330: Fix some race conditions in residue
 calculation
In-Reply-To: <20160308141551.GP11154@localhost>
References: <1456319674.2867.15.camel@linaro.org>
 <20160308041238.GL11154@localhost> <1457433611.2818.83.camel@linaro.org>
 <20160308141551.GP11154@localhost>
Message-ID: <1457452241.2818.128.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-08 at 19:45 +0530, Vinod Koul wrote:
> On Tue, Mar 08, 2016 at 10:40:11AM +0000, Jon Medhurst (Tixy) wrote:
> > On Tue, 2016-03-08 at 09:42 +0530, Vinod Koul wrote:
> > > On Wed, Feb 24, 2016 at 01:14:34PM +0000, Jon Medhurst (Tixy) wrote:
> > > > The residue calculation in pl330_tx_status doesn't handle transitional
> > > > states that occur at the time one descriptor (A) is completed and the
> > > > next (B) is started. Specifically, both A and B can simultaneously be in
> > > > the BUSY state and at this time the thread's 'req_running' may (or may
> > > > not) be -1.
> > > 
> > > you are under lock so descriptor state wont be update while we are it.
> > > 
> > > Also the query for residue is for "a descriptor" not whatever is the current
> > > running descriptor...
> > > 
> > > > 
> > > > To cope with this situation we change the code to ensure A is treated as
> > > > complete and B as having not yet started. Prior to the change, the code
> > > > would calculate a transferred byte count as if both A and B had
> > > > completed.
> > > 
> > > You query for either A or B not both!
> > 
> > I've probably been using wrong/ambiguous terminology...
> > 
> > In my description I'm using 'descriptor' to refer to a 'struct
> > dma_pl330_desc', I guess other people assume 'struct
> > dma_async_tx_descriptor'?
> 
> Nope
> 
> > The situation I was debugging was audio playback, where ASoC ends up
> > calling pl330_prep_dma_cyclic() with a period one quarter the length of
> > the buffer it is using, so that results in four dma_pl330_desc
> > 'descriptors' being created to cover that buffer. These later get
> > submitted to a DMA channel (struct dma_pl330_chan) which has a list of
> > these that it is processing (the 'work_list').
> > 
> > The residual calculation that currently exists in pl08x_dma_tx_status()
> > is iterating this work_list and summing the length of currently
> > transferring 'descriptor' with those later pending ones. I believe that
> > is correct behaviour because these 'descriptors' (dma_pl330_desc) are
> > all internal implementation details of the driver, and the dmaengine
> > API's are dealing in units of 'dma_async_tx_descriptor' ?
> 
> Not really. If you look closely dma_pl330_desc contains
> dma_async_tx_descriptor. A descriptor represents a tranasaction and is
> certainly not internal detail of your driver

I think that for this driver it's kinda both, which is why it's
confusing...

pl330_prep_dma_cyclic(), after creating a number of dma_pl330_desc
objects in a circular list, returns the address of the
dma_async_tx_descriptor contained in the last one. I'm guessing that as
far as users of the dmaengine API is concerned, this is treated as just
a single descriptor. pl330_prep_slave_sg() creates a similar circular
list.

When these descriptors are later submitted to the driver for transfer,
it is done by a call to pl330_tx_submit, which I has this comment...

/*
 * We returned the last one of the circular list of descriptor(s)
 * from prep_xxx, so the argument to submit corresponds to the last
 * descriptor of the list.
 */

This goes on to add all the linked descriptors to the pending queue for
sending to the DMA hardware, and then returns the cookie of the last
descriptor, maintaining the fiction to the dmaengine API's that there is
just a single descriptor.

> 
> The reside is requested for "a descriptor". For example if you have prepared
> two descriptors A and B and submitted them, then you can request status and
> reside for A and you need to calculate that for A only and not take into
> account status of B

But, in the case of the pl330 driver, A and B may each consist of
multiple internal/hidden descriptors. So the residue calculation has to
sum up the residue of all these internal/hidden descriptors as well.
This is what the current pl330_tx_status() function does, but has bugs.

I've only just managed to clearly understand all the above details
whilst writing this email, and this confusion obviously means the code
and any commit messages need to explain things better.

-- Tixy

> 
> > 
> > If the current code is OK in this regard, it is definitely buggy because
> > it doesn't cope with the situation when two dma_pl330_desc's are in the
> > state 'BUSY' a, which I have seen occur when debugging this issue, had
> > worked out can happen by analysing the code, and is acknowledged by the
> > in-source comments for enum desc_status...
> > 
> > 	/*
> > 	 * Sitting on the work_list and already submitted
> > 	 * to the PL330 core. Not more than two descriptors
> > 	 * of a channel can be BUSY at any time.
> > 	 */
> > 	BUSY,
> > 
> > In my problematic usecase I have userside code calling ALSA ioctls to
> > poll the current audio playback position which results in
> > pl08x_dma_tx_status() being called multiple times a second. After only a
> > second or two the buggy situation gets hit, resulting in a
> > miscalculation that ASoC interprets as a buffer underflow and so it
> > stops the stream.
> > 
> > I spent several days debugging this, with enough ad hoc tests and
> > printk's littered everywhere to be very confident as to how things are
> > going wrong - what I'm not not totally confident of is how things should
> > be properly fixed.
> 
> There maybe a problem but this patch and the fix dont explain that
> 
> > 
> > This patch appears to fix the situation that I was hitting, but it
> > really looks like there isn't any locking that prevent this polling use
> > of pl08x_dma_tx_status() from happening concurrently with the irq
> > handler reprogramming the hardware for the next dma_pl330_desc. I didn't
> > attempt any fix for that for fear of introducing bugs in what looks like
> > complex code, and because it's not a problem I saw happen in practice.
> > 
> > -- Tixy
> > 
> > > 
> > > > 
> > > > Fixes: aee4d1fac887 ("dmaengine: pl330: improve pl330_tx_status() function")
> > > > 
> > > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > > > ---
> > > > 
> > > > I discovered this issue when trying to work out why audio stopped
> > > > working on ARM's Juno platform and bisected it to commit aee4d1fac887.
> > > > Whilst this patch seems to fix the problems I was seeing, I can't help
> > > > but think there are more race conditions with this code. E.g. if the
> > > > running descriptor changes under us, pl330_get_current_xferred_count
> > > > can end up reading values from hardware that relate to a different
> > > > descriptor. And if we're really unlucky, the reading of the 'val' and
> > > > 'addr' values in pl330_get_current_xferred_count can come from different
> > > > descriptors. I don't know if there is any locks we can use to prevent
> > > > such races or if we need to try and detect when things have changed and
> > > > redo/abort the residue calculation...
> > > > 
> > > >  drivers/dma/pl330.c | 24 ++++++++++++++++++++----
> > > >  1 file changed, 20 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > > > index 17ee758..55e3c5f 100644
> > > > --- a/drivers/dma/pl330.c
> > > > +++ b/drivers/dma/pl330.c
> > > > @@ -2240,6 +2240,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > > >  	struct dma_pl330_desc *desc, *running = NULL;
> > > >  	struct dma_pl330_chan *pch = to_pchan(chan);
> > > >  	unsigned int transferred, residual = 0;
> > > > +	bool first_busy;
> > > >  
> > > >  	ret = dma_cookie_status(chan, cookie, txstate);
> > > >  
> > > > @@ -2253,16 +2254,31 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > > >  
> > > >  	if (pch->thread->req_running != -1)
> > > >  		running = pch->thread->req[pch->thread->req_running].desc;
> > > > +	first_busy = true;
> > > >  
> > > >  	/* Check in pending list */
> > > >  	list_for_each_entry(desc, &pch->work_list, node) {
> > > >  		if (desc->status == DONE)
> > > >  			transferred = desc->bytes_requested;
> > > > -		else if (running && desc == running)
> > > > -			transferred =
> > > > -				pl330_get_current_xferred_count(pch, desc);
> > > > -		else
> > > > +		else if (desc->status == BUSY && first_busy) {
> > > > +			first_busy = false;
> > > > +			if (running && desc == running) {
> > > > +				transferred =
> > > > +					pl330_get_current_xferred_count(pch, desc);
> > > > +			} else {
> > > > +				/* BUSY but not running means it's just completed */
> > > > +				transferred = desc->bytes_requested;
> > > > +			}
> > > > +		} else {
> > > > +			/*
> > > > +			 * Descriptor is either in PREP state queued for future
> > > > +			 * transfer or it is the second BUSY descriptor we have
> > > > +			 * seen. The latter case means it has just, or is about
> > > > +			 * to be, started, so treat it as having not yet
> > > > +			 * transferred any bytes, the same as PREP.
> > > > +			 */
> > > >  			transferred = 0;
> > > > +		}
> > > >  		residual += desc->bytes_requested - transferred;
> > > >  		if (desc->txd.cookie == cookie) {
> > > >  			switch (desc->status) {
> > > > -- 
> > > > 2.1.4
> > > > 
> > > > 
> > > 
> > 
> > 
> 
