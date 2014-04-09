From: lho@apm.com (Loc Ho)
Date: Wed, 9 Apr 2014 10:16:11 -0700
Subject: [rtc-linux] [PATCH v3 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <20140403162648.GW14763@sirena.org.uk>
References: <1396505873-5507-1-git-send-email-lho@apm.com>
 <1396505873-5507-2-git-send-email-lho@apm.com>
 <1396505873-5507-3-git-send-email-lho@apm.com>
 <20140403162648.GW14763@sirena.org.uk>
Message-ID: <CAPw-ZT=XRDbqN8CJLOyXauif25Yq0n9G+NANqUtvX63QsyNT1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +static int xgene_rtc_suspend(struct device *dev)
>> +{
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct xgene_rtc_dev *pdata = platform_get_drvdata(pdev);
>> +     int irq;
>> +
>> +     irq = platform_get_irq(pdev, 0);
>> +     if (device_may_wakeup(&pdev->dev)) {
>> +             if (!enable_irq_wake(irq))
>> +                     pdata->irq_wake = 1;
>> +     } else {
>> +             xgene_rtc_alarm_irq_enable(dev, 0);
>> +             clk_disable(pdata->clk);
>> +     }
>
> Why does the driver only disable the clock over suspend rather than also
> unpreparing it?

This was modeled after rtc-spear.c. Is this or rtc-spear in-correct?

>
>> +     if (device_may_wakeup(&pdev->dev)) {
>> +             if (pdata->irq_wake) {
>> +                     disable_irq_wake(irq);
>> +                     pdata->irq_wake = 0;
>> +             }
>> +     } else {
>> +             clk_enable(pdata->clk);
>
> It's also not checking for errors here.

This was also modeled after rtc-spear. I guess I can check and print
an warning but don't believe it matter.

>
>> +             xgene_rtc_alarm_irq_enable(dev, 1);
>> +     }
>
> Won't this unconditionally enable the interrupt regardless of what the
> setting was prior to suspend?

This was also modeled after rtc-spear.c. Is this or rtc-spear in-correct?

-Loc
