From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 14:10:18 +0000
Subject: [PATCH 0/6] Bug-fixes and new features for 2.6.34-rc1
Message-ID: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There are some patches which I've had in my branch for some time and I
would like to get them merged by 2.6.34.

The first three are fixes to allow Linux to work better on SMP systems.
The next two are improvements for the ARMv7. The last patch remove the
use of domains for ARMv6k and ARMv7 processors. One of the reasons is
that because of domain switching, we can get speculative fetches from
I/O areas.


Catalin Marinas (6):
      Global ASID allocation on SMP
      Broadcast the DMA cache operations on ARMv6 SMP hardware
      Fix a race in the vfp_notifier() function on SMP systems
      ARMv7: Use lazy cache flushing if hardware broadcasts cache operations
      ARMv7: Improved page table format with TRE and AFE
      Remove the domain switching on ARMv6k/v7 CPUs


 arch/arm/include/asm/assembler.h   |    9 +-
 arch/arm/include/asm/cacheflush.h  |   29 ++++++++
 arch/arm/include/asm/domain.h      |   31 ++++++++
 arch/arm/include/asm/futex.h       |    9 +-
 arch/arm/include/asm/memory.h      |    6 +-
 arch/arm/include/asm/mmu.h         |    1 
 arch/arm/include/asm/mmu_context.h |   15 ++++
 arch/arm/include/asm/page.h        |    8 ++
 arch/arm/include/asm/pgalloc.h     |   10 ++-
 arch/arm/include/asm/pgtable.h     |  117 ++++++++++++++++++++++++++++----
 arch/arm/include/asm/smp_plat.h    |    9 ++
 arch/arm/include/asm/uaccess.h     |   16 ++--
 arch/arm/kernel/entry-armv.S       |    4 +
 arch/arm/kernel/smp.c              |  133 ++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c            |   17 +++++
 arch/arm/lib/getuser.S             |   13 ++--
 arch/arm/lib/putuser.S             |   29 ++++----
 arch/arm/lib/uaccess.S             |   83 +++++++++++-----------
 arch/arm/mm/Kconfig                |   26 +++++++
 arch/arm/mm/context.c              |  120 +++++++++++++++++++++++++++++---
 arch/arm/mm/dma-mapping.c          |   20 ++++-
 arch/arm/mm/fault-armv.c           |    2 -
 arch/arm/mm/fault.c                |   10 +++
 arch/arm/mm/flush.c                |    9 +-
 arch/arm/mm/mmu.c                  |    7 +-
 arch/arm/mm/proc-v7.S              |   58 ++++++----------
 arch/arm/vfp/vfpmodule.c           |   25 ++++++-
 27 files changed, 647 insertions(+), 169 deletions(-)

-- 
Catalin
