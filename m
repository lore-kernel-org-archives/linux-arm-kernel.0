From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 17 Nov 2014 15:40:20 +0800
Subject: Add Support for MediaTek PMIC MT6397 MFD Core and Regulator
Message-ID: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch sets add support for MediaTek PMIC MT6397 MFD core and its regulator driver.
This is hardware layout for access PMIC MT6397 from AP SoC MT8135.
Between PMIC MT6397 and MT8135, the physical signal channel is SPI bus. 
Tere is a specific hardware called PMIC Wrapper or PWRAP to handle access protocols in both PMIC and AP side.

+-----------------+           +---------------+
|                 |           |               |
| Mediatek AP SoC |           |               |
| (ex. MT8135)    |           |    MT6397     |
|                 |           |               |
|      +--------+ | (SPI bus) | +--------+    |
|      |        | |-----------| |        |    |
|      |  PMIC  | |-----------| |  PMIC  |    |
|      | Wrapper| |-----------| | Wrapper|    |
|      |        | |-----------| |        |    |
|      +--------+ |           | +--------+    |
|                 |           |               |
+-----------------+           +---------------+

The patch set: 
Patch 1/7: Add core driver files for PMIC MT6397 MFD.
Patch 2/7: Add PMIC wrapper of MT8135 to access MT6397 MFD. This is regmap of MT6397 MFD.
Patch 3/7: PMIC provides regulator functions. This patch is MT6397 regulator driver.
Patch 4/7: Add document for MT6397 MFD.
Patch 5/7: Add document for MT6397 Regulator.
Patch 6/7: Add device tree for MT6397 MFD and its regmap in mt8135.dtsi.
Patch 7/7: Add device tree for MT6397 regulators in mt8135.dtsi.

This driver is based on 3.18-rc1.
Please notice that reset controller in Patch 2/7 is based previous patch in 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/299141.html.

Flora Fu (7):
  mfd: MT6397: Add support for PMIC MT6397 MFD
  mfd: MT6397: Add regmap for MT8135 and MT6397 SoC
  regulator: MT6397: Add support for MT6397 regulator
  dt-bindings: Add document for MT6397 MFD
  dt-bindings: Add document for MT6397 regulator
  ARM: dts: mt8135: Add support for PMIC MT6397 MFD
  ARM: dts: mt8135: Add support for MT6397 regulator

 Documentation/devicetree/bindings/mfd/mt6397.txt   |  87 +++
 .../bindings/regulator/mt6397-regulator.txt        |  31 +
 arch/arm/boot/dts/mt8135.dtsi                      | 211 +++++
 drivers/mfd/Kconfig                                |  18 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/mt6397-core.c                          |  94 +++
 drivers/mfd/mt8135-pmic-wrap.c                     | 847 +++++++++++++++++++++
 drivers/mfd/mt8135-pmic-wrap.h                     | 138 ++++
 drivers/mfd/mtk-pmic-wrap.h                        |  25 +
 drivers/regulator/Kconfig                          |   6 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6397-regulator.c               | 547 +++++++++++++
 include/linux/mfd/mt6397/core.h                    |  27 +
 include/linux/mfd/mt6397/registers.h               | 362 +++++++++
 include/linux/regulator/mt6397-regulator.h         |  50 ++
 15 files changed, 2446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
 create mode 100644 drivers/mfd/mt6397-core.c
 create mode 100644 drivers/mfd/mt8135-pmic-wrap.c
 create mode 100644 drivers/mfd/mt8135-pmic-wrap.h
 create mode 100644 drivers/mfd/mtk-pmic-wrap.h
 create mode 100644 drivers/regulator/mt6397-regulator.c
 create mode 100644 include/linux/mfd/mt6397/core.h
 create mode 100644 include/linux/mfd/mt6397/registers.h
 create mode 100644 include/linux/regulator/mt6397-regulator.h

--
1.8.1.1.dirty
