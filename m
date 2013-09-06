From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Sep 2013 15:14:44 +0100
Subject: [PATCH v5 11/13] xen: introduce xen_alloc/free_coherent_pages
In-Reply-To: <alpine.DEB.2.02.1309051742390.6397@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
 <1377801154-29215-11-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130905160905.GI11887@arm.com>
 <alpine.DEB.2.02.1309051742390.6397@kaball.uk.xensource.com>
Message-ID: <20130906141444.GE1946@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 05:43:33PM +0100, Stefano Stabellini wrote:
> On Thu, 5 Sep 2013, Catalin Marinas wrote:
> > On Thu, Aug 29, 2013 at 07:32:32PM +0100, Stefano Stabellini wrote:
> > > xen_swiotlb_alloc_coherent needs to allocate a coherent buffer for cpu
> > > and devices. On native x86 and ARMv8 is sufficient to call
> > > __get_free_pages in order to get a coherent buffer, while on ARM we need
> > > to call arm_dma_ops.alloc.
> > 
> > Don't bet on this for ARMv8. It's not mandated for the architecture, so
> > at some point some SoC will require non-cacheable buffers for coherency.
> 
> I see.
> Would it be better if I implemented xen_alloc_coherent_pages on armv8 by
> calling arm64_swiotlb_dma_ops.alloc?

What does this buffer do exactly? Is it allocated by guests?

Currently arm64_swiotlb_dma_ops assume cache-coherent DMA. I have a
patch which introduces new ops for non-coherent DMA but this should
really be orthogonal to swiotlb. You can basically have 4 combinations
of coherent/non-coherent and swiotlb/iommu. Mark Rutland is currently
looking into how best to describe this via DT as it may not even be per
SoC but per bus or device.

-- 
Catalin
