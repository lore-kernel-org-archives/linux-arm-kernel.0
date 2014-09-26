From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:33 +0200
Subject: [PATCH 00/27] Changes for arm/arm64 KVM for 3.18
Message-ID: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

The following changes since commit f51770ed465e6eb41da7fa16fd92eb67069600cf:

  kvm: Make init_rmode_identity_map() return 0 on success. (2014-09-17 13:10:12 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.18

for you to fetch changes up to 0496daa5cf99741ce8db82686b4c7446a37feabb:

  arm/arm64: KVM: Report correct FSC for unsupported fault types (2014-09-26 14:39:45 +0200)

This includes a bunch of changes:
 - Support read-only memory slots on arm/arm64
 - Various changes to fix Sparse warnings
 - Correctly detect write vs. read Stage-2 faults
 - Various VGIC cleanups and fixes
 - Dynamic VGIC data strcuture sizing
 - Fix SGI set_clear_pend offset bug
 - Fix VTTBR_BADDR Mask
 - Correctly report the FSC on Stage-2 faults

Thanks,
-Christoffer

---
Ard Biesheuvel (1):
      ARM/arm64: KVM: fix use of WnR bit in kvm_is_write_fault()

Christoffer Dall (11):
      KVM: Introduce gfn_to_hva_memslot_prot
      arm/arm64: KVM: Support KVM_CAP_READONLY_MEM
      Merge remote-tracking branch 'kvm/next' into queue
      arm/arm64: KVM: Rename irq_state to irq_pending
      arm/arm64: KVM: Rename irq_active to irq_queued
      arm/arm64: KVM: vgic: Clear queued flags on unqueue
      arm/arm64: KVM: vgic: Improve handling of GICD_I{CS}PENDRn
      arm/arm64: KVM: vgic: Fix SGI writes to GICD_I{CS}PENDR0
      arm/arm64: KVM: vgic: Clarify and correct vgic documentation
      arm/arm64: KVM: Fix set_clear_sgi_pend_reg offset
      arm/arm64: KVM: Report correct FSC for unsupported fault types

Eric Auger (1):
      KVM: EVENTFD: remove inclusion of irq.h

Joel Schopp (1):
      arm/arm64: KVM: Fix VTTBR_BADDR_MASK and pgd alloc

Marc Zyngier (8):
      KVM: ARM: vgic: plug irq injection race
      arm/arm64: KVM: vgic: switch to dynamic allocation
      arm/arm64: KVM: vgic: Parametrize VGIC_NR_SHARED_IRQS
      arm/arm64: KVM: vgic: kill VGIC_MAX_CPUS
      arm/arm64: KVM: vgic: handle out-of-range MMIO accesses
      arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
      arm/arm64: KVM: vgic: delay vgic allocation until init time
      arm/arm64: KVM: vgic: make number of irqs a configurable attribute

Will Deacon (6):
      KVM: ARM/arm64: fix non-const declaration of function returning const
      KVM: ARM/arm64: fix broken __percpu annotation
      KVM: ARM/arm64: avoid returning negative error code as bool
      KVM: ARM/arm64: return -EFAULT if copy_from_user fails in set_timer_reg
      KVM: vgic: return int instead of bool when checking I/O ranges
      KVM: vgic: declare probe function pointer as const

 Documentation/virtual/kvm/devices/arm-vgic.txt |  10 +
 arch/arm/include/asm/kvm_emulate.h             |   5 +
 arch/arm/include/asm/kvm_host.h                |   2 +-
 arch/arm/include/asm/kvm_mmu.h                 |  11 -
 arch/arm/include/uapi/asm/kvm.h                |   2 +
 arch/arm/kvm/arm.c                             |  17 +-
 arch/arm/kvm/coproc.c                          |   2 +-
 arch/arm/kvm/guest.c                           |   2 +-
 arch/arm/kvm/mmu.c                             |  40 +-
 arch/arm64/include/asm/kvm_arm.h               |  13 +-
 arch/arm64/include/asm/kvm_emulate.h           |   5 +
 arch/arm64/include/asm/kvm_host.h              |   4 +-
 arch/arm64/include/asm/kvm_mmu.h               |  18 +-
 arch/arm64/include/uapi/asm/kvm.h              |   2 +
 arch/arm64/kvm/guest.c                         |   2 +-
 arch/arm64/kvm/sys_regs.c                      |   2 +-
 include/kvm/arm_vgic.h                         | 112 +++--
 include/linux/kvm_host.h                       |   2 +
 virt/kvm/arm/vgic.c                            | 631 ++++++++++++++++++++-----
 virt/kvm/eventfd.c                             |   1 -
 virt/kvm/kvm_main.c                            |  11 +-
 21 files changed, 678 insertions(+), 216 deletions(-)
