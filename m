From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 11 Aug 2015 14:31:34 +0100
Subject: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <20150811093742.GC14980@8bytes.org>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
 <20150807084228.GU14980@8bytes.org> <55C4B4DF.4040608@arm.com>
 <20150811093742.GC14980@8bytes.org>
Message-ID: <55C9F936.8080201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 11/08/15 10:37, Joerg Roedel wrote:
> On Fri, Aug 07, 2015 at 02:38:39PM +0100, Robin Murphy wrote:
>> Indeed, DMA_DEBUG will check that a driver is making DMA API calls
>> to the arch code in the right way; this is a different check, to
>> catch things like the arch code passing the wrong domain into this
>> layer, or someone else having messed directly with the domain via
>> the IOMMU API. If the iommu_unmap doesn't match the IOVA region we
>> looked up, that means the IOMMU page tables have somehow become
>> inconsistent with the IOVA allocator, so we are in an unrecoverable
>> situation where we can no longer be sure what devices have access
>> to. That's bad.
>
> Sure, but the BUG_ON would also trigger on things like a double-free,
> which is bad to handle as a BUG_ON. A WARN_ON for this is sufficient.

Oh dear, it gets even better than that; in the case of a simple 
double-unmap where the IOVA is already free, we wouldn't even get as far 
as that check because we'd die calling iova_size(NULL). How on Earth did 
I get to v5 without spotting that? :(

Anyway, on reflection I think you're probably right; I've clearly been 
working on this for long enough to start falling into the "my thing is 
obviously more important than all the other things" trap.

>> AFAIK, yes (this is just a slight tidyup of the existing code that
>> 32-bit Exynos/Tegra/Rockchip/etc. devices are already using) - the
>> display guys want increasingly massive contiguous allocations for
>> framebuffers, layers, etc., so having IOMMU magic deal with that
>> saves CMA for non-IOMMU devices that really need it.
>
> Makes sense, I thougt about something similar for x86 too to avoid the
> high-order allocations we currently do. I guess the buffer will later be
> mapped into the vmalloc space for the CPU?

Indeed - for non-coherent devices we have to remap all allocations 
(IOMMU or not) anyway in order to get a non-cacheable CPU mapping of the 
buffer, so having non-contiguous pages is no bother; for coherent 
devices we can just do the same thing but keep the vmalloc mapping 
cacheable. There's also the DMA_ATTR_NO_KERNEL_MAPPING case (e.g. GPU 
just wants a big buffer to render into and read back out again) where we 
wouldn't need a CPU address at all, although on arm64 vmalloc space is 
cheap enough that we've no plans to implement that at the moment.

Robin.
