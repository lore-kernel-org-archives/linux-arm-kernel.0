From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Jul 2012 11:09:34 -0700
Subject: [PATCH] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120703140202.GF22705@S2101-09.ap.freescale.net>
References: <1341245355-21397-1-git-send-email-shawn.guo@linaro.org>
 <4FF1F154.3050506@codeaurora.org>
 <20120703140202.GF22705@S2101-09.ap.freescale.net>
Message-ID: <4FF3355E.6080900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/12 07:02, Shawn Guo wrote:
> On Mon, Jul 02, 2012 at 12:07:00PM -0700, Stephen Boyd wrote:
>> On 07/02/12 09:09, Shawn Guo wrote:
>>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>>> index 08cbdb9..511ddcb 100644
>>> --- a/drivers/rtc/Kconfig
>>> +++ b/drivers/rtc/Kconfig
>>> @@ -1087,4 +1087,14 @@ config RTC_DRV_MXC
>>>  	   This driver can also be built as a module, if so, the module
>>>  	   will be called "rtc-mxc".
>>>  
>>> +config RTC_DRV_SNVS
>>> +	tristate "Freescale SNVS RTC support"
>>> +	depends on ARCH_MXC
>> If you want more build coverage you can depend on HAS_IOMEM and drop the
>> ARCH_MXC part.
>>
> Dropping ARCH_MXC sounds like a good idea.  But why do we need to
> depend on HAS_IOMEM?  readl/writel are not always available?

Yes, that is my understanding.

>
> I would add "depends on OF" though.
>
>
>>> +static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
>>> +{
>>> +	struct device *dev = dev_id;
>>> +	struct snvs_rtc_data *data = dev_get_drvdata(dev);
>> Why not just pass the svsns_rtc_data to request_irq() so you can cast
>> dev_id directly?
>>
> Because snvs_rtc_alarm_irq_enable(dev, 0) is being called in there
> with dev as the first parameter.

Ah, sorry for the noise.

>
>>> +static int __devinit snvs_rtc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct snvs_rtc_data *data;
>>> +	struct resource *res;
>>> +	int ret;
>>> +
>>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	data->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
>>> +	if (!data->ioaddr)
>>> +		return -EADDRNOTAVAIL;
>>> +
>>> +	data->irq = platform_get_irq(pdev, 0);
>> What if this irq fails to exist?
>>
> The later devm_request_irq() call will report error then.

request_irq() takes an unsigned int. Are you relying on there being no
descriptor for that extremely high irq number? Or maybe I'm missing
something in the code.

>
>>> +	{ .compatible = "fsl,sec-v4.0-mon" },
>>> +	{ /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, snvs_dt_ids);
>> Surround this of_device table in #ifdef CONFIG_OF?
>>
> Maybe not.  I intend to have the driver OF only.
>

Ok. I guess if someone wants to use it non-OF they can always send a patch.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
