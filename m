From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Apr 2018 13:28:46 +0100
Subject: [VERY RFC 0/2] iommu: optionally skip attaching to a DMA domain
In-Reply-To: <20180411185510.11594-1-jcrouse@codeaurora.org>
References: <20180411185510.11594-1-jcrouse@codeaurora.org>
Message-ID: <5b4519c1-f10a-9786-7d87-e11896482b98@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/18 19:55, Jordan Crouse wrote:
> I've been struggling with a problem for a while and I haven't been able to come
> up with a clean solution. Rob convinced me to stop complaining and do
> _something_ and hopefully this can spur a good discussion.
> 
> The scenario is basically this: The MSM GPU wants to manage its own IOMMU
> virtual address space in lieu of using the DMA API to do so. The most important
> reason is that when per-instance pagetables [1] are enabled each file descriptor
> uses its own pagetable which are dynamically switched between contexts. In
> conjunction with this we use a split pagetable scheme to allow global buffers
> be persistently mapped so even a single pagetable has multiple ranges that need
> to be utilized based on buffer type.
> 
> Obviously the DMA API isn't suitable for this kind of specialized use. We want
> to push it off to the side, allocate our own domain, and use it directly with
> the IOMMU APIs. In a perfect world we would just not use the DMA API and attach
> our own domain and that would be the end of the story. Unfortunately this is not
> a perfect world.
> 
> In order to switch the pagetable from the GPU the SoC has some special wiring so
> that the GPU can reprogram the TTBR0 register in the IOMMU to the appropriate
> value. For a variety of reasons the hardware is hardcoded to only be able to
> access context bank 0 in the SMMU device. Long story short; if the DMA
> domain is allocated during bus enumeration and attached to context bank 0 then
> by the time we get to the driver domain we have long since lost our chance to
> get the context bank we need.

Red herrings abound! That's not actually the DMA domain's fault at all, 
it just happens to fall out of the current SMMU driver behaviour. If the 
context bank allocator went top-down instead of bottom-up (IIRC I nearly 
ended up with that at one point during refactoring all that lot, or 
maybe that was the SMR allocator...) then you'd see a very different 
perspective of the problem.

The driver could certainly do with being cleverer in terms of not 
keeping hardware CBs allocated for inactive domains - right now I don't 
think you can even move a device from one domain to another at all if 
you only have a single context bank, which is pretty bogus. That alone 
might even manage to hide this problem, but I wouldn't like to rely on 
it. The "device X can only use context bank N" condition is a real 
hardware limitation which should be described by firmware, but I don't 
have any immediate good ideas as to how :(

The matter of opting out of DMA ops which expect the default domain is a 
separate and more general issue, so I won't start a fork of that 
discussion here.

Robin.

> After going back and forth and trying a few possible options it seems like the
> "easiest" solution" is to skip attaching the DMA domain in the first place. But
> we still need to create a default domain and set up the IOMMU groups correctly
> so that when the GPU driver comes along it can attach the device and everything
> will Just Work (TM). Rob suggested that we should use a blacklist of devices
> that choose to not participate so thats what I'm offering as a starting point
> for discussion.
> 
> The first patch in this series allows the specific IOMMU driver to gracefully
> skip attaching a device by returning -ENOSUPP. In that case, the core will
> skip printing error messages and it won't attach the domain to the group but
> it still allows the group to get created so that the IOMMU device is properly
> set up. In arch_setup_dma_ops() the call to iommu_get_domain_for_dev() will
> return NULL and the IOMMU ops won't be set up.
> 
> The second patch implements the blacklist in arm-smmu.c based on the compatible
> string of the GPU device and returns -ENOTSUPP.
> 
> I tested this with my current per-instance pagetable stack and it does the job
> but I am very much in the market for better ideas.
> 
> [1] https://patchwork.freedesktop.org/series/38729/
> 
> Jordan Crouse (2):
>    iommu: Gracefully allow drivers to not attach to a default domain
>    iommu/arm-smmu: Add list of devices to opt out of DMA domains
> 
>   drivers/iommu/arm-smmu.c | 23 +++++++++++++++++++++++
>   drivers/iommu/iommu.c    | 18 ++++++++++++++----
>   2 files changed, 37 insertions(+), 4 deletions(-)
> 
