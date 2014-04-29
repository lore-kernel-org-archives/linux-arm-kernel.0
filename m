From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 Apr 2014 12:03:31 +0200
Subject: [PATCH v4 00/11] CCF support for Renesas r7s72100
Message-ID: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the r7s72100 platfrom from the legacy clock implementation to
the common clock framework.

This series has been tested with the renesas-devel-v3.15-rc2-20140428 tag.
If you want to boot into a console, you have a runtime dependency [1].

Changes since V4:

* only use dt alias for scif2

Changes since V3:

* rebased and tested against latest renesas/devel-tag
* using the new "clock-indices" binding
* reordered patches to skip the workaround entry for scif2
* moved serial aliases from the dtsi to the board file
  (and kept the numbering according to the legacy board code)
* updated my email-address

The workaround in the last patch could be avoided once the DT patches for MTU2
are available. Or we include the patch right now and clean the little bit up
later in an incremental fashion. Please apply.

Thanks,

   Wolfram

PS: A tree can be found here with this series and the dependency patch:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf

[1] http://www.spinics.net/lists/linux-sh/msg30918.html (clk: shmobile: clk-mstp: change to using clock-indices)


Wolfram Sang (11):
  ARM: shmobile: r7s72100: document MSTP clock support
  ARM: shmobile: r7s72100: add essential clock nodes to dtsi
  ARM: shmobile: r7s72100: genmai: populate nodes for external clocks
  ARM: shmobile: r7s72100: add scif nodes to dtsi
  ARM: shmobile: r7s72100: genmai: add uart aliases and activate scif2
    as console
  ARM: shmobile: r7s72100: genmai: platform scif devices only for legacy
    support
  ARM: shmobile: r7s72100: add i2c clocks to dtsi
  ARM: shmobile: r7s72100: remove I2C DT clocks from legacy clock
    support
  ARM: shmobile: r7s72100: add spi clocks to dtsi
  ARM: shmobile: r7s72100: remove SPI DT clocks from legacy clock
    support
  ARM: shmobile: r7s72100: use workaround for non DT-clocks

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 arch/arm/boot/dts/r7s72100-genmai-reference.dts    |  26 ++-
 arch/arm/boot/dts/r7s72100.dtsi                    | 215 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-genmai-reference.c    |  14 +-
 arch/arm/mach-shmobile/board-genmai.c              |  44 +++++
 arch/arm/mach-shmobile/clock-r7s72100.c            |   9 -
 arch/arm/mach-shmobile/setup-r7s72100.c            |  43 -----
 include/dt-bindings/clock/r7s72100-clock.h         |  41 ++++
 8 files changed, 337 insertions(+), 56 deletions(-)
 create mode 100644 include/dt-bindings/clock/r7s72100-clock.h

-- 
1.9.2
