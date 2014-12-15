From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 15 Dec 2014 19:53:48 +0200
Subject: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
 instead of initcall
In-Reply-To: <20141215174302.GU20738@arm.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1458739.IClpD3xz3i@avalon> <20141215174302.GU20738@arm.com>
Message-ID: <4894156.QdIh4JzSl0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Monday 15 December 2014 17:43:02 Will Deacon wrote:
> On Mon, Dec 15, 2014 at 05:27:30PM +0000, Laurent Pinchart wrote:
> > On Monday 15 December 2014 17:17:00 Will Deacon wrote:
> > > On Sun, Dec 14, 2014 at 12:45:36PM +0000, Laurent Pinchart wrote:
> > > > On Wednesday 19 November 2014 12:15:47 Marek Szyprowski wrote:
> > > > > +static int __init exynos_iommu_of_setup(struct device_node *np)
> > > > > +{
> > > > > +	struct platform_device *pdev;
> > > > > +
> > > > > +	if (!init_done)
> > > > > +		exynos_iommu_init();
> > > > > +
> > > > > +	pdev = of_platform_device_create(np, NULL,
> > > > > platform_bus_type.dev_root);
> > > > > +	if (IS_ERR(pdev))
> > > > > +		return PTR_ERR(pdev);
> > > > 
> > > > If we end up having to create the IOMMU platform devices from within
> > > > the drivers, the introduction of IOMMU_OF_DECLARE starts to feel like
> > > > a workaround to me. I wonder whether it wouldn't then be better to let
> > > > the driver core instantiate the IOMMU platform device from DT as for
> > > > all other devices, and use device notifiers to defer probe of the bus
> > > > masters until the required IOMMU(s) are registered.
> > > > 
> > > > Will, what's your opinion on that ?
> > > 
> > > Creating the platform device manually for the IOMMU is indeed grotty,
> > > but I don't really understand why it's needed. Interrupt controllers,
> > > for example, seem to get by without one.
> > 
> > There's several reasons, one of the most compelling ones I can think of at
> > the moment is runtime PM. IRQ controllers close to the CPU use CPU PM
> > notifiers instead. Note that IRQ controllers that are further away from
> > the CPU (such as GPIO-based IRQ controllers) are real platform devices
> > and use runtime PM.
>
> Ok, that's a good point, but the IOMMU will still probe later anyway, right?

That depends on the driver implementation, using OF node match an IOMMU driver 
doesn't have to register a struct driver. Assuming we require IOMMU drivers to 
register a struct driver, a platform device should then be probed at a later 
time.

However, if we wait until the IOMMU gets probed to initialize runtime PM and 
make it functional, we'll be back in square one if the IOMMU gets probed after 
the bus master, as the bus master could start issuing bus requests at probe 
time with the IOMMU not powered yet.

> > IOMMUs are not as low-level as system interrupt controllers or system
> > clocks. I'm beginning to agree with Thierry that they should be treated
> > as normal platform devices as they're not required earlier than probe
> > time of their bus master devices.
> 
> Well, I think you'd have to propose patches for discussion since I'm
> certainly not wed to the current approach; I just want something that
> allows of_{dma,iommu}_configure to run with the information it needs.

Do we need of_dma_configure() to run when the device is created, or could we 
postpone it to just before probe time ?

> The usual answer is `we should model buses properly', but that's really
> not practical afaict.

-- 
Regards,

Laurent Pinchart
