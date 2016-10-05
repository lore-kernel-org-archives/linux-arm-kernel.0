From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Wed,  5 Oct 2016 20:46:54 -0300
Subject: [PATCH 0/3] mtd: s3c2410: add device tree support
Message-ID: <1475711217-974-1-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for configuring Samsung's s3c2410 and
compatible flash memory controller via devicetree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Patch 3 depends on patch 1.

Changes since v1:
- read timings from nand_sdr_timings when booting with a device tree
- naming improvements in the device tree binding
  (s/nand/nand-controller/, s/_/-, s/children/child)
- dropped property samsung,ignore_unset_ecc
- remove @0 from nand device node
- checking pdev->dev.of_node instead of using ifdef CONFIG_OF_MTD
- preventing from parsing device tree properties twice
- increment the nand controller child node refcount, since we
  maintain a reference to it and its name field
- using of_device_get_match_data() instead of of_match_device()
  to make the code simpler
- remove CONFIG_MTD_NAND_S3C2410_HWECC compile option so we can
  select ECC mode using nand-ecc-mode property in the device tree

Sergio Prado (3):
  mtd: s3c2410: make ecc mode configurable via platform data
  dt-bindings: mtd: add DT binding for s3c2410 flash controller
  mtd: s3c2410: parse the device configuration from OF node

 .../devicetree/bindings/mtd/samsung-s3c2410.txt    |  57 +++++
 arch/arm/mach-s3c24xx/common-smdk.c                |   1 +
 arch/arm/mach-s3c24xx/mach-anubis.c                |   1 +
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   1 +
 arch/arm/mach-s3c24xx/mach-bast.c                  |   1 +
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   1 +
 arch/arm/mach-s3c24xx/mach-jive.c                  |   1 +
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   1 +
 arch/arm/mach-s3c24xx/mach-osiris.c                |   1 +
 arch/arm/mach-s3c24xx/mach-qt2410.c                |   1 +
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   1 +
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   1 +
 arch/arm/mach-s3c24xx/mach-vstms.c                 |   1 +
 arch/arm/mach-s3c64xx/mach-hmt.c                   |   1 +
 arch/arm/mach-s3c64xx/mach-mini6410.c              |   1 +
 arch/arm/mach-s3c64xx/mach-real6410.c              |   1 +
 drivers/mtd/nand/Kconfig                           |   9 -
 drivers/mtd/nand/s3c2410.c                         | 284 +++++++++++++++------
 include/linux/platform_data/mtd-nand-s3c2410.h     |   7 +-
 19 files changed, 289 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt

-- 
1.9.1
