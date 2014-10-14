From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 14 Oct 2014 15:37:59 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <4378271.6Q6s1JjOus@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <3765297.6j3Rv68iqn@wuerfel> <2650492.UcyhNye0aG@avalon>
 <4378271.6Q6s1JjOus@wuerfel>
Message-ID: <20141014133757.GA2217@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 03:20:46PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 October 2014 16:07:38 Laurent Pinchart wrote:
> > On Tuesday 23 September 2014 09:44:25 Arnd Bergmann wrote:
> > > On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
> > > > > I see two problems with using deferred probing here:
> > > > > 
> > > > > - we don't actually need to defer the probing but the binding to the
> > > > >   driver when no dma ops are set, but it seems silly to even create the
> > > > >   device before we can find out which ops it should use.
> > > > 
> > > > What does device creation have to do with anything? Surely a device
> > > > won't need IOMMU services before the device is bound to a driver.
> > > 
> > > The problem is that the driver will start using the IOMMU as soon
> > > as it calls dma_map_*, but that happens at runtime, not necessarily
> > > during the probe function.
> > > 
> > > So we can get into the weird situation that probe() returns success,
> > > but then you can't use the device yet because you don't know whether
> > > it is supposed to use an IOMMU or not.
> > 
> > If we want IOMMU devices to be supported by common device drivers we need to 
> > defer probing of the master devices, there's no doubt about that. Earlier 
> > approaches that hooked up into the device core code were rejected, but it 
> > should be possible to use bus notifiers to achieve the same result (with the 
> > drawback of having to register one notifier per bus). The 
> > BUS_NOTIFY_BIND_DRIVER notifier can then just return -EPROBE_DEFER when a 
> > iommus property is available and points to an IOMMU not registered yet. I'm 
> > not saying we have to do this, but I believe that at least from a technical 
> > point of view it could be done.
> 
> I think that fundamentally speaking, relying on notifiers for something like
> this is very problematic, both in terms of maintainability and reliability.
> We should really try to get the notifiers out of the iommu handling, not put
> more of them in.

Agreed. Also last time I checked the driver core simply ignored the
return value from notifiers, therefore this wouldn't work without
changing the core either.

Still, I agree with Laurent that we really should be relying on probe
deferral for probe ordering. And while it's true that earlier attempts
to put this into the core were rejected, I think there's still value in
proposing it again. The alternative proposed here is similarly close to
the core and needs to duplicated for every architecture. That itself is
to me a strong indication that this really does belong in the core.

I think initially this was proposed to become part of really_probe() and
I still think that's where it belongs. There's precedent for it with the
pinctrl_bind_pins() call, though it seems like Greg regrets allowing
that into the core. Perhaps if really_probe() is "too core", then
platform_drv_probe() would be a better candidate?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141014/0f482365/attachment.sig>
