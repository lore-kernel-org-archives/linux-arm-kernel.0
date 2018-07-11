From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2018 08:24:34 +0200
Subject: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 12:23:10AM +0800, Robin Gong wrote:
> Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead
> of '0xffff'.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
> +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst,
> +		dma_addr_t dma_src, size_t len, unsigned long flags)
> +{
> +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> +	struct sdma_engine *sdma = sdmac->sdma;
> +	int channel = sdmac->channel;
> +	size_t count;
> +	int i = 0, param;
> +	struct sdma_buffer_descriptor *bd;
> +	struct sdma_desc *desc;
> +
> +	if (!chan || !len)
> +		return NULL;
> +
> +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
> +		&dma_src, &dma_dst, len, channel);
> +
> +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len / SDMA_BD_MAX_CNT
> +					+ 1);
> +	if (!desc)
> +		goto err_out;
> +
> +	do {
> +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);

When len is bigger than 0xffff you initialize count to 0xffff...

> +		bd = &desc->bd[i];
> +		bd->buffer_addr = dma_src;
> +		bd->ext_buffer_addr = dma_dst;
> +		bd->mode.count = count;
> +		desc->chn_count += count;
> +
> +		switch (sdmac->word_size) {
> +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +			bd->mode.command = 0;
> +			if ((count | dma_src | dma_dst) & 3)
> +				goto err_bd_out;
> +			break;

...In which case you bail out here with an error.

Please make sure bigger transfers are working.

> +		case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +			bd->mode.command = 2;
> +			if ((count | dma_src | dma_dst) & 1)
> +				goto err_bd_out;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +			bd->mode.command = 1;
> +			break;
> +		default:
> +			goto err_bd_out;
> +		}
> +
> +		dma_src += count;
> +		dma_dst += count;
> +		len -= count;
> +		i++;
> +
> +		param = BD_DONE | BD_EXTD | BD_CONT;

Probably better readable if you drop BD_CONT here and do a

	if (len) {
		param |= BD_CONT;
	} else  {
		...
	}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
