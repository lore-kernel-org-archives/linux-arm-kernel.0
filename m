From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:25 +0100
Subject: [PULL 00/27] KVM/ARM GICv4 Support for v4.15
Message-ID: <20171113091752.10663-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Radim,

Here is the second pull request for KVM/ARM for v4.15. These changes
introduce GICv4 support in KVM/ARM, allowing direct injection of LPIs
from devices generating MSIs into VMs.  The changes rely on irqchip
infrastructure for GICv4 already merged in tip:irq/core.

The pull request is based on kvm-arm-for-v4.15 plus 722c908f84c6 merged
from tip:irq/core.  The diffstat has been trimmed to only show the
changes between the merge base mentioned above and the KVM/ARM side of
GICv4 support, and does not include the additional changes in KVM not
present in tip:irq/core.

I expect that pulling this into the KVM tree after the irq/core changes
land in Linus' tree should result in a clean subsequent pull request
upstream, but let me know if you want me to work this out in some other
way.

The following changes since commit 722c908f84c67bf120105ca870675cadc1bb7b20:

  Merge tag 'irqchip-4.15-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core (2017-11-02 19:18:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-gicv4-for-v4.15

for you to fetch changes up to 95b110ab9a093b5baf3a72e51f71279368d618e2:

  KVM: arm/arm64: Don't queue VLPIs on INV/INVALL (2017-11-10 09:59:20 +0100)

Thanks,
-Christoffer

Christoffer Dall (2):
  KVM: arm/arm64: Fix GICv4 ITS initialization issues
  KVM: arm/arm64: Don't queue VLPIs on INV/INVALL

Eric Auger (2):
  KVM: arm/arm64: register irq bypass consumer on ARM/ARM64
  KVM: arm/arm64: vgic: restructure kvm_vgic_(un)map_phys_irq

Marc Zyngier (23):
  KVM: arm: Select ARM_GIC_V3 and ARM_GIC_V3_ITS
  KVM: arm/arm64: vgic: Move kvm_vgic_destroy call around
  KVM: arm/arm64: vITS: Add MSI translation helpers
  KVM: arm/arm64: vITS: Add a helper to update the affinity of an LPI
  KVM: arm/arm64: GICv4: Add property field and per-VM predicate
  KVM: arm/arm64: GICv4: Add init/teardown of the per-VM vPE irq domain
  KVM: arm/arm64: GICv4: Wire mapping/unmapping of VLPIs in VFIO irq
    bypass
  KVM: arm/arm64: GICv4: Handle INT command applied to a VLPI
  KVM: arm/arm64: GICv4: Unmap VLPI when freeing an LPI
  KVM: arm/arm64: GICv4: Propagate affinity changes to the physical ITS
  KVM: arm/arm64: GICv4: Handle CLEAR applied to a VLPI
  KVM: arm/arm64: GICv4: Handle MOVALL applied to a vPE
  KVM: arm/arm64: GICv4: Propagate property updates to VLPIs
  KVM: arm/arm64: GICv4: Handle INVALL applied to a vPE
  KVM: arm/arm64: GICv4: Use pending_last as a scheduling hint
  KVM: arm/arm64: GICv4: Add doorbell interrupt handling
  KVM: arm/arm64: GICv4: Use the doorbell interrupt as an unblocking
    source
  KVM: arm/arm64: GICv4: Hook vPE scheduling into vgic flush/sync
  KVM: arm/arm64: GICv4: Enable virtual cpuif if VLPIs can be delivered
  KVM: arm/arm64: GICv4: Prevent a VM using GICv4 from being saved
  KVM: arm/arm64: GICv4: Prevent userspace from changing doorbell
    affinity
  KVM: arm/arm64: GICv4: Enable VLPI support
  KVM: arm/arm64: GICv4: Theory of operations

 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 Documentation/virtual/kvm/devices/arm-vgic-its.txt |   2 +
 arch/arm/kvm/Kconfig                               |   5 +
 arch/arm/kvm/Makefile                              |   1 +
 arch/arm64/kvm/Kconfig                             |   3 +
 arch/arm64/kvm/Makefile                            |   1 +
 include/kvm/arm_vgic.h                             |  41 ++-
 virt/kvm/arm/arch_timer.c                          |  24 +-
 virt/kvm/arm/arm.c                                 |  48 ++-
 virt/kvm/arm/hyp/vgic-v3-sr.c                      |   9 +-
 virt/kvm/arm/vgic/vgic-init.c                      |   7 +
 virt/kvm/arm/vgic/vgic-its.c                       | 204 ++++++++----
 virt/kvm/arm/vgic/vgic-mmio-v3.c                   |   5 +
 virt/kvm/arm/vgic/vgic-v3.c                        |  14 +
 virt/kvm/arm/vgic/vgic-v4.c                        | 364 +++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.c                           |  67 +++-
 virt/kvm/arm/vgic/vgic.h                           |  10 +
 17 files changed, 695 insertions(+), 114 deletions(-)
 create mode 100644 virt/kvm/arm/vgic/vgic-v4.c

-- 
2.14.2
