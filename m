From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 22 Feb 2016 10:16:21 +0100
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160222032730.GU19598@localhost>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222032730.GU19598@localhost>
Message-ID: <20160222101621.4f03ef8b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vinod,

On Mon, 22 Feb 2016 08:57:30 +0530, Vinod Koul wrote:
> On Mon, Feb 15, 2016 at 08:58:03AM +0100, Thomas Petazzoni wrote:
> > diff --git a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> > new file mode 100644
> > index 0000000..0a03dcf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
> > @@ -0,0 +1,19 @@
> > +* Marvell XOR v2 engines
> > +
> > +Required properties:
> > +- compatible: Should be "marvell,mv-xor-v2"
> > +- reg: Should contain registers location and length (two sets)
> > +    the first set is the DMA registers
> > +    the second set is the global registers
> > +- msi-parent: Phandle to the MSI-capable interrupt controller used for
> > +  interrupts.
> > +
> > +Example:
> > +
> > +	xor0 at 400000 {
> > +		compatible = "marvell,mv-xor-v2";
> > +		reg = <0x400000 0x1000>,
> > +		      <0x410000 0x1000>;
> > +		msi-parent = <&gic_v2m0>;
> > +		dma-coherent;
> > +	};
> 
> This should be a separate patch :)

This is really a personal preference, and different maintainers have
different opinions on the matter. However, if your preference is to
have the DT binding documentation as a separate patch, then I'll split
it, no problem :)

> 
> > +/* DMA Engine Registers */
> > +#define DMA_DESQ_BALR_OFF	0x000
> > +#define DMA_DESQ_BAHR_OFF	0x004
> > +#define DMA_DESQ_SIZE_OFF	0x008
> > +#define DMA_DESQ_DONE_OFF	0x00C
> > +#define   DMA_DESQ_DONE_PENDING_MASK		0x7FFF
> > +#define   DMA_DESQ_DONE_PENDING_SHIFT		0
> > +#define   DMA_DESQ_DONE_READ_PTR_MASK		0x1FFF
> > +#define   DMA_DESQ_DONE_READ_PTR_SHIFT		16
> > +#define DMA_DESQ_ARATTR_OFF	0x010
> > +#define   DMA_DESQ_ATTR_CACHE_MASK		0x3F3F
> > +#define   DMA_DESQ_ATTR_OUTER_SHAREABLE		0x202
> > +#define   DMA_DESQ_ATTR_CACHEABLE		0x3C3C
> > +#define DMA_IMSG_CDAT_OFF	0x014
> > +#define DMA_IMSG_THRD_OFF	0x018
> > +#define   DMA_IMSG_THRD_MASK			0x7FFF
> > +#define   DMA_IMSG_THRD_SHIFT			0x0
> > +#define DMA_DESQ_AWATTR_OFF	0x01C
> > +  /* Same flags as DMA_DESQ_ARATTR_OFF */
> > +#define DMA_DESQ_ALLOC_OFF	0x04C
> > +#define   DMA_DESQ_ALLOC_WRPTR_MASK		0xFFFF
> > +#define   DMA_DESQ_ALLOC_WRPTR_SHIFT		16
> > +#define DMA_IMSG_BALR_OFF	0x050
> > +#define DMA_IMSG_BAHR_OFF	0x054
> > +#define DMA_DESQ_CTRL_OFF	0x100
> > +#define	  DMA_DESQ_CTRL_32B			1
> > +#define   DMA_DESQ_CTRL_128B			7
> > +#define DMA_DESQ_STOP_OFF	0x800
> > +#define DMA_DESQ_DEALLOC_OFF	0x804
> > +#define DMA_DESQ_ADD_OFF	0x808
> 
> Please namespace these and others. Something like MRVL_XOR_XXX or anyother
> patter you like would be fine...

The issue is that with such name-spacing, the names get really long,
and it's hard to stay with the 80 characters limit. But OK, I'll try to
see what I can do.

> > +/* descriptors queue size */
> > +#define MV_XOR_V2_MAX_DESC_NUM	1024
> 
> Is this hardware defined?

No, it is a software choice. The hardware supports up to 2^14
descriptors, i.e 16384, at least from my understanding of the datasheet.

