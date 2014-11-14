From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 13 Nov 2014 17:57:41 -0800
Subject: [PATCH v14 0/7] KVM/arm/x86: dirty page logging for ARMv7 (3.17.0-rc1)
Message-ID: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series adds support for ARMv7 and generic dirty page logging support. 
As we try to move towards generic dirty page logging additional logic is moved 
to generic code. Initially x86, armv7 KVM_GET_DIRTY_LOG reuses generic 
code, shortly followed by armv8 patches.

Testing:
- Generally live migration + checksumming of source/destination memory regions 
  is used to validate correctness.
- ARMv7 - qemu machvirt, VExpress - Exynos 5440, FastModels - lmbench + dirty 
  guest memory cycling. On FastModels you must set 'migrate_set_downtime=1'
  for higher dirty rate (for example 2000 pges/100mS).

See https://github.com/mjsmar/arm-dirtylog-tests for details.

In addition to ARMv7 patch series was compiled for:
- x86_64 - defconfig 
- ia64 - ia64-linux-gcc4.6.3 - defconfig, ia64 Kconfig defines BROKEN worked 
  around that to make sure new changes don't break build. Eventually build
  breaks due to other reasons.
- mips - mips64-linux-gcc4.6.3 - malta_kvm_defconfig
- ppc - powerpc64-linux-gcc4.6.3 - pseries_defconfig
- s390 - s390x-linux-gcc4.6.3 - defconfig
- armv8 - aarch64-linux-gnu-gcc4.8.1 - defconfig

ARMv7 Dirty page logging implementation overivew-
- initially write protects memory region pages 2nd stage page tables
- add support to read dirty page log and again write protect dirty pages 
  for next pass.
- second stage huge page are dissolved into small page tables to keep track of
  dirty pages at page granularity. Tracking at huge page granularity limits
  migration to an almost idle system. Small page size logging supports higher
  memory dirty rates.
- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.

Changes since v13:
- Addressed comments from Cornelia, Paolo, Marc, and Christoffer
- Most signifcant change is reduce number of arguments to stage2_set_pte
- Another is introduce Kconfig symbol for generic kvm_get_dirty_log_protect()

Changes since v12:
- Added Paolos and James Hogan's comments to extend kvm_get_dirty_log() to
  make it further generic by adding write protection in addition to dirty bit
  map handling. This led to new generic function kvm_get_dirty_log_protect().

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
  KVM: arm: Add ARMv7 API to flush TLBs
  KVM: arm: Add initial dirty page locking support
  KVM: arm: dirty logging write protect support
  KVM: arm: page logging 2nd stage fault handling

Paolo Bonzini (1):
  KVM: x86: switch to kvm_get_dirty_log_protect

 arch/arm/include/asm/kvm_asm.h        |    1 +
 arch/arm/include/asm/kvm_host.h       |   14 +++
 arch/arm/include/asm/kvm_mmu.h        |   20 +++
 arch/arm/include/asm/pgtable-3level.h |    1 +
 arch/arm/kvm/Kconfig                  |    2 +
 arch/arm/kvm/arm.c                    |   46 +++++++
 arch/arm/kvm/interrupts.S             |   11 ++
 arch/arm/kvm/mmu.c                    |  216 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/kvm_host.h       |    3 -
 arch/x86/kvm/Kconfig                  |    1 +
 arch/x86/kvm/mmu.c                    |    4 +-
 arch/x86/kvm/x86.c                    |   64 ++--------
 include/linux/kvm_host.h              |    9 ++
 virt/kvm/Kconfig                      |    9 ++
 virt/kvm/kvm_main.c                   |   82 +++++++++++++
 15 files changed, 415 insertions(+), 68 deletions(-)

-- 
1.7.9.5
