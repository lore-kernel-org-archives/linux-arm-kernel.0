From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 1 Mar 2012 20:52:56 +0800
Subject: [PATCH 3/8] rtc: sa1100: add OF support
In-Reply-To: <201203010951.12405.arnd@arndb.de>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
 <1330582228-12424-4-git-send-email-haojian.zhuang@marvell.com>
 <201203010951.12405.arnd@arndb.de>
Message-ID: <CAN1soZwe+NRaf--SKupqtTnJ=YExT9LYBx+R9jUV3aA0ecbkbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2012 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 01 March 2012, Haojian Zhuang wrote:
>> +#ifdef CONFIG_OF
>> +static int sa1100_rtc_probe_dt(struct platform_device *pdev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct sa1100_rtc *info)
>> +{
>> + ? ? ? info->irq_alarm = platform_get_irq(pdev, 0);
>> + ? ? ? info->irq_1hz = platform_get_irq(pdev, 1);
>> + ? ? ? if (info->irq_1hz < 0 || info->irq_alarm < 0)
>> + ? ? ? ? ? ? ? return -ENODEV;
>> + ? ? ? return 0;
>> +}
>> +#else
>> +static int sa1100_rtc_probe_dt(struct platform_device *pdev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct sa1100_rtc *info)
>> +{
>> + ? ? ? return 1;
>> +}
>> +#endif
>> +
>> +static int sa1100_rtc_probe_irq(struct platform_device *pdev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct sa1100_rtc *info)
>> +{
>> + ? ? ? info->irq_1hz = platform_get_irq_byname(pdev, "rtc 1Hz");
>> + ? ? ? info->irq_alarm = platform_get_irq_byname(pdev, "rtc alarm");
>> + ? ? ? if (info->irq_1hz < 0 || info->irq_alarm < 0)
>> + ? ? ? ? ? ? ? return -ENODEV;
>> + ? ? ? return 0;
>> +}
>
> This should not be necessary. I thought we had already added support
> for named irq resources coming from the device tree. If not, why not
> just make the other ones anonymous as well and just use platform_get_irq()?
>

Yes, platform_get_irq() is better. I'll append the two irqs into
interrupts property.
