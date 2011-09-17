From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 16:02:46 +0100
Subject: [PATCH v2] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
References: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110917150246.GH16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 02:56:00AM -0700, Barry Song wrote:
> +static int sirfsoc_dma_slave_config(struct sirfsoc_dma_chan *schan,
> +	struct dma_slave_config *config)
> +{
> +	u32 addr, direction;
> +	unsigned long flags;
> +
> +	switch (config->direction) {

config->direction is deprecated, please don't use it.

> +	case DMA_FROM_DEVICE:
> +		direction = 0;
> +		addr = config->dst_addr;
> +		break;
> +
> +	case DMA_TO_DEVICE:
> +		direction = 1;
> +		addr = config->src_addr;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if ((config->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
> +		(config->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&schan->lock, flags);
> +	schan->addr = addr;
> +	schan->direction = direction;
> +	schan->mode = (config->src_maxburst == 4 ? 1 : 0);

Please store the source address, destination address, and mode separately
for each direction.  You should then select from that at prepare time.
