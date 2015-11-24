From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 16:43:57 +0100
Subject: [PATCH 0/3] KVM: arm/arm64: Fix some more timer related issues
Message-ID: <1448379840-17516-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This little series addresses some problems we've been observing with the
arch timer.  First, we were fiddling with a PPI timer interrupt outside
of a preemptible section, which is bad for obvious reasons.  Second, we
were clearing the physical active state when we shouldn't.  Third, we
can simplify the vgic code by just considering the LR state instead of
the GIC physical state on guest return.

Christoffer Dall (3):
  KVM: arm/arm64: Fix preemptible timer active state crazyness
  KVM: arm/arm64: arch_timer: Preserve physical dist. active state on
    LR.active
  KVM: arm/arm64: vgic: Trust the LR state for HW IRQs

 arch/arm/kvm/arm.c        |  7 +------
 include/kvm/arm_vgic.h    |  2 +-
 virt/kvm/arm/arch_timer.c | 28 +++++++++++++++----------
 virt/kvm/arm/vgic.c       | 53 ++++++++++++++++++++++++-----------------------
 4 files changed, 46 insertions(+), 44 deletions(-)

-- 
2.1.2.330.g565301e.dirty
