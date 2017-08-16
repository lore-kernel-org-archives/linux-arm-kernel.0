From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Aug 2017 22:17:09 +0530
Subject: [PATCH v3 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <1501062502-18778-3-git-send-email-pierre-yves.mordret@st.com>
References: <1501062502-18778-1-git-send-email-pierre-yves.mordret@st.com>
 <1501062502-18778-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170816164709.GR3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 11:48:20AM +0200, Pierre-Yves MORDRET wrote:

> +/* MDMA Channel x transfer configuration register */
> +#define STM32_MDMA_CTCR(x)		(0x50 + 0x40 * (x))
> +#define STM32_MDMA_CTCR_BWM		BIT(31)
> +#define STM32_MDMA_CTCR_SWRM		BIT(30)
> +#define STM32_MDMA_CTCR_TRGM_MSK	GENMASK(29, 28)
> +#define STM32_MDMA_CTCR_TRGM(n)		(((n) & 0x3) << 28)
> +#define STM32_MDMA_CTCR_TRGM_GET(n)	(((n) & STM32_MDMA_CTCR_TRGM_MSK) >> 28)

OK this seems oft repeated here.

So you are trying to extract the bit values and set the bit value, so why
not this do generically...

#define STM32_MDMA_SHIFT(n)		(ffs(n) - 1))
#define STM32_MDMA_SET(n, mask)		((n) << STM32_MDMA_SHIFT(mask))
#define STM32_MDMA_GET(n, mask)		(((n) && mask) >> STM32_MDMA_SHIFT(mask))

Basically, u extract the shift using the mask value and ffs helping out, so
no need to define these and reduce chances of coding errors...

> +static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
> +				enum dma_slave_buswidth width)
> +{
> +	switch (width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		return ffs(width) - 1;
> +	default:
> +		dev_err(chan2dev(chan), "Dma bus width not supported\n");

please log the width here, helps in debug...

> +static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
> +				     enum dma_slave_buswidth width)
> +{
> +	u32 best_burst = max_burst;
> +	u32 burst_len = best_burst * width;
> +
> +	while ((burst_len > 0) && (tlen % burst_len)) {
> +		best_burst = best_burst >> 1;
> +		burst_len = best_burst * width;
> +	}
> +
> +	return (best_burst > 0) ? best_burst : 1;

when would best_burst <= 0? DO we really need this check


> +static struct dma_async_tx_descriptor *
> +stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
> +			   size_t buf_len, size_t period_len,
> +			   enum dma_transfer_direction direction,
> +			   unsigned long flags)
> +{
> +	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> +	struct dma_slave_config *dma_config = &chan->dma_config;
> +	struct stm32_mdma_desc *desc;
> +	dma_addr_t src_addr, dst_addr;
> +	u32 ccr, ctcr, ctbr, count;
> +	int i, ret;
> +
> +	if (!buf_len || !period_len || period_len > STM32_MDMA_MAX_BLOCK_LEN) {
> +		dev_err(chan2dev(chan), "Invalid buffer/period len\n");
> +		return NULL;
> +	}
> +
> +	if (buf_len % period_len) {
> +		dev_err(chan2dev(chan), "buf_len not multiple of period_len\n");
> +		return NULL;
> +	}
> +
> +	/*
> +	 * We allow to take more number of requests till DMA is
> +	 * not started. The driver will loop over all requests.
> +	 * Once DMA is started then new requests can be queued only after
> +	 * terminating the DMA.
> +	 */
> +	if (chan->busy) {
> +		dev_err(chan2dev(chan), "Request not allowed when dma busy\n");
> +		return NULL;
> +	}

is that a HW restriction? Once a txn is completed can't we submit
subsequent txn..? Can you explain this part please.

> +	if (len <= STM32_MDMA_MAX_BLOCK_LEN) {
> +		cbndtr |= STM32_MDMA_CBNDTR_BNDT(len);
> +		if (len <= STM32_MDMA_MAX_BUF_LEN) {
> +			/* Setup a buffer transfer */
> +			tlen = len;
> +			ccr |= STM32_MDMA_CCR_TCIE | STM32_MDMA_CCR_CTCIE;
> +			ctcr |= STM32_MDMA_CTCR_TRGM(STM32_MDMA_BUFFER);
> +			ctcr |= STM32_MDMA_CTCR_TLEN((tlen - 1));
> +		} else {
> +			/* Setup a block transfer */
> +			tlen = STM32_MDMA_MAX_BUF_LEN;
> +			ccr |= STM32_MDMA_CCR_BTIE | STM32_MDMA_CCR_CTCIE;
> +			ctcr |= STM32_MDMA_CTCR_TRGM(STM32_MDMA_BLOCK);
> +			ctcr |= STM32_MDMA_CTCR_TLEN(tlen - 1);
> +		}
> +
> +		/* Set best burst size */
> +		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;

that maynot be best.. we should have wider and longer burst for best
throughput..

> +	ret = device_property_read_u32(&pdev->dev, "dma-requests",
> +				       &nr_requests);
> +	if (ret) {
> +		nr_requests = STM32_MDMA_MAX_REQUESTS;
> +		dev_warn(&pdev->dev, "MDMA defaulting on %i request lines\n",
> +			 nr_requests);
> +	}
> +
> +	count = of_property_count_u32_elems(of_node, "st,ahb-addr-masks");

We dont have device_property_xxx for this?

> +	if (count < 0)
> +		count = 0;
> +
> +	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev) + sizeof(u32) * count,
> +			      GFP_KERNEL);
> +	if (!dmadev)
> +		return -ENOMEM;
> +
> +	dmadev->nr_channels = nr_channels;
> +	dmadev->nr_requests = nr_requests;
> +	of_property_read_u32_array(of_node, "st,ahb-addr-masks",
> +				   dmadev->ahb_addr_masks,
> +				   count);

i know we have an device api for array reads :)
and I think that helps in former case..

-- 
~Vinod
