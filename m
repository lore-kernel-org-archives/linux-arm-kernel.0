From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 24 Sep 2014 10:07:55 +0530
Subject: [PATCH 1/2] dmaengine: Add QCOM ADM DMA driver
In-Reply-To: <20140923221002.GC5975@qualcomm.com>
References: <1410401933-20621-1-git-send-email-agross@codeaurora.org>
 <1410401933-20621-2-git-send-email-agross@codeaurora.org>
 <20140923102850.GI24663@intel.com>
 <20140923221002.GC5975@qualcomm.com>
Message-ID: <20140924043755.GQ24663@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 05:10:02PM -0500, Andy Gross wrote:
> <snip>
> 
> > > +			break;
> > > +		default:
> > > +			achan->slave.src_maxburst = 0;
> > > +			achan->slave.dst_maxburst = 0;
> > Why clear these for error cases
> 
> With the return I shouldn't need to.  I'll fix this.
> 
> > > +			ret = -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		if (!ret)
> > > +			writel(achan->blk_size,
> > > +				adev->regs + HI_CRCI_CTL(achan->id, adev->ee));
> > and why do we write to HW on this. Shouldn't this be done when you program
> > the descriptor?
> 
> It could be deferred to later.  The main point is that I don't see the
> slave_config happening every transaction.  I was only modifying it now instead
> of making a register write for every transaction.
Well wouldn't it cause a problem if you write to hardware and a transaction
is already in progress.
So it makese sense to write every time at transaction start with latest
value programmed.

> > 
> > > +static enum dma_status adm_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > > +	struct dma_tx_state *txstate)
> > > +{
> > > +	struct adm_chan *achan = to_adm_chan(chan);
> > > +	struct virt_dma_desc *vd;
> > > +	enum dma_status ret;
> > > +	unsigned long flags;
> > > +	size_t residue = 0;
> > > +
> > > +	ret = dma_cookie_status(chan, cookie, txstate);
> > > +
> > Last arg can be null to this, so before you do residue calcluation and block
> > interrupts would make sense to return from here if arg is NULL
> 
> Good catch.  Will fix.
> 
> > 
> > > +	spin_lock_irqsave(&achan->vc.lock, flags);
> > > +
> > > +	vd = vchan_find_desc(&achan->vc, cookie);
> > > +	if (vd)
> > > +		residue = container_of(vd, struct adm_async_desc, vd)->length;
> > > +	else if (achan->curr_txd && achan->curr_txd->vd.tx.cookie == cookie)
> > > +		residue = achan->curr_txd->length;
> > so this is current cookie, so you need to read from HW on current position
> 
> There is no way to get current position unfortunately without relying on
> unreliable debug registers.
In that case would it make sense to return complete txn length?

-- 
~Vinod
