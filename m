From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  8 Aug 2016 18:21:42 +0100
Subject: [PATCH v4 0/7] arm64: Allwinner A64 support
Message-ID: <20160808172149.30861-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new attempt on proper upstream Allwinner A64 support. It
builds on the bits that have already been merged (arm64 architecture
support and the pinctrl driver), and mostly completes it with some
DT files.

I chose a new approach on the clock system:
- For the basic PLL clocks we go with fixed-clocks now, as Allwinner
recommends fixed frequencies for those anyway. I am not sure whether
we should express the dependencies between those clocks as fixed-factor
clocks or not.
- The clock gates are left as in the previous post, so using a flexible,
DT driver based on the existing simple-gates.c. There are ways to get
away without it, but those approaches are more hideous and I still
consider this approach pretty clean.
- Any other clock is expected to be handled by firmware using the
SCPI protocol (which ARM's Juno board uses as well). While this is not
the most flexible and all-encompassing interface, it fits the bill for
our clocks for now and enjoys upstream support on the Linux side already,
so there are no patches needed on this front.
I will send RFC patches demonstrating this just after this series.

This series focusses on the basic peripherals. The MMC support, which was
part of former revisions of this series, is dropped for now as the
current driver lacks some bits to properly support the enhanced A64 MMC
controller, which becomes evident when trying to use it on an eMMC device.
There are patches floating around to tackle this, but this workd shouldn't
delay upstreaming the basic bits first.

This series has been tested (with an initrd) on the Pine64 and
BananaPi M64 boards.

As Maxime's latest post uses a completely different clock system, I
wanted to put this forward as a simpler and more sustainable approach
to tackle the tricky Allwinner CCU subsystem. I am happy to collaborate
and to find the right way (TM) to support this (and future!) SoCs.

Any comments are welcome!

Cheers,
Andre.

Changelog v3..v4:
- add proper Kconfig bits to build the pinctrl driver
- adapt Maxime's approach of avoiding pine64-common.dtsi
- add PMU DT node
- use fixed-clocks for basic PLL clocks
- use clock names based on manual (periph0 & friends)
- move clocks out of their own subnode into a separate file
- add .dts for BananaPi-M64 (thanks to Nora Lee for a sample board)


Andre Przywara (7):
  arm64: sunxi: Kconfig: add essential pinctrl driver
  DT: clk: sunxi: add binding doc for the multi-bus-gates clock
  clk: sunxi: add generic multi-parent bus clock gates driver
  of: add vendor prefix for Pine64
  arm64: dts: add Allwinner A64 SoC .dtsi
  arm64: dts: add Pine64 support
  arm64: dts: add BananaPi M64 support

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 Documentation/devicetree/bindings/clock/sunxi.txt  |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   6 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  74 ++++
 .../boot/dts/allwinner/sun50i-a64-clocks.dtsi      | 140 ++++++++
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  48 +++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  74 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 398 +++++++++++++++++++++
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-multi-gates.c                | 105 ++++++
 13 files changed, 858 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-clocks.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
 create mode 100644 drivers/clk/sunxi/clk-multi-gates.c

-- 
2.9.0
