From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 20 Mar 2017 19:24:02 +0530
Subject: [PATCH v6 0/4] phy: USB and PCIe phy drivers for Qcom chipsets
Message-ID: <1490018046-8549-1-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds couple of PHY drivers for Qualcomm chipsets.
a) qcom-qusb2 phy driver: that provides High Speed USB functionality.
b) qcom-qmp phy driver: that is a combo phy providing support for
   USB3, PCIe, UFS and few other controllers.

The patches are based on next branch of linux-phy tree, and depends
on phy driver grouping series[1]:
[PATCH v4 0/3] phy: Group phy drivers based on vendor listing.

These patches have been tested on Dragon board db820c hardware with
required set of dt patches and the patches to get rpm up on msm8996.
Couple of other patches [2, 3] fixing DMA config for XHCI are also
pulled in for testing.
The complete branch is available in github [4].

Changes since v5:
 - Addressed review comments from Bjorn:
   - Removed instances of readl/wirtel_relaxed calls from the drivers.
     Instead, using simple readl/writel. Inserting a readl after a writel
     to ensure the write is through to the device.
   - Replaced regulator handling with regulator_bulk_** apis. This helps
     in cutting down a lot of regulator handling code.
   - Fixed minor return statements.

Changes since v4:
 - Addressed comment to add child nodes for qmp phy driver. Each phy lane
   now has a separate child node under the main qmp node.
 - Modified the clock and reset initialization and enable methods.
   Different phys - pcie, usb and later ufs, have varying number of clocks
   and resets that are mandatory. So adding provision for clocks and reset
   lists helps in requesting all mandatory resources for individual phys
   and handle their failure cases accordingly.

Changes since v3:
 - Addressed review comments given by Rob and Stephen for qusb2 phy
   and qmp phy bindings respectively.
 - Addressed review comments given by Stephen and Bjorn for qmp phy driver.

Changes since v2:
 - Addressed review comments given by Rob and Stephen for bindings.
 - Addressed the review comments given by Stephen for the qusb2 and qmp
   phy drivers.

Changes since v1:
 - Moved device tree binding documentation to separate patches, as suggested
   by Rob.
 - Addressed review comment regarding qfprom accesses by qusb2 phy driver,
   given by Rob.
 - Addressed review comments from Kishon.
 - Addressed review comments from Srinivas for QMP phy driver.
 - Addressed kbuild warning.

Please see individual patches for detailed changelogs.

[1] https://www.spinics.net/lists/arm-kernel/msg569990.html
[2] https://patchwork.kernel.org/patch/9567767/
[3] https://patchwork.kernel.org/patch/9567779/
[4] https://github.com/vivekgautam1/linux/tree/linux-phy-next-qcom-phy-db820c

Vivek Gautam (4):
  dt-bindings: phy: Add support for QUSB2 phy
  phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips
  dt-bindings: phy: Add support for QMP phy
  phy: qcom-qmp: new qmp phy driver for qcom-chipsets

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  106 ++
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   45 +
 drivers/phy/qualcomm/Kconfig                       |   18 +
 drivers/phy/qualcomm/Makefile                      |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 1153 ++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  491 +++++++++
 6 files changed, 1815 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qusb2.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
