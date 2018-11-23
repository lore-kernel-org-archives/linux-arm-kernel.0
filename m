From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 11:15:49 +0100
Subject: [PATCH 0/7] Bring suspend to RAM support to MVEBU SATA
Message-ID: <20181123101556.29888-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of an effort to bring suspend to RAM support to Armada 3700
SoCs (main target: ESPRESSObin), this series handles the work around
the SATA IP.

First, a change in the libahci platform adds support for the new PHY
framework by following the phy_set_mode()/phy_power_on()
sequence. Then, the AHCI MVEBU driver is a bit updated (patch 2 & 3)
and a missing initialization is added for the A3700 in patch 4 (only
done by the Bootloader before). Missing clock support is implemented
in patch 5 to be sure the clock will be resumed before this driver
(see [1] for the series adding device links to the clock core).

Finally, device trees are updated to reflect the hardware: the missing
PHY is added to the ESPRESSObin DT, and the clock is added to the SoC
DT (patch 6 & 7). Bindings already document the clock and the PHY so
no update is needed on this regard.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/614527.html

Thanks,
Miqu?l


Miquel Raynal (7):
  ata: libahci_platform: comply to PHY framework
  ata: ahci: mvebu: remove stale comment
  ata: ahci: mvebu: do Armada 38x configuration only on relevant SoCs
  ata: ahci: mvebu: add Armada 3700 initialization needed for S2RAM
  ata: ahci: mvebu: add clock support
  ARM64: dts: marvell: armada-37xx: declare SATA clock
  ARM64: dts: marvell: armada-3720-espressobin: declare SATA PHY
    property

 .../dts/marvell/armada-3720-espressobin.dts   |  2 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  1 +
 drivers/ata/ahci_mvebu.c                      | 93 ++++++++++++++-----
 drivers/ata/libahci_platform.c                | 11 +++
 4 files changed, 84 insertions(+), 23 deletions(-)

-- 
2.19.1
