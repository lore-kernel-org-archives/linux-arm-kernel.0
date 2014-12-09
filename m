From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 16:43:59 +0100
Subject: [PATCH 0/5] Fix vgic initialization problems
Message-ID: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
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

Christoffer Dall (4):
  arm/arm64: KVM: Rename vgic_initialized to vgic_ready
  arm/arm64: KVM: Add (new) vgic_initialized macro
  arm/arm64: KVM: Don't allow creating VCPUs after vgic_initialized
  arm/arm64: KVM: Initialize the vgic on-demand when injecting IRQs

Peter Maydell (1):
  arm/arm64: KVM: vgic: move reset initialization into vgic_init_maps()

 arch/arm/kvm/arm.c     | 13 +++++---
 include/kvm/arm_vgic.h | 12 +++++--
 virt/kvm/arm/vgic.c    | 91 +++++++++++++++++++++++---------------------------
 3 files changed, 60 insertions(+), 56 deletions(-)

-- 
2.1.2.330.g565301e.dirty
