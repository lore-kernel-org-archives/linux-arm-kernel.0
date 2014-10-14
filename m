From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Oct 2014 15:20:46 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <2650492.UcyhNye0aG@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <3765297.6j3Rv68iqn@wuerfel> <2650492.UcyhNye0aG@avalon>
Message-ID: <4378271.6Q6s1JjOus@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 October 2014 16:07:38 Laurent Pinchart wrote:
> On Tuesday 23 September 2014 09:44:25 Arnd Bergmann wrote:
> > On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
> > > > I see two problems with using deferred probing here:
> > > > 
> > > > - we don't actually need to defer the probing but the binding to the
> > > >   driver when no dma ops are set, but it seems silly to even create the
> > > >   device before we can find out which ops it should use.
> > > 
> > > What does device creation have to do with anything? Surely a device
> > > won't need IOMMU services before the device is bound to a driver.
> > 
> > The problem is that the driver will start using the IOMMU as soon
> > as it calls dma_map_*, but that happens at runtime, not necessarily
> > during the probe function.
> > 
> > So we can get into the weird situation that probe() returns success,
> > but then you can't use the device yet because you don't know whether
> > it is supposed to use an IOMMU or not.
> 
> If we want IOMMU devices to be supported by common device drivers we need to 
> defer probing of the master devices, there's no doubt about that. Earlier 
> approaches that hooked up into the device core code were rejected, but it 
> should be possible to use bus notifiers to achieve the same result (with the 
> drawback of having to register one notifier per bus). The 
> BUS_NOTIFY_BIND_DRIVER notifier can then just return -EPROBE_DEFER when a 
> iommus property is available and points to an IOMMU not registered yet. I'm 
> not saying we have to do this, but I believe that at least from a technical 
> point of view it could be done.

I think that fundamentally speaking, relying on notifiers for something like
this is very problematic, both in terms of maintainability and reliability.
We should really try to get the notifiers out of the iommu handling, not put
more of them in.

	Arnd
