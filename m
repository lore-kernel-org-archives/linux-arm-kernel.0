From: julien.grall@arm.com (Julien Grall)
Date: Tue,  8 Mar 2016 11:29:24 +0000
Subject: [PATCH v3 0/9] arm64: Add support of KVM with ACPI
Message-ID: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series allows an ARM64 ACPI based platform to use KVM.

Currently the KVM code has to parse the firmware table to get the necessary
information to setup the virtual timer and virtual GIC.

However the parsing of those tables are already done in the GIC and arch
timer drivers.

This patch series introduces different helpers to retrieve the information
from different drivers avoiding the duplication of the parsing code.

Compare to v2, the serie has been reworked to allow easy merge via the
different trees.

For the other changes see the different patches.

Sincerely yours,

Julien Grall (9):
  clocksource: arm_arch_timer: Gather KVM specific information in a
    structure
  clocksource: arm_arch_timer: Extend arch_timer_kvm_info to get the
    virtual IRQ
  irqchip/gic-v2: Gather ACPI specific data in a single structure
  irqchip/gic-v2: Parse and export virtual GIC information
  irqchip/gic-v3: Gather all ACPI specific data in a single structure
  irqchip/gic-v3: Parse and export virtual GIC information
  KVM: arm/arm64: arch_timer: Rely on the arch timer to parse the
    firmware tables
  KVM: arm/arm64: vgic: Rely on the GIC driver to parse the firmware
    tables
  clocksource: arm_arch_timer: Remove arch_timer_get_timecounter

 drivers/clocksource/arm_arch_timer.c   |  11 ++-
 drivers/irqchip/irq-gic-common.c       |  13 +++
 drivers/irqchip/irq-gic-common.h       |   3 +
 drivers/irqchip/irq-gic-v3.c           | 145 ++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c              |  91 +++++++++++++++++++--
 include/clocksource/arm_arch_timer.h   |  12 +--
 include/kvm/arm_vgic.h                 |   7 +-
 include/linux/irqchip/arm-gic-common.h |  34 ++++++++
 virt/kvm/arm/arch_timer.c              |  40 +++------
 virt/kvm/arm/vgic-v2.c                 |  67 ++++++---------
 virt/kvm/arm/vgic-v3.c                 |  45 +++-------
 virt/kvm/arm/vgic.c                    |  50 ++++++------
 12 files changed, 345 insertions(+), 173 deletions(-)
 create mode 100644 include/linux/irqchip/arm-gic-common.h

-- 
1.9.1
