From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:27 -0400
Subject: [RFC/PATCH 0/7] ARM: ARM11 MPCore preemption/task migration cache
	coherency fixups
In-Reply-To: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
Message-ID: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

On ARM11 MPCore, the "SCU does not handle coherency consequences of CP15
cache operations" [1].  So cache maintenance functions have to insure
that memory is globally consistent.  Although the current Linux kernel
works reasonably well on ARM11 MPCore machines, PREEMPT stress testing,
e.g. parallel module loading and hackbench, results in crashes which
exhibit non-sense oops traces where machine state does not make sense
relative to the code executing at the time of the oops.

Review and analysis of the various ARM11 MPCore cache maintenance
functions reveal that there are a number critical sections in which
ARM11 MPCore caches and/or memory may become inconsistent, i.e. a
cache line on CPU A contains a modified entry but preemption and task
migration occurs after which the same cache line is cleaned/flushed
on CPU B.  This can obviously lead to inconsistent memory and/or
cache state as cache ops on ARM11 MPCore are non-coherent.

The following is a partial series of ARM11 MPCore preemption/task
migration fixes to resolve cache coherency problems on these machines:

George G. Davis (6):
      ARM: ARM11 MPCore: pte_alloc_one{,_kernel} are not preempt safe
      ARM: ARM11 MPCore: {clean,flush}_pmd_entry are not preempt safe
      ARM: ARM11 MPCore: clean_dcache_area is not preempt safe
      ARM: Move get_thread_info macro definition to <asm/assembler.h>
      ARM: ARM11 MPCore: DMA_CACHE_RWFO operations are not preempt safe
      ARM: ARM11 MPCore: cpu_v6_set_pte_ext is not preempt safe

Konstantin Baidarov (1):
      ARM: ARM11 MPCore: pgd_alloc is not preempt safe

 arch/arm/include/asm/assembler.h |   13 +++++++++++++
 arch/arm/include/asm/pgalloc.h   |   23 ++++++++++++++++++++---
 arch/arm/include/asm/pgtable.h   |    9 +++++++++
 arch/arm/include/asm/smp_plat.h  |    2 ++
 arch/arm/kernel/entry-header.S   |   11 -----------
 arch/arm/mm/cache-v6.S           |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mm/idmap.c              |    5 +++++
 arch/arm/mm/ioremap.c            |    9 +++++++++
 arch/arm/mm/mmu.c                |   12 ++++++++++++
 arch/arm/mm/pgd.c                |    7 +++++++
 arch/arm/mm/proc-v6.S            |   11 +++++++++++
 arch/arm/plat-omap/iommu.c       |   10 ++++++++++
 arch/arm/vfp/entry.S             |    5 ++++-
 arch/arm/vfp/vfphw.S             |    5 ++++-
 14 files changed, 139 insertions(+), 16 deletions(-)

The above changes are among the "low hanging fruit" where the
workarounds are relatively low impact from a performance and/or
implementation effort perspective.  I'm still working on fixes
for the harder problems.  Also, I believe that Catalin's "ARM: Allow
lazy cache flushing on ARM11MPCore" [2][3] is required for ARM11
MPCore machines and would like to see that or similar/alternative
solution applied.

Comments/feedback greatly appreciated.

TIA!

--
Regards,
George

[1] http://infocenter.arm.com/help/topic/com.arm.doc.dai0228a/index.html#arm_toc9
[2] http://www.spinics.net/lists/arm-kernel/msg129403.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014990.html
