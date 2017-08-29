From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 29 Aug 2017 11:38:58 +0200
Subject: [RFC PATCH 0/4] Handle forwarded level-triggered interrupts
Message-ID: <20170829093902.15379-1-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series illustrates an alternative approach to Eric Auger's direct EOI
setup patches [1] in terms of the KVM VGIC support.

The idea is to maintain existing semantics for the VGIC for mapped
level-triggered IRQs and think support for the timer into it.

Patch 1 is stolen from Eric's series and is necessary for these patches
to compile as well.  Patch 2 includes the core support for mapped
level-triggered interrupts.  Patch 3 moves some code around for patch 4.
Patch 4 implements an optimization for the timer.  The last two patches
could be deferred until the timer optimization series.

This series is untested (hence the RFC tag) and I'm looking for
feedback from the VGIC guys (you know who you are) on the approach and
whether we know up-front that this breaks for some reason.

I'll be happy to test and debug further if we agree on the overall
approach.

Based on v4.13-rc7.

Thanks,
-Christoffer

[1]: https://lists.cs.columbia.edu/pipermail/kvmarm/2017-June/026072.html

Christoffer Dall (3):
  KVM: arm/arm64: vgic: Support level-triggered mapped interrupts
  KVM: arm/arm64: Rearrange kvm_vgic_[un]map_phys code in vgic.c
  KVM: arm/arm64: Provide a vgic interrupt line level sample function

Eric Auger (1):
  KVM: arm/arm64: vgic: restructure kvm_vgic_(un)map_phys_irq

 include/kvm/arm_vgic.h      | 19 +++++++++++--
 virt/kvm/arm/arch_timer.c   | 38 ++++++++++---------------
 virt/kvm/arm/vgic/vgic-v2.c | 29 +++++++++++++++++++
 virt/kvm/arm/vgic/vgic-v3.c | 29 +++++++++++++++++++
 virt/kvm/arm/vgic/vgic.c    | 68 +++++++++++++++++++++++++++++++++++++--------
 virt/kvm/arm/vgic/vgic.h    |  7 +++++
 6 files changed, 153 insertions(+), 37 deletions(-)

-- 
2.9.0
