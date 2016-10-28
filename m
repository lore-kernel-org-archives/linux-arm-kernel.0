From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Fri, 28 Oct 2016 16:48:13 -0400
Subject: [PATCH V6 0/3] irqchip: qcom: Add IRQ combiner driver
Message-ID: <1477687696-1509-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for IRQ combiners in the Top-level Control and Status
Registers (TCSR) hardware block in Qualcomm Technologies chips.

The first patch fixes probe deferral by allowing platform_device
IRQ resources to be re-initialized if the ACPI core failed to find
the IRQ domain during ACPI bus scan.

The second patch adds support for ResourceSource/IRQ domain mapping
when using Extended IRQ Resources with a specific ResourceSource.
The core ACPI resource management code has been changed to lookup
the IRQ domain when an IRQ resource indicates a ResourceSource,
and register the IRQ on that domain, instead of a GSI.

The third patch takes advantage of the new capabilities to implement
the driver for the IRQ combiners.

Changes V5 -> V6:
* Drop probe table and on-demand probing based on resource_source
* Add patch to fix probe deferral
* Change back combiner driver to use the platform_device/platform_driver
  APIs

Changes V4 -> V5:
* Fix issues flagged by the 0-DAY build bot
* Fix some minor style issues raised by Timur

Changes V3 -> V4:
* Add a DSDT device probe table that is used to probe DSDT IRQ chips
  as necessary when converting HW IRQs to Linux IRQs
* Describe IRQ combiner registers as ACPI Register resources

Agustin Vega-Frias (3):
  ACPI: Retry IRQ conversion if it failed previously
  ACPI: Add support for ResourceSource/IRQ domain mapping
  irqchip: qcom: Add IRQ combiner driver

 drivers/acpi/Makefile               |   1 +
 drivers/acpi/irqdomain.c            | 119 +++++++++++++
 drivers/acpi/resource.c             |  80 ++++++++-
 drivers/base/platform.c             |   9 +-
 drivers/irqchip/Kconfig             |   8 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/qcom-irq-combiner.c | 337 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h                |  32 ++++
 8 files changed, 577 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/irqdomain.c
 create mode 100644 drivers/irqchip/qcom-irq-combiner.c

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
