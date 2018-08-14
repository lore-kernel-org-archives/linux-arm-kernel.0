From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 14 Aug 2018 19:50:14 +0300
Subject: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Message-ID: <cover.1534264292.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx7d the pcie-phy power domain is turned off in suspend and this can
make the system hang on resume when attempting any read from PCI.

Fix this by adding PM_SLEEP support to the imx6 pci driver. This is
currently only enabled for imx7d but the suspend/resume sequence also
applies to other socs.

V3 of this series was reviewed by Lucas but stalled because the merge
window opened.

There was also some confusion about how to deal with the dependence on
commit 26fce0557fa6 ("reset: imx7: Fix always writing bits as 0"). To
clarify: both patch 2 and 26fce0557fa6 are required to fix imx7d suspend
but merging one without the other shouldn't cause other issues.


V4 adds 4 more patches with PME_Turn_Off support on top, using a new
reset bit. I generally try to keep series short but in this case some
planning might be needed to get patches into 4.20.

Since the new reset is treated as optional with old DTB there should be
again no problem if reset and pci are merged out of order.


Shawn/Philipp/Lorenzo: Would it make sense to merge this series through a
single specific tree, such as the one for imx?

Link to v3: https://lkml.org/lkml/2018/7/24/713

Leonard Crestez (6):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  PCI: imx: Initial imx7d pm support
  reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
  dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
  ARM: dts: imx7d: Add turnoff reset
  PCI: imx: Add PME_Turn_Off support

 .../bindings/pci/fsl,imx6q-pcie.txt           |   1 +
 arch/arm/boot/dts/imx7d.dtsi                  |  17 ++-
 drivers/pci/controller/dwc/pci-imx6.c         | 112 +++++++++++++++++-
 drivers/reset/reset-imx7.c                    |   1 +
 include/dt-bindings/reset/imx7-reset.h        |   4 +-
 5 files changed, 123 insertions(+), 12 deletions(-)

-- 
2.17.1
