From: jenskuske@gmail.com (Jens Kuske)
Date: Tue, 27 Oct 2015 17:50:20 +0100
Subject: [PATCH v4 0/6] ARM: sunxi: Introduce Allwinner H3 support
Message-ID: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v4 of my patch series introducing basic kernel support for Allwinner's
H3 SoC. It mainly adds basic clocks, resets and pinctrl. It also adds
interrupts, timers, watchdog, RTC, dmaengine, MMC and UARTs, which are mostly
compatible to those in earlier SoCs like A23 and A31, and can simply be reused.

These patches are based on the sunxi-next branch from
git://github.com/linux-sunxi/linux-sunxi.git


Patch 1 improves the sunxi divs clock to read the name of the base factor clock
from devicetree instead of hardcoding it, which allows us to reuse sun6i-pll6
for our pll8.

Patch 2 adds support for the basic clocks.

Patch 3 adds the pin sets for the H3 main PIO.

Patch 4 adds the H3 reset controller

Patch 5 adds the DTSI for the H3.

Patch 6 adds a DTS for the Orange Pi Plus SBC, which these patches
were developed and tested with.


Changes since v3:
- add a clock driver specific to the bus gates instead of listing parents in
  the DTSI
- skip the holes in the reset controller with of_xlate()

Changes since v2:
- add mbus clock
- add Maxime's suggestion to take the substring up to the first "_" as name
  for the divs base clock
- use A31 pll6 for H3 pll6
- use a clock similar to the new simple gates for H3 bus gates
- drop the pinctrl-as-module patch since pinctrl and gpio don't seem to be
  ready for removable drivers
- documentation and machine support are merged already
  
Changes since v1:
- Update sunxi README in Documentation
- Add the multiple parents gates and use them for bus-gates instead of
  ahb1, ahb2, apb1 and apb2 gates
- Merge the pll8 clock with sun6i pll6
- Merge the ahb12, apb1 and apb2 resets to bus-resets with own compatible
- Add sun6i_timer_init to sun8i machine
- Remove the single SoC names from machine definition, its sun8i family
- Make the pinctrl driver tristate and put its Kconfig entry in the right order
- Rename pinctrl "scr" to "sim" and clock "sim" to "scr" to match user manual
- Remove the address paragraph from GPL in dts and dtsi
- Some style cleanup and line wrapping in dtsi
- Add ARM architected timers
- dmaengine isn't included anymore, it is merged already

Best Regards,
Jens

Jens Kuske (6):
  clk: sunxi: Let divs clocks read the base factor clock name from
    devicetree
  clk: sunxi: Add H3 clocks support
  pinctrl: sunxi: Add H3 PIO controller support
  reset: sunxi: Add Allwinner H3 bus resets
  ARM: dts: sunxi: Add Allwinner H3 DTSI
  ARM: dts: sun8i: Add Orange Pi Plus support

 Documentation/devicetree/bindings/clock/sunxi.txt  |   2 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../bindings/reset/allwinner,sunxi-clock-reset.txt |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  77 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 482 +++++++++++++++++++
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-sun8i-bus-gates.c            | 111 +++++
 drivers/clk/sunxi/clk-sunxi.c                      |  47 +-
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c           | 516 +++++++++++++++++++++
 drivers/reset/reset-sunxi.c                        |  30 +-
 13 files changed, 1260 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
 create mode 100644 drivers/clk/sunxi/clk-sun8i-bus-gates.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c

-- 
2.6.2
