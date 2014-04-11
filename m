From: lho@apm.com (Loc Ho)
Date: Thu, 10 Apr 2014 21:22:43 -0700
Subject: [PATCH v4 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <20140410224244.GH6518@sirena.org.uk>
References: <1397155678-26607-1-git-send-email-lho@apm.com>
 <1397155678-26607-2-git-send-email-lho@apm.com>
 <1397155678-26607-3-git-send-email-lho@apm.com>
 <20140410224244.GH6518@sirena.org.uk>
Message-ID: <CAPw-ZTns1EOT0inn0hq0Xh+CdjMkxhOkvL+_BnRThnm7HQC=BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>
>> +     if (device_may_wakeup(&pdev->dev)) {
>> +             if (!enable_irq_wake(irq))
>> +                     pdata->irq_wake = 1;
>> +     } else {
>> +             pdata->irq_enabled = xgene_rtc_alarm_irq_enabled(dev);
>> +             xgene_rtc_alarm_irq_enable(dev, 0);
>> +             clk_disable(pdata->clk);
>> +     }
>> +     clk_unprepare(pdata->clk);
>
> This will unconditionally unprepare the clock even if it wasn't disabled
> which looks like a bug - I would have expected the disable to be a
> clk_disable_unprepare() instead?  Similarly for the resume path.
>

I was modeled after driver rtc-coh901331.c. It seems like all I need
here is to call clk_disable_unprepare() instead clk_disable for
suspend. For resume, call clk_prepare_disable() instead clk_enable().
No need to split them up. Am I correct?

Given that Andrew Morton applied v2, should I post an patch against v2
going forward?

-Loc
