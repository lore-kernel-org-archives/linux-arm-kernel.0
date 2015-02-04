From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 Feb 2015 19:12:41 -0800
Subject: [PATCH v4] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <1422745124-22103-2-git-send-email-emilio@elopez.com.ar>
References: <1422745124-22103-1-git-send-email-emilio@elopez.com.ar>
 <1422745124-22103-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20150204031241.GJ4489@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 07:58:44PM -0300, Emilio L?pez wrote:

> +/** Dedicated DMA register layout **/
> +
> +/* Dedicated DMA configuration register layout */
> +#define DDMA_CFG_LOADING			BIT(31)
> +#define DDMA_CFG_BUSY				BIT(30)
> +#define DDMA_CFG_CONT_MODE			BIT(29)
> +#define DDMA_CFG_DEST_NON_SECURE		BIT(28)
> +#define DDMA_CFG_DEST_DATA_WIDTH(width)		((width) << 25)
> +#define DDMA_CFG_DEST_BURST_LENGTH(len)		((len) << 23)
> +#define DDMA_CFG_DEST_ADDR_MODE(mode)		((mode) << 21)
> +#define DDMA_CFG_DEST_DRQ_TYPE(type)		((type) << 16)
> +#define DDMA_CFG_BYTE_COUNT_MODE_REMAIN		BIT(15)
> +#define DDMA_CFG_SRC_NON_SECURE			BIT(12)
> +#define DDMA_CFG_SRC_DATA_WIDTH(width)		((width) << 9)
> +#define DDMA_CFG_SRC_BURST_LENGTH(len)		((len) << 7)
> +#define DDMA_CFG_SRC_ADDR_MODE(mode)		((mode) << 5)
> +#define DDMA_CFG_SRC_DRQ_TYPE(type)		((type) << 0)
> +
> +/* Dedicated DMA parameter register layout */
> +#define DDMA_PARA_DEST_DATA_BLK_SIZE(n)		(((n) - 1) << 24)
> +#define DDMA_PARA_DEST_WAIT_CYCLES(n)		(((n) - 1) << 16)
> +#define DDMA_PARA_SRC_DATA_BLK_SIZE(n)		(((n) - 1) << 8)
> +#define DDMA_PARA_SRC_WAIT_CYCLES(n)		(((n) - 1) << 0)
> +
> +/** DMA register offsets **/
> +
> +/* General register offsets */
> +#define DMA_IRQ_ENABLE_REG			0x0
> +#define DMA_IRQ_PENDING_STATUS_REG		0x4
> +
> +/* Normal DMA register offsets */
> +#define NDMA_CHANNEL_REG_BASE(n)		(0x100 + (n) * 0x20)
> +#define NDMA_CFG_REG				0x0
> +#define NDMA_SRC_ADDR_REG			0x4
> +#define NDMA_DEST_ADDR_REG			0x8
> +#define NDMA_BYTE_COUNT_REG			0xC
> +
> +/* Dedicated DMA register offsets */
> +#define DDMA_CHANNEL_REG_BASE(n)		(0x300 + (n) * 0x20)
> +#define DDMA_CFG_REG				0x0
> +#define DDMA_SRC_ADDR_REG			0x4
> +#define DDMA_DEST_ADDR_REG			0x8
> +#define DDMA_BYTE_COUNT_REG			0xC
> +#define DDMA_PARA_REG				0x18
All these should be namespaced to avoid future conflicts

> +
> +/** DMA Driver **/
> +
> +/*
> + * Normal DMA has 8 channels, and Dedicated DMA has another 8, so that's
> + * 16 channels. As for endpoints, there's 29 and 21 respectively. Given
> + * that the Normal DMA endpoints (other than SDRAM) can be used as tx/rx,
> + * we need 78 vchans in total
> + */
> +#define NDMA_NR_MAX_CHANNELS	8
> +#define DDMA_NR_MAX_CHANNELS	8
> +#define DMA_NR_MAX_CHANNELS	(NDMA_NR_MAX_CHANNELS + DDMA_NR_MAX_CHANNELS)
> +#define NDMA_NR_MAX_VCHANS	(29 * 2 - 1)
> +#define DDMA_NR_MAX_VCHANS	21
> +#define DMA_NR_MAX_VCHANS	(NDMA_NR_MAX_VCHANS + DDMA_NR_MAX_VCHANS)
> +
> +/* This set of DDMA timing parameters were found experimentally while
> + * working with the SPI driver and seem to make it behave correctly */
> +#define DDMA_MAGIC_SPI_PARAMETERS	(DDMA_PARA_DEST_DATA_BLK_SIZE(1) | \
> +					DDMA_PARA_SRC_DATA_BLK_SIZE(1) | \
> +					DDMA_PARA_DEST_WAIT_CYCLES(2) | \
> +					DDMA_PARA_SRC_WAIT_CYCLES(2))
This should ideally be configurable from SPI

