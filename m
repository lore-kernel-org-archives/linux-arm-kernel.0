From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Mar 2018 17:16:42 +0000
Subject: [PATCH v2 0/6] KVM/ARM fixes for 4.16-rc6
Message-ID: <20180315171648.19501-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Radim, Paolo,

Heres a handful of fixes that I've collected over the past couple of
weeks. A number of them are -stable candidates, and address funny
regressions (some which have been there for quite a while).

Please pull.

	M.


The following changes since commit 67870eb1204223598ea6d8a4467b482e9f5875b5:

  ARM: kvm: fix building with gcc-8 (2018-02-15 20:58:36 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-for-v4.16-2

for you to fetch changes up to 27e91ad1e746e341ca2312f29bccb9736be7b476:

  kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3 (2018-03-14 18:31:26 +0000)

----------------------------------------------------------------
kvm/arm fixes for 4.16, take 2

- Peace of mind locking fix in vgic_mmio_read_pending
- Allow hw-mapped interrupts to be reset when the VM resets
- Fix GICv2 multi-source SGI injection
- Fix MMIO synchronization for GICv2 on v3 emulation
- Remove excess verbosity on the console

----------------------------------------------------------------
Andre Przywara (1):
      KVM: arm/arm64: vgic: Add missing irq_lock to vgic_mmio_read_pending

Ard Biesheuvel (1):
      KVM: arm/arm64: Reduce verbosity of KVM init log

Christoffer Dall (2):
      KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
      KVM: arm/arm64: Reset mapped IRQs on VM reset

Marc Zyngier (2):
      KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid
      kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3

 arch/arm64/kvm/guest.c             |  3 --
 include/kvm/arm_vgic.h             |  1 +
 include/linux/irqchip/arm-gic-v3.h |  1 +
 include/linux/irqchip/arm-gic.h    |  1 +
 virt/kvm/arm/arch_timer.c          |  6 ++-
 virt/kvm/arm/arm.c                 |  9 ----
 virt/kvm/arm/hyp/vgic-v3-sr.c      |  3 +-
 virt/kvm/arm/mmu.c                 |  6 +--
 virt/kvm/arm/vgic/vgic-mmio.c      |  3 ++
 virt/kvm/arm/vgic/vgic-v2.c        | 11 ++++-
 virt/kvm/arm/vgic/vgic-v3.c        |  9 +++-
 virt/kvm/arm/vgic/vgic.c           | 87 ++++++++++++++++++++++++++++++++------
 virt/kvm/arm/vgic/vgic.h           |  3 ++
 13 files changed, 109 insertions(+), 34 deletions(-)
