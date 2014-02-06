From: steve.capper@linaro.org (Steve Capper)
Date: Thu,  6 Feb 2014 16:18:47 +0000
Subject: [RFC PATCH V2 0/4] get_user_pages_fast for ARM and ARM64
Message-ID: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This RFC series implements get_user_pages_fast and __get_user_pages_fast.
These are required for Transparent HugePages to function correctly, as
a futex on a THP tail will otherwise result in an infinite loop (due to
the core implementation of __get_user_pages_fast always returning 0).
This series may also be beneficial for direct-IO heavy workloads and
certain KVM workloads.
 
Previous RFCs for fast_gup on arm have included one from Chanho Park:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162115.html

one from Zi Shen Lim:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202133.html

and my RFC V1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205951.html

The main issues with previous RFCs have been in the mechanisms used to
prevent page table pages from being freed from under the fast_gup
walker. Some other architectures disable interrupts in the fast_gup
walker, and then rely on the fact that TLB invalidations require IPIs;
thus the page table freeing code is blocked by the walker. Some ARM
platforms, however, have hardware broadcasts for TLB invalidation, so
do not always require IPIs to flush TLBs. Some extra logic is therefore
required to protect the fast_gup walker on ARM.

My previous RFC attempted to protect the fast_gup walker with atomics,
but this led to performance degradation.

This RFC V2 instead uses the RCU scheduler logic from PowerPC to protect
the fast_gup walker. All page table pages belonging to an address space
with more than one user are batched together and freed from a delayed
call_rcu_sched routine. Disabling interrupts will block the RCU delayed
scheduler and prevent the page table pages from being freed from under
the fast_gup walker. If there is not enough memory to batch the page
tables together (which is very rare), then IPIs are raised individually
instead.

The RCU logic is activated by enabling HAVE_RCU_TABLE_FREE, and some
modifications are made to the mmu_gather code in ARM and ARM64 to plumb
it in. On ARM64, we could probably go one step further and switch to
the generic mmu_gather code too.

THP splitting is made to broadcast an IPI as we need to block these
completely when the fast_gup walker is active. As THP splits are
relatively rare (on my machine with 22 days uptime I count 27678), I do
not expect these IPIs to cause any performance issues.

I have tested the series using the Fast Model for ARM64 and an Arndale
Board. A series of hackbench runs on the Arndale did not turn up any
performance degradation with this patch set applied.

This series applies to 3.13, but has also been tested on 3.14-rc1.

I would really appreciate any comments and/or testers!

Cheers,
-- 
Steve

Steve Capper (4):
  arm: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm: mm: implement get_user_pages_fast
  arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm64: mm: implement get_user_pages_fast

 arch/arm/Kconfig                      |   1 +
 arch/arm/include/asm/pgtable-3level.h |   6 +
 arch/arm/include/asm/tlb.h            |  38 ++++-
 arch/arm/mm/Makefile                  |   2 +-
 arch/arm/mm/gup.c                     | 251 ++++++++++++++++++++++++++++
 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/pgtable.h      |   4 +
 arch/arm64/include/asm/tlb.h          |  27 +++-
 arch/arm64/mm/Makefile                |   2 +-
 arch/arm64/mm/gup.c                   | 297 ++++++++++++++++++++++++++++++++++
 10 files changed, 623 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mm/gup.c
 create mode 100644 arch/arm64/mm/gup.c

-- 
1.8.1.4
