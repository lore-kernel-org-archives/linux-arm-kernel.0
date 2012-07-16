From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Jul 2012 21:46:17 +0530
Subject: [PATCH v5 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <5000F276.3080301@denx.de>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-6-git-send-email-hs@denx.de> <5000294C.5070606@ti.com>
 <5000F276.3080301@denx.de>
Message-ID: <50043E51.8070702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/14/2012 9:45 AM, Heiko Schocher wrote:
> Hello Sekhar,
> 
> On 13.07.2012 15:57, Sekhar Nori wrote:
>> Hi Heiko,
>>
>> On 5/30/2012 3:49 PM, Heiko Schocher wrote:
>>> add of support for the davinci i2c driver.
>>>
>>> Signed-off-by: Heiko Schocher<hs@denx.de>
>>> Cc: davinci-linux-open-source at linux.davincidsp.com
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> Cc: linux-i2c at vger.kernel.org
>>> Cc: Ben Dooks<ben-linux@fluff.org>
>>> Cc: Wolfram Sang<w.sang@pengutronix.de>
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>> Cc: Sekhar Nori<nsekhar@ti.com>
>>> Cc: Wolfgang Denk<wd@denx.de>
>>> Cc: Sylwester Nawrocki<s.nawrocki@samsung.com>
> [...]

[...]

>>> diff --git a/drivers/i2c/busses/i2c-davinci.c
>>> b/drivers/i2c/busses/i2c-davinci.c
>>> index a76d85f..4e7a966 100644
>>> --- a/drivers/i2c/busses/i2c-davinci.c
>>> +++ b/drivers/i2c/busses/i2c-davinci.c

[...]

>>>   static int davinci_i2c_probe(struct platform_device *pdev)
>>>   {
>>>       struct davinci_i2c_dev *dev;
>>> @@ -676,6 +695,25 @@ static int davinci_i2c_probe(struct
>>> platform_device *pdev)
>>>       dev->irq = irq->start;
>>>       platform_set_drvdata(pdev, dev);
>>>
>>> +    if ((dev->dev->platform_data == NULL)&&
>>> +        (pdev->dev.of_node)) {
>>> +        u32 prop;
>>> +
>>> +        dev->pdata = devm_kzalloc(&pdev->dev,
>>> +            sizeof(struct davinci_i2c_platform_data), GFP_KERNEL);
>>> +        if (!dev->pdata) {
>>> +            r = -ENOMEM;
>>> +            goto err_free_mem;
>>> +        }
>>> +        memcpy(dev->pdata,&davinci_i2c_platform_data_default,
>>> +            sizeof(struct davinci_i2c_platform_data));
>>> +        if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>>> +            &prop))
>>> +            dev->pdata->bus_freq = prop / 1000;
>>> +        if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
>>> +            &prop))
>>> +            dev->pdata->bus_delay = prop;
>>
>> You are leaving out two other platform data members (the gpio pins
>> corresponding to data and clock) from DT data. We should be able to
>> get that information from DT too, right?
> 
> Yes, but I had not ported the GPIO driver to OF ...

Okay. Understood. They can added once GPIO has been ported too and this
part is tested.

> 
>> So, I took this patch and tried to see if pdata maintenance can be
>> simplified and came with the diff below. Can you have a look and see
>> if this makes sense? I tested this using i2cdetect both with and
>> without DT.
> 
> Tested your patch on the enbw_cmc board with a LM75 on the enbw_cmc
> board, works fine. Can I post a "v6" of my patch, merged with your
> patch below and your Signed-off?

Yes, please do. You can post it as in independent patch (not as part of
a series) since the patch does not have any dependencies.

Thanks,
Sekhar
