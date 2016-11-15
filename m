From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Nov 2016 12:18:05 +0100
Subject: [PATCH] ARM: dma-mapping: preallocate DMA-debug hash tables in
 pure_initcall
In-Reply-To: <9470b8cc-daaf-0edc-da33-0872d9919311@samsung.com>
References: <CGME20161115100459eucas1p152b644d5d329192a0902c836b13f35ba@eucas1p1.samsung.com>
 <3289056.5bg7xtivbS@wuerfel>
 <9470b8cc-daaf-0edc-da33-0872d9919311@samsung.com>
Message-ID: <6476437.ygKkNgMBPR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 15, 2016 11:39:17 AM CET Marek Szyprowski wrote:
> On 2016-11-15 11:31, Arnd Bergmann wrote:
> > On Tuesday, November 15, 2016 11:04:55 AM CET Marek Szyprowski wrote:
> >> fs_initcall is definitely too late to initialize DMA-debug hash tables,
> >> because some drivers might get probed and use DMA mapping framework
> >> already in core_initcall. Late initialization of DMA-debug results in
> >> false warning about accessing memory, that was not allocated, like this
> >> one:
> > To ask the obvious question: what driver does DMA allocations in a
> > core_initcall, and have you tried to change that first?
> 
> See the attached stack trace.
> 
> Exynos IOMMU driver does that in its domain_alloc implementation (to 
> allocate
> first level of PTE) and I see no easy way to avoid that, as iommu 
> domains are
> allocated very early (as well as the whole IOMMU initialization and 
> attaching
> to the devices). Exynos IOMMU driver has to use DMA-mapping API for PTE
> management, because the IOMMU controllers are not coherent with system 
> CPU and
> there is no other way to ensure proper CPU cache management.

Could the allocation be deferred until the first user of the IOMMU
comes up?

	Arnd
