From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Oct 2013 12:45:33 +0200 (CEST)
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <20131006052029.GE2954@intel.com>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
Message-ID: <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Oct 2013, Vinod Koul wrote:

> Pls keep Dan cced!

Sure, sorry.

> On Sun, Oct 06, 2013 at 12:31:37AM +0100, Russell King - ARM Linux wrote:
> > On Sat, Oct 05, 2013 at 11:00:45PM +0200, Guennadi Liakhovetski wrote:
> > > On Sat, 5 Oct 2013, Russell King - ARM Linux wrote:
> > > 
> > > > On Sat, Oct 05, 2013 at 07:36:20PM +0200, Guennadi Liakhovetski wrote:
> > > > > +	A DMA transaction descriptor, returned to the user by one of "prep"
> > > > > +	methods is considered as belogning to the user until it is submitted
> > > > > +	to the dmaengine driver for transfer. However, it is recommended, that
> > > > > +	the dmaengine driver keeps references to prepared descriptors too,
> > > > > +	because if dmaengine_terminate_all() is called at that time, the driver
> > > > > +	will have to recycle all allocated descriptors for the respective
> > > > > +	channel.
> > > > 
> > > > No.  That's quite dangerous.  think about what can happen.
> > > > 
> > > > Thread 1		Thread 2
> > > > Driver calls prepare
> > > > 			dmaengine_terminate_all()
> > > > 				dmaengine driver frees prepared descriptor
> > > > driver submits descriptor
> > > > 
> > > > You now have a descriptor which has been freed submitted to the DMA engine
> > > > queue.  This will cause chaos.
> > > 
> > > Yes, I understand this. So, it is intentional, that after a *_prep_* a 
> > > descriptor belongs to the user and - if the user fails - it will simply be 
> > > leaked. A terminate-all shouldn't recycle them and dmaengine driver 
> > > unbinding is impossible at that time, as long as the user hasn't released 
> > > the channel. Ok, I can rework the above just to explain this.
> > 
> > "the user fails" should be very difficult.  One of the requirements here
> > is that any "user" submits the prepared descriptor as soon as possible
> > after preparation.  Some DMA engine implementations hold a spinlock
> > between preparation and submission so this is absolutely necessary.
> > 
> > As Dan Williams explained to me, the reason for the separate submission
> > step is there to allow the callback information to be set.  So literally
> > any "user" of this should do this:
> > 
> > 	desc = prepare();
> > 	if (!desc)
> > 		goto failed_to_prepare;
> > 
> > 	desc->callback = function;
> > 	desc->callback_param = param;
> > 	dmaengine_submit(desc);
> > 
> > There should be very little possiblity of the user failing between those
> > two calls.
> > 
> > > > > -   On completion of each DMA operation, the next in queue is started and
> > > > > -   a tasklet triggered. The tasklet will then call the client driver
> >           ^^^^^^^^^^^^^^^^^^^^
> > > > > -   completion callback routine for notification, if set.
> > > > > +   On completion of each DMA operation, the next active transaction in queue is
> > > > > +   started and the ISR bottom half, e.g. a tasklet or a kernel thread is
> > > > > +   triggered.
> > > > 
> > > > Or a kernel thread?  I don't think that's right.  It's always been
> > > > specified that the callback will happen from tasklet context.
> > > 
> > > Do you see any problems using, say, a threaded interrupt handler, apart 
> > > from possible performance issues? That seems to be pretty convenient. 
> > > Otherwise we should really mandate somewhere, that bottom half processing 
> > > should take place in a tasklet?
> > 
> > The documentation has always stated that callbacks will be made from
> > tasklet context.  The problem with allowing different contexts from
> > different drivers is taht spinlocking becomes problematical.  Remember
> > that we have _bh() variants which lock against tasklets but allow IRQs.

Vinod, Dan, what do you think about the bottom half interrupt processing? 
Do we want to make the use of a tasklet compulsory or can we also allow 
other contexts?

