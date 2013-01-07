From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:55:25 +0100
Subject: [PATCH 00/11] switch the Nomadik to Device Tree
Message-ID: <1357599325-7310-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements Device Tree support for the Nomadik S8815 and
deletes the old board files.

When another patch from today removing the <mach/irqs.h> file
dependency from drivers/pinctrl/pinctrl-nomadik.c is merged
I can also remove <mach/irqs.h> and move the machine over to
multiplatform, quite easily, as it will then have all required
things in place: generic clocks, SPARSE_IRQ, DT...

Caveats: some auxdata left, notably for naming some blocks
to match the clock lookups. There is also an OCR mask thing
which I think was debated in the past (Lee?)

I would like to get this in first then fix the auxdatas one
by one.

Linus Walleij (11):
  ARM: nomadik: move last custom calls to pinctrl
  ARM: nomadik: initial devicetree support
  ARM: nomadik: move pin maps to cpu file
  ARM: nomadik: move remaining PrimeCells to device tree
  ARM: nomadik: add FSMC NAND
  ARM: nomadik: move GPIO and pinctrl to device tree
  ARM: nomadik: convert SMSC91x ethernet to device tree
  ARM: nomadik: migrate MMC/SD card support to device tree
  ARM: nomadik: add I2C devices to the device tree
  ARM: nomadik: delete old board files
  ARM: nomadik: get rid of <mach/hardware.h>

 .../devicetree/bindings/mtd/fsmc-nand.txt          |   2 +-
 arch/arm/Kconfig                                   |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |  34 ++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 256 ++++++++++++++
 arch/arm/mach-nomadik/Kconfig                      |  10 +-
 arch/arm/mach-nomadik/Makefile                     |   6 -
 arch/arm/mach-nomadik/board-nhk8815.c              | 359 --------------------
 arch/arm/mach-nomadik/cpu-8815.c                   | 370 +++++++++++++++------
 arch/arm/mach-nomadik/cpu-8815.h                   |   4 -
 arch/arm/mach-nomadik/i2c-8815nhk.c                |  88 -----
 arch/arm/mach-nomadik/include/mach/hardware.h      |  90 -----
 arch/arm/mach-nomadik/include/mach/irqs.h          |   2 -
 arch/arm/mach-nomadik/include/mach/uncompress.h    |   1 -
 drivers/mtd/nand/fsmc_nand.c                       |   1 +
 drivers/pinctrl/pinctrl-nomadik.c                  |   4 +
 16 files changed, 578 insertions(+), 652 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-nomadik-s8815.dts
 create mode 100644 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
 delete mode 100644 arch/arm/mach-nomadik/board-nhk8815.c
 delete mode 100644 arch/arm/mach-nomadik/cpu-8815.h
 delete mode 100644 arch/arm/mach-nomadik/i2c-8815nhk.c
 delete mode 100644 arch/arm/mach-nomadik/include/mach/hardware.h

-- 
1.7.11.7
