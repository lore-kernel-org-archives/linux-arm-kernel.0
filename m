From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 12:17:23 +0100
Subject: [PATCH v2 0/6] Fix vgic initialization problems
Message-ID: <1418469449-13277-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes problems with initializing the VGIC.

The problem is that we were initializing the state of the VGIC on-demand
partially, and doing some final initializtion at the time when we were
going to run a VCPU for the first time.

This broke migration, because the first-vcpu-run init would overwrite
restored state.

We also cleanup the naming of the init functions and add checks when
creating VCPUs and when injecting IRQs from userspace.

This series invalidates patch 3 "KVM: arm/arm64: check vgic_initialized
before VCPU creation" in Eric Auger's vgic init ioctl series.

Eric's series should be applied after this one, making future ABIs
(IRQFD, VFIO, GICv3, ...) require explicit userspace vgic initialization
instead of this on-demand approach that we now have to maintain for
legacy userspace compatiblity.

I've tested this with 32-bit and 64-bit QEMU and kvmtool.

Changes since v1:
 - Use vgic_initialized in vgic_init instead of open-coded check
 - Check return value from vgic_init in kvm_vgic_inject_irq
 - Added Patch 6

Christoffer Dall (5):
  arm/arm64: KVM: Rename vgic_initialized to vgic_ready
  arm/arm64: KVM: Add (new) vgic_initialized macro
  arm/arm64: KVM: Don't allow creating VCPUs after vgic_initialized
  arm/arm64: KVM: Initialize the vgic on-demand when injecting IRQs
  arm/arm64: KVM: Require in-kernel vgic for the arch timers

Peter Maydell (1):
  arm/arm64: KVM: vgic: move reset initialization into vgic_init_maps()

 arch/arm/kvm/arm.c           |  24 +++++++---
 include/kvm/arm_arch_timer.h |   2 +-
 include/kvm/arm_vgic.h       |  12 +++--
 virt/kvm/arm/arch_timer.c    |  15 ++++---
 virt/kvm/arm/vgic.c          | 101 +++++++++++++++++++++----------------------
 5 files changed, 88 insertions(+), 66 deletions(-)

-- 
2.1.2.330.g565301e.dirty
