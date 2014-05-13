From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 May 2014 15:42:58 +0200
Subject: [PATCH v7] DMA: sun6i: Add driver for the Allwinner A31 DMA
 controller
In-Reply-To: <20140430070408.GR32284@intel.com>
References: <20140430070408.GR32284@intel.com>
Message-ID: <20140513134258.GA29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, Apr 30, 2014 at 12:34:08PM +0530, Vinod Koul wrote:
> > +
> > +static int sun6i_dma_terminate_all(struct sun6i_vchan *vchan)
> > +{
> > +	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(vchan->vc.chan.device);
> > +	struct sun6i_pchan *pchan = vchan->phy;
> > +	unsigned long flags;
> > +	LIST_HEAD(head);
> > +
> > +	spin_lock(&sdev->lock);
> > +	list_del_init(&vchan->node);
> > +	spin_unlock(&sdev->lock);
> > +
> > +	spin_lock_irqsave(&vchan->vc.lock, flags);
> > +
> > +	vchan_get_all_descriptors(&vchan->vc, &head);
> > +
> > +	if (pchan) {
> > +		writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
> > +		writel(DMA_CHAN_PAUSE_RESUME, pchan->base + DMA_CHAN_PAUSE);
> > +
> > +		vchan->phy = NULL;
> > +		pchan->vchan = NULL;
> > +		pchan->desc = NULL;
> > +		pchan->done = NULL;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&vchan->vc.lock, flags);
> > +
> > +	vchan_dma_desc_free_list(&vchan->vc, &head);
> 
> shouldn't you kill the tasklet as well here?

Just to be clear, which tasklet? vchan's or the driver's?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/95b4b1dc/attachment.sig>
