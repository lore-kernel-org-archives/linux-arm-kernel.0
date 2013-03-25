From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:19:37 +0000
Subject: [PATCH 0/4] TLB and mm-related optimisations
Message-ID: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is another slightly random set of patches which I cooked up when
trying to optimise various bits and pieces in arch/arm/mm after writing
my changes to the ASID allocator.

The first two patches modify the local_* variants of our TLB and BP
invalidation functions to use the non-shareable versions, avoiding the
need to broadcast them in hardware. This allows us to update the ASID
allocator to use only local operations (which it needs anyway for
11MPCore).

The third patch removes some redundant cache-flushing when writing page
table entries for ARMv7 SMP targets (which require table walking at L1)
and the final patch allows us to use non-exclusive instructions for
atomic64 read/set (like we do for the 32-bit variants) when we have LPAE,
since this requires atomicity of aligned double-word accesses in order to
manipulate ptes atomically.

All feedback welcome,

Will


Will Deacon (4):
  ARM: tlb: don't perform inner-shareable invalidation for local TLB
    ops
  ARM: tlb: don't perform inner-shareable invalidation for local BP ops
  ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP
    instead
  ARM: atomics: don't use exclusives for atomic64 read/set with LPAE

 arch/arm/include/asm/atomic.h   | 24 ++++++++++++
 arch/arm/include/asm/tlbflush.h | 83 +++++++++++++++++++++++++++++++++++++----
 arch/arm/kernel/smp_tlb.c       | 10 ++---
 arch/arm/mm/context.c           |  5 +--
 arch/arm/mm/proc-v6.S           |  2 -
 arch/arm/mm/proc-v7-2level.S    |  3 +-
 arch/arm/mm/proc-v7-3level.S    |  3 +-
 arch/arm/mm/proc-v7.S           |  4 +-
 8 files changed, 112 insertions(+), 22 deletions(-)

-- 
1.8.0
