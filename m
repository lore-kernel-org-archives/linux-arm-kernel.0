From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 12 Jun 2012 16:40:11 -0400
Subject: [RFC/PATCH v5 0/7] ARM11 MPCore: preemption/task migration cache
 coherency fixups
In-Reply-To: <1318945654-548-1-git-send-email-gdavis@mvista.com>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
Message-ID: <1339533618-15969-1-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

Apologies for the long delay following up on this...

On ARM11 MPCore, the "SCU does not handle coherency consequences of CP15
cache operations" [1].  So cache maintenance functions have to insure
that memory is globally consistent.  Although the current Linux kernel
works reasonably well on ARM11 MPCore machines, PREEMPT stress testing,
e.g. parallel module loading, hackbench and LTP stress, results in
crashes which exhibit non-sense oops traces where machine state does
not make sense relative to the code executing at the time of the oops.

Review and analysis of the various ARM11 MPCore cache maintenance
functions reveal that there are a number critical sections in which
ARM11 MPCore caches and/or memory may become inconsistent, i.e. a
cache line on CPU A contains a modified entry but preemption and task
migration occurs after which the same cache line is cleaned/flushed
on CPU B.  This can obviously lead to inconsistent memory and/or
cache state as cache ops on ARM11 MPCore are non-coherent.

The following is a series of ARM11 MPCore preemption/task migration
fixes to resolve cache coherency problems on these machines:

George G. Davis (6):
      ARM: ARM11 MPCore: Make pte_alloc_one{,_kernel} preempt safe
      ARM: ARM11 MPCore: Make {clean,flush}_pmd_entry preempt safe
      ARM: Move get_thread_info macro definition to <asm/assembler.h>
      ARM: ARM11 MPCore: cpu_v6_dcache_clean_area needs RFO
      ARM: ARM11 MPCore: Make DMA_CACHE_RWFO operations preempt safe
      ARM: ARM11 MPCore: Make cpu_v6_set_pte_ext preempt safe

Konstantin Baidarov (1):
      ARM: ARM11 MPCore: Make pgd_alloc preempt safe

 arch/arm/include/asm/assembler.h      |   13 +++++++++
 arch/arm/include/asm/pgalloc.h        |   28 +++++++++++++++++---
 arch/arm/include/asm/pgtable-2level.h |    8 ++++++
 arch/arm/include/asm/pgtable.h        |    1 +
 arch/arm/include/asm/smp_plat.h       |    2 +
 arch/arm/kernel/entry-header.S        |   11 --------
 arch/arm/mm/cache-v6.S                |   45 +++++++++++++++++++++++++++++++++
 arch/arm/mm/idmap.c                   |    4 +++
 arch/arm/mm/pgd.c                     |    7 +++++
 arch/arm/mm/proc-macros.S             |    3 ++
 arch/arm/mm/proc-v6.S                 |   22 +++++++++++++++-
 arch/arm/vfp/entry.S                  |    5 +++-
 arch/arm/vfp/vfphw.S                  |    5 +++-
 13 files changed, 135 insertions(+), 19 deletions(-)

The above changes were tested on:

1. ARM Ltd RealView ARM11 MPCore
2. NEC NE1 TB
3. NEC NEmid TB

Test cases used:

1. Continuous parallel modprobe stress test
2. 24 hour LTP stress test

When these fixes are not applied, both test cases fail often and early where
the failure symptoms are random hard/soft lockups and/or non-sense oopses.

When these fixes are applied, no test case failures are observed.

Note that the following change is an alternative implementation to
fix all callers of clean_dcache_area:

      ARM: ARM11 MPCore: cpu_v6_dcache_clean_area needs RFO

If the above change is not an acceptable fix, then preemption/
task migration issues in callers of clean_dcache_area still
need to be fixed in some way.  On the other hand, if the above
change is acceptable, then the following changes can be dropped
since they call clean_dcache_area which is fixed by the above
change:

      ARM: ARM11 MPCore: Make pgd_alloc preempt safe
      ARM: ARM11 MPCore: Make pte_alloc_one{,_kernel} preempt safe


I further believe that Catalin's "ARM: Allow lazy cache flushing on
ARM11MPCore" [2][3] is required for ARM11 MPCore machines and would
like to see that or similar/alternative solution applied.  I have
an additional RWFO preempt fix which must be applied on top of
Catalin's patch [2][3] to resolve preeption/task migration issues
when his patch is applied.  I'll submit that patch as a follow up
to that thread.

Comments/feedback greatly appreciated.

TIA!

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
V5:
- Drop OMAP specific changes in "ARM: ARM11 MPCore: clean_dcache_area
  is not preempt safe" based on feed back from Tony Lindgren [4]
  indicating that the affected code is not used on ARM11 MPCore
  machines.
- Fix bug in implementation of conditional preempt_schedule calls
  pointed out by Nicolas Pitre [5].
- Reimplement "ARM: ARM11 MPCore: cpu_v6_set_pte_ext is not preempt safe"
  to simply disable/enable interrupts around critical section based on
  feedback from Nicolas Pitre [6].
- Improve (ARMv6+ instruction cycle) efficiency of preempt_enable
  assembler code sequences as suggested by Nicolas Pitre [7]. 
- Implement alternative implementation for fixup of clean_dcache_area
  callers by implementing RFO and preempt disable in
  cpu_v6_dcache_clean_area.  If this change is acceptable, the
  "ARM: ARM11 MPCore: Make pgd_alloc preempt safe" and "ARM: ARM11
  MPCore: Make pte_alloc_one{,_kernel} preempt safe" commits can be
  dropped. Else, if unacceptable, some callers of clean_dcache_area
  may be missing preempt/migration fixups which are not otherwise
  fixed in this series.

--
Regards,
George

References:

[1] http://infocenter.arm.com/help/topic/com.arm.doc.dai0228a/index.html#arm_toc9
[2] http://www.spinics.net/lists/arm-kernel/msg129403.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014990.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069912.html
[5] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069942.html
[6] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069943.html
[7] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069953.html
