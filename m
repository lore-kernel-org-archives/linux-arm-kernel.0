From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Dec 2016 13:45:01 +0000
Subject: [RFC v2 PATCH 0/3] Fix dma_alloc_coherent() and friends for NOMMU
Message-ID: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seem that addition of cache support for M-class cpus uncovered
latent bug in DMA usage. NOMMU memory model has been treated as being
always consistent; however, for R/M classes of cpu memory can be
covered by MPU which in turn might configure RAM as Normal
i.e. bufferable and cacheable. It breaks dma_alloc_coherent() and
friends, since data can stuck in caches now or be buffered.

This patch set is trying to address the issue by providing region of
memory suitable for consistent DMA operations. It is supposed that such
region is marked by MPU as non-cacheable. Since we have MPU support in
Linux for R-class only and M-class setting MPU in bootloader, proposed
interface to advertise such memory is via "memdma=size at start" command
line option, to avoid clashing with normal memory (which usually comes
from dts) it'd be safer to use it together with "mem=" command line
option. Meanwhile, I'm open to suggestions for the better way telling
Linux of such memory.

For configuration without cache support (like Cortex-M3/M4) dma
operations are forced to be coherent and wired with dma-noop. Such
decision is made based on cacheid global variable. In case cpu
supports caches and no coherent memory region is given - dma is
disallowed. Probably, some other important checks are missing, so I'll
all my ears :)

To make life easier NOMMU dma operations are kept in separate
compilation unit.

Thanks!

Changelog:

    RFC v1 -> RFC v2
           - s/dmac_unmap_area/dmac_map_area in __dma_page_cpu_to_dev()
	   - removed unrelated changes in nommu.c

Vladimir Murzin (3):
  ARM: NOMMU: introduce dma operations for noMMU
  ARM: NOMMU: set ARM_DMA_MEM_BUFFERABLE for M-class cpus
  ARM: dma-mapping: remove traces of NOMMU code

 arch/arm/include/asm/dma-mapping.h |    3 +-
 arch/arm/mm/Kconfig                |    2 +-
 arch/arm/mm/Makefile               |    5 +-
 arch/arm/mm/dma-mapping-nommu.c    |  262 ++++++++++++++++++++++++++++++++++++
 arch/arm/mm/dma-mapping.c          |   26 +---
 arch/arm/mm/mm.h                   |    3 +
 arch/arm/mm/nommu.c                |    6 +
 7 files changed, 278 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/mm/dma-mapping-nommu.c

-- 
1.7.9.5
