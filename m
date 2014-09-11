From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 11 Sep 2014 10:44:52 +0530
Subject: [PATCH v3 1/2] dma: at_xdmac: creation of the atmel eXtended
 DMA Controller driver
In-Reply-To: <20140910132353.GP4434@ldesroches-Latitude-E6320>
References: <1404825096-15724-1-git-send-email-ludovic.desroches@atmel.com>
 <1404825096-15724-2-git-send-email-ludovic.desroches@atmel.com>
 <20140725071631.GH8181@intel.com>
 <20140728155431.GV2349@ldesroches-Latitude-E6320>
 <20140728164750.GH8181@intel.com>
 <20140910132353.GP4434@ldesroches-Latitude-E6320>
Message-ID: <20140911051452.GC3131@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 03:23:53PM +0200, Ludovic Desroches wrote:
> Hi,
> 
> Sorry for the delay. I am about to send a new version but I have still
> have some questions.
> 
> On Mon, Jul 28, 2014 at 10:17:50PM +0530, Vinod Koul wrote:
> > On Mon, Jul 28, 2014 at 05:54:31PM +0200, Ludovic Desroches wrote:
> > > > > +{
> > > > > +	struct at_xdmac_desc	*desc = txd_to_at_desc(tx);
> > > > > +	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(tx->chan);
> > > > > +	dma_cookie_t		cookie;
> > > > > +	unsigned long		flags;
> > > > > +
> > > > > +	spin_lock_irqsave(&atchan->lock, flags);
> > > > > +	cookie = dma_cookie_assign(tx);
> > > > > +
> > > > > +	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
> > > > > +		 __func__, atchan, desc);
> > > > > +	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
> > > > > +	if (list_is_singular(&atchan->xfers_list))
> > > > > +		at_xdmac_start_xfer(atchan, desc);
> > > > so you dont start if list has more than 1 descriptors, why?
> > > Because I will let at_xdmac_advance_work managing the queue if not
> > > empty. So the only moment when I have to start the transfer in tx_submit
> > > is when I have only one transfer in the queue.
> > So xfers_list is current active descriptors right and if it is always going
> > to be singular why bother with a list?
> 
> xfers_list won't be always singular. I put all transfers into this list.
> If it is not singular, I don't have to start this transfer now.
Okay i think i got it now, you want to start only when its sigular and if
list is larger then at_xdmac_advance_work() would do so

> > > > > +static struct dma_async_tx_descriptor *
> > > > > +at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > > > > +			 size_t len, unsigned long flags)
> > > > > +{
> > > > > +	struct at_xdmac_chan 	*atchan = to_at_xdmac_chan(chan);
> > > > > +	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > > > > +	size_t			remaining_size = len, xfer_size = 0, ublen;
> > > > > +	dma_addr_t		src_addr = src, dst_addr = dest;
> > > > > +	u32			dwidth;
> > > > > +	/*
> > > > > +	 * WARNING: The channel configuration is set here since there is no
> > > > > +	 * dmaengine_slave_config call in this case. Moreover we don't know the
> > > > > +	 * direction, it involves we can't dynamically set the source and dest
> > > > > +	 * interface so we have to use the same one. Only interface 0 allows EBI
> > > > > +	 * access. Hopefully we can access DDR through both ports (at least on
> > > > > +	 * SAMA5D4x), so we can use the same interface for source and dest,
> > > > > +	 * that solves the fact we don't know the direction.
> > > > and why do you need slave config for memcpy?
> > > Maybe the comments is not clear. With slave config we have the direction
> > > per to mem or mem to per. Of course when doing memcpy we don't need this
> > > information. But I use this information not only to set the transfer
> > > direction but also to set the interfaces to use for the source and dest
> > > (these interfaces depend on the connection on the matrix).
> > > So slave config was useful due to direction field  to tell which interface
> > > to use as source and which one as dest.
> > > I am lucky because NAND and DDR are on the same interfaces so it's not a
> > > problem.
> > > 
> > > This comment is more a warning for myself to keep in mind this possible 
> > > issue in order to not have a device with NAND and DDR on different
> > > interfaces because it will be difficult to tell which interface is the
> > > source and which one is the dest.
> > Well in that case shouldnt NAND be treated like periphral and not memory?
> 
> Yes maybe it would be better but it is not needed at the moment.
> 
> [...]
> 
> > > > > +	 */
> > > > > +	list_del(&desc->xfer_node);
> > > > > +	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
> > > > shouldnt you move all the desc in active list in one shot ?
> > > > 
> > > 
> > > Sorry I don't get it. What are you suggesting by one shot?
> > Rather than invoking this per descriptor moving descriptors to
> > free_desc_list one by one, we can move all descriptors togther.
> 
> Per descriptor? list_splice_init move all the desc in one shot. Are you
> talking about the terminate all case? 
In this case you invoke the function for a descriptor which you delete from
its list and then join it to free_descs_list.

> > > > > +static void at_xdmac_tasklet(unsigned long data)
> > > > > +{
> > > > > +	struct at_xdmac_chan	*atchan = (struct at_xdmac_chan *)data;
> > > > > +	struct at_xdmac_desc	*desc;
> > > > > +	u32			error_mask;
> > > > > +
> > > > > +	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
> > > > > +		 __func__, atchan->status);
> > > > > +
> > > > > +	error_mask = AT_XDMAC_CIS_RBEIS
> > > > > +		     | AT_XDMAC_CIS_WBEIS
> > > > > +		     | AT_XDMAC_CIS_ROIS;
> > > > > +
> > > > > +	if (at_xdmac_chan_is_cyclic(atchan)) {
> > > > > +		at_xdmac_handle_cyclic(atchan);
> > > > > +	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
> > > > > +		   || (atchan->status & error_mask)) {
> > > > > +		struct dma_async_tx_descriptor  *txd;
> > > > > +
> > > > > +		if (atchan->status & AT_XDMAC_CIS_RBEIS)
> > > > > +			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
> > > > > +		else if (atchan->status & AT_XDMAC_CIS_WBEIS)
> > > > > +			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
> > > > > +		else if (atchan->status & AT_XDMAC_CIS_ROIS)
> > > > > +			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
> > > > > +
> > > > > +		desc = list_first_entry(&atchan->xfers_list,
> > > > > +					struct at_xdmac_desc,
> > > > > +					xfer_node);
> > > > > +		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
> > > > > +		BUG_ON(!desc->active_xfer);
> > > > > +
> > > > > +		txd = &desc->tx_dma_desc;
> > > > > +
> > > > > +		at_xdmac_terminate_xfer(atchan, desc);
> > > > why terminate here? This looks wrong
> > > 
> > > Why? What do you have in mind? It is not obvious for me that it is the
> > > wrong place.
> > The descriptor has completed. The terminate has special meaning. The user
> > can cancel all transactions by invoking terminate_all(). That implies to
> > clean up the channel and abort the transfers. The transfer is done so what
> > does it mean to terminate.
> 
> So maybe I have to rename this function because I need to remove the
> transfer from the transfer list and put the transfer descriptors in the
> free descriptor list once transfer is done.
ok

-- 
~Vinod
