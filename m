From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jan 2014 14:56:32 +0000
Subject: [PATCH v2 00/10] arm/arm64: KVM: host cache maintainance when guest
 caches are off
Message-ID: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
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

This patch series implements the last solution, for both arm and
arm64. Tested on TC2 (ARMv7) and FVP model (ARMv8).

>From v1 (http://www.spinics.net/lists/kvm/msg99404.html):
- Fixed AArch32 VM handling on arm64 (Reported by Anup)
- Added ARMv7 support:
  * Fixed a couple of issues regarding handling of 64bit cp15 regs
  * Per-vcpu HCR
  * Switching of AMAIR0 and AMAIR1

Marc Zyngier (10):
  arm64: KVM: force cache clean on page fault when caches are off
  arm64: KVM: allows discrimination of AArch32 sysreg access
  arm64: KVM: trap VM system registers until MMU and caches are ON
  arm64: KVM: flush VM pages before letting the guest enable caches
  ARM: KVM: force cache clean on page fault when caches are off
  ARM: KVM: fix handling of trapped 64bit coprocessor accesses
  ARM: KVM: fix ordering of 64bit coprocessor accesses
  ARM: KVM: introduce per-vcpu HYP Configuration Register
  ARM: KVM: trap VM system registers until MMU and caches are ON
  ARM: KVM: add world-switch for AMAIR{0,1}

 arch/arm/include/asm/kvm_arm.h   |   4 +-
 arch/arm/include/asm/kvm_asm.h   |   4 +-
 arch/arm/include/asm/kvm_host.h  |   9 ++--
 arch/arm/include/asm/kvm_mmu.h   |  11 ++--
 arch/arm/kernel/asm-offsets.c    |   1 +
 arch/arm/kvm/coproc.c            |  95 +++++++++++++++++++++++++++-------
 arch/arm/kvm/coproc.h            |  14 +++--
 arch/arm/kvm/coproc_a15.c        |   2 +-
 arch/arm/kvm/coproc_a7.c         |   2 +-
 arch/arm/kvm/guest.c             |   1 +
 arch/arm/kvm/interrupts_head.S   |  21 +++++---
 arch/arm/kvm/mmu.c               |  87 ++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/kvm_arm.h |   3 +-
 arch/arm64/include/asm/kvm_asm.h |   3 +-
 arch/arm64/include/asm/kvm_mmu.h |  12 +++--
 arch/arm64/kvm/sys_regs.c        | 107 ++++++++++++++++++++++++++++++++++-----
 arch/arm64/kvm/sys_regs.h        |   2 +
 17 files changed, 316 insertions(+), 62 deletions(-)

-- 
1.8.3.4
