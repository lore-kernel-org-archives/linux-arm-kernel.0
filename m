From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:56:50 +0100
Subject: [GIT PULL] Second pull request for KVM on arm/arm64 for 3.18
Message-ID: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

Please find below the second pull request for KVM/arm for 3.18. The
most obvious thing is the sizeable MMU changes to support 48bit VAs on
arm64.

Also, please note that there will be a conflict with one of the
patches (the BE accesses fix), which should be resolved just like in
-next.

Thanks,

	M.

The following changes since commit 0496daa5cf99741ce8db82686b4c7446a37feabb:

  arm/arm64: KVM: Report correct FSC for unsupported fault types (2014-09-26 14:39:45 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.18-take-2

for you to fetch changes up to 2df36a5dd6792870bef48f63bfca42055ea5b79c:

  arm/arm64: KVM: Fix BE accesses to GICv2 EISR and ELRSR regs (2014-10-16 10:57:41 +0200)

----------------------------------------------------------------
Second batch of changes for KVM/{arm,arm64} for 3.18

- Support for 48bit IPA and VA (EL2)
- A number of fixes for devices mapped into guests
- Yet another VGIC fix for BE
- A fix for CPU hotplug
- A few compile fixes (disabled VGIC, strict mm checks)

----------------------------------------------------------------
Ard Biesheuvel (6):
      arm/arm64: KVM: use __GFP_ZERO not memset() to get zeroed pages
      arm/arm64: KVM: fix potential NULL dereference in user_mem_abort()
      arm/arm64: KVM: add 'writable' parameter to kvm_phys_addr_ioremap
      ARM: kvm: define PAGE_S2_DEVICE as read-only by default
      arm64: kvm: define PAGE_S2_DEVICE as read-only by default
      arm/arm64: KVM: map MMIO regions at creation time

Arnd Bergmann (1):
      ARM: KVM: fix vgic-disabled build

Christoffer Dall (3):
      arm64: KVM: Implement 48 VA support for KVM EL2 and Stage-2
      arm/arm64: KVM: Ensure memslots are within KVM_PHYS_SIZE
      arm/arm64: KVM: Fix BE accesses to GICv2 EISR and ELRSR regs

Steve Capper (1):
      arm: kvm: STRICT_MM_TYPECHECKS fix for user_mem_abort

Vladimir Murzin (1):
      arm: kvm: fix CPU hotplug

 arch/arm/include/asm/kvm_mmu.h   |  31 +++++-
 arch/arm/include/asm/pgtable.h   |   2 +-
 arch/arm/kvm/arm.c               |   5 +-
 arch/arm/kvm/interrupts_head.S   |   7 ++
 arch/arm/kvm/mmu.c               | 235 ++++++++++++++++++++++++++++++++-------
 arch/arm64/include/asm/kvm_mmu.h | 127 +++++++++++++++++++--
 arch/arm64/include/asm/pgtable.h |   2 +-
 arch/arm64/kvm/vgic-v2-switch.S  |  12 +-
 include/kvm/arm_vgic.h           |  12 +-
 virt/kvm/arm/vgic-v2.c           |  24 +---
 virt/kvm/arm/vgic.c              |  21 +++-
 11 files changed, 392 insertions(+), 86 deletions(-)
