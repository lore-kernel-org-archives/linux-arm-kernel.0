From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 15 Jan 2015 15:58:51 -0800
Subject: [PATCH v16 00/10] KVM/arm/arm64/x86: dirty page logging for ARMv7/8
 (3.18.0-rc2)
Message-ID: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series adds support for armv7/8 dirty page logging. As we move
towards generic dirty page logging interface we move some common code to
generic layer shared by x86, armv7 and armv8.

armv7/8 Dirty page logging implementation overivew-
- initially write protects memory region 2nd stage page tables
- read dirty page log and again write protect dirty pages for next pass.
- second stage huge pages are dissolved into normal pages to keep track of
  dirty memory at page granularity. Tracking at huge page granularity
  limits granularity of marking dirty memory and migration to a light memory
  load. Small page size logging supports higher memory dirty rates, enables
  rapid migration.

  armv7 supports 2MB Huge page, and armv8 supports 2MB (4kb) and
  512MB (64kb)
- In the event migration is canceled, normal behavior is resumed huge pages
  are rebuilt over time.

Testing:
- ARMv7: 
  o Fast Models Live Migration and shared memory mmio described below.
    For both instances correctness is validated through checksum of source and
    destination file copies on both ends. Tests with instructions
    at: https://github.com/mjsmar/arm-dirtylog-tests
  o To test migration Christoffer's patches need to be applied
    https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012809.html
    "Fix vgic initialization problems". You can try validate without the patches
    (through checksums) but destination VM will not be responsive
  o Test combinations:
    - 4k, 2MB - Guest on
    - 4k, 2MB - Host

- ARMv8:
  o Currently migration is not supported on ARMv8 another method is used to
    validate dirty page logging. Used Foundation Model 9.0.xx for testing.
    Details at: https://github.com/mjsmar/arm-dirtylog-tests
  o Test Description:
    - Added mmio device to QEMU 'virt' with on board memory (8MB in this case),
      Device memory is Posix shared memory segment visible to host.
      Enabled dirty logging for that memslot.
    - Added memslot migration thread to export dirty bit map to host.
    - Implemented memory migration thread on host
  o To test on 64 page host using Founcation_model/FVP
    - modifed QEMU - is needed to map VM GICC at same offset as Foundation
      Models gic-v3 GICV (thanks to Marc's insight).
    - modified host kernel - disable page align checks for GICV, can enable KVM
    - Apply IPA TLB flush fix -
      https://lists.cs.columbia.edu/pipermail/kvmarm/2015-January/013079.html
  o Test Combinations:
    64b/4kb,2MB,39b/4kb,2MB; 64b/64kb,42b/64kb - Guest On
    64b/4kb+2MB,39b/4kb+2MB; 64b/64kb,42b/64kb - Host

Changes since v15:
- Handle read faults to writable regions properly
- Along with Christoffers suggestions optimized user_mem_abor() while logging
- Fix enable of dirty page logging to Device memory - reject request
- fixed bug exposed by new generic __get_user_pages_fast(), when region is 
  writable, prevent write protection of pte on read fault
- Removed marking entire huge page dirty on initial access

Changes since v14:
- Fixed a bug referencsing 2nd stage pmd pfn instead IPA to flush 2nd stage TLB.
- Fixed initial write protect to include KVM_MR_MOVE case.
- Fixed timing issue between tlb flush and completion on other CPUs.
- Added PUD write protect and clear.
- Refactored some code in kvm/mmu.c due to 3rd issue above.
- Combined armv7 and 8 patches into one series
- Reworded descirption for kvm_vm_ioctl_get_dirty_log(), applied Paolos changes
- rebased to 3.18.0-rc2

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
- Applied Christoffers comments

Mario Smarduch (9):
  KVM: Add architecture-defined TLB flush support
  KVM: Add generic support for dirty page logging
  KVM: arm: Add ARMv7 API to flush TLBs
  KVM: arm: Add initial dirty page locking support
  KVM: arm: dirty logging write protect support
  KVM: arm: page logging 2nd stage fault handling
  KVM: arm64: ARMv8 header changes for page logging
  KVM: arm64: Add HYP interface to flush VM Stage 1/2 TLB entries
  KVM: arm/arm64: Enable Dirty Page logging for ARMv8

Paolo Bonzini (1):
  KVM: x86: switch to kvm_get_dirty_log_protect

 arch/arm/include/asm/kvm_asm.h         |    1 +
 arch/arm/include/asm/kvm_host.h        |    2 +
 arch/arm/include/asm/kvm_mmu.h         |   21 +++
 arch/arm/include/asm/pgtable-3level.h  |    1 +
 arch/arm/kvm/Kconfig                   |    2 +
 arch/arm/kvm/arm.c                     |   32 +++-
 arch/arm/kvm/interrupts.S              |   11 ++
 arch/arm/kvm/mmu.c                     |  257 ++++++++++++++++++++++++++++++--
 arch/arm64/include/asm/kvm_asm.h       |    1 +
 arch/arm64/include/asm/kvm_host.h      |    1 +
 arch/arm64/include/asm/kvm_mmu.h       |   21 +++
 arch/arm64/include/asm/pgtable-hwdef.h |    1 +
 arch/arm64/kvm/Kconfig                 |    2 +
 arch/arm64/kvm/hyp.S                   |   22 +++
 arch/x86/include/asm/kvm_host.h        |    3 -
 arch/x86/kvm/Kconfig                   |    1 +
 arch/x86/kvm/mmu.c                     |    4 +-
 arch/x86/kvm/x86.c                     |   72 ++-------
 include/linux/kvm_host.h               |    9 ++
 virt/kvm/Kconfig                       |    9 ++
 virt/kvm/kvm_main.c                    |   82 ++++++++++
 21 files changed, 481 insertions(+), 74 deletions(-)

-- 
1.7.9.5
