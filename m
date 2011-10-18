From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 18 Oct 2011 09:47:27 -0400
Subject: [RFC/PATCH v4 0/7] ARM11 MPCore: preemption/task migration cache
	coherency fixups
In-Reply-To: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
Message-ID: <1318945654-548-1-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

On ARM11 MPCore, the "SCU does not handle coherency consequences of CP15
cache operations" [1]. ?So cache maintenance functions have to insure
that memory is globally consistent. ?Although the current Linux kernel
works reasonably well on ARM11 MPCore machines, PREEMPT stress testing,
e.g. parallel module loading and hackbench, results in crashes which
exhibit non-sense oops traces where machine state does not make sense
relative to the code executing at the time of the oops.

Review and analysis of the various ARM11 MPCore cache maintenance
functions reveal that there are a number critical sections in which
ARM11 MPCore caches and/or memory may become inconsistent, i.e. a
cache line on CPU A contains a modified entry but preemption and task
migration occurs after which the same cache line is cleaned/flushed
on CPU B. ?This can obviously lead to inconsistent memory and/or
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

 arch/arm/include/asm/assembler.h |   13 ++++++++++++
 arch/arm/include/asm/pgalloc.h   |   28 ++++++++++++++++++++++----
 arch/arm/include/asm/pgtable.h   |    9 ++++++++
 arch/arm/include/asm/smp_plat.h  |    2 +
 arch/arm/kernel/entry-header.S   |   11 ----------
 arch/arm/mm/cache-v6.S           |   39 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/idmap.c              |    5 ++++
 arch/arm/mm/pgd.c                |    7 ++++++
 arch/arm/mm/proc-v6.S            |   15 ++++++++++++++
 arch/arm/plat-omap/iommu.c       |   10 +++++++++
 arch/arm/vfp/entry.S             |    5 +++-
 arch/arm/vfp/vfphw.S             |    5 +++-
 12 files changed, 131 insertions(+), 18 deletions(-)

ChangeLog:

V2:
- Substitute {get,put}_cpu() with preempt_{disable,enable}().
- Fixed preempt {dis,en}able assembler code sequences to not
  use r11 since it is reserved for frame pointer use.  Also
  optimised these sequences to use r2, r3; ip scratch registers
  in most cases to eliminate stack push/pop.  In one case,
  cpu_v6_set_pte_ext, there are only two scratch registers
  available, r3 and ip.  However, both of these are used within
  the armv6_set_pte_ext macro.  So for this case, r3 is used
  as a temporary scratch when disabling preemption and r4 and
  r5 are pushed/popped as needed for other uses to avoid
  conflict with scratch register usage in armv6_set_pte_ext.
- Remove incorrect use of ALT_SMP macros in cpu_v6_set_pte_ext,
  making the preempt {dis,en}able assembler code sequences
  compile time dependent upon CONFIG_SMP instead.  This code
  is safe on UP machines anyway.
V3:
- Fix HIGHMEM breakage.
V4:
- Drop preempt_{disable,enable}() around calls to flush_pmd_entry()
  in remap_area_sections() and remap_area_supersections() in
  file arch/arm/mm/ioremap.c since these functions are not used
  on SMP machines (they're enclosed within #ifndef SMP/#endif)
- Drop preempt_{disable,enable}() around call to flush_pmd_entry()
  in alloc_init_section() in file arch/arm/mm/mmu.c since this
  function is called during early kernel initialization during
  which time preemption and task migration is not possible.  Also
  removed bogus FIXME comment as part of this change.
- Added calls to preempt_schedule when re-enabling preemption
  in various arch/arm/mm/{cache,proc}-v6.S functions which need
  preemption disabled due task migration issues.

The above changes are among the "low hanging fruit" where the
workarounds are relatively low impact from a performance and/or
implementation effort perspective. ?I'm still working on fixes
for the harder problems. ?Also, I believe that Catalin's "ARM: Allow
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
