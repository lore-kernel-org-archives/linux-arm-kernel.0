From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  4 Sep 2015 16:24:37 +0200
Subject: [PATCH 0/2] arm/arm64: KVM: Fix arthictected timer issues
Message-ID: <1441376679-8341-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches fix two separate issues with the architected timer and
the corresponding interrupt injection to VMs on KVM/ARM.

The first patch fixes an issue introduced with the active timer state
switching series recently merged for v4.3, which could cause a guest to
loop without progress if another VCPU is run on the same physical CPU
and preempts the original VCPU while the guest is running the ISR for
the timer interrupt.

The second patch resets the architected timer's control register to zero
on system reset, ensuring that interrupts are not injected when a system
resets.  This fixes a long-standing issue with UEFI, where soft reset
initiated from within UEFI prevented the system from booting again.

Christoffer Dall (2):
  arm/arm64: KVM: vgic: Move active state handling to flush_hwstate
  arm/arm64: KVM: arch timer: Reset CNTV_CTL to 0

 virt/kvm/arm/arch_timer.c |  8 ++++++++
 virt/kvm/arm/vgic.c       | 42 ++++++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.1.2.330.g565301e.dirty
