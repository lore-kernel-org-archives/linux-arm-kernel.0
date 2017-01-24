From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:19 +0800
Subject: [PATCH 00/11] clk: sunxi-ng: Add support for A80 CCUs
Message-ID: <20170124023230.3990-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds new "sunxi-ng" style drivers for the CCUs found in the
Allwinner A80 SoC. The A80 contains 1 main clock control unit, and some
subsystem specific clock control units at separate addresses. These
include the USB, display engine, and MMC.

  - The MMC clocks can be supported by the old clock drivers,
    hence here we do not add a new driver for it.

  - The old USB clock driver is intertwined with other SoCs,
    requires old style bindings with clock-output-names and
    CLK_OF_DECLARE for its parents. It is easier to switch
    to a new binding and driver.

  - The display engine (DE) CCU was not supported in the past.

The A80 CCU also has some quirks about its design. It has

  - Separate registers for PLL lock status

  - P1, P2 dividers, which are power-of-2 and only 1 bit wide

The first 3 patches fix and extend the behavior of sunxi-ng's
mux clock type, based on the behavior of the clk subsystem's
basic mux clock.

The fourth patch adds support for checking PLL lock status
bits in separate registers, as opposed to within the PLL's
config register.

Patches 5 through 7 add drivers for the CCU blocks.

Patches 8 through 10 do some cleanup of the sunxi/allwinner dts
files prior to switching sun9i dts to the new sunxi-ng clock
bindings. These are independent of the clk stuff, but touch the
same lines for sun9i. Including them should make it easier to
apply and test patches.

Patch 11 has sun9i switch over to the new clock bindings.

Please take a look and let me know what you think.

I also have a series adding support for the first display pipeline
of the A80 with RGB LCD panel output which I will send out later
on.


Regards
ChenYu

Chen-Yu Tsai (11):
  clk: sunxi-ng: mux: Fix determine_rate for mux clocks with
    pre-dividers
  clk: sunxi-ng: mux: honor CLK_SET_RATE_NO_REPARENT flag
  clk: sunxi-ng: mux: Get closest parent rate possible with
    CLK_SET_RATE_PARENT
  clk: sunxi-ng: Support separately grouped PLL lock status register
  clk: sunxi-ng: Add A80 CCU
  clk: sunxi-ng: Add A80 USB CCU
  clk: sunxi-ng: Add A80 Display Engine CCU
  ARM: dts: sun8i-a23-q8-tablet: Drop pinmux setting for codec PA gpio
  ARM: dts: sunxi: Remove no longer used pinctrl/sun4i-a10.h header
  arm64: dts: allwinner: Remove no longer used pinctrl/sun4i-a10.h
    header
  ARM: dts: sun9i: Switch to new clock bindings

 .../devicetree/bindings/clock/sun9i-de.txt         |   28 +
 .../devicetree/bindings/clock/sun9i-usb.txt        |   24 +
 .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |    1 -
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |    1 -
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |    1 -
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |    1 -
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |    1 -
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |    1 -
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |    1 -
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |    1 -
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |    1 -
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |    1 -
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |    1 -
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |    1 -
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |    1 -
 arch/arm/boot/dts/sun4i-a10.dtsi                   |    1 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |    1 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |    1 -
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |    1 -
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |    1 -
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |    1 -
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |    1 -
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |    1 -
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |    1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |    1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |    1 -
 arch/arm/boot/dts/sun5i-a13.dtsi                   |    1 -
 arch/arm/boot/dts/sun5i-gr8.dtsi                   |    1 -
 arch/arm/boot/dts/sun5i.dtsi                       |    1 -
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |    1 -
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |    1 -
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |    1 -
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |    1 -
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |    1 -
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |    1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                   |    1 -
 arch/arm/boot/dts/sun6i-a31s-cs908.dts             |    2 -
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |    1 -
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi     |    1 -
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |    1 -
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |    1 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |    1 -
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |    1 -
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |    1 -
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |    1 -
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |    1 -
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |    1 -
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |    1 -
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |    1 -
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |    1 -
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |    1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |    1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |    1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |    1 -
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |    1 -
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |    1 -
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |    1 -
 arch/arm/boot/dts/sun7i-a20.dtsi                   |    1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |    1 -
 arch/arm/boot/dts/sun8i-a23-evb.dts                |    1 -
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |   10 -
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |    1 -
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |    2 -
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |    1 -
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |    1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |    1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |    1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |    1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |    1 -
 arch/arm/boot/dts/sun8i-h3.dtsi                    |    1 -
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |    1 -
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |    1 -
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  404 ++-----
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |    1 -
 .../boot/dts/sunxi-reference-design-tablet.dtsi    |    1 -
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |    1 -
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    3 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |  283 +++++
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h            |   33 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |  144 +++
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h           |   25 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               | 1223 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun9i-a80.h               |   57 +
 drivers/clk/sunxi-ng/ccu_common.c                  |    8 +-
 drivers/clk/sunxi-ng/ccu_common.h                  |    2 +
 drivers/clk/sunxi-ng/ccu_mux.c                     |   35 +-
 include/dt-bindings/clock/sun9i-a80-ccu.h          |  162 +++
 .../dt-bindings/clock/sun9i-a80-de.h               |   73 +-
 .../dt-bindings/clock/sun9i-a80-usb.h              |   44 +-
 .../dt-bindings/reset/sun9i-a80-ccu.h              |   91 +-
 .../dt-bindings/reset/sun9i-a80-de.h               |   45 +-
 .../dt-bindings/reset/sun9i-a80-usb.h              |   41 +-
 94 files changed, 2270 insertions(+), 550 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sun9i-de.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sun9i-usb.txt
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80.h
 create mode 100644 include/dt-bindings/clock/sun9i-a80-ccu.h
 copy arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi => include/dt-bindings/clock/sun9i-a80-de.h (67%)
 copy arch/arm/boot/dts/sun8i-a23-q8-tablet.dts => include/dt-bindings/clock/sun9i-a80-usb.h (73%)
 copy arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi => include/dt-bindings/reset/sun9i-a80-ccu.h (56%)
 copy arch/arm/boot/dts/sun8i-a23-q8-tablet.dts => include/dt-bindings/reset/sun9i-a80-de.h (73%)
 copy arch/arm/boot/dts/sun8i-a23-q8-tablet.dts => include/dt-bindings/reset/sun9i-a80-usb.h (73%)

-- 
2.11.0
