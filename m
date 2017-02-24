From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 24 Feb 2017 13:52:08 +0000
Subject: [RFC PATCH v6 0/7] ARM: Fix dma_alloc_coherent() and friends for
 NOMMU
In-Reply-To: <ee0c9417-3665-4c56-dd57-2595eb3b8b1c@st.com>
References: <1485448965-32855-1-git-send-email-vladimir.murzin@arm.com>
 <ee0c9417-3665-4c56-dd57-2595eb3b8b1c@st.com>
Message-ID: <2fa0b2a6-bea0-b86f-91ae-b6b4493ede22@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 24/02/17 13:46, Alexandre Torgue wrote:
> Hi Vlad,
> 
> On 01/26/2017 05:42 PM, Vladimir Murzin wrote:
>> Hi,
>>
>> It seem that addition of cache support for M-class CPUs uncovered
>> latent bug in DMA usage. NOMMU memory model has been treated as being
>> always consistent; however, for R/M CPU classes memory can be covered
>> by MPU which in turn might configure RAM as Normal i.e. bufferable and
>> cacheable. It breaks dma_alloc_coherent() and friends, since data can
>> stuck in caches now or be buffered.
>>
>> This patch set is trying to address the issue by providing region of
>> memory suitable for consistent DMA operations. It is supposed that
>> such region is marked by MPU as non-cacheable. Robin suggested to
>> advertise such memory as reserved shared-dma-pool, rather then using
>> homebrew command line option, and extend dma-coherent to provide
>> default DMA area in the similar way as it is done for CMA (PATCH
>> 4/7). It allows us to offload all bookkeeping on generic coherent DMA
>> framework, and it seems that it might be reused by other architectures
>> like c6x and blackfin.
>>
>> While reviewing/testing previous vesrions of the patch set it turned
>> out that dma-coherent does not take into account "dma-ranges" device
>> tree property, so it is addressed in PATCH 3/7.
> 
> What it is the status of this RFC ? This patchset is very interesting for STM32 platform based on cortex M7 (STM32F746 and STM32H743). Without it, we can't activate DMA + CACHE.

Since I did not get feedback on common bits I've restarted with dropped RFC
tag [1]. Robin already gave useful feedback on some patches and I've addressed
them locally and planning resubmit after rc1.

[1] https://www.spinics.net/lists/arm-kernel/msg562802.html

Thanks
Vladimir

> 
> Thanks in advance
> Alex
> 
>>
>> For ARM, dedicated DMA region is required for cases other than:
>>  - MMU/MPU is off
>>  - cpu is v7m w/o cache support
>>  - device is coherent
>>
>> In case one of the above conditions is true dma operations are forced
>> to be coherent and wired with dma_noop_ops.
>>
>> To make life easier NOMMU dma operations are kept in separate
>> compilation unit.
>>
>> Since the issue was reported in the same time as Benjamin sent his
>> patch [1] to allow mmap for NOMMU, his case is also addressed in this
>> series (PATCH 1/7 and PATCH 2/7).
>>
>> Thanks!
>>
>> [1] http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8633/1
>>
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
>> Vladimir Murzin (7):
>>   dma: Take into account dma_pfn_offset
>>   dma: Add simple dma_noop_mmap
>>   drivers: dma-coherent: Account dma_pfn_offset when used with device
>>     tree
>>   drivers: dma-coherent: Introduce default DMA pool
>>   ARM: NOMMU: Introduce dma operations for noMMU
>>   ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
>>   ARM: dma-mapping: Remove traces of NOMMU code
>>
>>  .../bindings/reserved-memory/reserved-memory.txt   |   3 +
>>  arch/arm/include/asm/dma-mapping.h                 |   3 +-
>>  arch/arm/mm/Kconfig                                |   2 +-
>>  arch/arm/mm/Makefile                               |   5 +-
>>  arch/arm/mm/dma-mapping-nommu.c                    | 253 +++++++++++++++++++++
>>  arch/arm/mm/dma-mapping.c                          |  26 +--
>>  drivers/base/dma-coherent.c                        |  76 ++++++-
>>  lib/dma-noop.c                                     |  29 ++-
>>  8 files changed, 356 insertions(+), 41 deletions(-)
>>  create mode 100644 arch/arm/mm/dma-mapping-nommu.c
>>
> 
