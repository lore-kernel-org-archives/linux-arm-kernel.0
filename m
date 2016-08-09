From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Tue,  9 Aug 2016 16:28:42 +0530
Subject: [RFC PATCH v2 0/4] arm/arm64: vgic-new: Implement API for vGICv3 live
 migration
Message-ID: <1470740326-27751-1-git-send-email-vijay.kilari@gmail.com>
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

v1 => v2:
 - The init sequence change patch is no more required.
   Fixed in patch 2 by using static vgic_io_dev regions structure instead
   of using dynamic allocation pointer.
 - Updated commit message of patch 4.
 - Dropped usage of union to manage 32-bit and 64-bit access in patch 1.
   Used local variable for 32-bit access.
 - Updated macro __ARM64_SYS_REG and ARM64_SYS_REG in 
   arch/arm64/include/uapi/asm/kvm.h as per qemu requirements.

Vijaya Kumar K (4):
  arm/arm64: vgic-new: Introduce 64-bit reg access support
  arm/arm64: vgic-new: Add distributor and redistributor access
  arm/arm64: vgic-new: Introduce find_reg_by_id()
  arm/arm64: vgic-new: Implement VGICv3 CPU interface access

 arch/arm64/include/uapi/asm/kvm.h   |  18 ++-
 arch/arm64/kvm/Makefile             |   1 +
 arch/arm64/kvm/sys_regs.c           |  22 ++--
 arch/arm64/kvm/sys_regs.h           |   4 +
 include/linux/irqchip/arm-gic-v3.h  |   4 +
 virt/kvm/arm/vgic/vgic-kvm-device.c | 138 +++++++++++++++++++---
 virt/kvm/arm/vgic/vgic-mmio-v2.c    |   4 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c    | 119 +++++++++++++++++++
 virt/kvm/arm/vgic/vgic-mmio.c       |   2 +-
 virt/kvm/arm/vgic/vgic-sys-reg-v3.c | 225 ++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h            |  14 +++
 11 files changed, 525 insertions(+), 26 deletions(-)
 create mode 100644 virt/kvm/arm/vgic/vgic-sys-reg-v3.c

-- 
1.9.1
