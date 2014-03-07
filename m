From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  7 Mar 2014 17:00:36 +0100
Subject: [PATCH V3 00/12] CCF support for Renesas r7s72100
Message-ID: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the r7s72100 platfrom from the legacy clock implementation to
the common clock framework.

This series has been tested with the renesas-devel-v3.14-rc5-20140307v2 tag.
If you want to boot into a console, you have a runtime dependency [1].

Patches 1-5 is the minimal set to activate CCF and get the board booting into a
console. Patches 6-8 add SCIF support, 9+10 I2C support, and 11+12 SPI support.

Changes since V2:

Patches 1+3 got updates, patch 12 was not send out last time due to sendmail error.

Patch 1 should probably go via clock tree (it has no dependencies). The rest
via shmobile. Please apply.

   Wolfram

PS: A tree can be found here with this series only:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf

And here with a quick hack to make the system bootable:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf-bootable

[1] http://lkml.org/lkml/2014/2/20/205 ([PATCH V7 0/3] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits)


Wolfram Sang (12):
  clk: shmobile: add CPG driver for rz-platforms
  ARM: shmobile: r7s72100: document MSTP clock support
  ARM: shmobile: r7s72100: add essential clock nodes to dtsi
  ARM: shmobile: r7s72100: genmai: populate nodes for external clocks
  ARM: shmobile: r7s72100: use workaround for non DT-clocks
  ARM: shmobile: r7s72100: add scif nodes to dtsi
  ARM: shmobile: r7s72100: genmai: activate scif2 for console output
  ARM: shmobile: r7s72100: genmai: platform scif devices only for legacy
    support
  ARM: shmobile: r7s72100: add i2c clocks to dtsi
  ARM: shmobile: r7s72100: remove I2C DT clocks from legacy clock
    support
  ARM: shmobile: r7s72100: add spi clocks to dtsi
  ARM: shmobile: r7s72100: remove SPI DT clocks from legacy clock
    support

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,rz-cpg-clocks.txt       |  29 +++
 arch/arm/boot/dts/r7s72100-genmai-reference.dts    |  12 ++
 arch/arm/boot/dts/r7s72100.dtsi                    | 223 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-genmai-reference.c    |  14 +-
 arch/arm/mach-shmobile/board-genmai.c              |  44 ++++
 arch/arm/mach-shmobile/clock-r7s72100.c            |   9 -
 arch/arm/mach-shmobile/setup-r7s72100.c            |  43 ----
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-rz.c                      | 103 ++++++++++
 include/dt-bindings/clock/r7s72100-clock.h         |  40 ++++
 11 files changed, 464 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-rz.c
 create mode 100644 include/dt-bindings/clock/r7s72100-clock.h

-- 
1.9.0
