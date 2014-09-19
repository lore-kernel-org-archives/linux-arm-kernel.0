From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 19 Sep 2014 18:16:16 +0200
Subject: [PATCH 0/5] i.MX53 cpufreq support
Message-ID: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements cpufreq support for the i.MX53 SoC
using the generic cpufreq-cpu0 driver. The design is based
on feedback I got on the last round of patches.

Basically this implements a CPU clock type that abstracts away
all the clock handling required for reprogramming the PLL
feeding the CPU, so we don't have to worry about this in the
cpufreq driver. For now this is only used on MX53, but looking
forward the same approach (and code) could be used on MX6.

The first patch allows cpufreq-cpu0 to deactivate OPPs where
the regulator isn't able to provide the required voltage. This
has been tested on custom a MX53 board.

Lucas Stach (5):
  cpufreq: cpu0: disable unsupported OPPs
  clk: imx5: add step clock, used when reprogramming PLL1
  clk: imx: add CPU clock type
  arm: imx53: clk: add ARM clock
  ARM: imx53: add cpufreq support

 arch/arm/boot/dts/imx53.dtsi           |  13 ++++-
 arch/arm/mach-imx/Makefile             |   2 +-
 arch/arm/mach-imx/clk-cpu.c            | 104 +++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c    |  14 ++++-
 arch/arm/mach-imx/clk.h                |   4 ++
 arch/arm/mach-imx/mach-imx53.c         |   4 ++
 drivers/cpufreq/cpufreq-cpu0.c         |  60 +++++++++++--------
 include/dt-bindings/clock/imx5-clock.h |   5 +-
 8 files changed, 179 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-cpu.c

-- 
2.1.0
