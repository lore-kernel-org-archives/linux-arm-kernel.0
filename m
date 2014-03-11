From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Tue, 11 Mar 2014 10:22:52 +0000
Subject: [PATCH v4 6/7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <20140311100838.GQ2815@lukather>
References: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394462512-11620-7-git-send-email-maxime.ripard@free-electrons.com>
 <1394531574.28803.222.camel@smile.fi.intel.com>
 <20140311100838.GQ2815@lukather>
Message-ID: <1394533371.28803.226.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-11 at 11:08 +0100, Maxime Ripard wrote:

[]

> > > +	spin_lock_irq(&sdev->lock);
> > > +	for (pchan_idx = 0; pchan_idx < NR_MAX_CHANNELS; pchan_idx++) {
> > > +		pchan = &sdev->pchans[pchan_idx];
> > > +
> > > +		if (pchan->vchan == NULL && !list_empty(&sdev->pending)) {
> > 
> > !pchan->vchan && ...
> 
> Ok.
> 
> > And you may decrease indentation level here if you use negative
> > condition.
> 
> Hmmm, I'm not following you here. What do you mean?

for () {
...
if (!(your current condition))
 continue;
... (do something else with decreased indentation level)
}

> > > +			vchan = list_first_entry(&sdev->pending,
> > > +						 struct sun6i_vchan, node);
> > > +
> > > +			/* Remove from pending channels */
> > > +			list_del_init(&vchan->node);
> > > +			pchan_alloc |= BIT(pchan_idx);
> > > +
> > > +			/* Mark this channel allocated */
> > > +			pchan->vchan = vchan;
> > > +			vchan->phy = pchan;
> > > +			dev_dbg(sdev->slave.dev, "pchan %u: alloc vchan %p\n",
> > > +				pchan->idx, &vchan->vc);
> > > +		}
> > > +	}
> > > +	spin_unlock_irq(&sdev->lock);
> > > +
> > > +	for (pchan_idx = 0; pchan_idx < NR_MAX_CHANNELS; pchan_idx++) {
> > > +		if (pchan_alloc & BIT(pchan_idx)) {
> > 
> > Ditto.

Same here.

[]

> > > +#ifdef DEBUG
> > > +	dev_dbg(chan2dev(chan), "First: %pad\n", &txd->p_lli);
> > 
> > dev_dbg is aware of DEBUG. So, please, remove that #ifdef at all.
> 
> Yep, but the line just below isn't.
> 
> The ifdef here is not really to prevent the call to dev_dbg, but rather...
> 
> > > +	for (prev = txd->v_lli; prev != NULL; prev = prev->v_lli_next)
> 
> ... this.

It doesn't matter since implementation of sun6i_dma_dump_lli is (and
actually should be) aware of DEBUG already, because it's dev_dbg based.

> > 
> > You may remove '!= NULL' part.
> 
> Ok.
> 
> > > +		sun6i_dma_dump_lli(vchan, prev);
> > > +#endif




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
