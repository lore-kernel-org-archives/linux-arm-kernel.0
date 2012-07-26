From: zonque@gmail.com (Daniel Mack)
Date: Thu, 26 Jul 2012 08:33:11 +0200
Subject: [PATCH 3/7] MTD: pxa3xx-nand: add devicetree bindings
In-Reply-To: <201207260259.51511.marek.vasut@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-4-git-send-email-zonque@gmail.com>
 <201207260259.51511.marek.vasut@gmail.com>
Message-ID: <5010E4A7.5020301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.07.2012 02:59, Marek Vasut wrote:
>> This patch contains a hack to get the DMA resources of the device when
>> probed from a devicetree node. This can be removed once a generic DMA
>> controller framework lands.
>>
>> A mtd_part_parser_data is passed mtd_device_parse_register which
>> contains a reference to the device node, so MTD partitions can be
>> added as children.
>>

>> +
>> +	nand0: nand at 43100000 {
>> +		compatible = "mrvl,pxa3xx-nand";
>> +		reg = <0x43100000 90> ;
> 
> 0x90 maybe?

No, mach-pxa/devices.c has 0x53 which would be 83. I chose 90 because
the register space up to 0x7c is unused. For some reason, lengths are
more likely given in dec than in hex.

> 
>> +		interrupts = <45>;
>> +		#address-cells = <1>;
>> +
>> +		mrvl,nand-enable-arbiter;
>> +		mrvl,nand-keep-config;
>> +		num-cs = <1>;
>> +
>> +		/* partitions (optional) */
>> +	};
>> +
>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c
>> b/drivers/mtd/nand/pxa3xx_nand.c index 252aaef..fb592a9 100644
>> --- a/drivers/mtd/nand/pxa3xx_nand.c
>> +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/io.h>
>>  #include <linux/irq.h>
>>  #include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>>
>>  #include <mach/dma.h>
>>  #include <plat/pxa3xx_nand.h>
>> @@ -1081,21 +1083,29 @@ static int alloc_nand_resource(struct
>> platform_device *pdev) }
>>  	clk_enable(info->clk);
>>
>> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> -	if (r == NULL) {
>> -		dev_err(&pdev->dev, "no resource defined for data DMA\n");
>> -		ret = -ENXIO;
>> -		goto fail_put_clk;
>> -	}
>> -	info->drcmr_dat = r->start;
>> +	/*
>> +	 * This is a dirty hack to make this driver work from devicetree
>> +	 * bindings. It can be removed once we have a prober DMA controller
>> +	 * framework for DT.
>> +	 */
>> +	if (pdev->dev.of_node && cpu_is_pxa3xx()) {
>> +		info->drcmr_dat = 97;
>> +		info->drcmr_cmd = 99;
> 
> cpu_is_() stuff should begone ... besides, what are these numbers here?

Hmm? Did you read the comment above this block and in the commit log?
The problem is that there is no generic DMA controller implementation
for DT, so we have to live with such hacks until this changes.



Daniel


> 
>> +	} else {
>> +		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> +		if (r == NULL) {
>> +			dev_err(&pdev->dev, "no resource defined for data 
> DMA\n");
>> +			ret = -ENXIO;
>> +			goto fail_put_clk;
>> +		}
>>
>> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>> -	if (r == NULL) {
>> -		dev_err(&pdev->dev, "no resource defined for command DMA\n");
>> -		ret = -ENXIO;
>> -		goto fail_put_clk;
>> +		r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>> +		if (r == NULL) {
>> +			dev_err(&pdev->dev, "no resource defined for command 
> DMA\n");
>> +			ret = -ENXIO;
>> +			goto fail_put_clk;
>> +		}
>>  	}
>> -	info->drcmr_cmd = r->start;
>>
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0) {
>> @@ -1200,12 +1210,55 @@ static int pxa3xx_nand_remove(struct
>> platform_device *pdev) return 0;
>>  }
>>
>> +#ifdef CONFIG_OF
>> +static struct of_device_id pxa3xx_nand_dt_ids[] = {
>> +	{ .compatible = "mrvl,pxa3xx-nand" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
>> +
>> +static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
>> +{
>> +	struct pxa3xx_nand_platform_data *pdata;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	const struct of_device_id *of_id =
>> +			of_match_device(pxa3xx_nand_dt_ids, &pdev->dev);
>> +
>> +	if (!of_id)
>> +		return 0;
>> +
>> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return -ENOMEM;
>> +
>> +	if (of_get_property(np, "mrvl,nand-enable-arbiter", NULL))
>> +		pdata->enable_arbiter = 1;
>> +	if (of_get_property(np, "mrvl,nand-keep-config", NULL))
> 
> of_property_read_bool() please.
> 
>> +		pdata->keep_config = 1;
>> +	of_property_read_u32(np, "num-cs", &pdata->num_cs);
>> +
>> +	pdev->dev.platform_data = pdata;
>> +
>> +	return 0;
>> +}
>> +#else
>> +static inline int pxa3xx_nand_probe_dt(struct platform_device *)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>  static int pxa3xx_nand_probe(struct platform_device *pdev)
>>  {
>>  	struct pxa3xx_nand_platform_data *pdata;
>> +	struct mtd_part_parser_data ppdata = {};
>>  	struct pxa3xx_nand_info *info;
>>  	int ret, cs, probe_success;
>>
>> +	ret = pxa3xx_nand_probe_dt(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	pdata = pdev->dev.platform_data;
>>  	if (!pdata) {
>>  		dev_err(&pdev->dev, "no platform data defined\n");
>> @@ -1229,8 +1282,9 @@ static int pxa3xx_nand_probe(struct platform_device
>> *pdev) continue;
>>  		}
>>
>> +		ppdata.of_node = pdev->dev.of_node;
>>  		ret = mtd_device_parse_register(info->host[cs]->mtd, NULL,
>> -						NULL, pdata->parts[cs],
>> +						&ppdata, pdata->parts[cs],
>>  						pdata->nr_parts[cs]);
>>  		if (!ret)
>>  			probe_success = 1;
>> @@ -1306,6 +1360,7 @@ static int pxa3xx_nand_resume(struct platform_device
>> *pdev) static struct platform_driver pxa3xx_nand_driver = {
>>  	.driver = {
>>  		.name	= "pxa3xx-nand",
>> +		.of_match_table = of_match_ptr(pxa3xx_nand_dt_ids),
>>  	},
>>  	.probe		= pxa3xx_nand_probe,
>>  	.remove		= pxa3xx_nand_remove,
