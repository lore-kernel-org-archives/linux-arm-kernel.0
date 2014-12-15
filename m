From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Dec 2014 12:41:47 +0100
Subject: [GIT PULL 00/12] KVM/ARM Changes for v3.19 - Take 2
Message-ID: <1418643719-25966-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

Here's the second pull request for KVM for arm/arm64 for v3.19, which fixes
reboot problems, clarifies VCPU init, and fixes a regression concerning the
VGIC init flow.

The diffstat includes the previous pull request's patches, because the
previous pull request is not in kvm/next yet I presume, hope that's not
too confusing.

The patches attached here only include the newer patches since the first
pull I sent for this merge window.

The following changes since commit f62c95fd4041d669159dd76ac0bb2a7f86b5b05d:

  Merge tag 'kvm-s390-next-20141028' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2014-10-29 13:31:32 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.19-take2

for you to fetch changes up to 05971120fca43e0357789a14b3386bb56eef2201:

  arm/arm64: KVM: Require in-kernel vgic for the arch timers (2014-12-15 11:50:42 +0100)

Thanks,
-Christoffer

---

Christoffer Dall (11):
      arm/arm64: KVM: Don't clear the VCPU_POWER_OFF flag
      arm/arm64: KVM: Correct KVM_ARM_VCPU_INIT power off option
      arm/arm64: KVM: Reset the HCR on each vcpu when resetting the vcpu
      arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
      arm/arm64: KVM: Turn off vcpus on PSCI shutdown/reboot
      arm/arm64: KVM: Introduce stage2_unmap_vm
      arm/arm64: KVM: Rename vgic_initialized to vgic_ready
      arm/arm64: KVM: Add (new) vgic_initialized macro
      arm/arm64: KVM: Don't allow creating VCPUs after vgic_initialized
      arm/arm64: KVM: Initialize the vgic on-demand when injecting IRQs
      arm/arm64: KVM: Require in-kernel vgic for the arch timers

Peter Maydell (1):
      arm/arm64: KVM: vgic: move reset initialization into vgic_init_maps()

 Documentation/virtual/kvm/api.txt    |  17 ++++-
 arch/arm/include/asm/kvm_emulate.h   |   5 ++
 arch/arm/include/asm/kvm_host.h      |   2 -
 arch/arm/include/asm/kvm_mmu.h       |   6 +-
 arch/arm/kvm/arm.c                   |  78 +++++++++++++++++++++--
 arch/arm/kvm/guest.c                 |  26 --------
 arch/arm/kvm/mmio.c                  |  15 +++--
 arch/arm/kvm/mmu.c                   |  99 +++++++++++++++++++++++++++---
 arch/arm/kvm/psci.c                  |  18 ++++++
 arch/arm64/include/asm/kvm_emulate.h |   5 ++
 arch/arm64/include/asm/kvm_host.h    |   3 +-
 arch/arm64/include/asm/kvm_mmu.h     |   6 +-
 arch/arm64/kvm/guest.c               |  26 --------
 arch/ia64/kvm/kvm-ia64.c             |   2 +-
 arch/x86/kvm/mmu.c                   |   6 +-
 include/kvm/arm_arch_timer.h         |  10 ++-
 include/kvm/arm_vgic.h               |  12 +++-
 include/linux/kvm_host.h             |   3 +-
 virt/kvm/arm/arch_timer.c            |  30 ++++++---
 virt/kvm/arm/vgic.c                  | 116 ++++++++++++++++++-----------------
 virt/kvm/kvm_main.c                  |  16 ++---
 21 files changed, 336 insertions(+), 165 deletions(-)
