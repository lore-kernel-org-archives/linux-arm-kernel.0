From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 11 Jan 2014 20:42:42 +0100
Subject: [PATCH RFC 00/10] Generic Device Tree based power domain look-up
Message-ID: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up till now there was no single generic method to bind devices to their
power domains using Device Tree. Each platform has been doing this using
its own way, example of which are Exynos power domain bindings [1] and
look-up code [2].

This series is intended to change this and provide generic DT bindings for
power domain specification and generic code performing look-up of power
domains and binding them to devices.

Patches 1, 2, 3 are not directly related to this series, but they are
dependencies of further patches making mach-s3c64xx a user of introduced
code. Patch 4 is the most important part of this series, as it's the one
introducing $subject. Further patches are fixing and adding two users,
mach-exynos (removing the legacy code) and mach-s3c64xx (no DT support for
power domains before). Last two patches are adding display support for
Mini6410 board, including a node for display controller (FIMD) which is
a power domain consumer.

Successfully tested on S3C6410-based Mini6410 board.

Tomasz Figa (10):
  ARM: s3c64xx: pm: Use name field of generic_pm_domain
  ARM: s3c64xx: pm: Add always_on field to s3c64xx_pm_domain struct
  ARM: s3c64xx: pm: Add pwr_stat bit for domain G
  base: power: Add generic OF-based power domain look-up
  ARM: exynos: Move to generic power domain bindings
  ARM: s3c64xx: pm: Add device tree based power domain instantiation
  ARM: s3c64xx: dt: Enable SoC-level power management
  ARM: dts: s3c64xx: Add nodes for power domains
  ARM: dts: s3c64xx: Add node for display controller
  ARM: dts: s3c6410-mini6410: Add support for LCD screen

 .../bindings/arm/exynos/power_domain.txt           |  12 +-
 .../devicetree/bindings/power/power_domain.txt     |  51 ++++
 arch/arm/boot/dts/s3c6400.dtsi                     |   1 +
 arch/arm/boot/dts/s3c6410-mini6410.dts             |  33 ++
 arch/arm/boot/dts/s3c6410.dtsi                     |   1 +
 arch/arm/boot/dts/s3c64xx.dtsi                     |  13 +
 arch/arm/mach-exynos/pm_domains.c                  |  80 +----
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c            |   8 +
 arch/arm/mach-s3c64xx/pm.c                         | 106 +++++--
 drivers/base/power/domain.c                        | 339 +++++++++++++++++++++
 include/dt-bindings/arm/s3c64xx-power-domains.h    |  26 ++
 include/linux/pm_domain.h                          |  34 +++
 kernel/power/Kconfig                               |   4 +
 13 files changed, 597 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/power_domain.txt
 create mode 100644 include/dt-bindings/arm/s3c64xx-power-domains.h

-- 
1.8.5.2
