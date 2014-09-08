From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Sep 2014 11:31:29 +0100
Subject: [RFC PATCH v2 2/7] dma-mapping: replace
 set_arch_dma_coherent_ops with arch_setup_dma_ops
In-Reply-To: <5409D8C5.9010804@ti.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-3-git-send-email-will.deacon@arm.com>
 <5409D8C5.9010804@ti.com>
Message-ID: <20140908103129.GC26030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 04:37:41PM +0100, Grygorii Strashko wrote:
> Hi Will,

Hi Grygorii,

> On 09/02/2014 08:56 PM, Will Deacon wrote:
> > set_arch_dma_coherent_ops is called from of_dma_configure in order to
> > swizzle the architectural dma-mapping functions over to a cache-coherent
> > implementation. This is currently implemented only for ARM.
> > 
> > In anticipation of re-using this mechanism for IOMMU-backed dma-mapping
> > ops too, this patch replaces the function with a broader
> > arch_setup_dma_ops callback which is also responsible for setting the
> > DMA mask and offset as well as selecting the correct mapping functions.
> > 
> > A further advantage of this split is that it nicely isolates the
> > of-specific code from the dma-mapping code, allowing potential reuse by
> > other buses (e.g. PCI) in the future.
> 
> I think this patch can introduce a regression if it will be used as is :(
> 
> When this code was initially created there ware a lot of discussion about
> and finally it was decided to configure all common (for all arches) DMA 
> specific parameters for devices in common code, while strictly arch 
> specific things using arch specific APIs/callbacks.
> 
> The following parameters are common now:
> dev->coherent_dma_mask	= mask;
> dev->dma_mask		= &dev->coherent_dma_mask;
> dev->dma_pfn_offset	= offset;
> 
> and they need to be set always, otherwise it will affect on other
> DT-based arches.

Ok, in which case we can either configure the struct device in
of_dma_configure before calling arch_setup_dma_ops, or we can do the work
in a generic version of arch_setup_dma_ops (that I haven't added yet).

The former is how it's done in mainline atm, so I'll stick with that.

Thanks,

Will
