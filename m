From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 26 Jul 2017 07:38:02 +0000
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <20170726052930.GF3053@localhost>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
 <20170726052930.GF3053@localhost>
Message-ID: <f2908e38-dc4d-3886-4058-52a7ad845415@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/26/2017 07:29 AM, Vinod Koul wrote:
> On Mon, Jul 24, 2017 at 01:55:10PM +0000, Pierre Yves MORDRET wrote:
> 
>>>> +
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	if (!res)
>>>> +		return -ENODEV;
>>>> +
>>>> +	iomem = devm_ioremap_resource(&pdev->dev, res);
>>>> +	if (!iomem)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	spin_lock_init(&stm32_dmamux->lock);
>>>> +
>>>> +	stm32_dmamux->clk = devm_clk_get(&pdev->dev, NULL);
>>>> +	if (IS_ERR(stm32_dmamux->clk)) {
>>>> +		dev_info(&pdev->dev, "Missing controller clock\n");
>>>
>>> Can you check for EPROBE_DEFER and print only for if that is not the error
>>> otherwise we end up sapmming with defered probe issues
>>>
>>
>> This is what you meant ?
>> 	if (IS_ERR(stm32_dmamux->clk) != EPROBE_DEFER) {
>> 		dev_info(&pdev->dev, "Missing controller clock\n");
>> 		return PTR_ERR(stm32_dmamux->clk);
>> 	}
>>
>> OR
>>
>> 	if (IS_ERR(stm32_dmamux->clk)) {
>> 		if (IS_ERR(stm32_dmamux->clk) != EPROBE_DEFER)
>> 			dev_info(&pdev->dev, "Missing controller clock\n");
>> 		return PTR_ERR(stm32_dmamux->clk);
>> 	}
> 
> This one please
> 

ok

>>
>>>> +
>>>> +#ifndef __DMA_STM32_DMAMUX_H
>>>> +#define __DMA_STM32_DMAMUX_H
>>>> +
>>>> +#if defined(CONFIG_STM32_DMAMUX)
>>>> +int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id);
>>>
>>> Why do we need a custom API in this case?
>>>
>>
>> This API is called by DMA when a slave is requested by client. DMA can work
>> without DMAMUX this API has been put in place to configure DMAMUX whether client
>> is requesting a DMAMUX Channel instead of a DMA one.
> 
> You mean the dmaengine driver right?
> 

Yes. The API is mainly called by "device_config" through out STM32 DMA Driver
when a router is in place for client.
Please refer to Patch 4/5 on this set.

Thanks
Py
