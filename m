From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Feb 2011 14:22:39 +0100
Subject: [PATCH v2 1/3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110218084513.GB18085@S2100-06.ap.freescale.net>
References: <1297650228-12762-1-git-send-email-shawn.guo@freescale.com>
	<201102171538.31061.arnd@arndb.de>
	<20110218084513.GB18085@S2100-06.ap.freescale.net>
Message-ID: <201102181422.39266.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 February 2011, Shawn Guo wrote:
> > > +static dma_cookie_t mxs_dma_assign_cookie(struct mxs_dma_chan *mxs_chan)
> > > +{
> > > +   dma_cookie_t cookie = mxs_chan->chan.cookie;
> > > +
> > > +   if (++cookie < 0)
> > > +           cookie = 1;
> > > +
> > > +   mxs_chan->chan.cookie = cookie;
> > > +   mxs_chan->desc.cookie = cookie;
> > > +
> > > +   return cookie;
> > > +}
> > > +
> > > +static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
> > > +{
> > > +   return container_of(chan, struct mxs_dma_chan, chan);
> > > +}
> > > +
> > > +static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> > > +{
> > > +   struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
> > > +   dma_cookie_t cookie;
> > > +   unsigned long flags;
> > > +
> > > +   spin_lock_irqsave(&mxs_chan->lock, flags);
> > > +
> > > +   cookie = mxs_dma_assign_cookie(mxs_chan);
> > > +
> > > +   mxs_dma_enable_chan(mxs_chan);
> > > +
> > > +   spin_unlock_irqrestore(&mxs_chan->lock, flags);
> > > +
> > > +   return cookie;
> > > +}
> > 
> > Just like the MMC driver, you use spin_lock_irqsave() in the functions that
> > are called by other drivers, but then don't actually lock in the interrupt
> > handler. This is clearly wrong, as I explained before:
> > 
> > The interrupt handler may already be running on another CPU, so it
> > is not at all serialized with this code.
> > 
> I may be wrong on this point, but spin_lock_irqsave/irqrestore pair
> is only for the protection you described?  I learnt that the pair
> should be used to protect the critical region, where I'm not sure
> if it's called from interrupt context.  Here I'm intending to protect
> the dma registers accessed in mxs_dma_enable_chan.

To generalize this further, a lock should protect specific data,
not portions of the code, and ideally you should document
exactly what you protect near the definition of the lock.

If you use the lock to protect all the DMA registers, you should use
it consistently, including inside of the interrupt handler, where
you access some other registers.

If you can prove that the registers used in the IRQ handler are
totally independent of the other ones, you don't need to use the
lock there, but then I'd advise documenting your assumptions.

> Thanks for teaching.  I intend to take the fix that Russell offered.
> (Thanks, Russell).  Does that look good to you, or spin_lock_bh
> version should be used than spin_lock_irqsave?

Russell's change looks correct to me.

Regarding the choice between spin_lock_bh and spin_lock_irqsave,
I always prefer to use the one that expresses best to the reader
what the intention is. spin_lock_irqsave() is stronger than
spin_lock_bh(), and can always be used in its place.

A short form of the strict rules (there are better documentations
out there) is:

* If all users are outside of interrupt or tasklet context,
  use a bare spin_lock().

* If one user is in a tasklet context, use spin_lock() inside
  the tasklet, but spin_lock_bh() outside, to prevent the
  tasklet from interrupting the critical section. Code that
  can be called in either tasklet or regular context needs
  to use spin_lock_bh() as well.

* If one user is in interrupt context, use spin_lock() inside
  of the interrupt handler, but spin_lock_irq() in tasklet
  and normal context (not spin_lock_irqsave()), to prevent
  the interrupt from happening during the critical section.

* Use spin_lock_irqsave() only for functions that can be called
  in either interrupt or non-interrupt context. Most drivers
  don't need this at all.

The simplified rule would be to always use spin_lock_irqsave(),
because that does not require you to understand what you are doing.

My position is that it is better to use the stricter rules, because
that documents that you actually do understand what you are doing ;-)
It's also slightly more efficient, because it avoids having to
save the interrupt status in a variable.

	Arnd
