From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 10 Jul 2014 07:39:50 -0700
Subject: [PATCH 0/6] arm/arm64: KVM: Various VGIC cleanups and improvements
Message-ID: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VGIC distributor struct has a number of fields which are named
subopimally when needing to add more refined handling of level-triggered
interrupts.

We also never handled writes to the GICD_ISPENDRn and GICD_ICPENDRn
properly, which was never a real concern until we started playing with
IRQ injection for assigned devices, IRQFDs, and other fun stuff.

This series tries to address some of these issues.

The code is also available here:
git://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vgic-set-clear-pending-v2

Changelog[v2]:
 - Rebased onto Marc's series from hell (kvm-arm/debug-merge-3.17)
 - Clarify comment in vgic_process_maintenance()
 - Fix spelling errors and other commit text blurbs
 - Actually tested it this time around (on TC2 and APM Mustang)

Christoffer Dall (6):
  arm/arm64: KVM: Rename irq_state to irq_pending
  arm/arm64: KVM: Rename irq_active to irq_queued
  arm/arm64: KVM: vgic: Clear queued flags on unqueue
  arm/arm64: KVM: vgic: Improve handling of GICD_I{CS}PENDRn
  arm/arm64: KVM: vgic: Fix SGI writes to GICD_I{CS}PENDR0
  arm/arm64: KVM: vgic: Clarify and correct vgic documentation

 include/kvm/arm_vgic.h |  24 ++++--
 virt/kvm/arm/vgic.c    | 222 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 189 insertions(+), 57 deletions(-)

-- 
2.0.0
