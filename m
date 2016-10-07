From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri,  7 Oct 2016 10:25:47 +0200
Subject: [PATCH v4 00/10] net-next: ethernet: add sun8i-emac driver
Message-ID: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patch series add the driver for sun8i-emac which handle the Ethernet MAC
present on Allwinner H3/A83T/A64 SoCs.

It supports 10/100/1000 Mbit/s speed with half/full duplex.
It can use an internal PHY (MII 10/100) or an external PHY
via RGMII/RMII.

This patch series enable the driver only for the H3 SoC since A83T and A64
doesn't have the necessary clocks present in mainline.

This patch series enable the driver only for OrangePiPC and OrangePIOne boards
since other board with H3 use external PHY which need optional regulators
that will be supported later.

The driver have been tested on the following boards:
- H3 Orange PI PC, Orange PI Plus, BananaPI-M2+
- A64 Pine64
- A83T BananaPI-M3

I would like to thanks Chen-Yu Tsai for his help on developing this driver.

Regards

Changes since v3
- sun8i-emac require a DT mdio node
- moved sun8i_emac_power() so that no clock/reset/regulator is used
    until netdev/open is called
- Removed PM patch until proper tests are done
- DT use phy-handle instead of phy
- Moved DT aliases ethernet to subnodes
- Renamed PHY nodes to [int|ext]_[r|g]mii_phy
- Moved clock/reset for internal PHY to PHY node.

Changes since v2
- Added patch to support Orange PI One
- Added a patch to enable SUN8I_EMAC in sunxi_defconfig
- Added a patch to enable pm_runtime
- The Emac clock is now used standard syscon/regmap
- Added netdev_sent_queue/netdev_completed_queue
- Added lots of documentation on working (locks, memory barrier, etc...)
- Cleaned DT bindings documentation
- Added ethernet0 aliases as suggested by Hans de Goede
- Change prefix of all DEFINE to EMAC_
- The driver is now endian safe
- Reworked the internal PHY mechanism
- Removed dma_set_mask_and_coherent(32) since it is the default for of_platform_driver

Changes since v1
- Implement NAPI
- Sorted and reworded all define
- Reworked ethtools stats strings
- Removed all unneeded __packked and __aligned
- Added tuning of RX/TX ring size via ethtool
- Corrected use of sk/skb naming
- Added some wmb when needed
- Moved irq claim/free to emac_open/close
- Lots of code refactoring

Corentin Labbe (9):
  ethernet: add sun8i-emac driver
  MAINTAINERS: Add myself as maintainer of sun8i-emac
  ARM: sun8i: dt: Add DT bindings documentation for Allwinner sun8i-emac
  ARM: dts: sun8i-h3: Add dt node for the syscon control module
  ARM: dts: sun8i-h3: add sun8i-emac ethernet driver
  ARM: dts: sun8i: Enable sun8i-emac on the Orange PI PC
  ARM: dts: sun8i: Enable sun8i-emac on the Orange Pi 2
  ARM: sunxi: Enable sun8i-emac driver on multi_v7_defconfig
  ARM: sunxi: Enable sun8i-emac driver on sunxi_defconfig

Hans de Goede (1):
  ARM: dts: sun8i: Enable sun8i-emac on the Orange PI One

 .../bindings/net/allwinner,sun8i-emac.txt          |   70 +
 MAINTAINERS                                        |    6 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |    8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |    8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |    8 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   29 +
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/configs/sunxi_defconfig                   |    1 +
 drivers/net/ethernet/allwinner/Kconfig             |   13 +
 drivers/net/ethernet/allwinner/Makefile            |    1 +
 drivers/net/ethernet/allwinner/sun8i-emac.c        | 2266 ++++++++++++++++++++
 11 files changed, 2411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
 create mode 100644 drivers/net/ethernet/allwinner/sun8i-emac.c

-- 
2.7.3
