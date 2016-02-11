From: julien.grall@arm.com (Julien Grall)
Date: Thu, 11 Feb 2016 15:33:18 +0000
Subject: [PATCH v2 0/6] arm64: Add support of KVM with ACPI
Message-ID: <1455204804-31830-1-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small series allows an ARM64 ACPI based platform to use KVM.

Currently the KVM code has to parse the firmware table to get the necessary
information to setup the virtual timer and virtual GIC.

However the parsing of those tables are already done in the GIC and arch
timer drivers.

This patch series introduces different helpers to retrieve the information
from different drivers avoiding to duplicate the parsing code.

Note there is patch series ([1] and [2]) adding support of KVM on ACPI,
although the approach chosen is completely different. The code to parse
the firmware tables are duplicated which I think make more complex to
support new firmware tables.

See the changes since v1 in the different patches.

Regards,

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-February/018482.html
[2] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-February/018355.html

Julien Grall (6):
  KVM: arm/arm64: arch_timer: Gather KVM specific information in a
    structure
  KVM: arm/arm64: arch_timer: Rely on the arch timer to parse the
    firmware tables
  irqchip/gic-v2: Gather ACPI specific data in a single structure
  irqchip/gic-v2: Parse and export virtual GIC information
  irqchip/gic-v3: Parse and export virtual GIC information
  KVM: arm/arm64: vgic: Rely on the GIC driver to parse the firmware
    tables

 drivers/clocksource/arm_arch_timer.c   | 11 ++--
 drivers/irqchip/irq-gic-common.c       | 13 +++++
 drivers/irqchip/irq-gic-common.h       |  3 ++
 drivers/irqchip/irq-gic-v3.c           | 36 ++++++++++++++
 drivers/irqchip/irq-gic.c              | 91 ++++++++++++++++++++++++++++++++--
 include/clocksource/arm_arch_timer.h   | 13 ++---
 include/kvm/arm_vgic.h                 |  7 +--
 include/linux/irqchip/arm-gic-common.h | 34 +++++++++++++
 virt/kvm/arm/arch_timer.c              | 39 ++++-----------
 virt/kvm/arm/vgic-v2.c                 | 67 +++++++++----------------
 virt/kvm/arm/vgic-v3.c                 | 45 +++++------------
 virt/kvm/arm/vgic.c                    | 50 ++++++++++---------
 12 files changed, 264 insertions(+), 145 deletions(-)
 create mode 100644 include/linux/irqchip/arm-gic-common.h

-- 
1.9.1
