From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Nov 2015 12:22:51 +0000
Subject: [RFC] ARM64: simplify dma_get_ops
In-Reply-To: <5118146.8KqrJiJrDe@wuerfel>
References: <4270550.cGd11OgA5n@wuerfel>
 <20151116183941.GF6556@e104818-lin.cambridge.arm.com>
 <5118146.8KqrJiJrDe@wuerfel>
Message-ID: <20151117122250.GH6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 08:57:41PM +0100, Arnd Bergmann wrote:
> On Monday 16 November 2015 18:39:41 Catalin Marinas wrote:
> > On Mon, Nov 16, 2015 at 05:25:48PM +0100, Arnd Bergmann wrote:
> > > @@ -985,7 +977,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> > >  			struct iommu_ops *iommu, bool coherent)
> > >  {
> > >  	if (!acpi_disabled && !dev->archdata.dma_ops)
> > > -		dev->archdata.dma_ops = dma_ops;
> > > +		dev->archdata.dma_ops = &swiotlb_dma_ops;
> > 
> > Why do we still keep the !acpi_disabled check here? If I remove it, the
> > WARN_ON() above disappears.
> 
> Ah, good. That must be my mistake then. This looks much better.

I merged this patch with the above change. Thanks.

> On a related note, we should also urgently fix the
> arch_setup_dma_ops() function to no longer ignore the base and size
> arguments. For dma_base, we can simply WARN_ON(dma_base != 0), so we
> can implement support for that whenever we need it,

I think we should, at least until we implement support for
dev->dma_pfn_offset. I'm not sure about iommu though, maybe there are
working configurations with dma_base != 0.

> but for the size we need to prevent drivers from calling
> dma_set_mask() with an argument larger than the size we pass in here,
> unless the size is also larger than max_pfn.

We have a default mask set up in of_dma_configure() based on size and
dma_base. Can we check the new mask against the default one?

-- 
Catalin
