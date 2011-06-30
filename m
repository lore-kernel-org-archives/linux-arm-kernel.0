From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 30 Jun 2011 08:25:16 -0400
Subject: [PATCH 0/7] ARM: SAMSUNG: Cleanup SPI platform specific code
Message-ID: <1309436723-662-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does the following:

1. Move duplicated code to common place
[PATCH 1/7] ARM: SAMSUNG: Move SPI device definitions to plat-samsung
SPI platform devices are defined in respective machine folder of
Samsung S3C64XX and S5P series SoCs.This is duplicated for every SoC.
So all SPI platform devices are moved to a common place.

[PATCH 2/7] ARM: SAMSUNG: Define common macro for SPI physical address

[PATCH 3/7] ARM: SAMSUNG: Add SPI clock definitions for SAMSUNG SoCs
Each SoC has it's own set of clock sources for SPI.So they are defined in
respective machine folder.

[PATCH 4/7] ARM: SAMSUNG: Create SPI device setup files in
respective machine folder

[PATCH 5/7] ARM: SAMSUNG: Add SPI platform specific code
As SPI platform devices are moved to common place some platform specific
code need to be initialized in the respective machine file.

[PATCH 6/7] SPI: S5PC100: Enable the SPI driver for S5PC100

[PATCH 7/7] SPI: S5PV210: Enable the SPI driver for S5PV210

 arch/arm/mach-s3c64xx/Kconfig                    |   14 ++
 arch/arm/mach-s3c64xx/Makefile                   |    3 +-
 arch/arm/mach-s3c64xx/dev-spi.c                  |  177 -----------------
 arch/arm/mach-s3c64xx/include/mach/map.h         |    2 +
 arch/arm/mach-s3c64xx/include/mach/spi-clocks.h  |    6 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c            |   11 +
 arch/arm/mach-s3c64xx/setup-spi0.c               |   21 ++
 arch/arm/mach-s3c64xx/setup-spi1.c               |   21 ++
 arch/arm/mach-s5p64x0/Kconfig                    |   20 ++-
 arch/arm/mach-s5p64x0/Makefile                   |    3 +-
 arch/arm/mach-s5p64x0/dev-spi.c                  |  222 ---------------------
 arch/arm/mach-s5p64x0/include/mach/map.h         |    2 +
 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h  |    5 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c            |   11 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c            |   11 +
 arch/arm/mach-s5p64x0/setup-spi0.c               |   31 +++
 arch/arm/mach-s5p64x0/setup-spi1.c               |   31 +++
 arch/arm/mach-s5pc100/Kconfig                    |   21 ++
 arch/arm/mach-s5pc100/Makefile                   |    4 +-
 arch/arm/mach-s5pc100/dev-spi.c                  |  223 ----------------------
 arch/arm/mach-s5pc100/include/mach/map.h         |    3 +
 arch/arm/mach-s5pc100/include/mach/spi-clocks.h  |    6 +
 arch/arm/mach-s5pc100/mach-smdkc100.c            |   19 ++
 arch/arm/mach-s5pc100/setup-spi0.c               |   21 ++
 arch/arm/mach-s5pc100/setup-spi1.c               |   21 ++
 arch/arm/mach-s5pc100/setup-spi2.c               |   23 +++
 arch/arm/mach-s5pv210/Kconfig                    |   14 ++
 arch/arm/mach-s5pv210/Makefile                   |    3 +-
 arch/arm/mach-s5pv210/dev-spi.c                  |  173 -----------------
 arch/arm/mach-s5pv210/include/mach/map.h         |    2 +
 arch/arm/mach-s5pv210/include/mach/spi-clocks.h  |    5 +
 arch/arm/mach-s5pv210/mach-smdkv210.c            |   12 ++
 arch/arm/mach-s5pv210/setup-spi0.c               |   23 +++
 arch/arm/mach-s5pv210/setup-spi1.c               |   23 +++
 arch/arm/plat-samsung/Kconfig                    |   15 ++-
 arch/arm/plat-samsung/Makefile                   |    3 +
 arch/arm/plat-samsung/dev-spi0.c                 |   87 +++++++++
 arch/arm/plat-samsung/dev-spi1.c                 |   87 +++++++++
 arch/arm/plat-samsung/dev-spi2.c                 |   87 +++++++++
 arch/arm/plat-samsung/include/plat/devs.h        |   12 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   18 ++-
 drivers/spi/Kconfig                              |    3 +-
 42 files changed, 677 insertions(+), 822 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-spi.c
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi0.c
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi1.c
 delete mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi0.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi1.c
 delete mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi0.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi1.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi2.c
 delete mode 100644 arch/arm/mach-s5pv210/dev-spi.c
 create mode 100644 arch/arm/mach-s5pv210/setup-spi0.c
 create mode 100644 arch/arm/mach-s5pv210/setup-spi1.c
 create mode 100644 arch/arm/plat-samsung/dev-spi0.c
 create mode 100644 arch/arm/plat-samsung/dev-spi1.c
 create mode 100644 arch/arm/plat-samsung/dev-spi2.c
