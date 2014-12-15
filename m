From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 15 Dec 2014 20:19:57 +0200
Subject: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
 instead of initcall
In-Reply-To: <20141215181323.GX20738@arm.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <4894156.QdIh4JzSl0@avalon> <20141215181323.GX20738@arm.com>
Message-ID: <1582013.9WDR2r2f3r@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 18:13:23 Will Deacon wrote:
> On Mon, Dec 15, 2014 at 05:53:48PM +0000, Laurent Pinchart wrote:
> > Hi Will,
> 
> Hello again :)
> 
> > On Monday 15 December 2014 17:43:02 Will Deacon wrote:
> > > On Mon, Dec 15, 2014 at 05:27:30PM +0000, Laurent Pinchart wrote:
> > > > On Monday 15 December 2014 17:17:00 Will Deacon wrote:
> > > > > Creating the platform device manually for the IOMMU is indeed
> > > > > grotty, but I don't really understand why it's needed. Interrupt
> > > > > controllers, for example, seem to get by without one.
> > > > 
> > > > There's several reasons, one of the most compelling ones I can think
> > > > of at the moment is runtime PM. IRQ controllers close to the CPU use
> > > > CPU PM notifiers instead. Note that IRQ controllers that are further
> > > > away from the CPU (such as GPIO-based IRQ controllers) are real
> > > > platform devices and use runtime PM.
> > > 
> > > Ok, that's a good point, but the IOMMU will still probe later anyway,
> > > right?
> >
> > That depends on the driver implementation, using OF node match an IOMMU
> > driver doesn't have to register a struct driver. Assuming we require
> > IOMMU drivers to register a struct driver, a platform device should then
> > be probed at a later time.
> > 
> > However, if we wait until the IOMMU gets probed to initialize runtime PM
> > and make it functional, we'll be back in square one if the IOMMU gets
> > probed after the bus master, as the bus master could start issuing bus
> > requests at probe time with the IOMMU not powered yet.
> 
> True, but couldn't the early init code do enough to get the thing
> functional? That said, I'm showing my ignorance here as I'm not familiar
> with the PM code (and the software models I have for the SMMU clearly don't
> implement anything in this regard).

We're reaching the limits of my knowledge as well. If the IOMMU is in a power 
domain different than the bus masters the driver would at least need to ensure 
that the power domain is turned on, which might be a bit hackish without 
runtime PM.

> > > > IOMMUs are not as low-level as system interrupt controllers or system
> > > > clocks. I'm beginning to agree with Thierry that they should be
> > > > treated as normal platform devices as they're not required earlier
> > > > than probe time of their bus master devices.
> > > 
> > > Well, I think you'd have to propose patches for discussion since I'm
> > > certainly not wed to the current approach; I just want something that
> > > allows of_{dma,iommu}_configure to run with the information it needs.
> > 
> > Do we need of_dma_configure() to run when the device is created, or could
> > we postpone it to just before probe time ?
> 
> I'm not sure I can answer that one... Arnd?

-- 
Regards,

Laurent Pinchart
