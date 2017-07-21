From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jul 2017 13:25:47 +0530
Subject: [PATCH v2 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <1499343941-6375-3-git-send-email-pierre-yves.mordret@st.com>
References: <1499343941-6375-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343941-6375-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170721075547.GO3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 02:25:39PM +0200, Pierre-Yves MORDRET wrote:

> +config STM32_MDMA
> +	bool "STMicroelectronics STM32 master dma support"
> +	depends on ARCH_STM32  || COMPILE_TEST
			    ^^^
why multiple spaces

> +static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
> +{
> +	enum dma_slave_buswidth max_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +
> +	while (((buf_len % max_width) || (tlen < max_width)) &&
> +	       (max_width > DMA_SLAVE_BUSWIDTH_1_BYTE))
> +		max_width = max_width >> 1;

ok, this is a bit hard to read...

> +static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
> +				     enum dma_transfer_direction direction,
> +				     u32 *mdma_ccr, u32 *mdma_ctcr,
> +				     u32 *mdma_ctbr, u32 buf_len)
> +{
> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> +	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
> +	enum dma_slave_buswidth src_addr_width, dst_addr_width;
> +	phys_addr_t src_addr, dst_addr;
> +	int src_bus_width, dst_bus_width;
> +	u32 src_maxburst, dst_maxburst, src_best_burst, dst_best_burst;
> +	u32 ccr, ctcr, ctbr, tlen;
> +
> +	src_addr_width = chan->dma_config.src_addr_width;
> +	dst_addr_width = chan->dma_config.dst_addr_width;
> +	src_maxburst = chan->dma_config.src_maxburst;
> +	dst_maxburst = chan->dma_config.dst_maxburst;
> +	src_addr = chan->dma_config.src_addr;
> +	dst_addr = chan->dma_config.dst_addr;

this doesn't seem right to me, only the periphral address would come from
slave_config, the memory address is passed as an arg to transfer..

...

> +static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
> +				 struct stm32_mdma_desc *desc,
> +				 struct scatterlist *sgl, u32 sg_len,
> +				 enum dma_transfer_direction direction)
> +{
> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> +	struct dma_slave_config *dma_config = &chan->dma_config;
> +	struct scatterlist *sg;
> +	dma_addr_t src_addr, dst_addr;
> +	u32 ccr, ctcr, ctbr;
> +	int i, ret = 0;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		if (sg_dma_len(sg) > STM32_MDMA_MAX_BLOCK_LEN) {
> +			dev_err(chan2dev(chan), "Invalid block len\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = stm32_mdma_set_xfer_param(chan, direction, &ccr, &ctcr,
> +						&ctbr, sg_dma_len(sg));
> +		if (ret < 0)
> +			return ret;
> +
> +		if (direction == DMA_MEM_TO_DEV) {
> +			src_addr = sg_dma_address(sg);
> +			dst_addr = dma_config->dst_addr;

and this seems correct, but then why are we doing it in
stm32_mdma_set_xfer_param()

> +static struct dma_async_tx_descriptor *stm32_mdma_prep_slave_sg(
> +	struct dma_chan *c, struct scatterlist *sgl,
> +	u32 sg_len, enum dma_transfer_direction direction,
> +	unsigned long flags, void *context)

right justfied these please, it makes a terrible read

> +{
> +	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
> +	struct stm32_mdma_desc *desc;
> +	int ret;
> +
> +	desc = stm32_mdma_alloc_desc(chan, sg_len);
> +	if (!desc)
> +		return NULL;
> +
> +	ret = stm32_mdma_setup_xfer(chan, desc, sgl, sg_len, direction);
> +	if (ret < 0)
> +		goto xfer_setup_err;
> +
> +	desc->cyclic = false;
> +
> +	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> +
> +xfer_setup_err:
> +	dma_pool_free(chan->desc_pool, &desc->hwdesc, desc->hwdesc_phys);
> +	kfree(desc);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *stm32_mdma_prep_dma_cyclic(
> +	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
> +	size_t period_len, enum dma_transfer_direction direction,
> +	unsigned long flags)

here too and few other places

> +static int stm32_mdma_probe(struct platform_device *pdev)
> +{
> +	struct stm32_mdma_chan *chan;
> +	struct stm32_mdma_device *dmadev;
> +	struct dma_device *dd;
> +	struct device_node *of_node;
> +	struct resource *res;
> +	u32 nr_channels, nr_requests;
> +	int i, count, ret;
> +
> +	of_node = pdev->dev.of_node;
> +	if (!of_node)
> +		return -ENODEV;
> +
> +	ret = of_property_read_u32(of_node, "dma-channels", &nr_channels);
> +	if (ret)
> +		nr_channels = STM32_MDMA_MAX_CHANNELS;
> +
> +	ret = of_property_read_u32(of_node, "dma-requests", &nr_requests);
> +	if (ret)
> +		nr_requests = STM32_MDMA_MAX_REQUESTS;

wouldn't it make sense to print error about these properties not being
present and continuing w/ defaults..?

and can we have device_property_xxx instead of of_ variants?

> +static int __init stm32_mdma_init(void)
> +{
> +	return platform_driver_probe(&stm32_mdma_driver, stm32_mdma_probe);
> +}
> +
> +subsys_initcall(stm32_mdma_init);

Where are the MODULE_xx tags, license is mandatory. You should add author
too.
 

-- 
~Vinod
