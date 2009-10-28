From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 28 Oct 2009 15:35:03 +0000
Subject: [PATCH 1/2] Add COH 901 318 DMA block driver v3
In-Reply-To: <1256743137-16987-1-git-send-email-linus.walleij@stericsson.com>
References: <1256743137-16987-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20091028153503.11018cbe@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +struct dma_chan;
> +struct platform_device;
> +struct dma_chan;
> +struct dma_async_tx_descriptor;
> +enum dma_data_direction;

Surely it would be better to get the headers included in the right order ?

> +	dev_buf = kmalloc(4*1024, GFP_KERNEL);
> +
> +	snprintf(tmp, 50, "DMA -- enable dma channels\n");
> +	strcat(dev_buf, tmp);

Out of memory - NULL - bang

> +
> +	for (i = 0; i < debugfs_dma_base->platform->max_channels; i++) {
> +		if (started_channels & (1 << i)) {
> +			snprintf(tmp, 50, "channel %d\n", i);
> +			strcat(dev_buf, tmp);

Why not do this without the copies ? 

		x += snprintf(x, .., .....)

> +	if (*f_pos + count > dev_size)
> +		count = dev_size - *f_pos;

Overflow ? or is your offset protected elsewhere from lseek/large count ?



> +	pm->started_channels &= ~((u64)1 << cohc->id);

1ULL is perhaps cleaner ?


> +	void *virtbase = cohc->base->virtbase;

These should probably be __iomem to keep sparse happy ?


> +static int __init coh901318_probe(struct platform_device *pdev)
> +{

> +	base = kmalloc(ALIGN(sizeof(struct coh901318_base), 4) +
> +		       pdata->max_channels *
> +		       sizeof(struct coh901318_chan),
> +		       GFP_KERNEL);
> +	base->chans = ((void *)base) + ALIGN(sizeof(struct coh901318_base), 4);
> +
> +	if (!base)
> +		goto err_alloc_coh_dma_channels;

I'd swap those two over 8)

> +	err = request_irq(irq, dma_irq_handler, IRQF_DISABLED,
> +			  "coh901318", base);

You pass base here


> + err_pool_create:
> +	free_irq(platform_get_irq(pdev, 0), NULL);

So need to do likewise here

> +static int __exit coh901318_remove(struct platform_device *pdev)
> +{
> +	struct coh901318_base *base = platform_get_drvdata(pdev);
> +
> +	dma_async_device_unregister(&base->dma_memcpy);
> +	dma_async_device_unregister(&base->dma_slave);
> +	coh901318_pool_destroy(&base->pool);
> +	free_irq(platform_get_irq(pdev, 0), NULL);

and here
