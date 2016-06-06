From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:25 +0200
Subject: [GIT PULL 0/8] ARM: exynos: Early stuff for v4.8
Message-ID: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,


This time I am sending a very early pull request because:
1. I already have a lot of stuff.
2. There are some conflicts, including annoying re-indent one (see below).
3. I am going for holidays soon.  After this weekend, my availability
   will be reduced.


There is no specific order of branches to pull (no inter-dependencies).
External dependencies (from Samsung clk and media) are pulled in.


Expected conflicts:

1. arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
   samsung-drivers-exynos-mfc-4.8 with samsung-dt-4.8

   Just include both changes:
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@@ -18,6 -16,8 +18,7 @@@
  #include <dt-bindings/sound/samsung-i2s.h>
  #include "exynos5800.dtsi"
  #include "exynos5422-cpus.dtsi"
 -#include "exynos5422-cpu-thermal.dtsi"
+ #include "exynos-mfc-reserved-memory.dtsi"

  / {
        memory {


2. arch/arm/configs/exynos_defconfig
   samsung-defconfig-4.8 with current fixes

   Just include both changes:
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@@ -80,11 -79,10 +79,11 @@@ CONFIG_TOUCHSCREEN_MMS114=
  CONFIG_INPUT_MISC=y
  CONFIG_INPUT_MAX77693_HAPTIC=y
  CONFIG_INPUT_MAX8997_HAPTIC=y
 +CONFIG_KEYBOARD_SAMSUNG=y
  CONFIG_SERIAL_8250=y
+ CONFIG_SERIAL_OF_PLATFORM=y
  CONFIG_SERIAL_SAMSUNG=y
  CONFIG_SERIAL_SAMSUNG_CONSOLE=y
- CONFIG_SERIAL_OF_PLATFORM=y
  CONFIG_HW_RANDOM=y
  CONFIG_TCG_TPM=y
  CONFIG_TCG_TIS_I2C_INFINEON=y


3. arch/arm/boot/dts/exynos5420.dtsi
   samsung-dt-4.8 with samsung-dt-odroid-xu-4.8

   This is non-trivial.  One branch added clocks and second changed
   the indentation.  Manual fix-up is needed by re-indenting the
   change with three clocks, like this:
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
+               mfc_pd: power-domain at 10044060 {
+                       compatible = "samsung,exynos4210-pd";
+                       reg = <0x10044060 0x20>;
 -                      clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_USER_ACLK333>;
 -                      clock-names = "oscclk", "clk0";
++                      clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_USER_ACLK333>,
++                               <&clock CLK_ACLK333>;
++                      clock-names = "oscclk", "clk0","asb0";
+                       #power-domain-cells = <0>;
+               };


4. arch/arm/mach-exynos/Kconfig
   arm-soc with tags/samsung-drivers

   Trivial:
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@@ -18,7 -19,7 +18,8 @@@ menuconfig ARCH_EXYNO
        select EXYNOS_THERMAL
        select EXYNOS_PMU
        select EXYNOS_SROM
+       select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 +      select GPIOLIB
        select HAVE_ARM_SCU if SMP
        select HAVE_S3C2410_I2C if I2C
        select HAVE_S3C2410_WATCHDOG if WATCHDOG


Best regards,
Krzysztof
