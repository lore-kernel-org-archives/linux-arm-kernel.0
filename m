From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 10:36:10 +0100
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
Message-ID: <20110725093610.GC9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 10:28:24AM +0900, Boojin Kim wrote:
> +static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
> +				struct samsung_dma_info *info)
> +{
> +	struct dma_chan *chan;
> +	dma_cap_mask_t mask;
> +	struct dma_slave_config slave_config;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(info->cap, mask);
> +
> +	chan = dma_request_channel(mask, pl330_filter, (void *)dma_ch);
> +
> +	if (info->direction == DMA_FROM_DEVICE) {
> +		memset(&slave_config, 0, sizeof(struct dma_slave_config));
> +		slave_config.direction = info->direction;
> +		slave_config.src_addr = info->fifo;
> +		slave_config.src_addr_width = info->width;

This should really set slave_config.src_maxburst to something sensible too,
even if that's just '1'.

> +		dmaengine_slave_config(chan, &slave_config);
> +	} else if (info->direction == DMA_TO_DEVICE) {
> +		memset(&slave_config, 0, sizeof(struct dma_slave_config));
> +		slave_config.direction = info->direction;
> +		slave_config.dst_addr = info->fifo;
> +		slave_config.dst_addr_width = info->width;

Ditto for dst_maxburst.

> +		dmaengine_slave_config(chan, &slave_config);
> +	}
> +
> +	return (unsigned)chan;

I hope these interfaces yet cleaned away soon so that these casts can be
killed off.

> +struct samsung_dma_prep_info {
> +	enum dma_transaction_type cap;
> +	enum dma_data_direction direction;
> +	unsigned buf;

dma_addr_t ?

> +	unsigned long period;
> +	unsigned long len;
> +	void (*fp)(void *data);
> +	void *fp_param;
> +};
> +
> +struct samsung_dma_info {
> +	enum dma_transaction_type cap;
> +	enum dma_data_direction direction;
> +	enum dma_slave_buswidth width;
> +	unsigned fifo;

dma_addr_t ?

> +	struct s3c2410_dma_client *client;
> +};
> +
> +struct samsung_dma_ops {
> +	bool init;

Unused?