> +
> +struct sun4i_dma_pchan {
> +	/* Register base of channel */
> +	void __iomem			*base;
> +	/* vchan currently being serviced */
> +	struct sun4i_dma_vchan		*vchan;
> +	/* Is this a dedicated pchan? */
> +	int				is_dedicated;
> +};
nitpick, it would be better if you follow kerneldoc for this struct comments
or add to same line. This is bit non intuitive here, or use empty lines


> +
> +static struct device *chan2dev(struct dma_chan *chan)
> +{
> +	return &chan->dev->device;
> +}
This should be in core..


> +static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
> +				   struct sun4i_dma_vchan *vchan)
> +{
> +	struct sun4i_dma_promise *promise = NULL;
> +	struct sun4i_dma_contract *contract = NULL;
> +	struct sun4i_dma_pchan *pchan;
> +	struct virt_dma_desc *vd;
> +	int ret;
> +
> +	lockdep_assert_held(&vchan->vc.lock);
> +
> +	/* We need a pchan to do anything, so secure one if available */
> +	pchan = find_and_use_pchan(priv, vchan);
> +	if (!pchan)
> +		return -EBUSY;
> +
> +	/*
> +	 * Channel endpoints must not be repeated, so if this vchan
> +	 * has already submitted some work, we can't do anything else
> +	 */
and shouldn't the search take care of this for you...
> +static struct sun4i_dma_promise *
> +generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
> +		      size_t len, struct dma_slave_config *sconfig)
> +{
> +	struct sun4i_dma_promise *promise;
> +	int ret;
> +
> +	promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
> +	if (!promise)
> +		return NULL;
> +
> +	promise->src = src;
> +	promise->dst = dest;
> +	promise->len = len;
> +	promise->cfg = NDMA_CFG_LOADING | NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
> +
> +	/* Use sensible default values if client is using undefined ones */
this doesn't make sense for slave

> +		/*
> +		 * These are the magic DMA engine timings that keep SPI going.
> +		 * I haven't seen any interface on DMAEngine to configure
> +		 * timings, and so far they seem to work for everything we
> +		 * support, so I've kept them here. I don't know if other
> +		 * devices need different timings because, as usual, we only
> +		 * have the "para" bitfield meanings, but no comment on what
> +		 * the values should be when doing a certain operation :|
> +		 */
> +		para = DDMA_MAGIC_SPI_PARAMETERS;
and that is why these shouldn't be here
> +
> +		/* And make a suitable promise */
> +		if (vchan->is_dedicated)
> +			promise = generate_ddma_promise(chan, srcaddr, dstaddr,
> +							sg_dma_len(sg), sconfig);
> +		else
> +			promise = generate_ndma_promise(chan, srcaddr, dstaddr,
> +							sg_dma_len(sg), sconfig);
> +
> +		if (!promise)
> +			return NULL; /* TODO: should we free everything? */
yes otherwise you leak..


> +
> +static int sun4i_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +			     unsigned long arg)
This needs to be updated to latest API..
> +{
> +	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
> +	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case DMA_RESUME:
> +	case DMA_PAUSE:
> +		ret = -EINVAL;
> +		break;
> +
> +	case DMA_TERMINATE_ALL:
> +		dev_dbg(chan2dev(chan), "Terminating everything on channel\n");
> +		ret = sun4i_dma_terminate_all(priv, vchan);
> +		break;
> +
> +	case DMA_SLAVE_CONFIG:
> +		memcpy(&vchan->cfg, (void *)arg, sizeof(vchan->cfg));
> +		break;
> +
> +	default:
> +		ret = -ENXIO;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

> +
> +static enum dma_status sun4i_dma_tx_status(struct dma_chan *chan,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *state)
> +{
> +	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
> +	struct sun4i_dma_pchan *pchan = vchan->pchan;
> +	struct sun4i_dma_contract *contract;
> +	struct sun4i_dma_promise *promise;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +	enum dma_status ret;
> +	size_t bytes = 0;
> +
> +	ret = dma_cookie_status(chan, cookie, state);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
before you proceed ahead check if state is null, if so bail out here.

> +
> +static int sun4i_dma_device_slave_caps(struct dma_chan *dchan,
> +				       struct dma_slave_caps *caps)
> +{
This needs update too


> +
> +static int sun4i_dma_remove(struct platform_device *pdev)
> +{
> +	struct sun4i_dma_dev *priv = platform_get_drvdata(pdev);
> +
> +	/* Disable IRQ so no more work is scheduled */
> +	disable_irq(priv->irq);
how about your tasklets, how do you ensure they have been completed
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&priv->slave);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
-- 
~Vinod
