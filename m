From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 12 Jan 2017 11:35:01 +0100
Subject: [RFC PATCH v4 0/5] ARM: Fix dma_alloc_coherent() and friends for
 NOMMU
In-Reply-To: <f4d17374-eb46-79f7-e394-cb2739f71ef4@arm.com>
References: <1484057925-23586-1-git-send-email-vladimir.murzin@arm.com>
 <CA+M3ks5JP14SzprzE90-ST8b3URJECgpJ=dxw5XKvaxYEF3UCw@mail.gmail.com>
 <f4d17374-eb46-79f7-e394-cb2739f71ef4@arm.com>
Message-ID: <CA+M3ks5jTNSLLOetvOUZP=B=a2wPNjXadbw6Zcn475Okc4QEPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-11 15:34 GMT+01:00 Vladimir Murzin <vladimir.murzin@arm.com>:
> On 11/01/17 13:17, Benjamin Gaignard wrote:
>> 2017-01-10 15:18 GMT+01:00 Vladimir Murzin <vladimir.murzin@arm.com>:
>>> Hi,
>>>
>>> It seem that addition of cache support for M-class cpus uncovered
>>> latent bug in DMA usage. NOMMU memory model has been treated as being
>>> always consistent; however, for R/M classes of cpu memory can be
>>> covered by MPU which in turn might configure RAM as Normal
>>> i.e. bufferable and cacheable. It breaks dma_alloc_coherent() and
>>> friends, since data can stuck in caches now or be buffered.
>>>
>>> This patch set is trying to address the issue by providing region of
>>> memory suitable for consistent DMA operations. It is supposed that
>>> such region is marked by MPU as non-cacheable. Robin suggested to
>>> advertise such memory as reserved shared-dma-pool, rather then using
>>> homebrew command line option, and extend dma-coherent to provide
>>> default DMA area in the similar way as it is done for CMA (PATCH
>>> 2/5). It allows us to offload all bookkeeping on generic coherent DMA
>>> framework, and it is seems that it might be reused by other
>>> architectures like c6x and blackfin.
>>>
>>> Dedicated DMA region is required for cases other than:
>>>  - MMU/MPU is off
>>>  - cpu is v7m w/o cache support
>>>  - device is coherent
>>>
>>> In case one of the above conditions is true dma operations are forced
>>> to be coherent and wired with dma_noop_ops.
>>>
>>> To make life easier NOMMU dma operations are kept in separate
>>> compilation unit.
>>>
>>> Since the issue was reported in the same time as Benjamin sent his
>>> patch [1] to allow mmap for NOMMU, his case is also addressed in this
>>> series (PATCH 1/5 and PATCH 3/5).
>>>
>>> Thanks!
>>
>> I have tested this v4 on my setup (stm32f4, no cache, no MPU) and unfortunately
>> it doesn't work with my drm/kms driver.
>
> I guess the same is for fbmem, but would be better to have confirmation since
> amba-clcd I use has not been ported to drm/kms (yet), so I can't test.
>
>> I haven't any errors but nothing is displayed unlike what I have when
>> using current dma-mapping
>> code.
>> I guess the issue is coming from dma-noop where __get_free_pages() is
>> used instead of alloc_pages()
>> in dma-mapping.
>
> Unless I've missed something bellow is a call stack for both
>
> #1
> __alloc_simple_buffer
>         __dma_alloc_buffer
>                 alloc_pages
>                 split_page
>                 __dma_clear_buffer
>                         memset
>         page_address
>
> #2
> __get_free_pages
>         alloc_pages
>         page_address
>
> So the difference is that nommu case in dma-mapping.c memzeros memory, handles
> DMA_ATTR_NO_KERNEL_MAPPING and does optimisation of memory usage.
>
> Is something from above critical for your driver?

I have removed all the diff (split_page,  __dma_clear_buffer, memset)
from #1 and it is still working.
DMA_ATTR_NO_KERNEL_MAPPING flag is not set when allocating the buffer.

I have investigated more and found that dma-noop doesn't take care of
"dma-ranges" property which is set in DT.
I believed that is the root cause of my problem with your patches.

Benjamin

>
>>
>> Since my hardware doesn't have cache or MPU (and so use dma-noop) I
>> haven't reserved specific memory region.
>> Buffer addresses and vma parameters look correct... What could I have
>> miss here ?
>
> No ideas, sorry...
>
> Cheers
> Vladimir
>
>>
>> Benjamin
>>
>>>
>>> [1] http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8633/1
>>>
>>> Vladimir Murzin (5):
>>>   dma: Add simple dma_noop_mmap
>>>   drivers: dma-coherent: Introduce default DMA pool
>>>   ARM: NOMMU: Introduce dma operations for noMMU
>>>   ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
>>>   ARM: dma-mapping: Remove traces of NOMMU code
>>>
>>>  .../bindings/reserved-memory/reserved-memory.txt   |   3 +
>>>  arch/arm/include/asm/dma-mapping.h                 |   3 +-
>>>  arch/arm/mm/Kconfig                                |   2 +-
>>>  arch/arm/mm/Makefile                               |   5 +-
>>>  arch/arm/mm/dma-mapping-nommu.c                    | 252 +++++++++++++++++++++
>>>  arch/arm/mm/dma-mapping.c                          |  26 +--
>>>  drivers/base/dma-coherent.c                        |  59 ++++-
>>>  lib/dma-noop.c                                     |  21 ++
>>>  8 files changed, 335 insertions(+), 36 deletions(-)
>>>  create mode 100644 arch/arm/mm/dma-mapping-nommu.c
>>>
>>> --
>>> 2.0.0
>>>
>>
>>
>>
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