> > > > > +   The dmaengine driver also has to check the DMA_CTRL_ACK flag by calling
> > > > > +   async_tx_test_ack() on the transaction. If the function returns true, i.e.
> > > > > +   if the transaction either has been flagged from the very beginning, or
> > > > > +   the user has flagged it later, then the transaction descriptor can be
> > > > > +   recycled immediately by the dmaengine driver.
> > > > 
> > > > "has to check" I think is wrong.  This is optional for slave only drivers,
> > > > because most slave stuff doesn't use the ACK stuff - that's more for the
> > > > async_tx APIs.
> > > 
> > > "most," but some do? E.g. the mx3_camera driver. Ok, that one is very 
> > > tightly bound to the respective dmaengine driver. But if there are other 
> > > slave drivers, using that, that can run on different platforms and use 
> > > various dmaengine drivers?
> > 
> > I'm not aware of any which actually make use of the ack stuff.  Only those
> > which implement the async_tx must implement this because it gets used for
> > chaining and dependency stuff.  However, there was a plan to remove this
> > and replace it with proper refcounting.
> > 
> > > > > If the function returns
> > > > > +   false, the descriptor cannot be recycled yet and the dmaengine driver has
> > > > > +   to keep polling the descriptor until it is acknowledged by the user.
> > > > >  
> > > > >     Interface:
> > > > >  	void dma_async_issue_pending(struct dma_chan *chan);
> > > > > @@ -171,6 +192,14 @@ Further APIs:
> > > > >     discard data in the DMA FIFO which hasn't been fully transferred.
> > > > >     No callback functions will be called for any incomplete transfers.
> > > > >  
> > > > > +   Note:
> > > > > +	Transactions, aborted by this call are considered as failed. However,
> > > > > +	if the user requests their status, using dma_async_is_complete() /
> > > > > +	dma_async_is_complete(), as described below, one of DMA_IN_PROGRESS and
> > > > > +	DMA_SUCCESS will be returned. So, drivers are advised not to use those
> > > > > +	calls on transactions, submitted before a call to
> > > > > +	dmaengine_terminate_all().
> > > > 
> > > > The last sentence doesn't make sense.
> > > 
> > > Right, sorry, there is a typo in the second line (to remind: this note is 
> > > for the dmaengine_terminate_all() function):
> > > 
> > > +   Note:
> > > +	Transactions, aborted by this call are considered as failed. However,
> > > +	if the user requests their status, using dma_async_is_tx_complete() /
> > > +	dma_async_is_complete(), as described below, one of DMA_IN_PROGRESS and
> > > +	DMA_SUCCESS will be returned. So, drivers are advised not to use those
> > > +	calls on transactions, submitted before a call to
> > > +	dmaengine_terminate_all().
> If you submit a bunch of descriptors then I see no reason when something in
> middle failed, the status for first descriptor which succedded is returned as an
> error even if user aborted the channel. The status query happens for a cookie
> which represents a descriptor. It doesnt return channel status.

No, not something in the middle. I was thinking about

(1) cookie 1-3 are submitted
(2) cookie 1 succeeds
(3) a DMA error occurs, cookies 2-3 are discarded
(4) cookie 4 is submitted and succeeds
(5) the user requests status of cookie 2 and gets success back, AFAICS

> > > What I was trying to say, is that if you submit transactions, then 
> > > terminate them, then try to retrieve their status using 
> > > dma_async_is_tx_complete() / dma_async_is_complete(), this won't produce 
> > > the expected DMA_ERROR result, instead, one of DMA_IN_PROGRESS and 
> > > DMA_SUCCESS will be returned, unless the driver implements some 
> > > sophisticated .device_tx_status() method.
> Well the moment you aborted the channel all the previously submitted descriptors
> can be freed by the driver. So you cant do anything with these. In the client
> driver care should be taken to drop all the references of descriptors and then
> terminate the channel.
> 
> > Remember that dmaengine_terminate_all() is targetted to a specific
> > channel - it terminates all submitted transactions on that channel
> > and stops any in-process transaction.  It doesn't affect any other
> > channel on the controller.
> > 
> > In the case of slave DMA users, you have to "own" the channel.  This
> > means it's up to the user to sort out what happens should _they_ call
> > dmaengine_terminate_all() on it.
> > 
> > For non-slave DMA users, I don't believe that terminating transactions
> > is permitted - they're expected to complete.
> 
> -- 
> ~Vinod

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
