From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 4 Jun 2015 17:09:46 +0200
Subject: [PATCH 1/2] dmaengine: at_xdmac: lock fixes
In-Reply-To: <20150604141938.GO3140@localhost>
References: <1433343154-5613-1-git-send-email-ludovic.desroches@atmel.com>
 <20150604141938.GO3140@localhost>
Message-ID: <20150604150946.GA17733@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 07:49:38PM +0530, Vinod Koul wrote:
> On Wed, Jun 03, 2015 at 04:52:26PM +0200, Ludovic Desroches wrote:
> > Using _bh variant for spin locks causes this kind of warning:
> > Starting logging: ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3 at /ssd_drive/linux/kernel/softirq.c:151
> > __local_bh_enable_ip+0xe8/0xf4()
> > Modules linked in:
> > CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.1.0-rc2+ #94
> > Hardware name: Atmel SAMA5
> > [<c0013c04>] (unwind_backtrace) from [<c00118a4>] (show_stack+0x10/0x14)
> > [<c00118a4>] (show_stack) from [<c001bbcc>]
> > (warn_slowpath_common+0x80/0xac)
> > [<c001bbcc>] (warn_slowpath_common) from [<c001bc14>]
> > (warn_slowpath_null+0x1c/0x24)
> > [<c001bc14>] (warn_slowpath_null) from [<c001e28c>]
> > (__local_bh_enable_ip+0xe8/0xf4)
> > [<c001e28c>] (__local_bh_enable_ip) from [<c01fdbd0>]
> > (at_xdmac_device_terminate_all+0xf4/0x100)
> > [<c01fdbd0>] (at_xdmac_device_terminate_all) from [<c02221a4>]
> > (atmel_complete_tx_dma+0x34/0xf4)
> > [<c02221a4>] (atmel_complete_tx_dma) from [<c01fe4ac>]
> > (at_xdmac_tasklet+0x14c/0x1ac)
> > [<c01fe4ac>] (at_xdmac_tasklet) from [<c001de58>]
> > (tasklet_action+0x68/0xb4)
> > [<c001de58>] (tasklet_action) from [<c001dfdc>]
> > (__do_softirq+0xfc/0x238)
> > [<c001dfdc>] (__do_softirq) from [<c001e140>] (run_ksoftirqd+0x28/0x34)
> > [<c001e140>] (run_ksoftirqd) from [<c0033a3c>]
> > (smpboot_thread_fn+0x138/0x18c)
> > [<c0033a3c>] (smpboot_thread_fn) from [<c0030e7c>] (kthread+0xdc/0xf0)
> > [<c0030e7c>] (kthread) from [<c000f480>] (ret_from_fork+0x14/0x34)
> > ---[ end trace b57b14a99c1d8812 ]---
> > 
> > It comes from the fact that devices can called some code from the DMA
> > controller with irq disabled. _bh variant is not intended to be used in
> > this case since it can enable irqs. Switch to irqsave/irqrestore variant to
> > avoid this situation.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Cc: stable at vger.kernel.org # 4.0 and later
> > ---
> >  drivers/dma/at_xdmac.c | 85 ++++++++++++++++++++++++++++----------------------
> >  1 file changed, 48 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > index 9b602a6..4a7e9c6 100644
> > --- a/drivers/dma/at_xdmac.c
> > +++ b/drivers/dma/at_xdmac.c
> > @@ -421,8 +421,9 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
> >  	struct at_xdmac_desc	*desc = txd_to_at_desc(tx);
> >  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(tx->chan);
> >  	dma_cookie_t		cookie;
> > +	unsigned long		irqflags;
> >  
> > -	spin_lock_bh(&atchan->lock);
> > +	spin_lock_irqsave(&atchan->lock, irqflags);
> >  	cookie = dma_cookie_assign(tx);
> >  
> >  	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
> > @@ -431,7 +432,7 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
> >  	if (list_is_singular(&atchan->xfers_list))
> >  		at_xdmac_start_xfer(atchan, desc);
> >  
> > -	spin_unlock_bh(&atchan->lock);
> > +	spin_unlock_irqrestore(&atchan->lock, irqflags);
> >  	return cookie;
> >  }
> >  
> > @@ -591,11 +592,13 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> >  		       unsigned int sg_len, enum dma_transfer_direction direction,
> >  		       unsigned long flags, void *context)
> >  {
> > -	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
> > -	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > -	struct scatterlist	*sg;
> > -	int			i;
> > -	unsigned int		xfer_size = 0;
> > +	struct at_xdmac_chan		*atchan = to_at_xdmac_chan(chan);
> > +	struct at_xdmac_desc		*first = NULL, *prev = NULL;
> > +	struct scatterlist		*sg;
> > +	int				i;
> > +	unsigned int			xfer_size = 0;
> > +	unsigned long			irqflags;
> > +	struct dma_async_tx_descriptor	*ret = NULL;
> This doesnt comply with stable rules, and you should not keep this in fixes
> either :(
> 
>   - It cannot contain any "trivial" fixes in it (spelling changes,
>     whitespace cleanups, etc).

Ok I understand, so what is the way to manage this case? I did
"whitespace cleanup" because of
+   struct dma_async_tx_descriptor  *ret = NULL;
which breaks previous indentation, so in my mind it was not cleanup.

Do I need to send you a patch to correct identation due to this fix or to send
a specific patch for stable without identation change?

Thanks

Ludovic
