From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 26 Aug 2014 16:51:06 -0700
Subject: [PATCH v10 0/6] arm: dirty page logging support for ARMv7
Message-ID: <1409097072-1096-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds support for ARMv7 dirty page logging. Some functions of dirty
page logging have been split to generic and arch specific implementations,
details below. Dirty page logging is one of serveral features required for 
live migration, live migration has been tested for ARMv7.

Testing:
- QEMU machvirt, VExpress - Exynos 5440, FastModels - lmbench + dirty guest
  memory cycling.
- ARMv8 Foundation Model/kvmtool - Due to slight overlap in 2nd stage handlers
  did a basic bringup and memory test.
- x86_64 QEMU basic migration on same platform.

See https://github.com/mjsmar/arm-migration-howto for details testing and
setup (see README).

The patch affects armv7,armv8, mips, ia64, powerpc, s390, x86_64. Patch
series has been compiled for affected architectures:

- x86_64 - defconfig 
- ia64 - ia64-linux-gcc4.6.3 - defconfig, ia64 Kconfig defines BROKEN worked 
  around that to make sure new changes don't break build. Eventually build
  breaks due to other reasons. 
- mips - mips64-linux-gcc4.6.3 - malta_kvm_defconfig
- ppc - powerpc64-linux-gcc4.6.3 - pseries_defconfig
- s390 - s390x-linux-gcc4.6.3 - defconfig
- armv8 - aarch64-linux-gnu-gcc4.8.1 - defconfig

ARMv7 Dirty page logging support overivew-
- initially write protects VM RAM memory regions - 2nd stage page tables
- add support to read dirty page log and again write protect the dirty pages 
  - second stage page table for next pass.
- second stage huge page are dissolved into small page tables to keep track of
  dirty pages at page granularity. Tracking at huge page granularity limits
  migration to an almost idle system.
- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.
- At this time reverse mappings are not used to for write protecting of 2nd 
  stage tables.

- Future Work 
  o Enable diry memory logging for ARMv8 FM,FVP 9x,juno

Changes since previous vesion:
- Split patches into generic and architecture specific variants for TLB Flushing
  and dirty log read (patches 1,2 & 3,4,5,6)
- rebased to 3.16.0-rc1
- Applied Christoffers comments.

Mario Smarduch (6):
  KVM: Add architecture-specific TLB flush implementations
  KVM: Add generic implementation of kvm_vm_ioctl_get_dirty_log
  arm: KVM: Add ARMv7 API to flush TLBs
  arm: KVM: Add initial dirty page locking infrastructure
  arm: KVM: dirty log read write protect support
  arm: KVM: ARMv7 dirty page logging 2nd stage page fault handling
    support

 arch/arm/include/asm/kvm_asm.h        |   1 +
 arch/arm/include/asm/kvm_host.h       |  15 +++
 arch/arm/include/asm/kvm_mmu.h        |  20 ++++
 arch/arm/include/asm/pgtable-3level.h |   1 +
 arch/arm/kvm/Kconfig                  |   1 +
 arch/arm/kvm/arm.c                    |  13 ++-
 arch/arm/kvm/interrupts.S             |  12 +++
 arch/arm/kvm/mmu.c                    | 195 ++++++++++++++++++++++++++++++++--
 arch/arm64/include/asm/kvm_host.h     |   2 +
 arch/arm64/kvm/Kconfig                |   1 +
 arch/ia64/include/asm/kvm_host.h      |   1 +
 arch/ia64/kvm/Kconfig                 |   1 +
 arch/ia64/kvm/kvm-ia64.c              |   2 +-
 arch/mips/include/asm/kvm_host.h      |   1 +
 arch/mips/kvm/Kconfig                 |   1 +
 arch/mips/kvm/mips.c                  |   2 +-
 arch/powerpc/include/asm/kvm_host.h   |   2 +
 arch/powerpc/kvm/Kconfig              |   1 +
 arch/powerpc/kvm/book3s.c             |   2 +-
 arch/powerpc/kvm/booke.c              |   2 +-
 arch/s390/include/asm/kvm_host.h      |   2 +
 arch/s390/kvm/Kconfig                 |   1 +
 arch/s390/kvm/kvm-s390.c              |   2 +-
 arch/x86/kvm/x86.c                    |  86 ---------------
 include/linux/kvm_host.h              |   2 +
 virt/kvm/Kconfig                      |   6 ++
 virt/kvm/kvm_main.c                   |  94 ++++++++++++++++
 27 files changed, 371 insertions(+), 98 deletions(-)

-- 
1.8.3.2
