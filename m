From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 14:18:57 +0100
Subject: [PATCH] ARM: nomadik: fix up SD/MMC DT settings
Message-ID: <1454332737-631-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DTSI file for the Nomadik does not properly specify how the
PL180 levelshifter is connected: the Nomadik actually needs all
the five st,sig-dir-* flags set to properly control all lines out.

Further this board supports full power cycling of the card, and
since this variant has no hardware clock gating, it needs a
ridiculously low frequency setting to keep up with the ever
overflowing FIFO.

The pin configuration set-up is a bit of a mystery, because of
course these pins are a mix of inputs and outputs. However the
reference implementation sets all pins to "output" with
unspecified initial value, so let's do that here as well.

Cc: stable at vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: this fixes the non-working SD/MMC card on the
Nomadik please apply this directly for fixes if Ulf is OK with
it.
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 37 ++++++++++++++++--------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 50c256f0fd98..b1707f6217bf 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -128,22 +128,14 @@
 			};
 			mmcsd_default_mode: mmcsd_default {
 				mmcsd_default_cfg1 {
-					/* MCCLK */
-					pins = "GPIO8_B10";
-					ste,output = <0>;
-				};
-				mmcsd_default_cfg2 {
-					/* MCCMDDIR, MCDAT0DIR, MCDAT31DIR, MCDATDIR2 */
-					pins = "GPIO10_C11", "GPIO15_A12",
-					"GPIO16_C13", "GPIO23_D15";
-					ste,output = <1>;
-				};
-				mmcsd_default_cfg3 {
-					/* MCCMD, MCDAT3-0, MCMSFBCLK */
-					pins = "GPIO9_A10", "GPIO11_B11",
-					"GPIO12_A11", "GPIO13_C12",
-					"GPIO14_B12", "GPIO24_C15";
-					ste,input = <1>;
+					/*
+					 * MCCLK, MCCMDDIR, MCDAT0DIR, MCDAT31DIR, MCDATDIR2
+					 * MCCMD, MCDAT3-0, MCMSFBCLK
+					 */
+					pins = "GPIO8_B10", "GPIO9_A10", "GPIO10_C11", "GPIO11_B11",
+					       "GPIO12_A11", "GPIO13_C12", "GPIO14_B12", "GPIO15_A12",
+					       "GPIO16_C13", "GPIO23_D15", "GPIO24_C15";
+					ste,output = <2>;
 				};
 			};
 		};
@@ -803,10 +795,21 @@
 			clock-names = "mclk", "apb_pclk";
 			interrupt-parent = <&vica>;
 			interrupts = <22>;
-			max-frequency = <48000000>;
+			max-frequency = <400000>;
 			bus-width = <4>;
 			cap-mmc-highspeed;
 			cap-sd-highspeed;
+			full-pwr-cycle;
+			/*
+			 * The STw4811 circuit used with the Nomadik strictly
+			 * requires that all of these signal direction pins be
+			 * routed and used for its 4-bit levelshifter.
+			 */
+			st,sig-dir-dat0;
+			st,sig-dir-dat2;
+			st,sig-dir-dat31;
+			st,sig-dir-cmd;
+			st,sig-pin-fbclk;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
 			vmmc-supply = <&vmmc_regulator>;
-- 
2.4.3