> > +static void mv_xor_v2_set_data_buffers(struct mv_xor_v2_device *xor_dev,
> > +					struct mv_xor_v2_descriptor *desc,
> > +					dma_addr_t src, int index)
> > +{
> > +	int arr_index = ((index >> 1) * 3);
> > +
> > +	/*
> > +	 * fill the buffer's addresses to the descriptor
> > +	 * The format of the buffers address for 2 sequential buffers X and X+1:
> 
> space around + please.

ACK.

> > +	 *  First word: Buffer-DX-Address-Low[31:0]
> > +	 *  Second word:Buffer-DX+1-Address-Low[31:0]
> > +	 *  Third word: DX+1-Buffer-Address-High[47:32] [31:16]
> > +	 *		DX-Buffer-Address-High[47:32] [15:0]
> > +	 */
> > +	if ((index & 0x1) == 0) {
> > +		desc->data_buff_addr[arr_index] = lower_32_bits(src);
> > +
> > +		/* Clear lower 16-bits */
> > +		desc->data_buff_addr[arr_index + 2] &= ~0xFFFF;
> > +
> > +		/* Set them if we have a 64 bits DMA address */
> > +		if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> > +			desc->data_buff_addr[arr_index + 2] |=
> > +				upper_32_bits(src) & 0xFFFF;
> 
> So why should it depend on how kernel is configured?

Because using upper_32_bits() on a 32-bits type seems wrong? You can do
a git grep for CONFIG_ARCH_DMA_ADDR_T_64BIT, and see that it is already
used in drivers/dma/sh/rcar-dmac.c, drivers/gpu/drm/tegra/dc.c or
drivers/iommu/tegra-smmu.c.

drivers/dma/sh/rcar-dmac.c uses it for exactly the same reason as me:
they need to know if dma_addr_t is 32 bits or 64 bits, and if it's 64
bits, then they need to take the upper 32 bits and feed them to some
register.

> > +/*
> > + * Return the next available index in the DESQ.
> > + */
> > +static inline int mv_xor_v2_get_desq_write_ptr(struct mv_xor_v2_device *xor_dev)
> 
> Pls wrap with 80 chars wherever it is reasonable

Sure.

> > +/*
> > + * Allocate resources for a channel
> > + */
> > +static int mv_xor_v2_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +	/* nothing to be done here */
> > +	return 0;
> > +}
> 
> No need for empty alloc
> 
> > +
> > +/*
> > + * Free resources of a channel
> > + */
> > +void mv_xor_v2_free_chan_resources(struct dma_chan *chan)
> > +{
> > +	/* nothing to be done here */
> > +}
> 
> and free as well :)

Ah, cool, less useless code, I like that! Will fix.

