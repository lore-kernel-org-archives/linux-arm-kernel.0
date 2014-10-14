From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 14 Oct 2014 16:07:38 +0300
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <3765297.6j3Rv68iqn@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <20140923070238.GH30514@ulmo> <3765297.6j3Rv68iqn@wuerfel>
Message-ID: <2650492.UcyhNye0aG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday 23 September 2014 09:44:25 Arnd Bergmann wrote:
> On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
> > > I see two problems with using deferred probing here:
> > > 
> > > - we don't actually need to defer the probing but the binding to the
> > >   driver when no dma ops are set, but it seems silly to even create the
> > >   device before we can find out which ops it should use.
> > 
> > What does device creation have to do with anything? Surely a device
> > won't need IOMMU services before the device is bound to a driver.
> 
> The problem is that the driver will start using the IOMMU as soon
> as it calls dma_map_*, but that happens at runtime, not necessarily
> during the probe function.
> 
> So we can get into the weird situation that probe() returns success,
> but then you can't use the device yet because you don't know whether
> it is supposed to use an IOMMU or not.

If we want IOMMU devices to be supported by common device drivers we need to 
defer probing of the master devices, there's no doubt about that. Earlier 
approaches that hooked up into the device core code were rejected, but it 
should be possible to use bus notifiers to achieve the same result (with the 
drawback of having to register one notifier per bus). The 
BUS_NOTIFY_BIND_DRIVER notifier can then just return -EPROBE_DEFER when a 
iommus property is available and points to an IOMMU not registered yet. I'm 
not saying we have to do this, but I believe that at least from a technical 
point of view it could be done.

> > >   The reason is that a driver does not actively ask for an IOMMU as it
> > >   would for other subsystems (gpio, led, dmaengine, ...).
> > 
> > Actually it does. At least in some cases. If you want to use the IOMMU
> > API directly you'd call something like iommu_present() on the bus type
> > and then allocate an IOMMU domain and attach to it. Unfortunately the
> > API seems to have been designed under the assumption that IOMMU will
> > have been registered before any users, so the API doesn't propagate any
> > meaningful errors.
> 
> That's just a special case that does not even work as it should yet,
> please don't confuse the matter more by talking about drivers that
> use the IOMMU API explicitly, this series has very little to do with
> that.
> 
> > Also, even if in other cases the drivers don't actively ask for an IOMMU
> > that doesn't mean that they couldn't be made to. For drivers that use
> > the DMA/IOMMU integration layer this is probably not practicable, but
> > there is no reason the core couldn't do it.
> 
> We intentionally have an abstraction that is meant to let you write drivers
> without knowing about iommu, swiotlb or coherency, these are all hidden
> behind the dma_map_ops implementation.

-- 
Regards,

Laurent Pinchart
