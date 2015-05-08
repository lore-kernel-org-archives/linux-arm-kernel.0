From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 08 May 2015 14:28:37 +0200
Subject: [PATCH v2 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <20150508063434.GZ3521@localhost> (Vinod Koul's message of "Fri,
 8 May 2015 12:04:34 +0530")
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-4-git-send-email-robert.jarzmik@free.fr>
 <20150508063434.GZ3521@localhost>
Message-ID: <873837uubu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

Hi Vinod,

First thanks for the review.

>> This is a new driver for pxa SoCs, which is also compatible with the former
>> mmp_pdma.
> The rationale is fine, is there a plan to remove old mmp_pdma then?
I have this in mind, yes. I will need a test from the MMP people to assess
pxa-dma works flawlessly with MMP architecture, with the same level of
stability. Once I have their blessing, I'll propose to remove mmp_pdma.

>> +config PXA_DMA
>> +	bool "PXA DMA support"
> no prompt?
Right, this is missing.  I first thought this will always be selected by
CONFIG_ARCH_PXA, and no user selection would be allowed. But I changed my mind
since then, and I'll add a prompt description there. For v3.

>> +#define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + (((n) & 0x3f) << 2))
> care to put a comment on this calculation
Definitely. For v3.

>> +#define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
>> +#define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
>> +
>> +#define DDADR_DESCADDR	0xfffffff0	/* Address of next descriptor (mask) */
>> +#define DDADR_STOP	BIT(0)	/* Stop (read / write) */
>> +
>> +#define DCMD_INCSRCADDR	BIT(31)	/* Source Address Increment Setting. */
>> +#define DCMD_INCTRGADDR	BIT(30)	/* Target Address Increment Setting. */
>> +#define DCMD_FLOWSRC	BIT(29)	/* Flow Control by the source. */
>> +#define DCMD_FLOWTRG	BIT(28)	/* Flow Control by the target. */
>> +#define DCMD_STARTIRQEN	BIT(22)	/* Start Interrupt Enable */
>> +#define DCMD_ENDIRQEN	BIT(21)	/* End Interrupt Enable */
>> +#define DCMD_ENDIAN	BIT(18)	/* Device Endian-ness. */
>> +#define DCMD_BURST8	(1 << 16)	/* 8 byte burst */
>> +#define DCMD_BURST16	(2 << 16)	/* 16 byte burst */
>> +#define DCMD_BURST32	(3 << 16)	/* 32 byte burst */
>> +#define DCMD_WIDTH1	(1 << 14)	/* 1 byte width */
>> +#define DCMD_WIDTH2	(2 << 14)	/* 2 byte width (HalfWord) */
>> +#define DCMD_WIDTH4	(3 << 14)	/* 4 byte width (Word) */
>> +#define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
> Please namespace these ...
Sorry I don't get this comment, would you care to explain me please ?

>> +#define chan_dbg(_chan, fmt, arg...)					\
>> +	dev_dbg(&(_chan)->vc.chan.dev->device, "%s(chan=%p): " fmt,	\
>> +		__func__, (_chan), ## arg)
...
> am not a big fan of driver specfic debug macros, can we use dev_ ones please
As you wish.  This will make the code ugly for all the chan_dbg() calls, which
is a bit a pity, but if you think this should be done that way then let's do
that.

>> +#define _phy_readl_relaxed(phy, _reg)					\
>> +	readl_relaxed((phy)->base + _reg((phy)->idx))
>> +#define phy_readl_relaxed(phy, _reg)					\
>> +	({								\
>> +		u32 _v;							\
>> +		_v = readl_relaxed((phy)->base + _reg((phy)->idx));	\
>> +		chan_vdbg(phy->vchan, "readl(%s): 0x%08x\n", #_reg,	\
>> +			  _v);						\
>> +		_v;							\
>> +	})
>> +#define phy_writel(phy, val, _reg)					\
>> +	do {								\
>> +		writel((val), (phy)->base + _reg((phy)->idx));		\
>> +		chan_vdbg((phy)->vchan, "writel(0x%08x, %s)\n",		\
>> +			  (u32)(val), #_reg);				\
>> +	} while (0)
>> +#define phy_writel_relaxed(phy, val, _reg)				\
>> +	do {								\
>> +		writel_relaxed((val), (phy)->base + _reg((phy)->idx));	\
>> +		chan_vdbg((phy)->vchan, "writel(0x%08x, %s)\n",		\
>> +			  (u32)(val), #_reg);				\
>> +	} while (0)
>> +
>> +/*
> ??
> Does this code compile?
Oh yes, it compiles and works with both debug on and debug off. This is actually
the most handy debug trace of this driver. I've been using that kind of
accessors for years in my drivers, and this is truly something I need to
maintain the driver, especially when a nasty corner case happens on a hardware I
don't own.

And I've tested this thoroughly when I was stabilizing this driver.

>> +	/*
>> +	 * dma channel priorities
>> +	 * ch 0 - 3,  16 - 19  <--> (0)
>> +	 * ch 4 - 7,  20 - 23  <--> (1)
>> +	 * ch 8 - 11, 24 - 27  <--> (2)
>> +	 * ch 12 - 15, 28 - 31  <--> (3)
>> +	 */
>> +
>> +	spin_lock_irqsave(&pdev->phy_lock, flags);
>> +	for (prio = pchan->prio; prio >= PXAD_PRIO_HIGHEST; prio--) {
>> +		for (i = 0; i < pdev->nr_chans; i++) {
>> +			if (prio != (i & 0xf) >> 2)
>> +				continue;
>> +			phy = &pdev->phys[i];
>> +			if (!phy->vchan) {
>> +				phy->vchan = pchan;
>> +				found = phy;
>> +				goto out_unlock;
> what does phy have to do with priorty here?
Each phy has a priority, it's part of the hardware.  IOW each phy has a "granted
bandwidth". This guarantee is based on the number of request on the system bus
the DMA IP can place.

In PXA2xx/PXA3xx, the DMA IP can have 8 simulaneous request. The highest
priority phys always get 4 slots, the high 2 slots, etc ...

So a priority is an intrinsic property of a phy.

>
>> +static bool pxad_try_hotchain(struct virt_dma_chan *vc,
>> +				  struct virt_dma_desc *vd)
>> +{
>> +	struct virt_dma_desc *vd_last_issued = NULL;
>> +	struct pxad_chan *chan = to_pxad_chan(&vc->chan);
>> +
>> +	/*
>> +	 * Attempt to hot chain the tx if the phy is still running. This is
>> +	 * considered successful only if either the channel is still running
>> +	 * after the chaining, or if the chained transfer is completed after
>> +	 * having been hot chained.
>> +	 * A change of alignment is not allowed, and forbids hotchaining.
>> +	 */
> okay, so what if while you are hotchaining the first txn completes, how do
> we prevent these sort of races with HW?

In the case where hotchaining is attempted, and while hotchaining txn completes,
obviously the channel stops, and the hotchained descriptor is not
"hotchained". This is the reason the function is called "...try_hotchain" and
not hotchain.

There is actually no race :
- either you succeed the hotchain, ie. the atomic write of the dma link
  descriptor happens before the txn finishes
- or you fail the hotchain, in which case the channel stops without beginning
  the new chained descriptor, ie. the atomic write of the dma link descriptor
  happens after txn finishes

It's a "try and test after" approach, and the "try" is atomic because it's a
single u32 write to link the descriptors (which is materialized in
pxad_desc_chain()).

>> +static struct pxad_desc_sw *
>> +pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>> +{
>> +	struct pxad_desc_sw *sw_desc;
>> +	dma_addr_t dma;
>> +	int i;
>> +
>> +	sw_desc = kzalloc(sizeof(*sw_desc) +
>> +			  nb_hw_desc * sizeof(struct pxad_desc_hw *),
>> +			  GFP_ATOMIC);
>> +	if (!sw_desc) {
>> +		chan_err(chan, "Couldn't allocate a sw_desc\n");
> this is not required, memory allocator will spew this as well. I think
> checkpatch should have warned you..
Checkpatch did not, but I agree, will remove this print alltogether. For v3.

>> +static inline struct dma_async_tx_descriptor *
>> +pxad_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
>> +		 unsigned long tx_flags)
>> +{
>> +	struct dma_async_tx_descriptor *tx;
>> +
>> +	tx = vchan_tx_prep(vc, vd, tx_flags);
>> +	tx->tx_submit = pxad_tx_submit;
>> +	tx->tx_release = pxad_tx_release;
> tx_release?
Oh sorry, this is a leftover from our former discussion on descriptor
reuse. You've convinced me since then to use async_tx_test_ack() in virt-dma.c,
so I will remove that. For v3.

>> +static int pxad_config(struct dma_chan *dchan,
>> +		       struct dma_slave_config *cfg)
>> +{
>> +	struct pxad_chan *chan = to_pxad_chan(dchan);
>> +	u32 maxburst = 0, dev_addr = 0;
>> +	enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
>> +
>> +	if (!dchan)
>> +		return -EINVAL;
>> +
>> +	chan->dir = cfg->direction;
>> +	chan->dcmd_base = 0;
>> +
>> +	if (cfg->direction == DMA_DEV_TO_MEM) {
> direction is depricated, please copy the parameters and then use them in
> your prep_ based on direction passed
Understood. For v3.

>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	list_for_each_entry(vd, &chan->vc.desc_issued, node) {
>> +		sw_desc = to_pxad_sw_desc(vd);
>> +
>> +		if (vd->tx.cookie == cookie && !prev_completed) {
>> +			residue = sw_desc->len;
>> +			break;
>> +		}
>> +		prev_completed = is_desc_completed(vd);
> why not use vchan_find_desc() ?
Indeed, why not :) I had not in mind the existence of this function. I'll use it
for v3.

>> +static enum dma_status pxad_tx_status(struct dma_chan *dchan,
>> +				      dma_cookie_t cookie,
>> +				      struct dma_tx_state *txstate)
>> +{
>> +	struct pxad_chan *chan = to_pxad_chan(dchan);
>> +	enum dma_status ret;
>> +
>> +	ret = dma_cookie_status(dchan, cookie, txstate);
> pls check if txstate is valid
My understanding is that's already the job of dma_cookie_status() and
dma_set_residue().

>> +static void pxad_free_channels(struct dma_device *dmadev)
>> +{
>> +	struct pxad_chan *c, *cn;
>> +
>> +	list_for_each_entry_safe(c, cn, &dmadev->channels,
>> +				 vc.chan.device_node) {
>> +		list_del(&c->vc.chan.device_node);
>> +		tasklet_kill(&c->vc.task);
>> +	}
>> +}
>> +
>> +static int pxad_remove(struct platform_device *op)
>> +{
>> +	struct pxad_device *pdev = platform_get_drvdata(op);
>> +
> you should free up irq as well, otherwise device can still generate
> interrupts
They are freed automatically because I used devm_request_irq() and not
request_irq().

Cheers.

-- 
Robert
