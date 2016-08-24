From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 24 Aug 2016 16:50:04 +0530
Subject: [RFC PATCH v3 0/5] arm/arm64: vgic-new: Implement API for vGICv3 live
 migration
Message-ID: <1472037609-4164-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

This patchset adds API for saving and restoring
of VGICv3 registers to support live migration with new vgic feature.
This API definition is as per version of VGICv3 specification
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html

To test live migration with QEMU, use below patch series
https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg01444.html

The patch 3 & 4 are picked from the Pavel's previous implementation.
http://www.spinics.net/lists/kvm/msg122040.html

v2 => v3:
 - Implemented separate API for ISPENDR and ICPENDR to
   read soft_pending instead of pending for level triggerred interrupts
 - Implemented ioctl KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO to access line level
 - Rebased on top of Christoffer's patch set
   http://www.spinics.net/lists/kvm/msg136840.html

 NOTE: GICD_STATUSR and GICR_STATUSR are implemented as RAZ/WI.

v1 => v2:
 - The init sequence change patch is no more required.
   Fixed in patch 2 by using static vgic_io_dev regions structure instead
   of using dynamic allocation pointer.
 - Updated commit message of patch 4.
 - Dropped usage of union to manage 32-bit and 64-bit access in patch 1.
   Used local variable for 32-bit access.
 - Updated macro __ARM64_SYS_REG and ARM64_SYS_REG in
   arch/arm64/include/uapi/asm/kvm.h as per qemu requirements.

Vijaya Kumar K (5):
  arm/arm64: vgic-new: Implement support for userspace access
  arm/arm64: vgic-new: Add distributor and redistributor access
  arm/arm64: vgic-new: Introduce find_reg_by_id()
  arm/arm64: vgic-new: Implement VGICv3 CPU interface access
  arm/arm64: vgic-new: Implement KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl

 arch/arm64/include/uapi/asm/kvm.h   |  24 +++-
 arch/arm64/kvm/Makefile             |   1 +
 arch/arm64/kvm/sys_regs.c           |  22 ++--
 arch/arm64/kvm/sys_regs.h           |   4 +
 include/linux/irqchip/arm-gic-v3.h  |   4 +
 virt/kvm/arm/vgic/vgic-kvm-device.c | 198 ++++++++++++++++++++++++++++++++-
 virt/kvm/arm/vgic/vgic-mmio-v2.c    |   9 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c    | 178 ++++++++++++++++++++++++++++--
 virt/kvm/arm/vgic/vgic-mmio.c       | 123 +++++++++++++++++++--
 virt/kvm/arm/vgic/vgic-mmio.h       |  31 ++++++
 virt/kvm/arm/vgic/vgic-sys-reg-v3.c | 211 ++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h            |  17 +++
 12 files changed, 789 insertions(+), 33 deletions(-)
 create mode 100644 virt/kvm/arm/vgic/vgic-sys-reg-v3.c

-- 
1.9.1
