From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Apr 2014 21:32:58 +0200
Subject: [PATCH v2 0/9] ARM: S3C24XX: convert s3c2410,
 s3c2440 s3c2442 to common clock framework
Message-ID: <2104342.rkElQpXtvM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least, here is v2 of the common clock conversion of s3c2410 - s3c2442.
If suitable this will finish the conversion of s3c24xx arches.

Tested on an Openmoko Neo Freerunner (GTA02).

It is meant to go on top of the s3c2412 ccf conversion already in
linux-samsung.

changes since v1:
- add already received Acks and Reviews
- remove patches that were already part of the s3c2412 submission
- implement suggestions from Tomasz Figa:
- in cpufreq-utils only request mpll clock the first time
- in dclk driver
  - use variant list to describe SoC differences
  - do not provide a dt binding at this time, as the dclk
    parts should probably be part of the pinctrl driver
    In any case this can be solved when the first dt platform needs
    support for the external clock outputs
- in clk-s3c2410
  - fix sentinels
  - rename dt-bindings header
  - don't export XTI clock id


Heiko Stuebner (9):
  ARM: S3C24XX: cpufreq-utils: don't write raw values to MPLLCON when
    using ccf
  clk: samsung: add clock driver for external clock outputs
  ARM: S3C24XX: enable usage of common dclk if common clock framework is
    enabled
  dt-bindings: add documentation for s3c2410 clock controller
  clk: samsung: add clock controller driver for s3c2410, s3c2440 and
    s3c2442
  ARM: S3C24XX: add platform code for conversion to the common clock
    framework
  ARM: S3C24XX: convert s3c2440 and s3c2442 to common clock framework
  ARM: S3C24XX: convert s3c2410 to common clock framework
  ARM: S3C24XX: remove legacy clock code

 .../bindings/clock/samsung,s3c2410-clock.txt       |  50 +++
 arch/arm/mach-s3c24xx/Kconfig                      |  50 ++-
 arch/arm/mach-s3c24xx/Makefile                     |   6 +-
 arch/arm/mach-s3c24xx/clock-dclk.c                 | 195 ---------
 arch/arm/mach-s3c24xx/clock-s3c2410.c              | 285 ------------
 arch/arm/mach-s3c24xx/clock-s3c2440.c              | 217 ----------
 arch/arm/mach-s3c24xx/clock-s3c244x.c              | 141 ------
 arch/arm/mach-s3c24xx/common.c                     |  45 +-
 arch/arm/mach-s3c24xx/common.h                     |  11 +-
 arch/arm/mach-s3c24xx/cpufreq-utils.c              |  14 +
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h    |  18 -
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     |   3 -
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |   9 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |  15 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |  10 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |  15 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   8 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |  10 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |  10 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |  12 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |  10 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |  15 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |  10 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |   9 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |  15 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |  10 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |   9 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |  10 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |   9 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |  15 +-
 arch/arm/mach-s3c24xx/pm.c                         |  12 -
 arch/arm/mach-s3c24xx/s3c2410.c                    |  56 ---
 arch/arm/mach-s3c24xx/s3c2442.c                    | 111 -----
 arch/arm/mach-s3c24xx/s3c244x.c                    |  59 +--
 drivers/clk/samsung/Makefile                       |   2 +
 drivers/clk/samsung/clk-s3c2410-dclk.c             | 440 +++++++++++++++++++
 drivers/clk/samsung/clk-s3c2410.c                  | 477 +++++++++++++++++++++
 include/dt-bindings/clock/s3c2410.h                |  62 +++
 38 files changed, 1276 insertions(+), 1179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2410-clock.txt
 delete mode 100644 arch/arm/mach-s3c24xx/clock-dclk.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c244x.c
 create mode 100644 drivers/clk/samsung/clk-s3c2410-dclk.c
 create mode 100644 drivers/clk/samsung/clk-s3c2410.c
 create mode 100644 include/dt-bindings/clock/s3c2410.h

-- 
1.9.0
