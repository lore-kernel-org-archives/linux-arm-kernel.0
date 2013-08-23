From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Aug 2013 12:19:58 -0700
Subject: [PATCH 0/8] Support VGIC save/restore using device control API
Message-ID: <1377285606-15692-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement save/restore of the VGIC state using the newer KVM Device
Control API.  This requries some number of changes to existing code in
addition to actually supporting save/restore of the necessary state.

The first patches (01-03) support creating the VGIC using the Device
Control API.  This change is necessary because there are no other
suitable KVM APIs that we can leverage to access the VGIC state from
user space and the device control API was crafted exactly for this
purpose.

Subsequent patches add the missing infrastructure and user space API
pieces necessary to actually save and restore the VGIC state.  The GIC
v2.0 architecture specification already specifies registers that can be
used to save and restore the complete VGIC state for suspend/resume
purposes on real hardware, and we can resuse this interface for the
VGIC.  The API is therefore based on the memory-mapped register accesses
defined in the specs.  See the individual patches for details.

The patches rely on a number of small fixes sent separately to actually
work:
git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate-prereq

This patch series based on the above can be cloned from:
git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate

User space patches for QEMU will follow shortly.  Tested on Versatile
Express TC2.

Christoffer Dall (8):
  ARM: KVM: Allow creating the VGIC after VCPUs
  KVM: arm-vgic: Support KVM_CREATE_DEVICE for VGIC
  KVM: arm-vgic: Set base addr through device API
  irqchip: arm-gic: Define additional MMIO offsets and masks
  KVM: arm-vgic: Make vgic mmio functions more generic
  KVM: arm-vgic: Add vgic reg access from dev attr
  KVM: arm-vgic: Add GICD_SPENDSGIR and GICD_CPENDSGIR handlers
  KVM: arm-vgic: Support CPU interface reg access

 Documentation/virtual/kvm/api.txt              |    6 +-
 Documentation/virtual/kvm/devices/arm-vgic.txt |   56 +++
 arch/arm/include/uapi/asm/kvm.h                |    8 +
 arch/arm/kvm/arm.c                             |   10 +-
 include/kvm/arm_vgic.h                         |    2 +-
 include/linux/irqchip/arm-gic.h                |   14 +
 include/linux/kvm_host.h                       |    1 +
 include/uapi/linux/kvm.h                       |    1 +
 virt/kvm/arm/vgic.c                            |  479 ++++++++++++++++++++++--
 virt/kvm/kvm_main.c                            |    5 +
 10 files changed, 554 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/arm-vgic.txt

-- 
1.7.10.4
