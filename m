From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 7 Jun 2014 00:52:48 +0200
Subject: [PATCH v2 6/6] usb: host: ohci-exynos: Use devm_ioremap_resource
 instead of devm_ioremap
In-Reply-To: <CAFp+6iEe8fvxboG79=2s=oe4BkQJYAoVUPtYkPdjJHCe+bC=8Q@mail.gmail.com>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
 <1399723210-21569-7-git-send-email-gautam.vivek@samsung.com>
 <CAFp+6iFufCh6SVEF-HQA62ZsJGJGSebDSs28eqcrMy1X8e5vjA@mail.gmail.com>
 <20140604131306.GB28484@ulmo>
 <CAFp+6iEe8fvxboG79=2s=oe4BkQJYAoVUPtYkPdjJHCe+bC=8Q@mail.gmail.com>
Message-ID: <20140606225246.GB22188@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 06:32:42PM +0530, Vivek Gautam wrote:
> On Wed, Jun 4, 2014 at 6:43 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Jun 04, 2014 at 03:41:20PM +0530, Vivek Gautam wrote:
> >> On Sat, May 10, 2014 at 5:30 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
[...]
> >> > diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> >> > index 9cf80cb..dec691d 100644
> >> > --- a/drivers/usb/host/ohci-exynos.c
> >> > +++ b/drivers/usb/host/ohci-exynos.c
> >> > @@ -120,10 +120,9 @@ skip_phy:
> >> >
> >> >         hcd->rsrc_start = res->start;
> >> >         hcd->rsrc_len = resource_size(res);
> >> > -       hcd->regs = devm_ioremap(&pdev->dev, res->start, hcd->rsrc_len);
> >> > -       if (!hcd->regs) {
> >> > -               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
> >> > -               err = -ENOMEM;
> >> > +       hcd->regs = devm_ioremap_resource(&pdev->dev, res);
> >>
> >> Here, we replaced devm_ioremap() call with devm_ioremap_resource(),
> >> which internally requests the memory region
> >
> > I guess this could lead to problems if drivers haven't been written to
> > cleanly split the register ranges that they access, since now two
> > overlapping regions may be requested and cause the drivers to fail.
> 
> Sorry i did not understand completely. Wouldn't the request_mem_region()
> fail for an already busy resource ?
> So devm_ioremap_resource() will in fact prevent the drivers from requesting
> the same memory region twice until the first request frees the region.
> Isn't it ?

Yes exactly. What I was trying to say is that since drivers weren't
requesting the resources before they may be using overlapping regions.
Now that this patch changes these drivers to also request the resources
they will fail if the regions overlap with those of other drivers.

> >> and then does a "devm_ioremap()" or "devm_ioremap_nocache()" based on
> >> the check for IORESOURCE_CACHEABLE flag.
> >>
> >> But this flag is not set for the resource of this device.
> >> So should we be explicitly setting the flag in driver ?
> >
> > I don't think it makes much sense to map these registers cached anyway.
> > Drivers will likely expect writes to this region to take effect without
> > needing any kind of flushing.
> 
> These "hcd->regs" are going to be used by the controller, so wouldn't
> there be a performance difference when the requested address space is
> cacheable/non-cacheable ?

The issue here is that if the region is mapped cacheable then register
writes may not immediately take effect and that's almost certainly not
what the driver will expect. I don't think it ever makes sense to map
registers cacheable.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140607/206b0a6d/attachment.sig>
