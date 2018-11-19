From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 19 Nov 2018 17:07:55 +0000
Subject: [PATCH 0/4] KVM: arm/arm64: vgic: Use raw_spinlock for locks taken in
 IRQ context
Message-ID: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing KVM running on PREEMPT_RT, starting guest could simply
freeze the machine. This is because we are using spinlocks for VGIC
locks, which is invalid in the VGIC case since the locks must be take
with interrupts disabled.

The solution is to use raw_spinlock instead of spinlocks.

Replacing those locks also highlighted an issue where we attempt to
cond_resched with interrupts disabled.

Patch 1 fixes the cond_resched issue.
Patch 2-4 replace the VGIC spinlocks with raw_spinlocks

Cheers,

Julien

-->

Julien Thierry (4):
  KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled
  KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
  KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

 include/kvm/arm_vgic.h           |   6 +-
 virt/kvm/arm/vgic/vgic-debug.c   |   4 +-
 virt/kvm/arm/vgic/vgic-init.c    |   8 +--
 virt/kvm/arm/vgic/vgic-its.c     |  22 +++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  14 ++---
 virt/kvm/arm/vgic/vgic-mmio-v3.c |  12 ++--
 virt/kvm/arm/vgic/vgic-mmio.c    |  67 +++++++++-----------
 virt/kvm/arm/vgic/vgic-v2.c      |   4 +-
 virt/kvm/arm/vgic/vgic-v3.c      |   8 +--
 virt/kvm/arm/vgic/vgic.c         | 130 +++++++++++++++++++--------------------
 10 files changed, 132 insertions(+), 143 deletions(-)

--
1.9.1
