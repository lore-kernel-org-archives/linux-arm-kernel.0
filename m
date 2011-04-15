From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Apr 2011 21:08:05 +0200
Subject: [RFC] sanitizing crazy clock data files
Message-ID: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following tries to solve the chicken-egg problem we have with the
common struct clk support and its users. It switches i.MX51 clock support
to the new API. Included are some generic clock helpers for dividers and
multiplexer. I first made them i.MX specific but after looking round in
the other architectures I found them useful enough for other architectures
aswell. If you could use the helpers but missing some bits please speak up.

There is one thing missing in Jeremys series and this series does not fix
it. Once I add the new (un)prepare calls to drivers they won't compile
without common struct clk support anymore. Maybe a

#ifndef CONFIG_USE_COMMON_STRUCT_CLK
#define clk_prepare()
#define clk_unprepare()
#endif

will do.

Sascha

The following changes since commit de4a95bc9025f0566ade64dc35e5e3014e640b85:

  clk: Generic support for fixed-rate clocks (2011-04-15 20:39:48 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git clk-common

Sascha Hauer (8):
      clk: Make NULL a valid clock again
      clk: implement parent pass through functions
      clk: Add support for simple dividers
      clk: Add support for a generic clock multiplexer
      ARM i.MX: Support for clock building blocks.
      ARM i.MX: Add generic support for pllv2
      ARM i.MX51/53: reimplement clock support
      ARM i.MX51/53: remove old clock support

 arch/arm/mach-mx5/Kconfig               |    6 +
 arch/arm/mach-mx5/Makefile              |    2 +-
 arch/arm/mach-mx5/clock-imx51-imx53.c   |  420 ++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c     | 1579 -------------------------------
 arch/arm/mach-mx5/crm_regs.h            |  249 +-----
 arch/arm/plat-mxc/Makefile              |    1 +
 arch/arm/plat-mxc/clock.c               |  182 ++++
 arch/arm/plat-mxc/include/mach/clkdev.h |    2 +
 arch/arm/plat-mxc/include/mach/clock.h  |  153 +++-
 arch/arm/plat-mxc/pllv2.c               |  228 +++++
 drivers/clk/Kconfig                     |    6 +
 drivers/clk/Makefile                    |    2 +
 drivers/clk/clk-divider.c               |  132 +++
 drivers/clk/clk-mux.c                   |   92 ++
 drivers/clk/clk.c                       |  104 ++
 include/linux/clk.h                     |   68 ++
 16 files changed, 1395 insertions(+), 1831 deletions(-)
 create mode 100644 arch/arm/mach-mx5/clock-imx51-imx53.c
 delete mode 100644 arch/arm/mach-mx5/clock-mx51-mx53.c
 create mode 100644 arch/arm/plat-mxc/pllv2.c
 create mode 100644 drivers/clk/clk-divider.c
 create mode 100644 drivers/clk/clk-mux.c
