From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 11 Aug 2015 11:37:42 +0200
Subject: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <55C4B4DF.4040608@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
 <20150807084228.GU14980@8bytes.org> <55C4B4DF.4040608@arm.com>
Message-ID: <20150811093742.GC14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 02:38:39PM +0100, Robin Murphy wrote:
> Indeed, DMA_DEBUG will check that a driver is making DMA API calls
> to the arch code in the right way; this is a different check, to
> catch things like the arch code passing the wrong domain into this
> layer, or someone else having messed directly with the domain via
> the IOMMU API. If the iommu_unmap doesn't match the IOVA region we
> looked up, that means the IOMMU page tables have somehow become
> inconsistent with the IOVA allocator, so we are in an unrecoverable
> situation where we can no longer be sure what devices have access
> to. That's bad.

Sure, but the BUG_ON would also trigger on things like a double-free,
which is bad to handle as a BUG_ON. A WARN_ON for this is sufficient.

> AFAIK, yes (this is just a slight tidyup of the existing code that
> 32-bit Exynos/Tegra/Rockchip/etc. devices are already using) - the
> display guys want increasingly massive contiguous allocations for
> framebuffers, layers, etc., so having IOMMU magic deal with that
> saves CMA for non-IOMMU devices that really need it.

Makes sense, I thougt about something similar for x86 too to avoid the
high-order allocations we currently do. I guess the buffer will later be
mapped into the vmalloc space for the CPU?


	Joerg
