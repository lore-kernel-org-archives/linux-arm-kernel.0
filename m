From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Mon, 24 Jul 2017 13:55:10 +0000
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <20170722065133.GT3053@localhost>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
Message-ID: <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/22/2017 08:51 AM, Vinod Koul wrote:
> On Thu, Jul 06, 2017 at 02:20:20PM +0200, Pierre-Yves MORDRET wrote:
>> +static int stm32_dmamux_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct device_node *dma_node;
>> +	struct stm32_dmamux_data *stm32_dmamux;
>> +	struct resource *res;
>> +	void __iomem *iomem;
>> +	int i, ret;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	stm32_dmamux = devm_kzalloc(&pdev->dev, sizeof(*stm32_dmamux),
>> +				    GFP_KERNEL);
>> +	if (!stm32_dmamux)
>> +		return -ENOMEM;
>> +
>> +	dma_node = of_parse_phandle(node, "dma-masters", 0);
>> +	if (!dma_node) {
>> +		dev_err(&pdev->dev, "Can't get DMA master node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (device_property_read_u32(&pdev->dev, "dma-channels",
>> +				     &stm32_dmamux->dmamux_channels))
>> +		stm32_dmamux->dmamux_channels = STM32_DMAMUX_MAX_CHANNELS;
>> +
>> +	if (device_property_read_u32(&pdev->dev, "dma-requests",
>> +				     &stm32_dmamux->dmamux_requests))
>> +		stm32_dmamux->dmamux_requests = STM32_DMAMUX_MAX_REQUESTS;
> 
> I think defaults should be warned here too
> 

ok

>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	iomem = devm_ioremap_resource(&pdev->dev, res);
>> +	if (!iomem)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&stm32_dmamux->lock);
>> +
>> +	stm32_dmamux->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(stm32_dmamux->clk)) {
>> +		dev_info(&pdev->dev, "Missing controller clock\n");
> 
> Can you check for EPROBE_DEFER and print only for if that is not the error
> otherwise we end up sapmming with defered probe issues
> 

This is what you meant ?
	if (IS_ERR(stm32_dmamux->clk) != EPROBE_DEFER) {
		dev_info(&pdev->dev, "Missing controller clock\n");
		return PTR_ERR(stm32_dmamux->clk);
	}

OR

	if (IS_ERR(stm32_dmamux->clk)) {
		if (IS_ERR(stm32_dmamux->clk) != EPROBE_DEFER)
			dev_info(&pdev->dev, "Missing controller clock\n");
		return PTR_ERR(stm32_dmamux->clk);
	}

>> +
>> +#ifndef __DMA_STM32_DMAMUX_H
>> +#define __DMA_STM32_DMAMUX_H
>> +
>> +#if defined(CONFIG_STM32_DMAMUX)
>> +int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id);
> 
> Why do we need a custom API in this case?
> 

This API is called by DMA when a slave is requested by client. DMA can work
without DMAMUX this API has been put in place to configure DMAMUX whether client
is requesting a DMAMUX Channel instead of a DMA one.

Thanks
Py
