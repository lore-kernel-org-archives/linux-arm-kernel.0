From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 15 Feb 2017 09:59:45 +0000
Subject: [PATCH 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
Message-ID: <1487152792-34214-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seem that addition of cache support for M-class CPUs uncovered
latent bug in DMA usage. NOMMU memory model has been treated as being
always consistent; however, for R/M CPU classes memory can be covered
by MPU which in turn might configure RAM as Normal i.e. bufferable and
cacheable. It breaks dma_alloc_coherent() and friends, since data can
stuck in caches now or be buffered.

This patch set is trying to address the issue by providing region of
memory suitable for consistent DMA operations. It is supposed that
such region is marked by MPU as non-cacheable. Robin suggested to
advertise such memory as reserved shared-dma-pool, rather then using
homebrew command line option, and extend dma-coherent to provide
default DMA area in the similar way as it is done for CMA (PATCH
4/7). It allows us to offload all bookkeeping on generic coherent DMA
framework, and it seems that it might be reused by other architectures
like c6x and blackfin.

While reviewing/testing previous vesrions of the patch set it turned
out that dma-coherent does not take into account "dma-ranges" device
tree property, so it is addressed in PATCH 3/7.

For ARM, dedicated DMA region is required for cases other than:
 - MMU/MPU is off
 - cpu is v7m w/o cache support
 - device is coherent

In case one of the above conditions is true dma operations are forced
to be coherent and wired with dma_noop_ops.

To make life easier NOMMU dma operations are kept in separate
compilation unit.

Since the issue was reported in the same time as Benjamin sent his
patch [1] to allow mmap for NOMMU, his case is also addressed in this
series (PATCH 1/7 and PATCH 2/7).

Thanks!

[1] http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8633/1

Changelog:
	RFC v6 -> v1
	       - dropped RFC tag
	       - added Alexandre's Tested-by

Vladimir Murzin (7):
  dma: Take into account dma_pfn_offset
  dma: Add simple dma_noop_mmap
  drivers: dma-coherent: Account dma_pfn_offset when used with device
    tree
  drivers: dma-coherent: Introduce default DMA pool
  ARM: NOMMU: Introduce dma operations for noMMU
  ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
  ARM: dma-mapping: Remove traces of NOMMU code

 .../bindings/reserved-memory/reserved-memory.txt   |   3 +
 arch/arm/include/asm/dma-mapping.h                 |   3 +-
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm/mm/Makefile                               |   5 +-
 arch/arm/mm/dma-mapping-nommu.c                    | 253 +++++++++++++++++++++
 arch/arm/mm/dma-mapping.c                          |  26 +--
 drivers/base/dma-coherent.c                        |  76 ++++++-
 lib/dma-noop.c                                     |  29 ++-
 8 files changed, 356 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/mm/dma-mapping-nommu.c

-- 
2.0.0
