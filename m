From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Dec 2013 12:14:11 -0800
Subject: [PATCH v4 0/6] Krait L1/L2 EDAC driver
Message-ID: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Krait L1/L2 cache error detection
hardware. The first patch fixes a generic framework bug. The next
two patches lay the groundwork for this driver to be added by 
exporting percpu irq functions as well as adding the Krait l2 indirection
register code. The next two patches add the driver and the binding and 
the final patch hooks it all up by adding the device tree node.

I'm not sure which tree this is supposed to go through. Ideally we could
send the first 3 plus the 5th one through an edac tree. The final dts changes
could go through arm-soc via davidb's tree and the Documentation patch could
go through the devicetree tree.

Changes since v3:
 * Fixed l1_irq handler to properly dereference dev_id

Changes since v2:
 * Picked up acks
 * s/an/a/ in DT binding

Changes since v1:
 * Moved binding into cpus node
 * Picked up acks on first two patches
 * Commented krait l2 accessor functions

Stephen Boyd (6):
  edac: Don't try to cancel workqueue when it's never setup
  genirq: export percpu irq functions for module usage
  ARM: Add Krait L2 accessor functions
  devicetree: bindings: Document Krait L1/L2 EDAC
  edac: Add support for Krait CPU cache error detection
  ARM: dts: msm: Add Krait CPU/L2 nodes

 Documentation/devicetree/bindings/arm/cpus.txt |  72 +++++
 arch/arm/boot/dts/qcom-msm8974.dtsi            |  41 +++
 arch/arm/common/Kconfig                        |   3 +
 arch/arm/common/Makefile                       |   1 +
 arch/arm/common/krait-l2-accessors.c           |  58 +++++
 arch/arm/include/asm/krait-l2-accessors.h      |  20 ++
 drivers/edac/Kconfig                           |   8 +
 drivers/edac/Makefile                          |   2 +
 drivers/edac/edac_device.c                     |   3 +
 drivers/edac/krait_edac.c                      | 346 +++++++++++++++++++++++++
 kernel/irq/manage.c                            |   2 +
 11 files changed, 556 insertions(+)
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
 create mode 100644 drivers/edac/krait_edac.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
