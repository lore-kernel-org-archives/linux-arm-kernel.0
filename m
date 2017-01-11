From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 11 Jan 2017 18:19:03 +0100
Subject: [PATCH v5 00/12] mmc: Add support to Marvell Xenon SD Host Controller
Message-ID: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This the fifth version of the series adding support for the SDHCI
Xenon controller. It can be currently found on the Armada 37xx and the
Armada 7K/8K but will be also used in more Marvell SoC (and not only
the mvebu ones actually).

v4->v5:

- Remove the patch to export sdhci_execute_tuning(). It is already
  exported in v4.10.

- Introduce a patch adding a missing clock for the sdhci controller
  present on the CP master for A7K/A8K. There is no build dependency
  but obviously this patch is need to use the sdhci controller present
  on the CP part.

- Adjust Xenon return setup, to avoid being overwritten by
   sdhci_add_host().

- Change Xenon register definition prefix to "XENON_".

-  Fix typos in Xenon driver and dt-binding docs.

- Change compatible string "marvell,armada-7000-sdhci" to
  "marvell,armada-8k-sdhci". Actually the Armada 7K SoCs are a subset
  of the Armada 8K SoCs. Moreover, the use of the '000' is not
  consistent with all the other compatible string already used for the
  Armada 7K/8K family.

- Added the Tested-by from Russell King on an Armada 8K based board.

v3 -> v4:
For this version a few change have been done:
- fixes 2 bug  reported by kbuild-bot
  - remove extra of_node_put()
  - convert 0 in false for function returning boolean

- add a device tree node for the sdhci controller present on the CP
  master for A7K/A8K. It also led to rename the sdhci0 node on AP to
  ap_sdhci0 to make a distinction with the one present on CP master.

v2 -> v3
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

Hu Ziji (8):
  mmc: sdhci: Export sdhci_set_ios() from sdhci.c
  mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
  mmc: sdhci: Export sdhci_enable_sdio_irq() from sdhci.c
  dt: bindings: Add bindings for Marvell Xenon SD Host Controller
  mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
  mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC.
  mmc: sdhci-xenon: Add SoC PHY PAD voltage control
  MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers

Konstantin Porotchkin (1):
  clk: apn806: Add eMMC clock to system controller driver

 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 197 ++-
 MAINTAINERS                                                   |   7 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                |  16 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |  11 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts                |  14 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |  13 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi          |  11 +-
 arch/arm64/configs/defconfig                                  |   1 +-
 drivers/clk/mvebu/ap806-system-controller.c                   |  15 +-
 drivers/mmc/host/Kconfig                                      |   9 +-
 drivers/mmc/host/Makefile                                     |   3 +-
 drivers/mmc/host/sdhci-xenon-phy.c                            | 904 +++++++-
 drivers/mmc/host/sdhci-xenon.c                                | 634 +++++-
 drivers/mmc/host/sdhci-xenon.h                                | 109 +-
 drivers/mmc/host/sdhci.c                                      |  11 +-
 drivers/mmc/host/sdhci.h                                      |   4 +-
 16 files changed, 1953 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

base-commit: 0c744ea4f77d72b3dcebb7a8f2684633ec79be88
-- 
git-series 0.9.1
