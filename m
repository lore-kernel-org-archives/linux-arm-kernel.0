From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Jun 2017 15:48:41 +0200
Subject: [PATCH] ARM64: dts: meson-gx: use specific compatible for the AO pwms
Message-ID: <20170607134841.6822-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the specific compatiable for AO pwms so the pwms input can
be correctly set

FDIV4 is not present on the pwm A0, so change kadhas vim input
clocks to xtal.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
This patch depends on the pwm patchset available here [0]

On the Khadas Vim I chose to replace FDIV4 with the crytal.
Only PWM_AO_B is actually used and It is used for led dimming.
The frequency, as long as it is high enough, does not matter.
Only the duty cycle does. After testing, xtal seems to be fast
enough.

PWM_AO_A is outputed on the general purpose header, but no usage is
defined for it.

It might be bit late for that but I wonder why it defined and enabled ?
Same goes for the other peripherals activated on this general purpose
header.

I know that's what shows the schematics but one could choose to do
anything else possible with it ? like use in GPIO mode, or another
function. In addition, we never which setting will be required ? (eg
which clock source ?).

Should we keep those ? or remove them ?

[0]: https://lkml.kernel.org/r/20170607133013.4766-1-jbrunet at baylibre.com

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 436b875060e7..fbaa6b598fca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -391,7 +391,7 @@
 			};
 
 			pwm_AO_ab: pwm at 550 {
-				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
+				compatible = "amlogic,meson-gx-ao-pwm", "amlogic,meson-gxbb-ao-pwm";
 				reg = <0x0 0x00550 0x0 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 6a81f0168da5..371f43cdd3ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -86,8 +86,8 @@
 	status = "okay";
 	pinctrl-0 = <&pwm_ao_a_3_pins>, <&pwm_ao_b_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_FCLK_DIV4>;
-	clock-names = "clkin0";
+	clocks = <&xtal> , <&xtal>;
+	clock-names = "clkin0", "clkin1" ;
 };
 
 &pwm_ef {
-- 
2.9.4
