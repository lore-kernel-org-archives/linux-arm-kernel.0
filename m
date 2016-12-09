From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Dec 2016 11:29:56 +0100
Subject: [PATCH v3 00/12] mmc: Add support to Marvell Xenon SD Host Controller
Message-ID: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This the third version of the series adding support for the SDHCI
Xenon controller. It can be currently found on the Armada 37xx and the
Armada 7K/8K but will be also used in more Marvell SoC (and not only
the mvebu ones actually).

I think that now most (if not all) the remarks had been taking into
account since the second version. According to Ziji Hu, here are the
following changes:
" Changes in V3:
  Adjust and improve Xenon DT bindings. Move some caps setting from driver into
  DT. Use mmc-card sub-node to represent eMMC type.
  Remove PHY Sampling Fixed Delay Line scan in lower speed mode.
  Improve Xenon probe and ->init_card() functions.
  Export sdhci_enable_sdio_irq() and implement own SDIO IRQ control.
  Split PHY patch into two smaller patches.
  Temporarily remove AXI clock before its implementation is improved."

Besides this changes I also
- Removed the sdhci-xenon-phy.h and moved its content in the
shc-xenon-phy.c file.
- Fixed the tuning-count usage
- Managed the error case for clk_prepare_enable

For the record the change from v1 was:
" Changes in V2:
  rebase on v4.9-rc2.
  Re-write Xenon bindings. Ajust Xenon DT property naming.
  Add a new DT property to indicate eMMC card type, instead of using
  variable card_candidate.
  Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
  Add support to HS400 retuning."

Thanks,

Gregory

Gregory CLEMENT (3):
  arm64: dts: marvell: add eMMC support for Armada 37xx
  arm64: dts: marvell: add sdhci support for Armada 7K/8K
  arm64: configs: enable SDHCI driver for Xenon

Hu Ziji (9):
  mmc: sdhci: Export sdhci_set_ios() from sdhci.c
  mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
  mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
  mmc: sdhci: Export sdhci_enable_sdio_irq() from sdhci.c
  MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
  dt: bindings: Add bindings for Marvell Xenon SD Host Controller
  mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
  mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC.
  mmc: sdhci-xenon: Add SOC PHY PAD voltage control

 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 197 ++-
 MAINTAINERS                                                   |   7 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                |  17 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |  11 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts                |   7 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |   9 +-
 arch/arm64/configs/defconfig                                  |   1 +-
 drivers/mmc/host/Kconfig                                      |   9 +-
 drivers/mmc/host/Makefile                                     |   3 +-
 drivers/mmc/host/sdhci-xenon-phy.c                            | 908 +++++++-
 drivers/mmc/host/sdhci-xenon.c                                | 616 +++++-
 drivers/mmc/host/sdhci-xenon.h                                | 111 +-
 drivers/mmc/host/sdhci.c                                      |  14 +-
 drivers/mmc/host/sdhci.h                                      |   5 +-
 14 files changed, 1910 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

base-commit: 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942
-- 
git-series 0.9.1
