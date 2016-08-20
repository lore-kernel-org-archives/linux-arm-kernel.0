From: nm@ti.com (Nishanth Menon)
Date: Fri, 19 Aug 2016 19:33:39 -0500
Subject: [PATCH 0/3] ARM: K2G: Add support for TI-SCI Clocks
Message-ID: <20160820003342.13599-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Texas Instruments' Keystone generation System on Chips (SoC)
starting with 66AK2G02[1], now include a dedicated SoC System Control
entity called PMMC(Power Management Micro Controller) in line with
ARM architecture recommendations. The function of this module is
to integrate all system operations in a centralized location.
Communication with the SoC System Control entity from various
processing units like ARM/DSP occurs over Message Manager hardware
block.

This series adds the base support for clock control using generic
power domain framework over the TI System Control Interface (TI-SCI)
protocol[2][3][4].

Overall architecture is very similar to SCPI[5] as follows:
+--------------+  +-------------+   +------------+
| TI SCI GENPD |  |TISCI Clk(*) |   |TISCI reset |
+------+-------+  +----+--------+   +----+-------+
       |               |                 |
       |          +----v--------------+  |
       +----------> TISCI Protocol    <--+
                  +----+--------------+
                       |
                   +---v-----------+
                   | MAILBOX  FWK  |
                   +---+-----------+
                       |
                   +---v-----------+
                   |  TI MSGMGR    |-> TISCI hardware block
                   +---------------+

(*) This series.

Baseline: v4.8-rc1 + [3] + [4] (the dependency is due to MAINTAINERS update, API, data)
Bootlog: http://pastebin.ubuntu.com/23071879/ (with the addition of couple of mach patches + dts)
Integrated series is available:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.9/tisci-clk-v1

This is the last of the three major blocks to provide functionality for K2G SoC.
TISCI reset series is a follow on series to enable DSP remoteproc and few other
peripherals.

NOTE: Tero is currently on vacation(till Aug 28) and the series
is being send on his behalf to provide a complete baseline series
for review. Obviously, all dependencies must be merged prior to
this series being merged, but any additional feedback will be much
appreciated.

Tero Kristo (3):
  Documentation: dt: Add TI SCI clock driver
  dt-binding: clock: Add k2g clock definitions
  clk: keystone: Add sci-clk driver support

[1] http://www.ti.com/product/66ak2g02
[2] http://processors.wiki.ti.com/index.php/TISCI
[3] https://lkml.org/lkml/2016/8/19/768
[4] https://lkml.org/lkml/2016/8/19/790
[5] Documentation/devicetree/bindings/arm/arm,scpi.txt

 .../devicetree/bindings/clock/ti,sci-clk.txt       |  51 ++
 MAINTAINERS                                        |   3 +
 drivers/clk/Kconfig                                |  13 +
 drivers/clk/keystone/Makefile                      |   1 +
 drivers/clk/keystone/sci-clk.c                     | 539 +++++++++++++++++++++
 include/dt-bindings/clock/k2g.h                    | 234 +++++++++
 6 files changed, 841 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 create mode 100644 drivers/clk/keystone/sci-clk.c
 create mode 100644 include/dt-bindings/clock/k2g.h

-- 
2.9.1.200.gb1ec08f
