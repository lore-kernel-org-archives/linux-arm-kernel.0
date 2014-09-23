From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 23 Sep 2014 09:02:39 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <3261451.zpO6MVx5yo@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <11868654.D6MinQlF2p@wuerfel> <20140922114039.GT1470@ulmo>
 <3261451.zpO6MVx5yo@wuerfel>
Message-ID: <20140923070238.GH30514@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 06:03:47PM +0200, Arnd Bergmann wrote:
> On Monday 22 September 2014 13:40:40 Thierry Reding wrote:
> > On Mon, Sep 22, 2014 at 01:08:27PM +0200, Arnd Bergmann wrote:
> > > On Monday 22 September 2014 11:36:15 Thierry Reding wrote:
> > > > On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> > > > > We need to ensure that the IOMMUs in the system have a chance to perform
> > > > > some basic initialisation before we start adding masters to them.
> > > > > 
> > > > > This patch adds a call to of_iommu_init before of_platform_populate.
> > > > 
> > > > Why can't you call it from of_platform_populate() directly? That way it
> > > > would be usable for all architectures rather than just ARM. Eventually
> > > > we're going to need the same thing for 64-bit ARM (and possibly others
> > > > as well).
> > > 
> > > IIRC, of_platform_populate can be called multiple times, even recursively
> > > be drivers that populate their own child devices.
> > 
> > Indeed. Perhaps it could be conditionally called when root == NULL. But
> > perhaps that's not safe either. Anyway, I still think we shouldn't be
> > making this some randomly placed early initcall anyway.
> 
> I disagree. IOMMUs are special in the same sense that irqchips, clocks and
> timers are. This is not just a random call, it is being explicit about a
> base functionality that is needed for all devices attached to it.

Why do you say IOMMUs are special? I can understand how clocks and
timers are somewhat special because they are required at early boot. But
IOMMUs are not special in that way. I don't think there are any IOMMU
users that early in the boot process. The only reason why IOMMU is
special is because of the way it's currently hooked into the driver
model.

> While we pretend that these are just device drivers in some sense, I think
> it's perfectly reasonable to have an explicit entry point for each subsystem
> here.

They aren't really device drivers at all. They don't bind to devices but
to device tree nodes. And that comes at a high cost. Writing drivers for
these subsystems is weird, because all of a sudden you can no longer use
all the goodies that we've become used to (dev_log(), devres, ...) over
the years.

> I see two problems with using deferred probing here: 
> 
> - we don't actually need to defer the probing but the binding to the driver
>   when no dma ops are set, but it seems silly to even create the device
>   before we can find out which ops it should use.

What does device creation have to do with anything? Surely a device
won't need IOMMU services before the device is bound to a driver.

>   The reason is that a driver does not actively ask for an IOMMU as it would
>   for other subsystems (gpio, led, dmaengine, ...).

Actually it does. At least in some cases. If you want to use the IOMMU
API directly you'd call something like iommu_present() on the bus type
and then allocate an IOMMU domain and attach to it. Unfortunately the
API seems to have been designed under the assumption that IOMMU will
have been registered before any users, so the API doesn't propagate any
meaningful errors.

Currently the specifics of how that works is all mostly hidden within
the IOMMU driver which will decide what IOMMU to attach to. That's
problematic for cases where a device has multiple master interfaces,
since it won't be able to decide which one to attach to.

Also, even if in other cases the drivers don't actively ask for an IOMMU
that doesn't mean that they couldn't be made to. For drivers that use
the DMA/IOMMU integration layer this is probably not practicable, but
there is no reason the core couldn't do it.

> - As long as the dma_ops are not set, we can't actually call probe() for
>   any device other than iommus, and even that would require adding special
>   magic in the platform_device_probe(), so we'd just defer every device
>   until we get to the iommu. This likely causes a lot of overhead at probe
>   time.

Why? The patches that I (and Hiroshi before me) posted a while ago did
exactly that and it worked just fine. The only objection to that was
that Greg (and you I think) didn't want to have that code in the core
and therefore -EPROBE_DEFER can't properly be propagated. There's no
special magic required beyond that. The IOMMU becomes a resource or
service provider, just like any other driver.

As for the overhead I think that's negligible. Hopefully the IOMMU would
be standalone enough not to defer probing itself, so at worst all IOMMU
users would be deferred once. Many of them will already defer because of
other resources such as GPIOs, clocks or regulators anyway. But that's a
problem for which a solution could be implemented. Dependency-based
probe ordering was discussed not so long ago. With that in place the
IOMMU would be probed before any of its users.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140923/a3f8d4f4/attachment.sig>
