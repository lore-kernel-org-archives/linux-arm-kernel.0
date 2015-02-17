From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Feb 2015 19:52:01 +0100
Subject: [PATCH 0/8] Add proper support for Compulab CM-A510/SBC-A510
Message-ID: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set improves current mainline support for the Compulab
CM-A510 System-on-Module (SoM) and its default Compulab SBC-A510
base board. Thanks to Gabriel Dobato who agreed to remote debug and
test the provided DT changes.

On the way to proper support, we
- Rework i2c-mux-pinctrl to honor disabled sub-bus nodes
- Add missing "compulab" vendor prefix
- Fix broken uart[23] reg properties
- Beautify Dove's dtsi files by adding gpio/irq includes, node
  labels for pcie, and some additional pinctrl settings
- Add a node for the internal i2c mux mechanism on Dove SoCs

And finally add a DT include for the Compulab CM-A510 SoM and a DT
board file for the SBC-A510 base board.

Patches are based on stable v3.19 and are indended for the next
merge window (either v3.21 or v4.1). Compulab related changes have
been tested by Gabriel Dobato, I tested on SolidRun CuBox that it
does not break existing Dove boards.

For the i2c-mux-pinctrl, a Tested-by from any user of Tegra20
Seaboard, Tamonten, or Ventana would be nice to see if it is fully
compatible.

I have added MVEBU maintainers to all patches, Wolfram for i2c and
Stephen as the i2c-mux-pinctrl author i2c-mux-pinctrl related patches,
and corresponding lists. As there is no important DT work in here,
I decided to not explicitly add each of the DT maintainers except for
the vendor prefix patch.

Sebastian Hesselbarth (8):
  i2c: mux-pinctrl: Rework to honor disabled child nodes
  devicetree: vendor-prefixes: Add CompuLab to known vendors
  ARM: dts: dove: Fix uart[23] reg property
  ARM: dts: dove: Always include gpio and interrupt-controller headers
  ARM: dts: dove: Add node labels for PCIe ports 0 and 1
  ARM: dts: dove: Add some more common pinctrl settings
  ARM: dts: dove: Add internal i2c multiplexer node
  ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510

 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |  28 +--
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/dove-cm-a510.dts                 |  38 ----
 arch/arm/boot/dts/dove-cm-a510.dtsi                | 195 +++++++++++++++++++++
 arch/arm/boot/dts/dove-sbc-a510.dts                | 182 +++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi                        | 103 ++++++++++-
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  70 +++++---
 8 files changed, 537 insertions(+), 85 deletions(-)
 delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts

---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-i2c at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
2.1.0
