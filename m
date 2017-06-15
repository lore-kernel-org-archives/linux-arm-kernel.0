From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 15 Jun 2017 08:25:06 +0100
Subject: [PATCH v5 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <20170608162555.GP4902@n2100.armlinux.org.uk>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <4e7625ec-54cd-899f-39a7-7cf0c2c8cb26@arm.com>
 <20170608162555.GP4902@n2100.armlinux.org.uk>
Message-ID: <e9ab0dd0-17e5-b124-6637-3651fea86713@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg?

On 08/06/17 17:25, Russell King - ARM Linux wrote:
> Well, I've no objection to this, but it does need acks from other
> people before I can apply it.
> 
> There's two patches that touch drivers/base that need Greg's ack.
> 
> I'm not sure what's happening with lib/dma-noop.c, there doesn't
> appear to be a maintainer list for it, so I guess that's a
> free-for-all.
> 
> On Thu, Jun 08, 2017 at 09:28:30AM +0100, Vladimir Murzin wrote:
>> Ping!
>>
>> On 24/05/17 11:24, Vladimir Murzin wrote:
>>> Short story:
>>>
>>> Without these patches coherent DMA is broken for Andr?s and Alexandre,
>>> so they cannot safely enable DMA on their platforms.
>>>
>>> Patches have been circulated on a list since last year without much
>>> attention to changes in dma-coherent.c and dma-noop.c. Meanwhile, ARM
>>> bits have been reviewed and there is no strict objection to get them
>>> merged. Unfortunately, applying only ARM bits doesn't help much and
>>> the original issue would still exist.
>>>
>>> Please, let me know how to move with this fix forward?
>>>
>>> Long story:
>>>
>>> It seems that addition of cache support for M-class CPUs uncovered
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
>>> While reviewing/testing previous versions of the patch set it turned
>>> out that dma-coherent does not take into account "dma-ranges" device
>>> tree property, so it is addressed in PATCH 3/7.
>>>
>>> For ARM, dedicated DMA region is required for cases other than:
>>>  - MMU/MPU is off
>>>  - cpu is v7m w/o cache support
>>>  - device is coherent
>>>
>>> In case any of the above conditions is true dma operations are forced
>>> to be coherent and wired with dma_noop_ops.
>>>
>>> To make life easier NOMMU dma operations are kept in separate
>>> compilation unit.
>>>
>>> Since the issue was reported at the same time as Benjamin sent his
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
>>> 	    v4 -> v5
>>> 	       - rebased on v4.12-rc2
>>> 	       - updated description for CONFIG_ARM_DMA_MEM_BUFFERABLE
>>>
>>> 	    v3 -> v4
>>> 	       - rebased on v4.11-rc7
>>> 	       - made CONFIG_ARM_DMA_MEM_BUFFERABLE optional for CPU_V7M
>>> 	       - added Arnd's Acked-by
>>>
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
>>>  arch/arm/Kconfig                                   |   1 +
>>>  arch/arm/include/asm/dma-mapping.h                 |   2 +-
>>>  arch/arm/mm/Kconfig                                |   8 +-
>>>  arch/arm/mm/Makefile                               |   5 +-
>>>  arch/arm/mm/dma-mapping-nommu.c                    | 253 +++++++++++++++++++++
>>>  arch/arm/mm/dma-mapping.c                          |  29 +--
>>>  drivers/base/dma-coherent.c                        |  74 +++++-
>>>  lib/dma-noop.c                                     |  29 ++-
>>>  9 files changed, 359 insertions(+), 45 deletions(-)
>>>  create mode 100644 arch/arm/mm/dma-mapping-nommu.c
>>>
>>
> 
