From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  2 Jul 2015 15:17:10 +0200
Subject: [RFC 00/17] ARM IRQ forward control based on IRQ bypass manager
Message-ID: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allows to set ARM IRQ forwarding between a VFIO platform
device physical IRQ and a guest virtual IRQ.

The setting is coordinated by the prototype IRQ bypass manager.
This kernel integration seems now prefered to previous kvm-vfio device
user api:
- [RFC v6 00/16] KVM-VFIO IRQ forward control,
  https://lkml.org/lkml/2015/4/13/353).

Some rationale can be found in IRQ bypass manager thread:
https://lkml.org/lkml/2015/6/29/268

The principle is the VFIO platform driver registers a producer struct
on VFIO_IRQ_SET_ACTION_TRIGGER while KVM irqfd registers a consumer struct
on the irqfd assignment. This leads to a handshake based on the eventfd
context (used as token) match.

When either of the producer/consumer module disappears, this leads to
an unregistration and the link is disconnected.

Structure of the series:
[1-6] Modifications in the VFIO (platform) driver to prepare for dynamic
      switch between automasked/masked mode
[7-8] Introduce halt/resume guest capability
[9] irq bypass manager proto as sent by Alex
[10-17] Adaptations to support forwarding on top of IRQ bypass manager

Dependencies:
1- [PATCH 00/10] arm/arm64: KVM: Active interrupt state switching for
   shared devices (http://www.spinics.net/lists/kvm/msg117411.html)
2- RFC "ARM: Forwarding physical interrupts to a guest VM"
   (http://lwn.net/Articles/603514/)
3- IRQ bypass manager proto: https://lkml.org/lkml/2015/6/29/268
4- [RFC v2 0/4] chip/vgic adaptations for forwarded irq
   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/323183.html

All those pieces can be found at:
https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.2-rc1-bypass-fwd

More backgroung on ARM IRQ forwarding in the text below and at
http://www.linux-kvm.org/images/a/a8/01x04-ARMdevice.pdf.

A forwarded IRQ is deactivated by the guest and not by the host.
When the guest deactivates the associated virtual IRQ, the interrupt
controller automatically completes the physical IRQ. Obviously
this requires some HW support in the interrupt controller. This is
the case for ARM GICv2.

The direct benefit is that, for a level sensitive IRQ, a VM exit
can be avoided on forwarded IRQ completion.

When the IRQ is forwarded, the VFIO platform driver does not need to
mask the physical IRQ anymore before signaling the eventfd. Indeed
genirq lowers the running priority, enabling other physical IRQ to hit
except that one.

Besides, the injection still is based on irqfd triggering. The only
impact on irqfd process is resamplefd is not called anymore on
virtual IRQ completion since deactivation is not trapped by KVM.

This was tested on Calxeda Midway, assigning the xgmac main IRQ

kvm-vfio v6 -> rfc based on IRQ bypass manager
see previous history in https://lkml.org/lkml/2015/4/13/353).

Best Regards

Eric


Alex Williamson (1):
  bypass: IRQ bypass manager proto by Alex

Eric Auger (16):
  VFIO: platform: test forwarded state when selecting IRQ handler
  VFIO: platform: single handler using function pointer
  VFIO: Introduce vfio_device_external_ops
  VFIO: pci: initialize vfio_device_external_ops
  VFIO: platform: implement vfio_device_external_ops callbacks
  VFIO: add vfio_external_{mask|is_active|set_automasked}
  KVM: arm: rename pause into power_off
  kvm: arm/arm64: implement kvm_arm_[halt,resume]_guest
  KVM: arm: select IRQ_BYPASS_MANAGER
  VFIO: platform: select IRQ_BYPASS_MANAGER
  irq: bypass: Extend skeleton for ARM forwarding control
  KVM: introduce kvm_arch functions for IRQ bypass
  KVM: arm/arm64: vgic: forwarding control
  KVM: arm/arm64: implement IRQ bypass consumer functions
  KVM: eventfd: add irq bypass consumer management
  VFIO: platform: add irq bypass producer management

 arch/arm/include/asm/kvm_host.h               |   5 +-
 arch/arm/kvm/Kconfig                          |   1 +
 arch/arm/kvm/arm.c                            |  60 +++++++-
 arch/arm/kvm/psci.c                           |  10 +-
 arch/arm64/include/asm/kvm_host.h             |   3 +
 arch/x86/kvm/Kconfig                          |   1 +
 drivers/vfio/pci/Kconfig                      |   1 +
 drivers/vfio/pci/vfio_pci.c                   |   1 +
 drivers/vfio/pci/vfio_pci_intrs.c             |   6 +
 drivers/vfio/platform/Kconfig                 |   1 +
 drivers/vfio/platform/vfio_platform_common.c  |   9 ++
 drivers/vfio/platform/vfio_platform_irq.c     | 160 ++++++++++++++++++++-
 drivers/vfio/platform/vfio_platform_private.h |  14 ++
 drivers/vfio/vfio.c                           |  39 ++++++
 include/kvm/arm_vgic.h                        |   7 +
 include/linux/irqbypass.h                     |  43 ++++++
 include/linux/kvm_host.h                      |  27 ++++
 include/linux/vfio.h                          |  34 +++++
 kernel/irq/Kconfig                            |   3 +
 kernel/irq/Makefile                           |   1 +
 kernel/irq/bypass.c                           | 156 +++++++++++++++++++++
 virt/kvm/arm/vgic.c                           | 195 ++++++++++++++++++++++++++
 virt/kvm/eventfd.c                            |  20 +++
 23 files changed, 778 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/irqbypass.h
 create mode 100644 kernel/irq/bypass.c

-- 
1.9.1
