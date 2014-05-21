From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 May 2014 10:58:29 +0200
Subject: [PATCH v7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <20140521053105.GI21128@intel.com>
References: <20140430070408.GR32284@intel.com>
 <20140513134258.GA29258@lukather>
 <20140521053105.GI21128@intel.com>
Message-ID: <20140521085829.GP27329@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 11:01:05AM +0530, Vinod Koul wrote:
> On Tue, May 13, 2014 at 03:42:58PM +0200, Maxime Ripard wrote:
> > Hi Vinod,
> > 
> > On Wed, Apr 30, 2014 at 12:34:08PM +0530, Vinod Koul wrote:
> > > > +
> > > > +static int sun6i_dma_terminate_all(struct sun6i_vchan *vchan)
> > > > +{
> > > > +	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(vchan->vc.chan.device);
> > > > +	struct sun6i_pchan *pchan = vchan->phy;
> > > > +	unsigned long flags;
> > > > +	LIST_HEAD(head);
> > > > +
> > > > +	spin_lock(&sdev->lock);
> > > > +	list_del_init(&vchan->node);
> > > > +	spin_unlock(&sdev->lock);
> > > > +
> > > > +	spin_lock_irqsave(&vchan->vc.lock, flags);
> > > > +
> > > > +	vchan_get_all_descriptors(&vchan->vc, &head);
> > > > +
> > > > +	if (pchan) {
> > > > +		writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
> > > > +		writel(DMA_CHAN_PAUSE_RESUME, pchan->base + DMA_CHAN_PAUSE);
> > > > +
> > > > +		vchan->phy = NULL;
> > > > +		pchan->vchan = NULL;
> > > > +		pchan->desc = NULL;
> > > > +		pchan->done = NULL;
> > > > +	}
> > > > +
> > > > +	spin_unlock_irqrestore(&vchan->vc.lock, flags);
> > > > +
> > > > +	vchan_dma_desc_free_list(&vchan->vc, &head);
> > > 
> > > shouldn't you kill the tasklet as well here?
> > 
> > Just to be clear, which tasklet? vchan's or the driver's?
> You need to take care of both. But I suspect if we ensure irq is not triggered
> and any pending ones are completed you can simply kill both of the tasklets
> happily. See the fixes merged in dmaengine last cycle (hint: patchlog shows what
> we need to do)

I still don't get why I should kill the driver tasklet in terminate_all.

The tasklet is common to all the channels, if you kill it, you'll
prevent it from scheduling while other channels might have had a need
for it to actually run.

About the commits themselves, I guess you talk about 9068b032 and
ccc7aad0. Both these commits only fix the remove path, not the
terminate_all one, and both these drivers are not doing anything
related to the tasklet in terminate_all.

> Btw just noticed, you *should* use dmaengine: as the subsytem name on the patch
> series...

Ok, I will.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/e1823552/attachment.sig>
