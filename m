From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 23 Mar 2017 09:26:23 +0000
Subject: [PATCH v3 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <33321273-E3E7-459B-A615-5ADA52445AA1@esh.hu>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <90e219f3-7139-c11c-a635-509173d4148a@arm.com>
 <33321273-E3E7-459B-A615-5ADA52445AA1@esh.hu>
Message-ID: <186f0c06-39ce-cb88-35e5-6dd57aa81166@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/17 12:23, Szemz? Andr?s wrote:
> I?ve tested this v3 version on my Atmel armv7m board with several drivers with DMA and enabled caches,
> and I?ve not seen any issues.
> 
> You can add my Tested-by.

Much appreciated! 

Russell, Andrew, Greg, any advise on how to get this series merged? Patches
has been circulated on a list since December last year and without them Andr?s
and Alexandre cannot safely enable DMA on their platforms.

Cheers
Vladimir

> 
> Thanks for the patches!
> 
> Andras 
> 
>> On 2017. Mar 16., at 10:03, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> Gentle ping!
>>
>> On 10/03/17 09:23, Vladimir Murzin wrote:
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
>>> - MMU/MPU is off
>>> - cpu is v7m w/o cache support
>>> - device is coherent
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
>>> Cc: Joerg Roedel <jroedel@suse.de>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: Michal Nazarewicz <mina86@mina86.com>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Doug Ledford <dledford@redhat.com>
>>>
>>> Changelog:
>>> 	    v2 -> v3
>>> 	       - fixed warnings reported by Alexandre and kbuild robot
>>>
>>> 	    v1 -> v2
>>> 	       - rebased on v4.11-rc1
>>> 	       - added Robin's Reviewed-by
>>> 	       - dedicated flag is introduced to use dev->dma_pfn_offset
>>> 	         rather than mem->device_base in case memory region is
>>> 		 configured via device tree (so Tested-by discarded there)
>>>
>>> 	RFC v6 -> v1
>>> 	       - dropped RFC tag
>>> 	       - added Alexandre's Tested-by
>>>
>>> Vladimir Murzin (7):
>>>  dma: Take into account dma_pfn_offset
>>>  dma: Add simple dma_noop_mmap
>>>  drivers: dma-coherent: Account dma_pfn_offset when used with device
>>>    tree
>>>  drivers: dma-coherent: Introduce default DMA pool
>>>  ARM: NOMMU: Introduce dma operations for noMMU
>>>  ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
>>>  ARM: dma-mapping: Remove traces of NOMMU code
>>>
>>> .../bindings/reserved-memory/reserved-memory.txt   |   3 +
>>> arch/arm/Kconfig                                   |   1 +
>>> arch/arm/include/asm/dma-mapping.h                 |   2 +-
>>> arch/arm/mm/Kconfig                                |   2 +-
>>> arch/arm/mm/Makefile                               |   5 +-
>>> arch/arm/mm/dma-mapping-nommu.c                    | 253 +++++++++++++++++++++
>>> arch/arm/mm/dma-mapping.c                          |  29 +--
>>> drivers/base/dma-coherent.c                        |  74 +++++-
>>> lib/dma-noop.c                                     |  29 ++-
>>> 9 files changed, 354 insertions(+), 44 deletions(-)
>>> create mode 100644 arch/arm/mm/dma-mapping-nommu.c
>>>
>>
> 
> 
