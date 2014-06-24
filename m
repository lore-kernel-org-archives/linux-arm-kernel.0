From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue, 24 Jun 2014 11:19:08 +0530
Subject: [PATCH v2 6/6] usb: host: ohci-exynos: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <20140606225246.GB22188@mithrandir>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
 <1399723210-21569-7-git-send-email-gautam.vivek@samsung.com>
 <CAFp+6iFufCh6SVEF-HQA62ZsJGJGSebDSs28eqcrMy1X8e5vjA@mail.gmail.com>
 <20140604131306.GB28484@ulmo>
 <CAFp+6iEe8fvxboG79=2s=oe4BkQJYAoVUPtYkPdjJHCe+bC=8Q@mail.gmail.com>
 <20140606225246.GB22188@mithrandir>
Message-ID: <CAFp+6iHqX+huiYJo7c38tgQZ-iE7v2nXXQHrJU6v55e8zkb7Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Sat, Jun 7, 2014 at 4:22 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Jun 06, 2014 at 06:32:42PM +0530, Vivek Gautam wrote:
>> On Wed, Jun 4, 2014 at 6:43 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
>> > On Wed, Jun 04, 2014 at 03:41:20PM +0530, Vivek Gautam wrote:
>> >> On Sat, May 10, 2014 at 5:30 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> [...]
>> >> > diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
>> >> > index 9cf80cb..dec691d 100644
>> >> > --- a/drivers/usb/host/ohci-exynos.c
>> >> > +++ b/drivers/usb/host/ohci-exynos.c
>> >> > @@ -120,10 +120,9 @@ skip_phy:
>> >> >
>> >> >         hcd->rsrc_start = res->start;
>> >> >         hcd->rsrc_len = resource_size(res);
>> >> > -       hcd->regs = devm_ioremap(&pdev->dev, res->start, hcd->rsrc_len);
>> >> > -       if (!hcd->regs) {
>> >> > -               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
>> >> > -               err = -ENOMEM;
>> >> > +       hcd->regs = devm_ioremap_resource(&pdev->dev, res);
>> >>
>> >> Here, we replaced devm_ioremap() call with devm_ioremap_resource(),
>> >> which internally requests the memory region
>> >
>> > I guess this could lead to problems if drivers haven't been written to
>> > cleanly split the register ranges that they access, since now two
>> > overlapping regions may be requested and cause the drivers to fail.
>>
>> Sorry i did not understand completely. Wouldn't the request_mem_region()
>> fail for an already busy resource ?
>> So devm_ioremap_resource() will in fact prevent the drivers from requesting
>> the same memory region twice until the first request frees the region.
>> Isn't it ?
>
> Yes exactly. What I was trying to say is that since drivers weren't
> requesting the resources before they may be using overlapping regions.
> Now that this patch changes these drivers to also request the resources
> they will fail if the regions overlap with those of other drivers.

Thanks for explaining it further.
I understand this fact. And i am sure this case does not arise in exynos.
For Tegra, Stephen noted this fact about the ehci driver and the
corresponding PHY.
So that the PHY does a devm_ioremap() only.
For other platforms too we did not get any concerns raised, so we
moved ahead with the series
for merging.

>
>> >> and then does a "devm_ioremap()" or "devm_ioremap_nocache()" based on
>> >> the check for IORESOURCE_CACHEABLE flag.
>> >>
>> >> But this flag is not set for the resource of this device.
>> >> So should we be explicitly setting the flag in driver ?
>> >
>> > I don't think it makes much sense to map these registers cached anyway.
>> > Drivers will likely expect writes to this region to take effect without
>> > needing any kind of flushing.
>>
>> These "hcd->regs" are going to be used by the controller, so wouldn't
>> there be a performance difference when the requested address space is
>> cacheable/non-cacheable ?
>
> The issue here is that if the region is mapped cacheable then register
> writes may not immediately take effect and that's almost certainly not
> what the driver will expect. I don't think it ever makes sense to map
> registers cacheable.

Ok, this explains things.



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
