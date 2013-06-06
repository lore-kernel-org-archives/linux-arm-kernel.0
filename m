From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Jun 2013 15:28:24 +0100
Subject: [PATCH 00/10] Make use of v7 barrier variants in Linux
Message-ID: <1370528914-17506-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series updates our barrier macros to make use of the
different variants introduced by the v7 architecture. This includes
both access type (store vs load/store) and shareability domain. There
is a dependency on my TLB patches, which I have included in the series
and which were most recently posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/169124.html

With these patches applied, I see around 5% improvement on hackbench
scores running on my TC2 with both clusters enabled.

Since these changes have subtle memory-ordering implications, I've
avoiding touching any cache-flushing operations or barrier code that is
used during things like CPU suspend/resume, where the CPU coming up/down
might have bits like actlr.smp clear. Maybe this is overkill, but it
reaches the point of diminishing returns if we start having
implementation-specific barrier options, so I've tried to keep it
general.

All feedback welcome,

Will


Will Deacon (10):
  ARM: mm: remove redundant dsb() prior to range TLB invalidation
  ARM: tlb: don't perform inner-shareable invalidation for local TLB ops
  ARM: tlb: don't bother with barriers for branch predictor maintenance
  ARM: tlb: don't perform inner-shareable invalidation for local BP ops
  ARM: barrier: allow options to be passed to memory barrier
    instructions
  ARM: spinlock: use inner-shareable dsb variant prior to sev
    instruction
  ARM: mm: use inner-shareable barriers for TLB and user cache
    operations
  ARM: tlb: reduce scope of barrier domains for TLB invalidation
  ARM: kvm: use inner-shareable barriers after TLB flushing
  ARM: mcpm: use -st dsb option prior to sev instructions

 arch/arm/common/mcpm_head.S      |   2 +-
 arch/arm/common/vlock.S          |   4 +-
 arch/arm/include/asm/assembler.h |   4 +-
 arch/arm/include/asm/barrier.h   |  32 ++++++------
 arch/arm/include/asm/spinlock.h  |   2 +-
 arch/arm/include/asm/switch_to.h |  10 ++++
 arch/arm/include/asm/tlbflush.h  | 105 ++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/smp_tlb.c        |  10 ++--
 arch/arm/kvm/init.S              |   2 +-
 arch/arm/kvm/interrupts.S        |   4 +-
 arch/arm/mm/cache-v7.S           |   4 +-
 arch/arm/mm/context.c            |   6 +--
 arch/arm/mm/dma-mapping.c        |   1 -
 arch/arm/mm/proc-v7.S            |   2 +-
 arch/arm/mm/tlb-v7.S             |   8 +--
 15 files changed, 134 insertions(+), 62 deletions(-)

-- 
1.8.2.2
