From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 29 Jan 2014 15:34:10 +0100
Subject: [RFC PATCH v2 00/14] mtd: nand: add sunxi NAND Flash Controller
 support
Message-ID: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for the sunxi NAND Flash Controller (NFC).
This controller supports up to 8 NAND chip connected.

I'm still in the early stages drivers development and some key features are
missing, but it's usable (I tested it on the cubietruck board).

Here's what's missing:
 - DMA support
 - HW randomization support
 - other improvements ?

This series depends on Emilio's patch series implementing mod0 clks
(http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185478.html)
+ an other patch not yet posted
(http://git.elopez.com.ar/linux/commits/5b4eb3ac406b9c98965714d40e8dd6da943d1ab0)


Best Regards,

Boris

Changes since v1:
 - add HW ECC support
 - rework NAND timings retrieval (use ONFI timing mode instead of raw timings)
 - add nand-ecc-level property to specify NAND ECC requirements from DT

Boris BREZILLON (14):
  mtd: nand: retrieve ECC requirements from Hynix READ ID byte 4
  of: mtd: add NAND ECC level requirements retrieval
  of: mtd: add documentation for nand-ecc-level property
  mtd: nand: define struct nand_timings
  mtd: nand: add ONFI timing mode to nand_timings converter
  of: mtd: add NAND timing mode retrieval support
  of: mtd: add documentation for the ONFI NAND timing mode property
  mtd: nand: add sunxi NAND flash controller support
  mtd: nand: add sunxi NFC dt bindings doc
  ARM: dt/sunxi: add NFC node to Allwinner A20 SoC
  ARM: dt/sunxi: add NFC pinctrl pin definitions
  ARM: sunxi/dt: enable NAND on cubietruck board
  mtd: nand: add sunxi HW ECC support
  ARM: sunxi/dt: enable HW ECC on cubietruck board

 Documentation/devicetree/bindings/mtd/nand.txt     |    8 +
 .../devicetree/bindings/mtd/sunxi-nand.txt         |   46 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   31 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   35 +
 drivers/mtd/nand/Kconfig                           |    6 +
 drivers/mtd/nand/Makefile                          |    3 +-
 drivers/mtd/nand/nand_base.c                       |   37 +
 drivers/mtd/nand/nand_timings.c                    |  248 +++++
 drivers/mtd/nand/sunxi_nand.c                      |  997 ++++++++++++++++++++
 drivers/of/of_mtd.c                                |   44 +
 include/linux/mtd/nand.h                           |   53 ++
 include/linux/of_mtd.h                             |   15 +
 12 files changed, 1522 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/sunxi-nand.txt
 create mode 100644 drivers/mtd/nand/nand_timings.c
 create mode 100644 drivers/mtd/nand/sunxi_nand.c

-- 
1.7.9.5
