From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Jun 2014 22:51:01 +0200
Subject: [RFC PATCH 0/6] arm/arm64: KVM: Various VGIC cleanups and improvements
Message-ID: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VGIC distributor struct has a number of fields which are named
subopimally when needing to add more refined handling of level-triggered
interrupts.

We also never handled writes to the GICD_ISPENDRn and GICD_ICPENDRn
properly, which was never a real concern until we started playing with
IRQ injection for assigned devices, IRQFDs, and other fun stuff.

This RFC series tries to address some of these issues.

*** WARNING ***
This series is untested!!

I am only sending it out now, untested, as is, giving people
ever-lasting right to ridicule me, because Eric Auger is blocked on this
work and I wanted to communicate my thoughts on how to handle this.

It also has the added benefit of receiving early comments (yes, please!)
and let other people who are messing around with this file a chance to
scream at me.

Christoffer Dall (6):
  arm/arm64: KVM: Rename irq_state to irq_pending
  arm/arm64: KVM: Rename irq_active to irq_queued
  arm/arm64: KVM: vgic: Clear queued flags on unqueue
  arm/arm64: KVM: vgic: Improve handling of GICD_I{CS}PENDRn
  arm/arm64: KVM: vgic: Fix SGI writes to GICD_I{CS}PENDR0
  arm/arm64: KVM: vgic: Clarify and correct vgic documentation

 include/kvm/arm_vgic.h |  24 ++++--
 virt/kvm/arm/vgic.c    | 217 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 184 insertions(+), 57 deletions(-)

-- 
1.8.5.2
