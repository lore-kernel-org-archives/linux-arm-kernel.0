From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 13:49:45 +0100
Subject: [GIT PULL] KVM/arm updates for 4.18-rc2
Message-ID: <20180622124953.12355-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Radim, Paolo,

This is the first batch of fixes for 4.18, mostly dealing with the
fallout from Dave's lazy FPSIMD handling. We also have the disabling
of the compat interface on arm64 (it never had it the first place),
and a relaxation on the alignment of the GICv3 compatibility
interface.

Please pull.

	M.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-for-4.18-1

for you to fetch changes up to 37b65db85f9b2fc98267eee4a18d7506492e6e8c:

  KVM: arm64: Prevent KVM_COMPAT from being selected (2018-06-21 17:17:50 +0100)

----------------------------------------------------------------
KVM/arm fixes for 4.18, take #1

- Lazy FPSIMD switching fixes
- Really disable compat ioctls on architectures that don't want it
- Disable compat on arm64 (it was never implemented...)
- Rely on architectural requirements for GICV on GICv3
- Detect bad alignments in unmap_stage2_range

----------------------------------------------------------------
Ard Biesheuvel (1):
      KVM: arm/arm64: Drop resource size check for GICV window

Dave Martin (3):
      KVM: arm64: Don't mask softirq with IRQs disabled in vcpu_put()
      KVM: arm64/sve: Fix SVE trap restoration for non-current tasks
      KVM: arm64: Avoid mistaken attempts to save SVE state for vcpus

Jia He (1):
      KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE aligned in unmap_stage2_range

Marc Zyngier (2):
      KVM: Enforce error in ioctl for compat tasks when !KVM_COMPAT
      KVM: arm64: Prevent KVM_COMPAT from being selected

Mark Rutland (1):
      arm64: Introduce sysreg_clear_set()

 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/sysreg.h   | 11 +++++++++++
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++---------
 virt/kvm/Kconfig                  |  2 +-
 virt/kvm/arm/mmu.c                |  2 ++
 virt/kvm/arm/vgic/vgic-v3.c       |  5 -----
 virt/kvm/kvm_main.c               | 19 +++++++++----------
 7 files changed, 51 insertions(+), 25 deletions(-)
