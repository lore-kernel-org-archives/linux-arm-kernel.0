From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jan 2014 15:03:10 +0000
Subject: [RFC PATCH 0/3] arm64: KVM: host cache maintainance when guest caches
 are off
Message-ID: <1389970993-19371-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we run a guest with cache disabled, we don't flush the cache to
the Point of Coherency, hence possibly missing bits of data that have
been written in the cache, but have not yet reached memory.

We also have the opposite issue: when a guest enables its cache,
whatever sits in the cache is suddenly going to become visible,
shadowing whatever the guest has written into RAM.

There are several approaches to these issues:
- Using the DC bit when caches are off: this breaks guests assuming
  caches off while doing DMA operations. Bootloaders, for example.
  It also breaks the I-D coherency.
- Fetch the memory attributes on translation fault, and flush the
  cache while handling the fault. This relies on using the PAR_EL1
  register to obtain the Stage-1 memory attributes, and tends to be
  slow.
- Detecting the translation faults occuring with MMU off (and
  performing a cache clean), and trapping SCTLR_EL1 to detect the
  moment when the guest is turning its caches on (and performing a
  cache invalidation). Trapping of SCTLR_EL1 is then disabled to
  ensure the best performance.

This patch series implements the last solution, only on arm64 for the
time being (I'll add the necessary ARMv7 bits once we reach an
agreement on arm64).

Marc Zyngier (3):
  arm64: KVM: force cache clean on page fault when caches are off
  arm64: KVM: trap VM system registers until MMU and caches are ON
  arm64: KVM: flush VM pages before letting the guest enable caches

 arch/arm/include/asm/kvm_mmu.h   |  4 +--
 arch/arm/kvm/mmu.c               | 76 ++++++++++++++++++++++++++++++++++++++--
 arch/arm64/include/asm/kvm_arm.h |  3 +-
 arch/arm64/include/asm/kvm_mmu.h | 12 ++++---
 arch/arm64/kvm/sys_regs.c        | 61 ++++++++++++++++++++++++++------
 5 files changed, 136 insertions(+), 20 deletions(-)

-- 
1.8.3.4
