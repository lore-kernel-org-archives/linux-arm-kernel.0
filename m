From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:05:00 +0200
Subject: [PATCH 00/11] clk: lpc32xx: add clock support for NXP LPC32xx
Message-ID: <1447981511-29653-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changeset adds common clock framework driver for NXP LPC32xx
boards.

The changeset has dependencies on the recent updates to LPC32xx DTS:
  http://permalink.gmane.org/gmane.linux.ports.arm.kernel/456304

The RFC version of CCF driver 9/11 can be found here:
  http://www.spinics.net/lists/devicetree/msg100583.html

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

Patch 9/11 may produce false positives from checkpatch, the fix
to checkpatch can be found in Andrew's tree.

Vladimir Zapolskiy (11):
  dt-bindings: clock: add description of LPC32xx clock controller
  dt-bindings: clock: add description of LPC32xx USB clock controller
  dt-bindings: clock: add NXP LPC32xx clock list for consumers
  arm: dts: lpc32xx: add device nodes for external oscillators
  arm: dts: lpc32xx: add clock controller device node
  arm: dts: lpc32xx: add clock properties to device nodes
  arm: dts: lpc32xx: add USB clock controller
  clk: lpc18xx: add NXP specific common clock framework selection
  clk: lpc32xx: add common clock framework driver
  arm: lpc32xx: switch to common clock framework
  arm: dts: lpc32xx: remove clock frequency property from UART device
    nodes

 .../devicetree/bindings/clock/nxp,lpc3220-clk.txt  |   30 +
 .../bindings/clock/nxp,lpc3220-usb-clk.txt         |   22 +
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |   87 +-
 arch/arm/mach-lpc32xx/Makefile                     |    3 +-
 arch/arm/mach-lpc32xx/clock.c                      | 1284 ----------------
 arch/arm/mach-lpc32xx/phy3250.c                    |    1 -
 arch/arm/mach-lpc32xx/serial.c                     |    3 -
 arch/arm/mach-lpc32xx/timer.c                      |  144 --
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/nxp/Makefile                           |    1 +
 drivers/clk/nxp/clk-lpc32xx.c                      | 1562 ++++++++++++++++++++
 include/dt-bindings/clock/lpc32xx-clock.h          |   56 +
 14 files changed, 1765 insertions(+), 1440 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
 delete mode 100644 arch/arm/mach-lpc32xx/clock.c
 delete mode 100644 arch/arm/mach-lpc32xx/timer.c
 create mode 100644 drivers/clk/nxp/clk-lpc32xx.c
 create mode 100644 include/dt-bindings/clock/lpc32xx-clock.h

-- 
2.1.4
