From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jan 2013 16:39:41 +0000
Subject: [PATCH v5 06/14] ARM: EXYNOS: add System MMU definition to DT
In-Reply-To: <20130116.184321.179736289870581833.hdoyu@nvidia.com>
References: <003601cdd790$082a1310$187e3930$%cho@samsung.com>
 <20130116115114.GB16543@mudshark.cambridge.arm.com>
 <20130116.184321.179736289870581833.hdoyu@nvidia.com>
Message-ID: <20130117163941.GL3699@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Wed, Jan 16, 2013 at 04:43:21PM +0000, Hiroshi Doyu wrote:
> Will Deacon <will.deacon@arm.com> wrote @ Wed, 16 Jan 2013 12:51:14 +0100:
> > Given that this information is not discoverable, it needs to be encoded
> > in the device tree, but where? I can see two approaches:
> > 
> >   1. For each IOMMU node, list phandles to the devices connected to it
> >      and have a corresponding list of StreamIDs.
> > 
> > or
> > 
> >   2. For each device wishing to use an IOMMU, have a phandle to the
> >      IOMMU node and a separate StreamID property. The IOMMU would then
> >      parse this information when the device is added to the bus.
> > 
> > Although I prefer the second approach, it has the downside of affecting
> > all device bindings that wish to use an IOMMU, so I'm open to any other
> > ideas.
> 
> Actually the above summarize tegra SMMU situation well too. For
> example, each IOMMU'able device has IOVA constraint that some of the
> address area isn't available because of its MMIO. This info needs to
> be described in DT. If <IOMMU phandle> + some parametes are embedded
> in a device node, that info could be dealt at a bus notifier(*1).
> 
> *1: http://lists.linuxfoundation.org/pipermail/iommu/2012-November/004934.html

I've been thinking about this a bit more and, unfortunately, my conclusion
is that method (2) above is problematic, so we do need something similar to
(1).

The reason for this comes about when dealing with chained IOMMUs. In this
case, each IOMMU in the chain needs to know about all of the masters hanging
beneath it (potentially behind other IOMMUs) but may also need to supplement
each device with additional data relevant to that point in the IOMMU chain.
In the case of the ARM System MMU, this could be StreamID information (as
the StreamID for a device can change as the transaction stream passes
through an SMMU) and for your case it could be that the DMA window is
widened along the chain.

So, extending the mmu-master property described in this thread to be
"mmu-masters : a list of phandles to device nodes representing bus masters
for which the IOMMU can provide a translation" is probably a good start.

Will
