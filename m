From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Mon, 18 Nov 2013 10:00:39 +0000
Subject: [PATCHv7] dmaengine: Add support for BCM2835
In-Reply-To: <5288E327.8050809@koalo.de>
References: <5288E327.8050809@koalo.de>
Message-ID: <1384768816.14845.186.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-11-17 at 16:39 +0100, Florian Meier wrote:
> Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> Currently it only supports cyclic DMA.

Few comments below.

> +++ b/drivers/dma/bcm2835-dma.c
> @@ -0,0 +1,736 @@

> +static int bcm2835_dma_abort(void __iomem *chan_base)
> +{
> +	unsigned long int cs;
> +	long int timeout = 10000;
> +
> +	cs = readl(chan_base + BCM2835_DMA_CS);
> +	if (!(cs & BCM2835_DMA_ACTIVE))
> +		return 0;
> +
> +	/* Write 0 to the active bit - Pause the DMA */
> +	writel(0, chan_base + BCM2835_DMA_CS);
> +
> +	/* Wait for any current AXI transfer to complete */
> +	while ((cs & BCM2835_DMA_ISPAUSED) && --timeout >= 0)
> +		cs = readl(chan_base + BCM2835_DMA_CS);

I actually don't see timeout here. timeout means counter in your case.
Might be better to have something like

while (readl(...) & BCM2835_DMA_ISPAUSED && --timeout)
cpu_relax();

?

> +	/* We'll un-pause when we set of our next DMA */
> +	if (cs & BCM2835_DMA_ISPAUSED)

if (!timeout)

> +		return -ETIMEDOUT;


> +
> +	if (!(cs & BCM2835_DMA_ACTIVE))
> +		return 0;

Duplicate code. Perhaps
static inline bool is_chan_not_active(unsigned long cs)
{
return !(cs & BCM2835_DMA_ACTIVE);
}

[]

> +static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> +{

[]

> +	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);

Since it's duplicate code, perhaps

static inline void set_chan_active(void __iomem *base)
{
writel(BCM2835_DMA_ACTIVE, base + BCM2835_DMA_CS);
}

[]

> +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> +{
> +	unsigned i;

In some cases you use 'unsigned long int' for 'unsigned long', for
example, but here 'unsigned' instead of 'unsigned int'. Please, align
style with certain choice.

[]

> +static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{

[]

> +	} else {
> +		txstate->residue = 0;

Useless assignment since dmaengine will do this for you in
dma_cookie_status.

[]

> +static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
> +	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +	size_t period_len, enum dma_transfer_direction direction,
> +	unsigned long flags, void *context)
> +{

[]

> +	/* Grab configuration */
> +	if (direction == DMA_DEV_TO_MEM) {
> +		dev_addr = c->cfg.src_addr;
> +		dev_width = c->cfg.src_addr_width;
> +		sync_type = BCM2835_DMA_S_DREQ;
> +	} else if (direction == DMA_MEM_TO_DEV) {
> +		dev_addr = c->cfg.dst_addr;
> +		dev_width = c->cfg.dst_addr_width;
> +		sync_type = BCM2835_DMA_D_DREQ;
> +	} else {
> +		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
> +		return NULL;
> +	}

You might use following as well

if (!is_slave_direction) {
 dev_err(...);
 return NULL;
}

if (direction == DMA_DEV_TO_MEM)
{
...
} else {
...
}

?

At least it will be aligned with what you have further in this function.

> +	/* Bus width translates to the element size (ES) */
> +	switch (dev_width) {
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		es = BCM2835_DMA_DATA_TYPE_S32;
> +		break;
> +	default:
> +		return NULL;
> +	}

So, you use switch-case on hope to extend it later, correct?

[]

> +static int bcm2835_dma_terminate_all(struct bcm2835_chan *c)
> +{
> +	struct bcm2835_dmadev *d = to_bcm2835_dma_dev(c->vc.chan.device);
> +	unsigned long flags;
> +	int timeout = 1000;
> +	LIST_HEAD(head);

[]

> +	if (c->desc) {
> +		c->desc = NULL;
> +		bcm2835_dma_abort(c->chan_base);
> +
> +		/* Wait for stopping */
> +		while (timeout > 0) {
> +			timeout--;

while (--timeout)

> +			if (!(readl(c->chan_base + BCM2835_DMA_CS) &
> +						BCM2835_DMA_ACTIVE))
> +				break;
> +
> +			cpu_relax();
> +		}
> +
> +		if (timeout <= 0)

if (!timeout)

[]

> +static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
> +					   struct of_dma *ofdma)
> +{
> +	struct bcm2835_dmadev *d = ofdma->of_dma_data;
> +	struct dma_chan *chan, *candidate;
> +
> +retry:
> +	candidate = NULL;
> +
> +	/* Walk the list of channels registered with the current instance and
> +	 * find one that is currently unused */
> +	list_for_each_entry(chan, &d->ddev.channels, device_node)
> +		if (chan->client_count == 0) {
> +			candidate = chan;
> +			break;
> +		}
> +
> +	if (!candidate)
> +		return NULL;
> +
> +	/* dma_get_slave_channel will return NULL if we lost a race between
> +	 * the lookup and the reservation */
> +	chan = dma_get_slave_channel(candidate);
> +
> +	if (chan) {

Perhaps

if (!chan)
goto retry;


> +		struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> +
> +		/* Set DREQ from param */
> +		c->dreq = spec->args[0];
> +
> +		return chan;
> +	}
> +
> +	goto retry;
> +}

> +static int bcm2835_dma_probe(struct platform_device *pdev)
> +{
> +	struct bcm2835_dmadev *od;
> +	struct resource *res;
> +	void __iomem *base;
> +	int rc;
> +	int i;
> +	int irq;
> +	uint32_t chans_available;

Why uint32_t?

[]

> +	if (pdev->dev.of_node) {

Perhaps

if (!...of_node) {
 ...
 return -EINVAL;
}

> +		/* Request DMA channel mask from device tree */
> +		if (of_property_read_u32(pdev->dev.of_node,
> +				"brcm,dma-channel-mask",
> +				&chans_available)) {
> +			dev_err(&pdev->dev, "Failed to get channel mask\n");
> +			bcm2835_dma_free(od);
> +			return -EINVAL;
> +		}
> +	} else {
> +		dev_err(&pdev->dev, "Failed to get channel mask. No device tree.\n");
> +		bcm2835_dma_free(od);
> +		return -EINVAL;
> +	}

> +	dev_dbg(&pdev->dev, "Initialized %i DMA channels\n", i);
> +
> +	if (pdev->dev.of_node) {

Does it make sense?

> +		/* Device-tree DMA controller registration */
> +		rc = of_dma_controller_register(pdev->dev.of_node,
> +				bcm2835_dma_xlate, od);
> +		if (rc) {
> +			dev_err(&pdev->dev, "Failed to register DMA controller\n");
> +			bcm2835_dma_free(od);
> +			return rc;

goto err_no_dma;

> +		}
> +	}
> +
> +	rc = dma_async_device_register(&od->ddev);
> +	if (rc) {
> +		dev_err(&pdev->dev,
> +			"Failed to register slave DMA engine device: %d\n", rc);
> +		bcm2835_dma_free(od);
> +		return rc;

goto err_no_dma;

> +	}
> +
> +	dev_dbg(&pdev->dev, "Load BCM2835 DMA engine driver\n");


> +	return rc;

return 0;

err_no_dma:
bcm2835_dma_free(od);
return rc;

?


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
