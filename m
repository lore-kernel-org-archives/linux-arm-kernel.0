From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 Jun 2016 16:08:37 +0200
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160222032730.GU19598@localhost>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222032730.GU19598@localhost>
Message-ID: <20160615160837.64377829@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for the long delay, I've just sent a v3 of this patch series. I'm
commenting below the comments you made during your previous review.

On Mon, 22 Feb 2016 08:57:30 +0530, Vinod Koul wrote:

> > +	xor0 at 400000 {
> > +		compatible = "marvell,mv-xor-v2";
> > +		reg = <0x400000 0x1000>,
> > +		      <0x410000 0x1000>;
> > +		msi-parent = <&gic_v2m0>;
> > +		dma-coherent;
> > +	};  
> 
> This should be a separate patch :)

Fixed in v3.

> > +#define DMA_DESQ_STOP_OFF	0x800
> > +#define DMA_DESQ_DEALLOC_OFF	0x804
> > +#define DMA_DESQ_ADD_OFF	0x808  
> 
> Please namespace these and others. Something like MRVL_XOR_XXX or anyother
> patter you like would be fine...

Fixed in v3.

> > +/* descriptors queue size */
> > +#define MV_XOR_V2_MAX_DESC_NUM	1024  
> 
> Is this hardware defined?

No, so I've changed this to MV_XOR_V2_DESC_NUM, and added a comment to
explain what are the hardware limits (they depend on the descriptor
size).

> > +	/*
> > +	 * fill the buffer's addresses to the descriptor
> > +	 * The format of the buffers address for 2 sequential buffers X and X+1:  
> 
> space around + please.

Fixed in v3.

> > +		/* Set them if we have a 64 bits DMA address */
> > +		if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> > +			desc->data_buff_addr[arr_index + 2] |=
> > +				upper_32_bits(src) & 0xFFFF;  
> 
> So why should it depend on how kernel is configured?

Since the driver now depends on ARM64, CONFIG_ARCH_DMA_ADDR_T_64BIT is
always y, so I've dropped those conditions.

> > + * Return the next available index in the DESQ.
> > + */
> > +static inline int mv_xor_v2_get_desq_write_ptr(struct mv_xor_v2_device *xor_dev)  
> 
> Pls wrap with 80 chars wherever it is reasonable

Done in v3.

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

Done in v3.

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

Ditto.

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

As we discussed, I've added a check that the number of pending
descriptors to process is not 0.

> > +	/* lock enqueue DESCQ */
> > +	spin_lock_bh(&xor_dev->push_lock);  
> 
> Why not a generic channel lock which is used in submit, issue_pending and
> tasklet. What is the reason for opting different locks?

I've changed to use a single spinlock per channel.

> > +	/* get the next available slot in the DESQ */
> > +	desq_ptr = mv_xor_v2_get_desq_write_ptr(xor_dev);
> > +
> > +	/* copy the HW descriptor from the SW descriptor to the DESQ */
> > +	dest_hw_desc = ((void *)xor_dev->hw_desq_virt +  
> 
> cast to and away from void are not required

Correct, I've simplified that in v3.

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

This is probably the only thing that I have not changed. The mv_xor
driver is already using the same strategy, and enqueuing in
issue_pending() would force us to add the request to a temporary linked
list, which would be dequeued in issue_pending(). This is quite a bit
of additional processing, while pushing the new requests directly to
the engine works fine.

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

Changed in v3 to regular error checking (i.e. returning NULL).

> > +static enum dma_status mv_xor_v2_tx_status(struct dma_chan *chan,
> > +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> > +{
> > +	/* return the transaction status */
> > +	return dma_cookie_status(chan, cookie, txstate);  
> 
> why not assign this as you status callback?

Done in v3.

> > +static void mv_xor_v2_issue_pending(struct dma_chan *chan)
> > +{
> > +	struct mv_xor_v2_device *xor_dev =
> > +		container_of(chan, struct mv_xor_v2_device, dmachan);
> > +
> > +	/* Activate the channel */
> > +	writel(0, xor_dev->dma_base + DMA_DESQ_STOP_OFF);  
> 
> what if channel is already running?

It will keep running. Writing 0 to this register activates the channel
if not already activated, and if already activated, the engine keeps
running.

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

Done in v3.

> 
> > +static struct platform_driver mv_xor_v2_driver = {
> > +	.probe		= mv_xor_v2_probe,
> > +	.remove		= mv_xor_v2_remove,
> > +	.driver		= {
> > +		.owner	= THIS_MODULE,  
> 
> I dont think we need this

Was already fixed in v2, so it's fixed in v3 as well.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
