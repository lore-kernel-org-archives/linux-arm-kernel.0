From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 16 Oct 2014 16:10:48 +0200
Subject: [PATCH v6 1/3] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <20141015133004.GP1638@intel.com>
References: <1412175565-810-1-git-send-email-ludovic.desroches@atmel.com>
 <1412175565-810-2-git-send-email-ludovic.desroches@atmel.com>
 <20141015133004.GP1638@intel.com>
Message-ID: <20141016141048.GC2367@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 07:00:04PM +0530, Vinod Koul wrote:
> On Wed, Oct 01, 2014 at 04:59:23PM +0200, Ludovic Desroches wrote:
> > New atmel DMA controller known as XDMAC, introduced with SAMA5D4
> > devices.
> > 
> > +
> > +static inline u32 at_xdmac_csize(u32 maxburst)
> > +{
> > +	u32 csize;
> > +
> > +	switch (ffs(maxburst) - 1) {
> This is pretty odd, I dont see a reason why we can have proper case values
> and converted ones. It would have made sense if we use this for conversion
> but in case values in quite puzzling
> 
> > +	case 1:
> > +		csize = AT_XDMAC_CC_CSIZE_CHK_2;
> and looking at values this can be ffs(maxburst) - 1 for valid cases

Yes I can return ffs(maxburst) - 1 for valid cases.

> > +		break;
> > +	case 2:
> > +		csize = AT_XDMAC_CC_CSIZE_CHK_4;
> > +		break;
> > +	case 3:
> > +		csize = AT_XDMAC_CC_CSIZE_CHK_8;
> > +		break;
> > +	case 4:
> > +		csize = AT_XDMAC_CC_CSIZE_CHK_16;
> > +		break;
> > +	default:
> > +		csize = AT_XDMAC_CC_CSIZE_CHK_1;
> why?

Because some devices don't set maxburst, for example, our serial driver.

> 
> > +	}
> > +
> > +	return csize;
> > +};
> > +
> > +static unsigned int init_nr_desc_per_channel = 64;
> > +module_param(init_nr_desc_per_channel, uint, 0644);
> > +MODULE_PARM_DESC(init_nr_desc_per_channel,
> > +		 "initial descriptors per channel (default: 64)");
> > +
> > +
> > +static bool at_xdmac_chan_is_enabled(struct at_xdmac_chan *atchan)
> > +{
> > +	return at_xdmac_chan_read(atchan, AT_XDMAC_GS) & atchan->mask;
> > +}
> > +
> > +static void at_xdmac_off(struct at_xdmac *atxdmac)
> > +{
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GD, -1L);
> > +
> > +	/* Wait that all chans are disabled. */
> > +	while (at_xdmac_read(atxdmac, AT_XDMAC_GS))
> > +		cpu_relax();
> > +
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GID, -1L);
> > +}
> > +
> > +/* Call with lock hold. */
> > +static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
> > +				struct at_xdmac_desc *first)
> > +{
> > +	struct at_xdmac	*atxdmac = to_at_xdmac(atchan->chan.device);
> > +	u32		reg;
> > +
> > +	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
> > +
> > +	if (at_xdmac_chan_is_enabled(atchan))
> > +		return;
> > +
> > +	/* Set transfer as active to not try to start it again. */
> > +	first->active_xfer = true;
> > +
> > +	/* Tell xdmac where to get the first descriptor. */
> > +	reg = AT_XDMAC_CNDA_NDA(first->tx_dma_desc.phys)
> > +	      | AT_XDMAC_CNDA_NDAIF(atchan->memif);
> > +	at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, reg);
> > +
> > +	/*
> > +	 * When doing memory to memory transfer we need to use the next
> > +	 * descriptor view 2 since some fields of the configuration register
> > +	 * depend on transfer size and src/dest addresses.
> > +	 */
> > +	if (atchan->cfg & AT_XDMAC_CC_TYPE_PER_TRAN) {
> > +		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
> > +		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->cfg);
> > +	} else {
> > +		reg = AT_XDMAC_CNDC_NDVIEW_NDV2;
> > +	}
> > +
> > +	reg |= AT_XDMAC_CNDC_NDDUP
> > +	       | AT_XDMAC_CNDC_NDSUP
> > +	       | AT_XDMAC_CNDC_NDE;
> > +	at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, reg);
> > +
> > +	dev_vdbg(chan2dev(&atchan->chan),
> > +		 "%s: XDMAC_CC=0x%08x XDMAC_CNDA=0x%08x, XDMAC_CNDC=0x%08x, "
> > +		 "XDMAC_CSA=0x%08x, XDMAC_CDA=0x%08x, XDMAC_CUBC=0x%08x\n",
> multi line prints are not encouraged. You could perhpas do XDMAC CC, CNDC...
> and reduce your text size and ignore 80char limit.

Ok

> 
> > +		 __func__, at_xdmac_chan_read(atchan, AT_XDMAC_CC),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CNDA),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CNDC),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CSA),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
> > +
> > +	at_xdmac_chan_write(atchan, AT_XDMAC_CID, 0xffffffff);
> > +	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE | AT_XDMAC_CIE_ROIE;
> > +	/*
> > +	 * There is no end of list when doing cyclic dma, we need to get
> > +	 * an interrupt after each periods.
> > +	 */
> > +	if (at_xdmac_chan_is_cyclic(atchan))
> > +		at_xdmac_chan_write(atchan, AT_XDMAC_CIE,
> > +				    reg | AT_XDMAC_CIE_BIE);
> > +	else
> > +		at_xdmac_chan_write(atchan, AT_XDMAC_CIE,
> > +				    reg | AT_XDMAC_CIE_LIE);
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GIE, atchan->mask);
> > +	dev_vdbg(chan2dev(&atchan->chan),
> > +		 "%s: enable channel (0x%08x)\n", __func__, atchan->mask);
> > +	wmb();
> > +	at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
> > +
> > +	dev_vdbg(chan2dev(&atchan->chan),
> > +		 "%s: XDMAC_CC=0x%08x XDMAC_CNDA=0x%08x, XDMAC_CNDC=0x%08x, "
> > +		 "XDMAC_CSA=0x%08x, XDMAC_CDA=0x%08x, XDMAC_CUBC=0x%08x\n",
> > +		 __func__, at_xdmac_chan_read(atchan, AT_XDMAC_CC),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CNDA),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CNDC),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CSA),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
> > +		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
> > +
> > +}
> 
> > +static int at_xdmac_set_slave_config(struct dma_chan *chan,
> > +				      struct dma_slave_config *sconfig)
> > +{
> > +	struct at_xdmac_chan 	*atchan = to_at_xdmac_chan(chan);
> > +
> > +	atchan->cfg = AT91_XDMAC_DT_PERID(atchan->perid)
> > +		      |	AT_XDMAC_CC_SWREQ_HWR_CONNECTED
> > +		      | AT_XDMAC_CC_MBSIZE_SIXTEEN
> > +		      | AT_XDMAC_CC_TYPE_PER_TRAN;
> > +
> > +	if (sconfig->direction == DMA_DEV_TO_MEM) {
> > +		atchan->cfg |= AT_XDMAC_CC_DAM_INCREMENTED_AM
> > +			       | AT_XDMAC_CC_SAM_FIXED_AM
> > +			       | AT_XDMAC_CC_DIF(atchan->memif)
> > +			       | AT_XDMAC_CC_SIF(atchan->perif)
> > +			       | AT_XDMAC_CC_DSYNC_PER2MEM;
> > +		atchan->dwidth = ffs(sconfig->src_addr_width) - 1;
> > +		atchan->cfg |= AT_XDMAC_CC_DWIDTH(atchan->dwidth);
> > +		atchan->cfg |= at_xdmac_csize(sconfig->src_maxburst);
> > +	} else if (sconfig->direction == DMA_MEM_TO_DEV) {
> > +		atchan->cfg |= AT_XDMAC_CC_DAM_FIXED_AM
> > +			       | AT_XDMAC_CC_SAM_INCREMENTED_AM
> > +			       | AT_XDMAC_CC_DIF(atchan->perif)
> > +			       | AT_XDMAC_CC_SIF(atchan->memif)
> > +			       | AT_XDMAC_CC_DSYNC_MEM2PER;
> > +		atchan->dwidth = ffs(sconfig->dst_addr_width) - 1;
> > +		atchan->cfg |= AT_XDMAC_CC_DWIDTH(atchan->dwidth);
> > +		atchan->cfg |= at_xdmac_csize(sconfig->dst_maxburst);
> please store both direction configs and use them based on direction in
> prep_xxx calls. We will remove the direction here.

Ok, I'll do this update.

> 
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Src address and dest addr are needed to configure the link list
> > +	 * descriptor so keep the slave configuration.
> > +	 */
> > +	memcpy(&atchan->dma_sconfig, sconfig, sizeof(struct dma_slave_config));
> > +
> > +	dev_dbg(chan2dev(chan), "%s: atchan->cfg=0x%08x\n", __func__, atchan->cfg);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct dma_async_tx_descriptor *
> > +at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > +		       unsigned int sg_len, enum dma_transfer_direction direction,
> > +		       unsigned long flags, void *context)
> > +{
> > +	struct at_xdmac_chan 	*atchan = to_at_xdmac_chan(chan);
> > +	struct dma_slave_config	*sconfig = &atchan->dma_sconfig;
> > +	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > +	struct scatterlist	*sg;
> > +	int 			i;
> > +
> > +	if (!sgl)
> > +		return NULL;
> > +
> > +	if (!is_slave_direction(direction)) {
> > +		dev_err(chan2dev(chan), "invalid DMA direction\n");
> > +		return NULL;
> > +	}
> > +
> > +	dev_dbg(chan2dev(chan), "%s: sg_len=%d, dir=%s, flags=0x%lx\n",
> > +		 __func__, sg_len,
> > +		 direction == DMA_MEM_TO_DEV ? "to device" : "from device",
> > +		 flags);
> > +
> > +	/* Protect dma_sconfig field that can be modified by set_slave_conf. */
> > +	spin_lock_bh(&atchan->lock);
> > +
> > +	/* Prepare descriptors. */
> > +	for_each_sg(sgl, sg, sg_len, i) {
> > +		struct at_xdmac_desc	*desc = NULL;
> > +		u32			len, mem;
> > +
> > +		len = sg_dma_len(sg);
> > +		mem = sg_dma_address(sg);
> > +		if (unlikely(!len)) {
> > +			dev_err(chan2dev(chan), "sg data length is zero\n");
> > +			spin_unlock_bh(&atchan->lock);
> > +			return NULL;
> > +		}
> > +		dev_dbg(chan2dev(chan), "%s: * sg%d len=%u, mem=0x%08x\n",
> > +			 __func__, i, len, mem);
> > +
> > +		desc = at_xdmac_get_desc(atchan);
> > +		if (!desc) {
> > +			dev_err(chan2dev(chan), "can't get descriptor\n");
> > +			if (first)
> > +				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> > +			spin_unlock_bh(&atchan->lock);
> > +			return NULL;
> > +		}
> > +
> > +		/* Linked list descriptor setup. */
> > +		if (direction == DMA_DEV_TO_MEM) {
> > +			desc->lld.mbr_sa = sconfig->src_addr;
> > +			desc->lld.mbr_da = mem;
> > +		} else {
> > +			desc->lld.mbr_sa = mem;
> > +			desc->lld.mbr_da = sconfig->dst_addr;
> > +		}
> > +		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV1		/* next descriptor view */
> > +			| AT_XDMAC_MBR_UBC_NDEN				/* next descriptor dst parameter update */
> > +			| AT_XDMAC_MBR_UBC_NSEN				/* next descriptor src parameter update */
> > +			| (i == sg_len - 1 ? 0 : AT_XDMAC_MBR_UBC_NDE)	/* descriptor fetch */
> > +			| len / (1 << atchan->dwidth);			/* microblock length */
> > +		dev_dbg(chan2dev(chan),
> > +			 "%s: lld: mbr_sa=0x%08x, mbr_da=0x%08x, mbr_ubc=0x%08x\n",
> > +			 __func__, desc->lld.mbr_sa, desc->lld.mbr_da, desc->lld.mbr_ubc);
> > +
> > +		/* Chain lld. */
> > +		if (prev) {
> > +			prev->lld.mbr_nda = desc->tx_dma_desc.phys;
> > +			dev_dbg(chan2dev(chan),
> > +				 "%s: chain lld: prev=0x%p, mbr_nda=0x%08x\n",
> > +				 __func__, prev, prev->lld.mbr_nda);
> > +		}
> > +
> > +		prev = desc;
> > +		if (!first)
> > +			first = desc;
> > +
> > +		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
> > +			 __func__, desc, first);
> > +		list_add_tail(&desc->desc_node, &first->descs_list);
> > +	}
> > +
> > +	spin_unlock_bh(&atchan->lock);
> > +
> > +	first->tx_dma_desc.cookie = -EBUSY;
> why are you init cookie here

Inspired by other driver. What is the right place so?

> > +	first->tx_dma_desc.flags = flags;
> > +	first->xfer_size = sg_len;
> > +
> > +	return &first->tx_dma_desc;
> > +}
> > +
> 
> > +static struct dma_async_tx_descriptor *
> > +at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> > +			 size_t len, unsigned long flags)
> > +{
> > +	struct at_xdmac_chan 	*atchan = to_at_xdmac_chan(chan);
> > +	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> > +	size_t			remaining_size = len, xfer_size = 0, ublen;
> > +	dma_addr_t		src_addr = src, dst_addr = dest;
> > +	u32			dwidth;
> > +	/*
> > +	 * WARNING: The channel configuration is set here since there is no
> > +	 * dmaengine_slave_config call in this case. Moreover we don't know the
> > +	 * direction, it involves we can't dynamically set the source and dest
> > +	 * interface so we have to use the same one. Only interface 0 allows EBI
> > +	 * access. Hopefully we can access DDR through both ports (at least on
> > +	 * SAMA5D4x), so we can use the same interface for source and dest,
> > +	 * that solves the fact we don't know the direction.
> For memcpy why should we need slave_config. The system memory source and
> destination width could be assumed to relastic values and then burst sizes
> maxed for performance. These values make more sense for periphral where we
> have to match up with the periphral

I don't tell I need slave_config. We have already talked about this. I don't
see the problem. It is only a comment, a reminder. The only information
I may need, one day, is the direction because we have to set src and dst
interfaces. At the moment, all our products are done in a way nand flash
and DDR are on the same interface so we don't have to care about
direction.
Since we don't have the direction, two solutions:
- remember this limitation for next products, that's why there is this reminder,
- change our nand driver in order to see nand as a peripheral instead of
  a memory. 

> 
> > +	 */
> > +	u32			chan_cc = AT_XDMAC_CC_DAM_INCREMENTED_AM
> > +					| AT_XDMAC_CC_SAM_INCREMENTED_AM
> > +					| AT_XDMAC_CC_DIF(0)
> > +					| AT_XDMAC_CC_SIF(0)
> > +					| AT_XDMAC_CC_MBSIZE_SIXTEEN
> > +					| AT_XDMAC_CC_TYPE_MEM_TRAN;
> > +
> > +	dev_dbg(chan2dev(chan), "%s: src=0x%08x, dest=0x%08x, len=%d, flags=0x%lx\n",
> > +		__func__, src, dest, len, flags);
> > +
> > +	if (unlikely(!len))
> > +		return NULL;
> > +
> > +	/*
> > +	 * Check address alignment to select the greater data width we can use.
> > +	 * Some XDMAC implementations don't provide dword transfer, in this
> > +	 * case selecting dword has the same behavior as selecting word transfers.
> > +	 */
> > +	if (!((src_addr | dst_addr) & 7)) {
> > +		dwidth = AT_XDMAC_CC_DWIDTH_DWORD;
> > +		dev_dbg(chan2dev(chan), "%s: dwidth: double word\n", __func__);
> > +	} else if (!((src_addr | dst_addr)  & 3)) {
> > +		dwidth = AT_XDMAC_CC_DWIDTH_WORD;
> > +		dev_dbg(chan2dev(chan), "%s: dwidth: word\n", __func__);
> > +	} else if (!((src_addr | dst_addr) & 1)) {
> > +		dwidth = AT_XDMAC_CC_DWIDTH_HALFWORD;
> > +		dev_dbg(chan2dev(chan), "%s: dwidth: half word\n", __func__);
> > +	} else {
> > +		dwidth = AT_XDMAC_CC_DWIDTH_BYTE;
> > +		dev_dbg(chan2dev(chan), "%s: dwidth: byte\n", __func__);
> > +	}
> > +
> > +	atchan->cfg = chan_cc | AT_XDMAC_CC_DWIDTH(dwidth);
> > +
> > +	/* Prepare descriptors. */
> > +	while (remaining_size) {
> > +		struct at_xdmac_desc	*desc = NULL;
> > +
> > +		dev_dbg(chan2dev(chan), "%s: remaining_size=%u\n", __func__, remaining_size);
> > +
> > +		spin_lock_bh(&atchan->lock);
> > +		desc = at_xdmac_get_desc(atchan);
> > +		spin_unlock_bh(&atchan->lock);
> > +		if (!desc) {
> > +			dev_err(chan2dev(chan), "can't get descriptor\n");
> > +			if (first)
> > +				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> > +			return NULL;
> > +		}
> > +
> > +		/* Update src and dest addresses. */
> > +		src_addr += xfer_size;
> > +		dst_addr += xfer_size;
> > +
> > +		if (remaining_size >= AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth)
> > +			xfer_size = AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth;
> > +		else
> > +			xfer_size = remaining_size;
> > +
> > +		dev_dbg(chan2dev(chan), "%s: xfer_size=%u\n", __func__, xfer_size);
> > +
> > +		/* Check remaining length and change data width if needed. */
> > +		if (!((src_addr | dst_addr | xfer_size) & 7)) {
> > +			dwidth = AT_XDMAC_CC_DWIDTH_DWORD;
> > +			dev_dbg(chan2dev(chan), "%s: dwidth: double word\n", __func__);
> > +		} else if (!((src_addr | dst_addr | xfer_size)  & 3)) {
> > +			dwidth = AT_XDMAC_CC_DWIDTH_WORD;
> > +			dev_dbg(chan2dev(chan), "%s: dwidth: word\n", __func__);
> > +		} else if (!((src_addr | dst_addr | xfer_size) & 1)) {
> > +			dwidth = AT_XDMAC_CC_DWIDTH_HALFWORD;
> > +			dev_dbg(chan2dev(chan), "%s: dwidth: half word\n", __func__);
> > +		} else if ((src_addr | dst_addr | xfer_size) & 1) {
> > +			dwidth = AT_XDMAC_CC_DWIDTH_BYTE;
> > +			dev_dbg(chan2dev(chan), "%s: dwidth: byte\n", __func__);
> > +		}
> > +		chan_cc |= AT_XDMAC_CC_DWIDTH(dwidth);
> > +
> > +		ublen = xfer_size >> dwidth;
> > +		remaining_size -= xfer_size;
> > +
> > +		desc->lld.mbr_sa = src_addr;
> > +		desc->lld.mbr_da = dst_addr;
> > +		desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV2
> > +			| AT_XDMAC_MBR_UBC_NDEN
> > +			| AT_XDMAC_MBR_UBC_NSEN
> > +			| (remaining_size ? AT_XDMAC_MBR_UBC_NDE : 0)
> > +			| ublen;
> > +		desc->lld.mbr_cfg = chan_cc;
> > +
> > +		dev_dbg(chan2dev(chan),
> > +			 "%s: lld: mbr_sa=0x%08x, mbr_da=0x%08x, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
> > +			 __func__, desc->lld.mbr_sa, desc->lld.mbr_da, desc->lld.mbr_ubc, desc->lld.mbr_cfg);
> > +
> > +		/* Chain lld. */
> > +		if (prev) {
> > +			prev->lld.mbr_nda = desc->tx_dma_desc.phys;
> > +			dev_dbg(chan2dev(chan),
> > +				 "%s: chain lld: prev=0x%p, mbr_nda=0x%08x\n",
> > +				 __func__, prev, prev->lld.mbr_nda);
> > +		}
> > +
> > +		prev = desc;
> > +		if (!first)
> > +			first = desc;
> > +
> > +		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
> > +			 __func__, desc, first);
> > +		list_add_tail(&desc->desc_node, &first->descs_list);
> > +	}
> > +
> > +	first->tx_dma_desc.cookie = -EBUSY;
> again..
> 
> -- 
> ~Vinod


Ludovic
