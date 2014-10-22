From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 22 Oct 2014 15:34:05 -0700
Subject: [PATCH v12 0/6] arm/KVM: dirty page logging support for ARMv7
 (3.17.0-rc1)
Message-ID: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduces dirty page logging for ARMv7 and adds some degree 
of generic dirty logging support for x86, armv7 and later armv8.

I implemented Alex's  suggestion after he took a look at the patches at kvm
forum to simplify the generic/arch split - leaving mips, powerpc, s390, 
(ia64 although broken) unchanged. x86/armv7 now share some dirty logging code. 
armv8 dirty log patches have been posted and tested but for time being armv8
is non-generic as well.

I briefly spoke to most of you at kvm forum, and this is the patch series
I was referring to. Implementation changed from previous version (patches
1 & 2), those who acked previous revision, please review again.

Last 4 patches (ARM) have been rebased for newer kernel, with no signifcant
changes.
 
Testing:
- Generally live migration + checksumming of source/destination memory regions 
  is used validate correctness. 
- qemu machvirt, VExpress - Exynos 5440, FastModels - lmbench + dirty guest
  memory cycling.
- ARMv8 Foundation Model/kvmtool - Due to slight overlap in 2nd stage handlers
  did a basic bringup using qemu.
- x86_64 qemu  default machine model, tested migration on HP Z620, tested 
  convergence for several dirty page rates

See https://github.com/mjsmar/arm-dirtylog-tests
    - Dirtlogtest-setup.pdf for ARMv7
    - https://github.com/mjsmar/arm-dirtylog-tests/tree/master/v7 - README

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

ARMv7 Dirty page logging implementation overivew-
- initially write protects VM RAM memory region - 2nd stage page tables
- add support to read dirty page log and again write protect the dirty pages 
  - second stage page table for next pass.
- second stage huge page are dissolved into small page tables to keep track of
  dirty pages at page granularity. Tracking at huge page granularity limits
  migration to an almost idle system. Small page size logging supports higher 
  memory dirty rates.
- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.

Changes since v11:
- Implemented Alex's comments to simplify generic layer.

Changes since v10:
- addressed wanghaibin comments 
- addressed Christoffers comments

Changes since v9:
- Split patches into generic and architecture specific variants for TLB Flushing
  and dirty log read (patches 1,2 & 3,4,5,6)
- rebased to 3.16.0-rc1
- Applied Christoffers comments.

Mario Smarduch (6):
  KVM: Add architecture-defined TLB flush support
  KVM: Add generic support for dirty page logging
  arm: KVM: Add ARMv7 API to flush TLBs
  arm: KVM: Add initial dirty page locking infrastructure
  arm: KVM: dirty log read write protect support
  arm: KVM: ARMv7 dirty page logging 2nd stage page fault

 arch/arm/include/asm/kvm_asm.h        |    1 +
 arch/arm/include/asm/kvm_host.h       |   14 +++
 arch/arm/include/asm/kvm_mmu.h        |   20 ++++
 arch/arm/include/asm/pgtable-3level.h |    1 +
 arch/arm/kvm/Kconfig                  |    2 +
 arch/arm/kvm/Makefile                 |    1 +
 arch/arm/kvm/arm.c                    |    2 +
 arch/arm/kvm/interrupts.S             |   11 ++
 arch/arm/kvm/mmu.c                    |  209 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/kvm_host.h       |    3 -
 arch/x86/kvm/Kconfig                  |    1 +
 arch/x86/kvm/Makefile                 |    1 +
 arch/x86/kvm/x86.c                    |   86 --------------
 include/linux/kvm_host.h              |    4 +
 virt/kvm/Kconfig                      |    6 +
 virt/kvm/dirtylog.c                   |  112 ++++++++++++++++++
 virt/kvm/kvm_main.c                   |    2 +
 17 files changed, 380 insertions(+), 96 deletions(-)
 create mode 100644 virt/kvm/dirtylog.c

-- 
1.7.9.5
