From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 12:18:42 +0200
Subject: [PATCH] ARM: nomadik: fix up double inversion in DT
Message-ID: <1406283522-6764-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO pin connected to card detect was inverted twice: once by
the argument to the GPIO line itself where it was magically marked
as active low by the flag GPIO_ACTIVE_LOW (0x01) in the third cell,
and also marked active low AGAIN by explicitly stating
"cd-inverted" (a deprecated method).

After commit 78f87df2b4f8760954d7d80603d0cfcbd4759683
"mmc: mmci: Use the common mmc DT parser" this results in the
line being inverted twice so it was effectively uninverted, while
the old code would not have this effect, instead disregarding the
flag on the GPIO line altogether, which is a bug. I admit the
semantics may be unclear but inverting twice is as good a
definition as any on how this should work.

So fix up the buggy device tree. Use proper #includes so the DTS
is clear and readable.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please either apply this directly for fixes, and if
that is too late, tag it for v3.16+ stable.
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index f557feb997f4..90d8b6c7a205 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -4,7 +4,7 @@
  */
 
 /dts-v1/;
-/include/ "ste-nomadik-stn8815.dtsi"
+#include "ste-nomadik-stn8815.dtsi"
 
 / {
 	model = "Calao Systems USB-S8815";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index d316c955bd5f..dbcf521b017f 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -1,7 +1,9 @@
 /*
  * Device Tree for the ST-Ericsson Nomadik 8815 STn8815 SoC
  */
-/include/ "skeleton.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include "skeleton.dtsi"
 
 / {
 	#address-cells = <1>;
@@ -842,8 +844,7 @@
 			bus-width = <4>;
 			cap-mmc-highspeed;
 			cap-sd-highspeed;
-			cd-gpios = <&gpio3 15 0x1>;
-			cd-inverted;
+			cd-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
 			vmmc-supply = <&vmmc_regulator>;
-- 
1.9.3
