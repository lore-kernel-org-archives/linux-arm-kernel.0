From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 13 Dec 2016 18:32:59 +0000
Subject: [RFC v2 PATCH 0/3] Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <58500D86.4070600@arm.com>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
 <20161213140711.GY14217@n2100.armlinux.org.uk> <58500243.8070107@arm.com>
 <ed07f3ca-8ce7-fb1b-2292-238ecf6460da@arm.com> <58500D86.4070600@arm.com>
Message-ID: <552e7994-31ee-9ec8-4acd-8f37d1a157a4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/16 15:02, Vladimir Murzin wrote:
> On 13/12/16 14:25, Robin Murphy wrote:
>> On 13/12/16 14:14, Vladimir Murzin wrote:
>>> On 13/12/16 14:07, Russell King - ARM Linux wrote:
>>>> On Tue, Dec 13, 2016 at 01:45:01PM +0000, Vladimir Murzin wrote:
>>>>> This patch set is trying to address the issue by providing region of
>>>>> memory suitable for consistent DMA operations. It is supposed that such
>>>>> region is marked by MPU as non-cacheable. Since we have MPU support in
>>>>> Linux for R-class only and M-class setting MPU in bootloader, proposed
>>>>> interface to advertise such memory is via "memdma=size at start" command
>>>>> line option, to avoid clashing with normal memory (which usually comes
>>>>> from dts) it'd be safer to use it together with "mem=" command line
>>>>> option. Meanwhile, I'm open to suggestions for the better way telling
>>>>> Linux of such memory.
>>>>
>>>> For those nommu systems where the MPU is not used, how do they allocate
>>>> DMA memory without setting aside a chunk of memory?
>>>>
>>>> >From what I understand of the current nommu code, it would just use
>>>> the normal page allocator for DMA memory allocation, so now requiring
>>>> everything to fit the "nommu has mpu" case seems like it's going to
>>>> break older nommu.
>>>>
>>>
>>> Probably, it'd be better if we just fallback to dma-noop operations if there
>>> is no dma region, i.e. assume that platform is coherent. We still need a way
>>> to tell user that absence of such region can be reason of broken DMA.
>>
>> As I mentioned internally, I think it would be worth trying to use CMA
>> for this, because dma_map_ops are already wired to try that first, and
>> from what I can see it seems already set up to do precisely this via a
>> "shared-dma-pool" reserved memory region (see rmem_cma_setup() in
>> drivers/base/dma-contiguous.c) - mandating that for cached v7-M systems
>> whilst letting cache-less/non-MPU systems automatically fall back to the
>> normal page allocator in its absence would seem to solve all 3 cases.
> 
> Unfortunately,
> 
> config DMA_CMA
>         bool "DMA Contiguous Memory Allocator"
>         depends on HAVE_DMA_CONTIGUOUS && CMA
>         help
> ...
> config CMA
>         bool "Contiguous Memory Allocator"
>         depends on HAVE_MEMBLOCK && MMU
> 	select MIGRATION
> 
> and it blows up if I remove dependecy on MMU :(

Ah yes, fair enough.

> Another option would be drivers/base/dma-coherent.c, but, IIUC, in this case
> memory is reserved per device exclusively, so I'm in doubt if tiny M-class can
> afford that...

I think as usual I managed to conflate the two - it was actually
dma_alloc_from_coherent() I had in mind when I mentioned dma_map_ops. It
does seem from 7bfa5ab6fa1b that dma-coherent *can* handle multiple
devices per region, so it wouldn't appear to be too hard to implement a
default coherent region (possibly specific to ARM_MPU) for all devices
in a similar manner to the default contiguous region. Either way I do
still think a reserved memory region in the DT is nicer and probably
more robust than the command line parameter.

Robin.

>> Other than the allocator issue, though, the rest of the refactoring does
>> look nice.
> 
> Thanks for going through it!
> 
> Cheers
> Vladimir
