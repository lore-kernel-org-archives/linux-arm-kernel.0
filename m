From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:05:45 +0200
Subject: [PATCH v2 00/22] ARM: dts: exynos: Add initial support for Odroid XU
Message-ID: <1462734367-5619-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Patchset adds necessary clocks, reorganizes existing stuff and finally
adds Odroid XU support.

Merging strategy
================
Complicated! The clock dt-bindings and driver changes can go to clock
tree. However there are three DTS patches in the middle.
a. This has to go in before adding "fin_pll_new" to clock driver:
   - [PATCH v2 03/22] ARM: dts: exynos: Add fin_pll node for clock driver

b. This should go in before renaming "fin_pll_new" back to original name:
   - [PATCH v2 05/22] ARM: dts: exynos: Switch MCT node to a new fin_pll clock
   - [PATCH v2 06/22] ARM: dts: exynos: Remove old fixed-clock provider on SMDK5410

The order of patches in the patchset is really how it should go in
to reduce any bisectability glitches.


Changes since v1
================
1. A lot of new patches.
2. Removed some TODO notes (eMMC 4.5 so no RCLK pin).
3. New clocks, more reorganization.
4. New common DTSI: exynos54xx.dtsi. I know, it is getting more
   and more complicated but this might help removing duplications
   and keeping everything under control.


Best regards,
Krzysztof


Krzysztof Kozlowski (22):
  dt-bindings: clock: Add license and reformat Exynos5410 clock IDs
  dt-bindings: clock: Add PWM and USB clock IDs to Exynos5410
  ARM: dts: exynos: Add fin_pll node for clock driver
  clk: samsung: exynos5410: Provide fin_pll external fixed clock
  ARM: dts: exynos: Switch MCT node to a new fin_pll clock
  ARM: dts: exynos: Remove old fixed-clock provider on SMDK5410
  clk: samsung: exynos5410: Rename fin_pll from temporary to regular
    name
  clk: samsung: exynos5410: Add serial3, USB and PWM clocks
  ARM: dts: exynos: Re-order alphabetically Exynos5420 SD0/SD1 pinctrl
    nodes
  ARM: dts: exynos: Use lowercase for Exynos5410 CPU node labels
  ARM: dts: exynos: Configure Exynos5410 pinctrl for eMMC and SD card
  ARM: dts: exynos: Split Odroid XU3 LEDs to separate DTSI
  ARM: dts: exynos: Move common nodes to exynos5.dtsi
  ARM: dts: exynos: Prepare for inclusion of exynos5.dtsi in
    exynos5410.dtsi
  ARM: dts: exynos: Use phandle to get parent node in exynos5250-snow
  ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc
  ARM: dts: exynos: Include common exynos5 in exynos5410.dtsi
  ARM: dts: exynos: Enable UART3 on Exynos5410
  ARM: dts: exynos: MCT is not an interrupt controller and extend length
    of iomap
  ARM: dts: exynos: Move common Exynos5410/542x/5800 nodes to new DTSI
  ARM: dts: exynos: Add USB to Exynos5410
  ARM: dts: exynos: Add initial support for Odroid XU board

 .../bindings/arm/samsung/samsung-boards.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5.dtsi                     |  171 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi                  | 1718 +++++++++--------
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  166 ++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |   77 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   16 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |  204 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   12 +-
 arch/arm/boot/dts/exynos5420.dtsi                  | 1981 ++++++++++----------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   35 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   35 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    |   50 +
 arch/arm/boot/dts/exynos54xx.dtsi                  |  142 ++
 drivers/clk/samsung/clk-exynos5410.c               |   52 +
 include/dt-bindings/clock/exynos5410.h             |   64 +-
 17 files changed, 2519 insertions(+), 2208 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 create mode 100644 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
 create mode 100644 arch/arm/boot/dts/exynos54xx.dtsi

-- 
2.5.0
