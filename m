From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:14 +0100
Subject: [PATCH v2 00/12] Make use of v7 barrier variants in Linux
Message-ID: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is the second version of the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173952.html

Changes since v1 include:

  - Fixed broken TLB invalidation with SMP_ON_UP (reported by Jonny)
  - Relaxed some additional barriers (l2x0 and flush_cache_vmap)
  - Based on 3.10-rc6

These are targetting 3.12, so no need to panic just yet!

All feedback welcome,

Will


Will Deacon (12):
  ARM: mm: remove redundant dsb() prior to range TLB invalidation
  ARM: tlb: don't perform inner-shareable invalidation for local TLB ops
  ARM: tlb: don't bother with barriers for branch predictor maintenance
  ARM: tlb: don't perform inner-shareable invalidation for local BP ops
  ARM: barrier: allow options to be passed to memory barrier
    instructions
  ARM: tlb: reduce scope of barrier domains for TLB invalidation
  ARM: mm: use inner-shareable barriers for TLB and user cache
    operations
  ARM: spinlock: use inner-shareable dsb variant prior to sev
    instruction
  ARM: kvm: use inner-shareable barriers after TLB flushing
  ARM: mcpm: use -st dsb option prior to sev instructions
  ARM: l2x0: use -st dsb option for ordering writel_relaxed with unlock
  ARM: cacheflush: use -ishst dsb variant for ensuring flush completion

 arch/arm/common/mcpm_head.S       |   2 +-
 arch/arm/common/vlock.S           |   4 +-
 arch/arm/include/asm/assembler.h  |   4 +-
 arch/arm/include/asm/barrier.h    |  32 +++----
 arch/arm/include/asm/cacheflush.h |   2 +-
 arch/arm/include/asm/spinlock.h   |   2 +-
 arch/arm/include/asm/switch_to.h  |  10 +++
 arch/arm/include/asm/tlbflush.h   | 181 +++++++++++++++++++++++++++++++-------
 arch/arm/kernel/smp_tlb.c         |  10 +--
 arch/arm/kvm/init.S               |   2 +-
 arch/arm/kvm/interrupts.S         |   4 +-
 arch/arm/mm/cache-l2x0.c          |   2 +-
 arch/arm/mm/cache-v7.S            |   4 +-
 arch/arm/mm/context.c             |   6 +-
 arch/arm/mm/dma-mapping.c         |   1 -
 arch/arm/mm/proc-v7.S             |   2 +-
 arch/arm/mm/tlb-v7.S              |   8 +-
 17 files changed, 199 insertions(+), 77 deletions(-)

-- 
1.8.2.2
