From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 23 Sep 2014 10:59:47 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <3765297.6j3Rv68iqn@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <3261451.zpO6MVx5yo@wuerfel> <20140923070238.GH30514@ulmo>
 <3765297.6j3Rv68iqn@wuerfel>
Message-ID: <20140923085946.GP30514@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 09:44:25AM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
> 
> > > I see two problems with using deferred probing here: 
> > > 
> > > - we don't actually need to defer the probing but the binding to the driver
> > >   when no dma ops are set, but it seems silly to even create the device
> > >   before we can find out which ops it should use.
> > 
> > What does device creation have to do with anything? Surely a device
> > won't need IOMMU services before the device is bound to a driver.
> 
> The problem is that the driver will start using the IOMMU as soon
> as it calls dma_map_*, but that happens at runtime, not necessarily
> during the probe function.

But it won't call dma_map_*() before probe, right? If this is done in
the core we can defer probing before the driver's probe is called, so
there shouldn't be an issue.

> So we can get into the weird situation that probe() returns success,
> but then you can't use the device yet because you don't know whether
> it is supposed to use an IOMMU or not.

Of course any such solution would only work under the assumption that
the driver (or core) knows what it's doing and doesn't call dma_map_*()
until IOMMU support has properly been set up.

For DMA/IOMMU integration users I'd expect the core to set everything up
before proceeding to calling the driver's .probe() function. For others
they will need a way to either explicitly check for the IOMMU master
interface or have the core do that for them (similar to how it would do
that for DMA/IOMMU integration users).

> > >   The reason is that a driver does not actively ask for an IOMMU as it would
> > >   for other subsystems (gpio, led, dmaengine, ...).
> > 
> > Actually it does. At least in some cases. If you want to use the IOMMU
> > API directly you'd call something like iommu_present() on the bus type
> > and then allocate an IOMMU domain and attach to it. Unfortunately the
> > API seems to have been designed under the assumption that IOMMU will
> > have been registered before any users, so the API doesn't propagate any
> > meaningful errors.
> 
> That's just a special case that does not even work as it should yet,

Of course it works. I count at least 3 drivers in mainline (and 1 local)
that do exactly this.

> please don't confuse the matter more by talking about drivers that
> use the IOMMU API explicitly, this series has very little to do with
> that.

It has everything to do with it. If we go and implement everything in
terms of DMA/IOMMU then we leave out all other users. Depending on who
you talk to the direct IOMMU users are the actually important ones.

> > Also, even if in other cases the drivers don't actively ask for an IOMMU
> > that doesn't mean that they couldn't be made to. For drivers that use
> > the DMA/IOMMU integration layer this is probably not practicable, but
> > there is no reason the core couldn't do it.
> 
> We intentionally have an abstraction that is meant to let you write drivers
> without knowing about iommu, swiotlb or coherency, these are all hidden
> behind the dma_map_ops implementation.

Perhaps I'm missing something then. How can you associate two devices
with the same domain with dma_map_ops?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140923/7f666936/attachment.sig>
