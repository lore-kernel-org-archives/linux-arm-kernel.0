From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 21 Feb 2017 12:27:45 +0000
Subject: [PATCH 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <c713deed-b2bd-e413-70e2-08c51c1f8c3e@arm.com>
References: <1487152792-34214-1-git-send-email-vladimir.murzin@arm.com>
 <b71a0cc6-4c5a-0dbb-f9ab-9f8d4f3794b0@arm.com>
 <c713deed-b2bd-e413-70e2-08c51c1f8c3e@arm.com>
Message-ID: <a0ec7767-c3d1-20b7-48c5-ef71be5918e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 21/02/17 12:16, Robin Murphy wrote:
> Hi Vladimir,
> 
> On 21/02/17 10:41, Vladimir Murzin wrote:
>> Gentle ping!
> 
> What's your plan for this series? Are you looking for acks on the common
> parts to take it through the ARM tree, or Russell's ack on the ARM parts
> for it to go through mm?

Nothing particular in my mind - either way would work me. So far I have not
heard feedback on common parts and it is not clear to me who should give Ack
on them :(

> 
> Either way, I expect the merge window is probably consuming most folks'
> attention just now.

I see.

Cheers
Vladimir

> 
> Robin.
> 
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Michal Nazarewicz <mina86@mina86.com>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>>
>> On 15/02/17 09:59, Vladimir Murzin wrote:
>>> Hi,
>>>
>>> It seem that addition of cache support for M-class CPUs uncovered
>>> latent bug in DMA usage. NOMMU memory model has been treated as being
>>> always consistent; however, for R/M CPU classes memory can be covered
>>> by MPU which in turn might configure RAM as Normal i.e. bufferable and
>>> cacheable. It breaks dma_alloc_coherent() and friends, since data can
>>> stuck in caches now or be buffered.
>>>
>>> This patch set is trying to address the issue by providing region of
>>> memory suitable for consistent DMA operations. It is supposed that
>>> such region is marked by MPU as non-cacheable. Robin suggested to
>>> advertise such memory as reserved shared-dma-pool, rather then using
>>> homebrew command line option, and extend dma-coherent to provide
>>> default DMA area in the similar way as it is done for CMA (PATCH
>>> 4/7). It allows us to offload all bookkeeping on generic coherent DMA
>>> framework, and it seems that it might be reused by other architectures
>>> like c6x and blackfin.
>>>
>>> While reviewing/testing previous vesrions of the patch set it turned
>>> out that dma-coherent does not take into account "dma-ranges" device
>>> tree property, so it is addressed in PATCH 3/7.
>>>
>>> For ARM, dedicated DMA region is required for cases other than:
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
>>> series (PATCH 1/7 and PATCH 2/7).
>>>
>>> Thanks!
>>>
>>> [1] http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8633/1
>>>
>>> Changelog:
>>> 	RFC v6 -> v1
>>> 	       - dropped RFC tag
>>> 	       - added Alexandre's Tested-by
>>>
>>> Vladimir Murzin (7):
>>>   dma: Take into account dma_pfn_offset
>>>   dma: Add simple dma_noop_mmap
>>>   drivers: dma-coherent: Account dma_pfn_offset when used with device
>>>     tree
>>>   drivers: dma-coherent: Introduce default DMA pool
>>>   ARM: NOMMU: Introduce dma operations for noMMU
>>>   ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
>>>   ARM: dma-mapping: Remove traces of NOMMU code
>>>
>>>  .../bindings/reserved-memory/reserved-memory.txt   |   3 +
>>>  arch/arm/include/asm/dma-mapping.h                 |   3 +-
>>>  arch/arm/mm/Kconfig                                |   2 +-
>>>  arch/arm/mm/Makefile                               |   5 +-
>>>  arch/arm/mm/dma-mapping-nommu.c                    | 253 +++++++++++++++++++++
>>>  arch/arm/mm/dma-mapping.c                          |  26 +--
>>>  drivers/base/dma-coherent.c                        |  76 ++++++-
>>>  lib/dma-noop.c                                     |  29 ++-
>>>  8 files changed, 356 insertions(+), 41 deletions(-)
>>>  create mode 100644 arch/arm/mm/dma-mapping-nommu.c
>>>
>>
> 
> 
