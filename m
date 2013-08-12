From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 18:28:44 +0100
Subject: [GIT PULL] Barrier updates for 3.12
Message-ID: <20130812172843.GH25995@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following barriers updates for 3.12. This series gives a
notable performance boost in hackbench benchmarks, and facilitates the use
of {non,inner}-shareable maintenance and memory barrier operations within
the kernel.

Cheers,

Will

--->8

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/barriers

for you to fetch changes up to 6af396a6b6c698eb3834184518fc9a59bc22c817:

  ARM: cacheflush: use -ishst dsb variant for ensuring flush completion (2013-08-12 12:25:46 +0100)

----------------------------------------------------------------
Will Deacon (12):
      ARM: mm: remove redundant dsb() prior to range TLB invalidation
      ARM: tlb: don't perform inner-shareable invalidation for local TLB ops
      ARM: tlb: don't bother with barriers for branch predictor maintenance
      ARM: tlb: don't perform inner-shareable invalidation for local BP ops
      ARM: barrier: allow options to be passed to memory barrier instructions
      ARM: tlb: reduce scope of barrier domains for TLB invalidation
      ARM: mm: use inner-shareable barriers for TLB and user cache operations
      ARM: spinlock: use inner-shareable dsb variant prior to sev instruction
      ARM: kvm: use inner-shareable barriers after TLB flushing
      ARM: mcpm: use -st dsb option prior to sev instructions
      ARM: l2x0: use -st dsb option for ordering writel_relaxed with unlock
      ARM: cacheflush: use -ishst dsb variant for ensuring flush completion

 arch/arm/common/mcpm_head.S       |   2 +-
 arch/arm/common/vlock.S           |   4 ++--
 arch/arm/include/asm/assembler.h  |   4 ++--
 arch/arm/include/asm/barrier.h    |  32 ++++++++++++++++----------------
 arch/arm/include/asm/cacheflush.h |   2 +-
 arch/arm/include/asm/spinlock.h   |   2 +-
 arch/arm/include/asm/switch_to.h  |  10 ++++++++++
 arch/arm/include/asm/tlbflush.h   | 181 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 arch/arm/kernel/smp_tlb.c         |  10 +++++-----
 arch/arm/kvm/init.S               |   2 +-
 arch/arm/kvm/interrupts.S         |   4 ++--
 arch/arm/mm/cache-l2x0.c          |   2 +-
 arch/arm/mm/cache-v7.S            |   4 ++--
 arch/arm/mm/context.c             |   7 +------
 arch/arm/mm/dma-mapping.c         |   1 -
 arch/arm/mm/proc-v7.S             |   2 +-
 arch/arm/mm/tlb-v7.S              |   8 ++++----
 17 files changed, 199 insertions(+), 78 deletions(-)
