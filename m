From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 18:56:57 +0100
Subject: [PATCH v4 0/3] irqfd support for arm/arm64
Message-ID: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables irqfd on arm and arm64.

Irqfd framework enables to inject a virtual IRQ into a guest upon an
eventfd trigger. User-side uses KVM_IRQFD VM ioctl to provide KVM with
a kvm_irqfd struct that associates a VM, an eventfd, a virtual IRQ number
(aka. the gsi). When an actor signals the eventfd (typically a VFIO
platform driver), the kvm irqfd subsystem injects the gsi into the VM.

Resamplefd also is supported for level sensitive interrupts, ie. the
user can provide another eventfd that is triggered when the completion
of the virtual IRQ (gsi) is detected by the GIC.

The gsi must correspond to a shared peripheral interrupt (SPI), ie the
GIC interrupt ID is gsi + 32.

The rationale behind not supporting PPI irqfd injection is that
any device using a PPI would be a private-to-the-CPU device (timer for
instance), so its state would have to be context-switched along with the
VCPU and would require in-kernel wiring anyhow. It is not a relevant use
case for irqfds.

this patch enables CONFIG_HAVE_KVM_EVENTFD and CONFIG_HAVE_KVM_IRQFD.

No IRQ routing table is used, enabling to remove CONFIG_HAVE_KVM_IRQCHIP

can be found at git://git.linaro.org/people/eric.auger/linux.git
on branch irqfd_integ_v8

This work was tested with Calxeda Midway xgmac main interrupt with
qemu-system-arm and QEMU VFIO platform device. Also irqfd was proven
functional on several vhost-net prototypes.

v3 -> v4:
- rebase on 3.18rc5
- vgic dynamic instantiation brought new challenges:
  handling of irqfd injection when vgic is not ready
- unset of CONFIG_HAVE_KVM_IRQCHIP in a separate patch
- add arm64 enable
- vgic.c style modifications according to Christoffer comments

v2 -> v3:
- removal of irq.h from eventfd.c put in a separate patch to increase
  visibility
- properly expose KVM_CAP_IRQFD capability in arm.c
- remove CONFIG_HAVE_KVM_IRQCHIP meaningfull only if irq_comm.c is used

v1 -> v2:
- rebase on 3.17rc1
- move of the dist unlock in process_maintenance
- remove of dist lock in __kvm_vgic_sync_hwstate
- rewording of the commit message (add resamplefd reference)
- remove irq.h


Eric Auger (2):
  KVM: arm/arm64: unset CONFIG_HAVE_KVM_IRQCHIP
  KVM: arm: add irqfd support

Joel Schopp (1):
  KVM: arm64: add irqfd support

 Documentation/virtual/kvm/api.txt |  5 ++-
 arch/arm/include/uapi/asm/kvm.h   |  3 ++
 arch/arm/kvm/Kconfig              |  4 +--
 arch/arm/kvm/Makefile             |  2 +-
 arch/arm/kvm/arm.c                |  3 ++
 arch/arm64/include/uapi/asm/kvm.h |  3 ++
 arch/arm64/kvm/Kconfig            |  3 +-
 arch/arm64/kvm/Makefile           |  2 +-
 virt/kvm/arm/vgic.c               | 72 ++++++++++++++++++++++++++++++++++++---
 9 files changed, 87 insertions(+), 10 deletions(-)

-- 
1.9.1
