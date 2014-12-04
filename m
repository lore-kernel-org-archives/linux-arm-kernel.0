From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Thu, 04 Dec 2014 08:57:06 +0000
Subject: [alsa-devel] [PATCH 1/5] ASoC: dwc: Allocate resources with
 devm_ioremap_resource
In-Reply-To: <547F3DD0.10405@metafoo.de>
References: <547F3C96.9070509@arm.com> <547F3DD0.10405@metafoo.de>
Message-ID: <548021E2.2080506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 16:44, Lars-Peter Clausen wrote:
> On 12/03/2014 05:38 PM, Andrew Jackson wrote:
> [,,,[
>> +	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
>> +	if (!dw_i2s_dai) {
>> +		dev_err(&pdev->dev, "mem allocation failed for dai driver\n");
> 
> All the memory alloc functions already print a error message.

I will remove the error message(s).

>>   		return -ENOMEM;
>>   	}
>>
>> +	dw_i2s_dai->ops = &dw_i2s_dai_ops;
>> +	dw_i2s_dai->suspend = dw_i2s_suspend;
>> +	dw_i2s_dai->resume = dw_i2s_resume;
> 
> This seems to be separate from the devm_ioremap_resource() change.

It seemed reasonable to assign these known values to the dw_i2s_dai as soon as it had been allocated. Would you prefer this in a separate patch?

>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
> 
> You don't actually have to check it devm_ioremap_resource does this for you.

Oh, thanks, paranoia was taking over.

>> +		dev_err(&pdev->dev, "no i2s resource defined\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(dev->i2s_base)) {
>> +		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
> 
> Same here devm_ioremap_resource() will already print a appropriate error 
> message.
> 
>> +		return PTR_ERR(dev->i2s_base);
>> +	}
> 
> 
