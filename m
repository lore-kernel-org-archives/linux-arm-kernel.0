From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 14 Oct 2014 17:05:29 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <2542016.raJF6a70c9@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <4378271.6Q6s1JjOus@wuerfel> <20141014133757.GA2217@ulmo>
 <2542016.raJF6a70c9@avalon>
Message-ID: <20141014150527.GA8819@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 06:01:58PM +0300, Laurent Pinchart wrote:
> Hi Thierry,
> 
> On Tuesday 14 October 2014 15:37:59 Thierry Reding wrote:
> > On Tue, Oct 14, 2014 at 03:20:46PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 14 October 2014 16:07:38 Laurent Pinchart wrote:
> > >> On Tuesday 23 September 2014 09:44:25 Arnd Bergmann wrote:
> > >>> On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
> > >>>>> I see two problems with using deferred probing here:
> > >>>>> 
> > >>>>> - we don't actually need to defer the probing but the binding to
> > >>>>>   the driver when no dma ops are set, but it seems silly to even
> > >>>>>   create the device before we can find out which ops it should use.
> > >>>> 
> > >>>> What does device creation have to do with anything? Surely a device
> > >>>> won't need IOMMU services before the device is bound to a driver.
> > >>> 
> > >>> The problem is that the driver will start using the IOMMU as soon
> > >>> as it calls dma_map_*, but that happens at runtime, not necessarily
> > >>> during the probe function.
> > >>> 
> > >>> So we can get into the weird situation that probe() returns success,
> > >>> but then you can't use the device yet because you don't know whether
> > >>> it is supposed to use an IOMMU or not.
> > >> 
> > >> If we want IOMMU devices to be supported by common device drivers we
> > >> need to defer probing of the master devices, there's no doubt about
> > >> that. Earlier approaches that hooked up into the device core code were
> > >> rejected, but it should be possible to use bus notifiers to achieve the
> > >> same result (with the drawback of having to register one notifier per
> > >> bus). The BUS_NOTIFY_BIND_DRIVER notifier can then just return -
> > >> EPROBE_DEFER when a iommus property is available and points to an IOMMU
> > >> not registered yet. I'm not saying we have to do this, but I believe that
> > >> at least from a technical point of view it could be done.
> > > 
> > > I think that fundamentally speaking, relying on notifiers for something
> > > like this is very problematic, both in terms of maintainability and
> > > reliability. We should really try to get the notifiers out of the iommu
> > > handling, not put more of them in.
> > 
> > Agreed. Also last time I checked the driver core simply ignored the
> > return value from notifiers, therefore this wouldn't work without
> > changing the core either.
> > 
> > Still, I agree with Laurent that we really should be relying on probe
> > deferral for probe ordering.
> 
> *If* we decide to support IOMMUs with real devices ;-)
> 
> I don't have a strong opinion on the subject. I initially thought it would be 
> a shame not to be able to use devres, until realizing that binding to a DT 
> node instead of a device meant that no unbind can ever occur. Loosing dev_* 
> support is also an annoyance though.

Binding to a DT node then also means that you can't build the driver as
a module. And in particular for multiplatform kernels this is going to
be a problem eventually.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141014/c2ebbf55/attachment.sig>
