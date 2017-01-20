From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 19 Jan 2017 21:34:17 -0500
Subject: [PATCH V11 0/3] irqchip: qcom: Add IRQ combiner driver
Message-ID: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for IRQ combiners in the Top-level Control and Status
Registers (TCSR) hardware block in Qualcomm Technologies chips.

The first patch prevents the ACPI core from attempting to map IRQ resources
with a valid ResourceSource as GSIs.

The second patch adds support for ResourceSource/IRQ domain mapping and
fixes IRQ probe deferral by allowing platform_device IRQ resources to be
re-initialized from the corresponding ACPI IRQ resource.

Both changes described above are conditional on the ACPI_GENERIC_GSI config.

The third patch takes advantage of the new capabilities to implement
the driver for the IRQ combiners.

Tested on top of v4.10-rc4.

Changes V10 -> V11:
* Add probe table and use it to implement driver presence detection.
* Fix kernel doc formatting in drivers/acpi/irq.c and some minor style issues.
* Minor bug fixes in the driver.

Changes V9 -> V10:
* Add checks for the producer_consumer field to not use produced IRQ
  resources as consumed.
* Minor bug fixes in the driver.

Changes V8 -> V9:
* Do not attempt the mapping for non-GSI IRQs during bus scan.
* Make some public APIs private to drivers/acpi/irq.c since they are no
  longer used on other modules.

Agustin Vega-Frias (3):
  ACPI: Generic GSI: Do not attempt to map non-GSI IRQs during bus scan
  ACPI: Add support for ResourceSource/IRQ domain mapping
  irqchip: qcom: Add IRQ combiner driver

 drivers/acpi/Makefile               |   2 +-
 drivers/acpi/{gsi.c => irq.c}       | 221 +++++++++++++++++++++++++
 drivers/acpi/resource.c             |  18 +-
 drivers/base/platform.c             |   8 +
 drivers/irqchip/Kconfig             |   9 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/qcom-irq-combiner.c | 320 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h   |   1 +
 include/linux/acpi.h                |  15 ++
 9 files changed, 593 insertions(+), 2 deletions(-)
 rename drivers/acpi/{gsi.c => irq.c} (28%)
 create mode 100644 drivers/irqchip/qcom-irq-combiner.c

--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
