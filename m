From: jenskuske@gmail.com (Jens Kuske)
Date: Fri, 15 May 2015 18:38:50 +0200
Subject: [PATCH v2 00/10] ARM: sunxi: Introduce Allwinner H3 support
Message-ID: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of my patch series introducing basic kernel support for Allwinner's
H3 SoC. It mainly adds basic clocks and pinctrl. It also adds interrupts,
timers, watchdog, RTC, dmaengine, MMC and UARTs, which are mostly compatible
to those in earlier SoCs like A23 and A31, and can simply be reused.

These patches are based on Maxime's sunxi/for-next branch from
git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git


The first four patches are documentation updates and generic changes to the
sunxi clock and pinctrl drivers, preparing them for the H3 addition.

Patch 1 updates the sunxi README with new SoCs, including the H3

Patch 2 adds support for multiple parents to the sunxi gates clock, needed
for the new bus gates in H3

Patch 3 improves the sunxi divs clock to read the name of the base factor clock
from devicetree instead of hardcoding it, which allows us to reuse sun6i-pll6
for our pll8.

Patch 4 prepares the sunxi pinctrl driver for building the SoC specific parts
as modules. This is later used for the H3 pinctrl driver. I believe the other
sunxi SoCs could or should be changed to tristate too, but that's independend
from this series and I wouldn't be able to test them anyway.

The remaining patches add H3 support.

Patch 5 adds machine support for the H3.

Patch 6 adds support for the basic clocks.

Patch 7 adds the pin sets for the H3 main PIO.

Patch 8 adds a new compatible for the H3 reset controller

Patch 9 adds the DTSI for the H3.

Patch 10 adds a DTS for the Orange Pi Plus SBC, which these patches
were developed and tested with.


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


Jens Kuske (10):
  Documentation: sunxi: Update Allwinner SoC documentation
  clk: sunxi: Add support for multiple parents to gates
  clk: sunxi: Let divs clocks read the base factor clock name from
    devicetree
  pinctrl: sunxi: Prepare for building SoC specific drivers as modules
  ARM: sunxi: Introduce Allwinner H3 support
  clk: sunxi: Add H3 clocks support
  pinctrl: sunxi: Add H3 PIO controller support
  reset: sunxi: Add compatible for Allwinner H3 bus resets
  ARM: dts: sunxi: Add Allwinner H3 DTSI
  ARM: dts: sun8i: Add Orange Pi Plus support

 Documentation/arm/sunxi/README                     |  18 +-
 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 Documentation/devicetree/bindings/clock/sunxi.txt  |   6 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../bindings/reset/allwinner,sunxi-clock-reset.txt |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  77 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 446 ++++++++++++++++++
 arch/arm/mach-sunxi/Kconfig                        |   2 +-
 arch/arm/mach-sunxi/sunxi.c                        |   4 +-
 drivers/clk/sunxi/clk-sunxi.c                      |  84 +++-
 drivers/pinctrl/sunxi/Kconfig                      |   8 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c           | 522 +++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |  25 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |   2 +
 drivers/reset/reset-sunxi.c                        |   1 +
 17 files changed, 1180 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c

-- 
2.4.0
