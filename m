From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 19:12:49 +0100
Subject: [RFC 0/4] vgic additions for forwarded irq
Message-ID: <1416766373-13569-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series applies on top of "ARM: Forwarding physical
interrupts to a guest VM" (http://lwn.net/Articles/603514/)
series.

It brings some extra functionalities that were requested to
be able to inject virtual level sensitive IRQs triggered from
VFIO/irqfd.

It adds:
- a specific handling of forwarded IRQ into the VGIC state machine.
- deactivation of physical IRQ and unforwarding on vgic destruction
- handling of forwarded IRQ injection before the vgic readiness:
  this was needed because in a sample qemu/vfio use case, qemu
  registers forwarded IRQ and set up VFIO signaling before the first
  vcpu run and hence before vgic readiness. At that time some
  physical IRQ may hit before the VGIC readiness. This is typically
  observed with Calxeda xgmac on second QEMU run.
- rbtree lock addition.

Integrated pieces can be found at
ssh://git.linaro.org/people/eric.auger/linux.git
on branch irqfd_integ_v8

The first 2 patch files were previously part of [RFC v2 0/9]
KVM-VFIO IRQ forward control (https://lkml.org/lkml/2014/9/1/347).


Eric Auger (4):
  KVM: arm: vgic: fix state machine for forwarded IRQ
  KVM: arm: vgic: add forwarded irq rbtree lock
  KVM: arm: vgic: cleanup forwarded IRQs on destroy
  KVM: arm: vgic: handle irqfd forwarded IRQ injection before vgic
    readiness

 include/kvm/arm_vgic.h |   1 +
 virt/kvm/arm/vgic.c    | 128 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 110 insertions(+), 19 deletions(-)

-- 
1.9.1
