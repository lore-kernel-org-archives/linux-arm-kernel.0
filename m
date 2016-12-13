From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 13 Dec 2016 14:25:35 +0000
Subject: [RFC v2 PATCH 0/3] Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <58500243.8070107@arm.com>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
 <20161213140711.GY14217@n2100.armlinux.org.uk> <58500243.8070107@arm.com>
Message-ID: <ed07f3ca-8ce7-fb1b-2292-238ecf6460da@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/16 14:14, Vladimir Murzin wrote:
> On 13/12/16 14:07, Russell King - ARM Linux wrote:
>> On Tue, Dec 13, 2016 at 01:45:01PM +0000, Vladimir Murzin wrote:
>>> This patch set is trying to address the issue by providing region of
>>> memory suitable for consistent DMA operations. It is supposed that such
>>> region is marked by MPU as non-cacheable. Since we have MPU support in
>>> Linux for R-class only and M-class setting MPU in bootloader, proposed
>>> interface to advertise such memory is via "memdma=size at start" command
>>> line option, to avoid clashing with normal memory (which usually comes
>>> from dts) it'd be safer to use it together with "mem=" command line
>>> option. Meanwhile, I'm open to suggestions for the better way telling
>>> Linux of such memory.
>>
>> For those nommu systems where the MPU is not used, how do they allocate
>> DMA memory without setting aside a chunk of memory?
>>
>> >From what I understand of the current nommu code, it would just use
>> the normal page allocator for DMA memory allocation, so now requiring
>> everything to fit the "nommu has mpu" case seems like it's going to
>> break older nommu.
>>
> 
> Probably, it'd be better if we just fallback to dma-noop operations if there
> is no dma region, i.e. assume that platform is coherent. We still need a way
> to tell user that absence of such region can be reason of broken DMA.

As I mentioned internally, I think it would be worth trying to use CMA
for this, because dma_map_ops are already wired to try that first, and
from what I can see it seems already set up to do precisely this via a
"shared-dma-pool" reserved memory region (see rmem_cma_setup() in
drivers/base/dma-contiguous.c) - mandating that for cached v7-M systems
whilst letting cache-less/non-MPU systems automatically fall back to the
normal page allocator in its absence would seem to solve all 3 cases.

Other than the allocator issue, though, the rest of the refactoring does
look nice.

Robin.

> 
> Cheers
> Vladimir
> 
