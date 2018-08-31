From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Fri, 31 Aug 2018 15:59:57 +0530
Subject: [PATCH 0/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
Message-ID: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add a driver for NXP FlexSPI host controller

 FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
 which supports two SPI channels and up to 4 external devices.
 Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional data lines)
 i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up to 8
 bidirectional data lines.

 FlexSPI controller is similar to the existing Freescale/NXP QuadSPI
 controller with advanced features.

- Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
 filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS targets.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
    Micron, mt35xu512aba[3], [Read - 1 bit mode]
    Cypress, s25fl512s, [Read - 1/2/4 bit mode]

Patch 1 adds variable size in spi_device struct, to save the
size of connected slave device.
Patch 2 adds flags for octal I/O data transfer.
Support for octal flash commands and other framework changes would going to be done in different
patch set.
Patch 3 adds a driver for the NXP FlexSPI controller, driver is based on
new spi-mem framework.
Patch 4 add binding file for this driver.
Patch 5 add device node property for FlexSPI driver for lx2160 SoC.
Patch 6 enables the config option.
Patch 7 add MAINTAINERS file.

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=9721
[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=63445

This series adds below patches:
Yogesh Gaur (7):
  spi: add slave device size in spi_device struct
  spi: add flags for octal I/O data transfer
  spi: spi-mem: Add a driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI driver
  arm64: dts: lx2160a: add fspi node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   42 +
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   21 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/mtd/devices/m25p80.c                       |    6 +
 drivers/mtd/spi-nor/spi-nor.c                      |    2 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-fspi.c                         | 1242 ++++++++++++++++++++
 include/linux/spi/spi.h                            |    4 +
 11 files changed, 1347 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

-- 
2.7.4
