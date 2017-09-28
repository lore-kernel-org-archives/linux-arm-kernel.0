From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 28 Sep 2017 15:17:49 +0200
Subject: [PATCH v4 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <20170928081310.GA30097@localhost>
References: <1503671466-32029-1-git-send-email-pierre-yves.mordret@st.com>
 <1503671466-32029-3-git-send-email-pierre-yves.mordret@st.com>
 <20170928081310.GA30097@localhost>
Message-ID: <1a869018-31e7-9fd4-2017-9c8cdd8c7d88@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/28/2017 10:13 AM, Vinod Koul wrote:
> On Fri, Aug 25, 2017 at 04:31:04PM +0200, Pierre-Yves MORDRET wrote:
>> +static int stm32_mdma_probe(struct platform_device *pdev)
>> +{
> 
> [snip]
> 
>> +	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev) + sizeof(u32) * count,
>> +			      GFP_KERNEL);
>> +	if (!dmadev)
>> +		return -ENOMEM;
>> +
>> +	dmadev->nr_channels = nr_channels;
>> +	dmadev->nr_requests = nr_requests;
>> +	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>> +				       dmadev->ahb_addr_masks,
>> +				       count);
>> +	dmadev->nr_ahb_addr_masks = count;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	dmadev->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(dmadev->base))
>> +		return PTR_ERR(dmadev->base);
>> +
>> +	dmadev->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(dmadev->clk)) {
>> +		dev_err(&pdev->dev, "Error: Missing controller clock\n");
>> +		return PTR_ERR(dmadev->clk);
>> +	}
> 
> I am assuming if clk is not availble at this point of time you return clk
> error which maybe defer probe, right?

Yes. So I will add an "if" statement as I did for DMAMUX
if (ret == -EPROBE_DEFER)
   dev_info .... (instead of dev_err)

> 
>> +static struct platform_driver stm32_mdma_driver = {
>> +	.driver = {
>> +		.name = "stm32-mdma",
>> +		.of_match_table = stm32_mdma_of_match,
>> +	},
>> +};
>> +
>> +static int __init stm32_mdma_init(void)
>> +{
>> +	return platform_driver_probe(&stm32_mdma_driver, stm32_mdma_probe);
> 
> and you register platform_driver_probe() which per
> drivers/base/platform.c:760 is incompatible with defer probing.
> So this need a fix
> 

Will change to platform_driver_register

Thanks and regards
