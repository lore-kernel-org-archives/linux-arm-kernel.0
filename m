From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun,  6 Dec 2015 12:45:52 +0200
Subject: [PATCH v2 0/5] clk: lpc32xx: add clock support for NXP LPC32xx
Message-ID: <1449398757-16834-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changeset adds common clock framework driver for NXP LPC32xx
boards.

The change can be applied without any dependencies, LPC32xx device tree
and mach changes will be done, when this changeset is accepted.

The v1 version of CCF driver can be found here:
  http://www.spinics.net/lists/arm-kernel/msg461632.html

The RFC version of CCF driver 9/11 can be found here:
  http://www.spinics.net/lists/devicetree/msg100583.html

Changes from v1 to v2:
* removed dependency on the recent LPC32xx device tree changes,
  also removed LPC32xx device tree and mach changes, which depend
  on this series,
* use lowercase hex numbers in a DT binding example,
* incremented by 1 all clock values, possibly clock "0" may have a
  special meaning in future,
* removed explicit COMMON_CLK selection for NXP LPC18xx,
* LPC32XX_CLK_DEFINE() does not stringify clock names,
* fixed a minor bug in clk_pll_set_rate().

Changes from RFC to v1:
* added definitions of a missed IRDA clock,
* renamed compatible property from lpc32xx-scb to lpc32xx-clk
* switched to regmap interface instead of mmio, this is required to
  secure access to registers shared between pinmux, dma and clock
  driver, unfortunately this change has to pull some code snippets
  from common gate, divider and mux helpers rebased on regmap API,
* split clock definitions from the driver to be able to update
  dts files separately from CCF driver.

The driver is written from scratch, here are main functional
differences with the legacy driver arch/arm/mach-lpc32xx/clock.c:
* serialized access to SCB registers,
* reworked routines to select PLL parameters,
* now the clock driver has detailed description of all clocks,
  the original driver misses several clock entries and most of fine
  grained clock controls, here every mux and divider are accounted,
* now clocks and clock hierarchies can be described in board DT file,
* sophisticated management of USB clocks, for example now USB device
  controller needs only one clock instead of USB PLL, USB OTG and USB
  device clocks,
* other benefits from a driver powered by CCF.

Patch 5/5 may produce false positives from checkpatch.pl, the fix
to checkpatch is found in Andrew's tree

Vladimir Zapolskiy (5):
  dt-bindings: clock: add description of LPC32xx clock controller
  dt-bindings: clock: add description of LPC32xx USB clock controller
  dt-bindings: clock: add NXP LPC32xx clock list for consumers
  clk: lpc18xx: add NXP specific COMMON_CLK_NXP configuration symbol
  clk: lpc32xx: add common clock framework driver

 .../devicetree/bindings/clock/nxp,lpc3220-clk.txt  |   30 +
 .../bindings/clock/nxp,lpc3220-usb-clk.txt         |   22 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/nxp/Makefile                           |    1 +
 drivers/clk/nxp/clk-lpc32xx.c                      | 1569 ++++++++++++++++++++
 include/dt-bindings/clock/lpc32xx-clock.h          |   56 +
 7 files changed, 1685 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
 create mode 100644 drivers/clk/nxp/clk-lpc32xx.c
 create mode 100644 include/dt-bindings/clock/lpc32xx-clock.h

-- 
2.1.4
