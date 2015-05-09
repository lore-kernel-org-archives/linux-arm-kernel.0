From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 9 May 2015 17:29:11 +0530
Subject: [PATCH v2 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <873837uubu.fsf@belgarion.home>
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-4-git-send-email-robert.jarzmik@free.fr>
 <20150508063434.GZ3521@localhost> <873837uubu.fsf@belgarion.home>
Message-ID: <20150509115911.GL3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 02:28:37PM +0200, Robert Jarzmik wrote:
> Vinod Koul <vinod.koul@intel.com> writes:
> 
> 
> >> +#define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
> >> +#define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
> >> +
> >> +#define DDADR_DESCADDR	0xfffffff0	/* Address of next descriptor (mask) */
> >> +#define DDADR_STOP	BIT(0)	/* Stop (read / write) */
> >> +
> >> +#define DCMD_INCSRCADDR	BIT(31)	/* Source Address Increment Setting. */
> >> +#define DCMD_INCTRGADDR	BIT(30)	/* Target Address Increment Setting. */
> >> +#define DCMD_FLOWSRC	BIT(29)	/* Flow Control by the source. */
> >> +#define DCMD_FLOWTRG	BIT(28)	/* Flow Control by the target. */
> >> +#define DCMD_STARTIRQEN	BIT(22)	/* Start Interrupt Enable */
> >> +#define DCMD_ENDIRQEN	BIT(21)	/* End Interrupt Enable */
> >> +#define DCMD_ENDIAN	BIT(18)	/* Device Endian-ness. */
> >> +#define DCMD_BURST8	(1 << 16)	/* 8 byte burst */
> >> +#define DCMD_BURST16	(2 << 16)	/* 16 byte burst */
> >> +#define DCMD_BURST32	(3 << 16)	/* 32 byte burst */
> >> +#define DCMD_WIDTH1	(1 << 14)	/* 1 byte width */
> >> +#define DCMD_WIDTH2	(2 << 14)	/* 2 byte width (HalfWord) */
> >> +#define DCMD_WIDTH4	(3 << 14)	/* 4 byte width (Word) */
> >> +#define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
> > Please namespace these ...
> Sorry I don't get this comment, would you care to explain me please ?
Right now you are using very genric names which can conflict with others, so
makese sense to add PXA_DCMD_LENGTH with me lesser prone to conflicts rather
than DCMD_LENGTH

> 
> >> +#define _phy_readl_relaxed(phy, _reg)					\
> >> +	readl_relaxed((phy)->base + _reg((phy)->idx))
> >> +#define phy_readl_relaxed(phy, _reg)					\
> >> +	({								\
> >> +		u32 _v;							\
> >> +		_v = readl_relaxed((phy)->base + _reg((phy)->idx));	\
> >> +		chan_vdbg(phy->vchan, "readl(%s): 0x%08x\n", #_reg,	\
> >> +			  _v);						\
> >> +		_v;							\
> >> +	})
> >> +#define phy_writel(phy, val, _reg)					\
> >> +	do {								\
> >> +		writel((val), (phy)->base + _reg((phy)->idx));		\
> >> +		chan_vdbg((phy)->vchan, "writel(0x%08x, %s)\n",		\
> >> +			  (u32)(val), #_reg);				\
> >> +	} while (0)
> >> +#define phy_writel_relaxed(phy, val, _reg)				\
> >> +	do {								\
> >> +		writel_relaxed((val), (phy)->base + _reg((phy)->idx));	\
> >> +		chan_vdbg((phy)->vchan, "writel(0x%08x, %s)\n",		\
> >> +			  (u32)(val), #_reg);				\
> >> +	} while (0)
> >> +
> >> +/*
> > ??
> > Does this code compile?
> Oh yes, it compiles and works with both debug on and debug off. This is actually
> the most handy debug trace of this driver. I've been using that kind of
> accessors for years in my drivers, and this is truly something I need to
> maintain the driver, especially when a nasty corner case happens on a hardware I
> don't own.
You have start of comment on that line, no ending, so how does it compile!

> >> +	spin_lock_irqsave(&pdev->phy_lock, flags);
> >> +	for (prio = pchan->prio; prio >= PXAD_PRIO_HIGHEST; prio--) {
> >> +		for (i = 0; i < pdev->nr_chans; i++) {
> >> +			if (prio != (i & 0xf) >> 2)
> >> +				continue;
> >> +			phy = &pdev->phys[i];
> >> +			if (!phy->vchan) {
> >> +				phy->vchan = pchan;
> >> +				found = phy;
> >> +				goto out_unlock;
> > what does phy have to do with priorty here?
> Each phy has a priority, it's part of the hardware.  IOW each phy has a "granted
> bandwidth". This guarantee is based on the number of request on the system bus
> the DMA IP can place.
> 
> In PXA2xx/PXA3xx, the DMA IP can have 8 simulaneous request. The highest
> priority phys always get 4 slots, the high 2 slots, etc ...
> 
> So a priority is an intrinsic property of a phy.
Yes that part is ok, but why are you looking up priorty while searching for
a phy, searching thru number of channels should suffice?

> >> +static struct pxad_desc_sw *
> >> +pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
> >> +{
> >> +	struct pxad_desc_sw *sw_desc;
> >> +	dma_addr_t dma;
> >> +	int i;
> >> +
> >> +	sw_desc = kzalloc(sizeof(*sw_desc) +
> >> +			  nb_hw_desc * sizeof(struct pxad_desc_hw *),
> >> +			  GFP_ATOMIC);
> >> +	if (!sw_desc) {
> >> +		chan_err(chan, "Couldn't allocate a sw_desc\n");
> > this is not required, memory allocator will spew this as well. I think
> > checkpatch should have warned you..
> Checkpatch did not, but I agree, will remove this print alltogether. For v3.
surprised it does actually, see,
# check for unnecessary "Out of Memory" messages

> 
> >> +static enum dma_status pxad_tx_status(struct dma_chan *dchan,
> >> +				      dma_cookie_t cookie,
> >> +				      struct dma_tx_state *txstate)
> >> +{
> >> +	struct pxad_chan *chan = to_pxad_chan(dchan);
> >> +	enum dma_status ret;
> >> +
> >> +	ret = dma_cookie_status(dchan, cookie, txstate);
> > pls check if txstate is valid
> My understanding is that's already the job of dma_cookie_status() and
> dma_set_residue().
Yes it is, but is txstate is NULL then no need to calculate residue so bail
out here

-- 
~Vinod