> > +static irqreturn_t mv_xor_v2_interrupt_handler(int irq, void *data)
> > +{
> > +	struct mv_xor_v2_device *xor_dev = data;
> > +
> > +	/*
> > +	 * Update IMSG threshold, to disable new IMSG interrupts until
> > +	 * end of the tasklet
> > +	 */
> > +	mv_xor_v2_set_imsg_thrd(xor_dev, MV_XOR_V2_MAX_DESC_NUM);
> 
> You don't want to check the source of interrupt?

To protect against what? An improper MSI message that ends up firing
this interrupt for now reason? But only kernel space stuff (or
privileged code in user-space) can write to the MSI triggering
registers, so we should be able to trust that such an improper MSI
message will not arrive.

That being said, I can add a read of the pending descriptors number,
and if it's 0, then bail out with IRQ_NONE. Is that what you were
thinking about?

> > +static dma_cookie_t
> > +mv_xor_v2_tx_submit(struct dma_async_tx_descriptor *tx)
> > +{
> > +	int desq_ptr;
> > +	void *dest_hw_desc;
> > +	dma_cookie_t cookie;
> > +	struct mv_xor_v2_sw_desc *sw_desc =
> > +		container_of(tx, struct mv_xor_v2_sw_desc, async_tx);
> > +	struct mv_xor_v2_device *xor_dev =
> > +		container_of(tx->chan, struct mv_xor_v2_device, dmachan);
> > +
> > +	dev_dbg(xor_dev->dmadev.dev,
> > +		"%s sw_desc %p: async_tx %p\n",
> > +		__func__, sw_desc, &sw_desc->async_tx);
> > +
> > +	/* assign coookie */
> > +	spin_lock_bh(&xor_dev->cookie_lock);
> > +	cookie = dma_cookie_assign(tx);
> > +	spin_unlock_bh(&xor_dev->cookie_lock);
> > +
> > +	/* lock enqueue DESCQ */
> > +	spin_lock_bh(&xor_dev->push_lock);
> 
> Why not a generic channel lock which is used in submit, issue_pending and
> tasklet. What is the reason for opting different locks?

Yeah, agreed. Until I get real performance data, it's probably overkill
to use multiple spinlocks here. I'll rework with one spinlock only.

> > +	/* get the next available slot in the DESQ */
> > +	desq_ptr = mv_xor_v2_get_desq_write_ptr(xor_dev);
> > +
> > +	/* copy the HW descriptor from the SW descriptor to the DESQ */
> > +	dest_hw_desc = ((void *)xor_dev->hw_desq_virt +
> 
> cast to and away from void are not required

Well in this case, it is actually needed, because xor_dev->hw_desq_virt
is a pointer to a struct mv_xor_v2_descriptor, but we want to do
byte-based arithmetic, and not sizeof(struct mv_xor_v2_descriptor)
based arithmetic. Though I admit it's a bit ugly, I'll try to see if we
can't simply use normal sizeof(struct mv_xor_v2_descriptor)
based arithmetic.

> 
> > +			(xor_dev->desc_size * desq_ptr));
> > +
> > +	memcpy(dest_hw_desc, &sw_desc->hw_desc, xor_dev->desc_size);
> > +
> > +	/* update the DMA Engine with the new descriptor */
> > +	mv_xor_v2_add_desc_to_desq(xor_dev, 1);
> > +
> > +	/* unlock enqueue DESCQ */
> > +	spin_unlock_bh(&xor_dev->push_lock);
> 
> and if IIUC, you are pushing this to HW as well, that is not quite right if
> thats the case. We need to do this in issue_pending

issue_pending is already starting the DMA engine, which will process
the descriptors that have been queued in ->tx_submit.

Of course, if the DMA engine is already running, then the descriptors
might be processed right after they are added in the queue in
->tx_submit().

We are using the same scheme in mv_xor.c (not to say that mv_xor.c
doesn't need to be fixed, but it explains why we're using this logic in
mv_xor_v2.c).

> > +static struct dma_async_tx_descriptor *
> > +mv_xor_v2_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
> > +		       unsigned int src_cnt, size_t len, unsigned long flags)
> > +{
> > +	struct mv_xor_v2_sw_desc	*sw_desc;
> > +	struct mv_xor_v2_descriptor	*hw_descriptor;
> > +	struct mv_xor_v2_device		*xor_dev;
> > +	int i;
> > +
> > +	BUG_ON(src_cnt > MV_XOR_V2_CMD_LINE_NUM_MAX_D_BUF || src_cnt < 1);
> 
> why BUG_ON, is the system unusable after this?

Well, the XOR engine cannot do XOR with 0 source buffers, or with more
than MV_XOR_V2_CMD_LINE_NUM_MAX_D_BUF.

But I see that I'm already setting max_xor in struct dma_device, so one
can assume that ->prep_dma_xor() will not be called with src_cnt == or
src_cnt > max_xor, so this BUG_ON can be removed.

> > +/*
> > + * poll for a transaction completion
> > + */
> > +static enum dma_status mv_xor_v2_tx_status(struct dma_chan *chan,
> > +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> > +{
> > +	/* return the transaction status */
> > +	return dma_cookie_status(chan, cookie, txstate);
> 
> why not assign this as you status callback?

Right, will do.

> > +static void mv_xor_v2_issue_pending(struct dma_chan *chan)
> > +{
> > +	struct mv_xor_v2_device *xor_dev =
> > +		container_of(chan, struct mv_xor_v2_device, dmachan);
> > +
> > +	/* Activate the channel */
> > +	writel(0, xor_dev->dma_base + DMA_DESQ_STOP_OFF);
> 
> what if channel is already running?

It will continue to run. Datasheet says: "Reset this bit to enable the
XOR unit (DESQ). Set this bit to disable (or Stop) the XOR unit." So as
long as we write 0, the engine will continue processing descriptors.

> > +static void mv_xor_v2_tasklet(unsigned long data)
> > +{
> > +	struct mv_xor_v2_device *xor_dev = (struct mv_xor_v2_device *) data;
> > +	int pending_ptr, num_of_pending, i;
> > +	struct mv_xor_v2_descriptor *next_pending_hw_desc = NULL;
> > +	struct mv_xor_v2_sw_desc *next_pending_sw_desc = NULL;
> > +
> > +	dev_dbg(xor_dev->dmadev.dev, "%s %d\n", __func__, __LINE__);
> > +
> > +	/* get thepending descriptors parameters */
> 
> space after the pls

Absolutely.

> > +static struct platform_driver mv_xor_v2_driver = {
> > +	.probe		= mv_xor_v2_probe,
> > +	.remove		= mv_xor_v2_remove,
> > +	.driver		= {
> > +		.owner	= THIS_MODULE,
> 
> I dont think we need this

This was already fixed in v2:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409404.html

Thanks for the review! There are a few questions from you in the above
discussion, I'll wait for your feedback to submit a v3 that includes
your suggested fixes.

Thanks again!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
