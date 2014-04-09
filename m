From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Apr 2014 22:01:48 +0100
Subject: [rtc-linux] [PATCH v3 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <CAPw-ZT=XRDbqN8CJLOyXauif25Yq0n9G+NANqUtvX63QsyNT1g@mail.gmail.com>
References: <1396505873-5507-1-git-send-email-lho@apm.com>
 <1396505873-5507-2-git-send-email-lho@apm.com>
 <1396505873-5507-3-git-send-email-lho@apm.com>
 <20140403162648.GW14763@sirena.org.uk>
 <CAPw-ZT=XRDbqN8CJLOyXauif25Yq0n9G+NANqUtvX63QsyNT1g@mail.gmail.com>
Message-ID: <20140409210148.GT6518@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 10:16:11AM -0700, Loc Ho wrote:
> >> +static int xgene_rtc_suspend(struct device *dev)

> >> +     } else {
> >> +             xgene_rtc_alarm_irq_enable(dev, 0);
> >> +             clk_disable(pdata->clk);
> >> +     }

> > Why does the driver only disable the clock over suspend rather than also
> > unpreparing it?

> This was modeled after rtc-spear.c. Is this or rtc-spear in-correct?

They're both broken, looks like a bad conversion to prepare clocks.

> >> +     if (device_may_wakeup(&pdev->dev)) {
> >> +             if (pdata->irq_wake) {
> >> +                     disable_irq_wake(irq);
> >> +                     pdata->irq_wake = 0;
> >> +             }
> >> +     } else {
> >> +             clk_enable(pdata->clk);

> > It's also not checking for errors here.

> This was also modeled after rtc-spear. I guess I can check and print
> an warning but don't believe it matter.

You should return an error if the operation failed.

> >> +             xgene_rtc_alarm_irq_enable(dev, 1);
> >> +     }

> > Won't this unconditionally enable the interrupt regardless of what the
> > setting was prior to suspend?

> This was also modeled after rtc-spear.c. Is this or rtc-spear in-correct?

I would expct they're both broken here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/5f65346d/attachment-0001.sig>
