From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 31 Aug 2016 14:13:24 +0200
Subject: [PATCH 0/9] ARM: dts: exynos: Use macros for GPIO to make it more
 readable
Message-ID: <1472645613-5362-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Example:
-		samsung,pin-function = <0x2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <PIN_FUNC_SPC_2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <PIN_DRV_LV1>;
 
This should be just more readable. Especially for drive strenghts which
are unobvious and different between some SoCs.

Tested with dtx_diff:
for i in dts-old/exynos*dtb; do scripts/dtc/dtx_diff $i dts-new/$(basename $i);  done


Everything generated with sed:

sed -i -e 's/samsung,pin-pud = <0>;$/samsung,pin-pud = <PIN_PULL_NONE>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-pud = <1>;$/samsung,pin-pud = <PIN_PULL_DOWN>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-pud = <3>;$/samsung,pin-pud = <PIN_PULL_UP>;/' arch/arm/boot/dts/exynos*

sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <PIN_DRV_LV1>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <PIN_DRV_LV2>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <PIN_DRV_LV3>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <PIN_DRV_LV4>;/' arch/arm/boot/dts/exynos[34]* arch/arm/boot/dts/exynos5250*

sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <PIN_DRV_LV1>;/' arch/arm/boot/dts/exynos5260*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <PIN_DRV_LV2>;/' arch/arm/boot/dts/exynos5260*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <PIN_DRV_LV4>;/' arch/arm/boot/dts/exynos5260*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <PIN_DRV_LV6>;/' arch/arm/boot/dts/exynos5260*

sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <PIN_DRV_LV1>;/' arch/arm/boot/dts/exynos5[48]*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <PIN_DRV_LV2>;/' arch/arm/boot/dts/exynos5[48]*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <PIN_DRV_LV3>;/' arch/arm/boot/dts/exynos5[48]*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <PIN_DRV_LV4>;/' arch/arm/boot/dts/exynos5[48]*

sed -i -e 's/samsung,pin-function = <0>;$/samsung,pin-function = <PIN_FUNC_INPUT>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <1>;$/samsung,pin-function = <PIN_FUNC_OUTPUT>;/' arch/arm/boot/dts/exynos*

sed -i -e 's/samsung,pin-function = <2>;$/samsung,pin-function = <PIN_FUNC_SPC_2>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <\(0x\)\?2>;$/samsung,pin-function = <PIN_FUNC_SPC_2>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <\(0x\)\?3>;$/samsung,pin-function = <PIN_FUNC_SPC_3>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <3>;$/samsung,pin-function = <PIN_FUNC_SPC_3>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <4>;$/samsung,pin-function = <PIN_FUNC_SPC_4>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <5>;$/samsung,pin-function = <PIN_FUNC_SPC_5>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <6>;$/samsung,pin-function = <PIN_FUNC_SPC_6>;/' arch/arm/boot/dts/exynos*
sed -i -e 's/samsung,pin-function = <0xf>;$/samsung,pin-function = <PIN_FUNC_SPC_F>;/' arch/arm/boot/dts/exynos*

Best regards,
Krzysztof

Krzysztof Kozlowski (9):
  ARM: dts: exynos: Add macros for GPIO configuration
  ARM: dts: exynos: Use macros for GPIO configuration on exynos3250
  ARM: dts: exynos: Use macros for GPIO configuration on exynos4210
  ARM: dts: exynos: Use macros for GPIO configuration on exynos4415
  ARM: dts: exynos: Use macros for GPIO configuration on exynos4x12
  ARM: dts: exynos: Use macros for GPIO configuration on exynos5250
  ARM: dts: exynos: Use macros for GPIO configuration on exynos5260
  ARM: dts: exynos: Use macros for GPIO configuration on exynos5410
  ARM: dts: exynos: Use macros for GPIO configuration on
    exynos542x/exynos5800

 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 275 +++++------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 471 ++++++++++---------
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  12 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   8 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  14 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  12 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  12 +-
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi          | 303 ++++++------
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          | 517 +++++++++++----------
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 419 +++++++++--------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   6 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  76 +--
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   6 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  72 +--
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 201 ++++----
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   6 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  30 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 196 ++++----
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  10 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   6 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 126 ++---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 371 ++++++++-------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  18 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  18 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 126 ++---
 27 files changed, 1716 insertions(+), 1603 deletions(-)

-- 
1.9.1
