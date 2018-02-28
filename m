From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 17:35:28 +0100
Subject: [PATCH v2 0/2] PCI: armada8k: Fix clock resource for Armada 7K/8K
Message-ID: <20180228163530.25389-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short series fixes the way the clocks are used for the PCIe host
controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
second one is needed in order to clock the registers. It was not
noticed until now because we relied on the bootloader and also because
the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

The first patch is just a small cleanup found when I wrote the main
patch.

Changelog:
v1 -> v2:

 - Removed a unneeded new line in the binding documentation, pointed
   by Thomas Petazzoni.

 - Added a new line in driver code, pointed by Thomas Petazzoni.

 - Managed the failure of clk_prepare_enable for the clk_reg in a
   separate case, pointed by Thomas Petazzoni.

 - Simplified the -EPROBE_DEFER case for the clk_reg, suggested by
   Russell King

 - Added backed the line getting the reg clock that disappeared in the
   first version.

Gregory CLEMENT (2):
  PCI: armada8k: Remove useless test before clk_disable_unprepare
  PCI: armada8k: Fix clock resource by adding a register clock

 .../devicetree/bindings/pci/pci-armada8k.txt        |  5 ++++-
 drivers/pci/dwc/pcie-armada8k.c                     | 21 +++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.16.1
