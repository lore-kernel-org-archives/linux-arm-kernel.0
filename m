From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Sep 2016 09:23:48 +0200
Subject: [PATCH v2 00/10] pinctrl: exynos/samsung: Add header with values used
 for configuration
Message-ID: <1472714638-15676-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Merging
=======
Patch #1 should probably go through pinctrl tree. In that case I would
appreciate a stable branch/tag so DTS could base on top of it.


Changes since v1
================
1. Follow Arnd's suggestion about moving the macros to common place.
2. Subjects: replace "GPIO" with "pinctrl".
3. There were some major changes here so I did not add Javier's
   reviewed-by and tested-by tags.


Goal
====
Increase readability:
 	uart0_data: uart0-data {
 		samsung,pins = "gpa0-0", "gpa0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 

Everything generated with sed:
sed -i -e 's/samsung,pin-pud = <0>;$/samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-pud = <1>;$/samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-pud = <3>;$/samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;/' arch/arm/boot/dts/exynos*

sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV3>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*

sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;/' arch/arm/boot/dts/exynos5260*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV2>;/' arch/arm/boot/dts/exynos5260*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV4>;/' arch/arm/boot/dts/exynos5260*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;/' arch/arm/boot/dts/exynos5260*

sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;/' arch/arm/boot/dts/exynos5[48]*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV2>;/' arch/arm/boot/dts/exynos5[48]*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;/' arch/arm/boot/dts/exynos5[48]*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;/' arch/arm/boot/dts/exynos5[48]*

sed -i -e 's/samsung,pin-function = <0>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <1>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;/' arch/arm/boot/dts/exynos*

sed -i -e 's/samsung,pin-function = <2>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_2>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <\(0x\)\?2>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_2>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <\(0x\)\?3>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_3>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <3>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_3>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <4>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_4>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <5>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_5>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <6>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_6>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <0xf>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_F>;/' arch/arm/boot/dts/exynos*

rm -fr dts-old; cp -r out/arch/arm/boot/dts dts-old
rm -fr dts-new; cp -r out/arch/arm/boot/dts dts-new
for i in dts-old/exynos*dtb; do scripts/dtc/dtx_diff $i dts-new/$(basename $i);  done


Best regards,
Krzysztof


Krzysztof Kozlowski (10):
  pinctrl: dt-bindings: samsung: Add header with values used for
    configuration
  ARM: dts: exynos: Use common macros for pinctrl configuration
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos3250
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos4210
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos4x12
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos4415
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos5250
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos5260
  ARM: dts: exynos: Use macros for pinctrl configuration on exynos5410
  ARM: dts: exynos: Use macros for pinctrl configuration on
    exynos542x/exynos5800

 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 346 +++++++-------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 456 +++++++++---------
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  12 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   8 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  14 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  12 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  12 +-
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi          | 288 +++++------
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          | 525 ++++++++++-----------
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 404 ++++++++--------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   6 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  76 +--
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   6 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  72 +--
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 280 ++++++-----
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   6 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  30 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 182 +++----
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  10 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   6 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 126 ++---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 356 +++++++-------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  18 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  18 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 126 ++---
 include/dt-bindings/pinctrl/samsung.h              |  57 +++
 29 files changed, 1754 insertions(+), 1707 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/samsung.h

-- 
1.9.1
