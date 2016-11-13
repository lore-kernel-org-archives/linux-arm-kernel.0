From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Sun, 13 Nov 2016 16:59:32 -0500
Subject: [PATCH V7 0/3] irqchip: qcom: Add IRQ combiner driver
Message-ID: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for IRQ combiners in the Top-level Control and Status
Registers (TCSR) hardware block in Qualcomm Technologies chips.

The first patch fixes IRQ probe deferral by allowing platform_device
IRQ resources to be re-initialized if the ACPI core failed to find
the IRQ domain during ACPI bus scan.

The second patch adds support for ResourceSource/IRQ domain mapping
when using Extended IRQ Resources with a specific ResourceSource.
These changes are conditional on the ACPI_GENERIC_GSI config.

The third patch takes advantage of the new capabilities to implement
the driver for the IRQ combiners.

Tested on top of v4.9-rc4.

Changes V6 -> V7:
* Consolidate changes for ResourceSource/IRQ domain mapping to the same
  source file implementing the generic GSI support, making it conditional
  on CONFIG_ACPI_GENERIC_GSI.
* Eliminate some code duplication by implementing acpi_register_gsi in
  terms of the new acpi_register_irq API.

Changes V5 -> V6:
* Drop probe table and on-demand probing based on resource_source
* Add patch to fix probe deferral
* Change back combiner driver to use the platform_device/platform_driver
  APIs

Agustin Vega-Frias (3):
  ACPI: Retry IRQ conversion if it failed previously
  ACPI: Add support for ResourceSource/IRQ domain mapping
  irqchip: qcom: Add IRQ combiner driver

 drivers/acpi/Makefile               |   2 +-
 drivers/acpi/{gsi.c => irq.c}       |  98 +++++++++--
 drivers/acpi/resource.c             |  88 ++++++++--
 drivers/base/platform.c             |   9 +-
 drivers/irqchip/Kconfig             |   8 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/qcom-irq-combiner.c | 337 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h                |  26 +++
 8 files changed, 541 insertions(+), 28 deletions(-)
 rename drivers/acpi/{gsi.c => irq.c} (53%)
 create mode 100644 drivers/irqchip/qcom-irq-combiner.c

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
