From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 9 Apr 2015 11:09:07 +0300
Subject: [PATCH v4 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
In-Reply-To: <20150408152349.GD26727@lukather>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
 <1428498892-28471-4-git-send-email-peter.ujfalusi@ti.com>
 <20150408152349.GD26727@lukather>
Message-ID: <552633A3.3070909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static inline void ti_dma_xbar_write(void __iomem *iomem, int xbar, int val)
>> +{
>> +	writew_relaxed(val, iomem + (xbar * 2));
> 
> Silently casting val (an integer) to a u16 isn't really nice I
> guess. At least you could be upfront about it in the prototype.

The value in val is guarantied not to overflow the u16, but sure, I can change
this.

>> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>> +	if (!dma_spec->np) {
>> +		dev_err(&pdev->dev, "Can't get DMA master\n");
>> +		return NULL;
>> +	}
>> +
>> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
>> +	if (!map)
>> +		return NULL;
> 
> You're leaking dma_spec->np.

If kzalloc fails we have other things to worry about, but true, I'll
restructure the code to avoid leaking the node.

>> +	dma_node = of_parse_phandle(node, "dma-masters", 0);
>> +	if (!dma_node) {
>> +		dev_err(&pdev->dev, "Can't get DMA master node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
>> +	if (!xbar)
>> +		return -ENOMEM;
> 
> And here too.

same here, I'll change the code to not leak.

> 
>> +	if (of_property_read_u32(dma_node, "dma-requests",
>> +				 &xbar->dma_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing XBAR output information, using %u.\n",
>> +			 TI_XBAR_OUTPUTS);
>> +		xbar->dma_requests = TI_XBAR_OUTPUTS;
>> +	}
>> +	of_node_put(dma_node);
>> +
>> +	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing XBAR input information, using %u.\n",
>> +			 TI_XBAR_INPUTS);
>> +		xbar->xbar_requests = TI_XBAR_INPUTS;
>> +	}
>> +
>> +	if (of_property_read_u32(node, "ti,dma-safe-map", &xbar->safe_val))
>> +		xbar->safe_val = 0;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
>> +				     dev_name(&pdev->dev)))
>> +		return -ENODEV;
>> +
>> +	iomem = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +	if (!iomem)
>> +		return -ENOMEM;
> 
> You can use devm_ioremap_resource here.

I tend to forgot about this...

>> +	xbar->iomem = iomem;
>> +
>> +	xbar->dmarouter.dev = &pdev->dev;
>> +	xbar->dmarouter.route_free = ti_dma_xbar_free;
>> +
>> +	platform_set_drvdata(pdev, xbar);
>> +
>> +	ret = of_dma_router_register(node, ti_dma_xbar_route_allocate,
>> +				     &xbar->dmarouter);
>> +	if (ret)
>> +		return -ENODEV;
> 
> Starting here, I'd expect that your driver can be used....
> 
>> +
>> +	/* Reset the crossbar */
>> +	for (i = 0; i < xbar->dma_requests; i++)
>> +		ti_dma_xbar_write(xbar->iomem, i, xbar->safe_val);
> 
> ... however, the hardware doesn't seem ready. Isn't it a race?

True, will change the order.

Thanks,
P?ter
