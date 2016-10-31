From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Oct 2016 12:09:49 +0100
Subject: [PATCH 0/10] mmc: Add support to Marvell Xenon SD Host Controller
Message-ID: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This the second version of the series adding support for the SDHCI
Xenon controller. It can be currently found on the Armada 37xx and the
Armada 7K/8K but will be also used in more Marvell SoC (and not only
the mvebu ones actually).

Some of the remarks had been taking into account since the first
version, according to Ziji Hu, here are the following chcanges:
"Changes in V2:
  rebase on v4.9-rc2.
  Re-write Xenon bindings. Ajust Xenon DT property naming.
  Add a new DT property to indicate eMMC card type, instead of using
  variable card_candidate.
  Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
  Add support to HS400 retuning."

I think the main open point which remains is about issuing commands
from the ->set_ios() callback (in patch 7).
Ulf, could you comment about it?

Thanks,

Gregory

Gregory CLEMENT (3):
  arm64: dts: marvell: add eMMC support for Armada 37xx
  arm64: dts: marvell: add sdhci support for Armada 7K/8K
  arm64: configs: enable SDHCI driver for Xenon

Ziji Hu (7):
  mmc: sdhci: Export sdhci_set_ios() from sdhci.c
  mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
  mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
  MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
  dt: bindings: Add bindings for Marvell Xenon SD Host Controller
  mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
  mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC

 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt |  161 +-
 MAINTAINERS                                                   |    7 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                |    8 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |   11 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts                |    8 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |    9 +-
 arch/arm64/configs/defconfig                                  |    1 +-
 drivers/mmc/host/Kconfig                                      |    9 +-
 drivers/mmc/host/Makefile                                     |    3 +-
 drivers/mmc/host/sdhci-xenon-phy.c                            | 1181 +++++++-
 drivers/mmc/host/sdhci-xenon-phy.h                            |  157 +-
 drivers/mmc/host/sdhci-xenon.c                                |  598 ++++-
 drivers/mmc/host/sdhci-xenon.h                                |  159 +-
 drivers/mmc/host/sdhci.c                                      |   11 +-
 drivers/mmc/host/sdhci.h                                      |    4 +-
 15 files changed, 2323 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

base-commit: 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942
-- 
git-series 0.8.10
