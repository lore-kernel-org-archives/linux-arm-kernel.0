From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:16 +0700
Subject: [RFCv2 PATCH 0/8] Introducing ACPI support for GICv2m
Message-ID: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI core patches for ARM64 are now upstreamed in 4.1. The PCI support
patches for ARM64 ACPI are also in progress. I am sending out this RFC to
introduce ACPI support for GICv2m. This would allow MSI to work when
booting ACPI.

There are some modifications to the irq_domain and acpi/gsi code.

Due to a large number of prerequisite patches, I have put together a branch
on GitHub for review and testing:

	https://github.com/ssuthiku/linux.git acpi-pci-msi-rfc2

This branch has been tested on AMD Seattle Platform. Any feedback and
comments are appreciated.

Thank you in advance,

Suravee

Changes in RFC2:
    - Rebased to V3 of Introducing per-device MSI domain
      (from Marc Zyngier)
    - Rebased to V2 of Add seld-probe infrastructure and stacked
      irqdomain support for APCI based GICv2/3 init
      (from Hanjun Guo)
    - Introduce GIC MSI frame handle.

Suravee Suthikulpanit (8):
  irqdomain: Introduce irq_domain_ops.init_alloc_info
  gic: Introduce gic_init_irq_alloc_info()
  gicv2m: Convert to use GIC irq_domain_ops.init_alloc_info
  acpi: gsi: Adding acpi_init_irq_alloc_info() hook
  arm64: Adding arch-specific acpi_init_irq_alloc_info
  gic: acpi: Introduce GIC MSI frame handle and helper functions
  gicv2m: Introducing gicv2m_acpi_init()
  pci: acpi: Bind GICv2m MSI frame to PCI host bridge

 arch/arm64/kernel/acpi.c             |  13 ++++
 drivers/acpi/gsi.c                   |  36 ++++++++--
 drivers/irqchip/irq-gic-acpi.c       |  78 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v2m.c        | 129 ++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c            |  85 +++++++++++++++++++----
 drivers/pci/pci-acpi.c               |  35 ++++++++++
 drivers/pci/probe.c                  |   2 +
 include/linux/irqchip/arm-gic-acpi.h |   3 +
 include/linux/irqchip/arm-gic.h      |  24 +++++++
 include/linux/irqdomain.h            |   2 +
 include/linux/pci-acpi.h             |   1 +
 kernel/irq/irqdomain.c               |  10 ++-
 12 files changed, 372 insertions(+), 46 deletions(-)

-- 
2.1.0
