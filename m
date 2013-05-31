From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:48 +0200
Subject: [PATCH 13/39] ARM: u300: support regulators in the device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-14-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Now that we have enabled board power and the AB3100 regulators,
put the regulator data into the device tree and enable it so
we can start to tie regulators to devices. To begin with we're
only supplying the power to the board itself.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 711a2d9..d1ab4e9 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -24,6 +24,11 @@
 		reg = <0x48000000 0x03c00000>;
 	};
 
+	s365 {
+		compatible = "stericsson,s365";
+		vana15-supply = <&ab3100_ldo_d_reg>;
+	};
+
 	timer: timer at c0014000 {
 		compatible = "stericsson,u300-apptimer";
 		reg = <0xc0014000 0x1000>;
@@ -70,6 +75,74 @@
 		interrupts = <8>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		ab3100: ab3100 at 0x48 {
+			compatible = "stericsson,ab3100";
+			reg = <0x48>;
+			interrupt-parent = <&vica>;
+			interrupts = <0>; /* EXT0 IRQ */
+			ab3100-regulators {
+				compatible = "stericsson,ab3100-regulators";
+				ab3100_ldo_a_reg: ab3100_ldo_a {
+					regulator-compatible = "ab3100_ldo_a";
+					startup-delay-us = <200>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+				ab3100_ldo_c_reg: ab3100_ldo_c {
+					regulator-compatible = "ab3100_ldo_c";
+					startup-delay-us = <200>;
+				};
+				ab3100_ldo_d_reg: ab3100_ldo_d {
+					regulator-compatible = "ab3100_ldo_d";
+					startup-delay-us = <200>;
+				};
+				ab3100_ldo_e_reg: ab3100_ldo_e {
+					regulator-compatible = "ab3100_ldo_e";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					startup-delay-us = <200>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+				ab3100_ldo_f_reg: ab3100_ldo_f {
+					regulator-compatible = "ab3100_ldo_f";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <2500000>;
+					startup-delay-us = <600>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+				ab3100_ldo_g_reg: ab3100_ldo_g {
+					regulator-compatible = "ab3100_ldo_g";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <2850000>;
+					startup-delay-us = <400>;
+				};
+				ab3100_ldo_h_reg: ab3100_ldo_h {
+					regulator-compatible = "ab3100_ldo_h";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <2750000>;
+					startup-delay-us = <200>;
+				};
+				ab3100_ldo_k_reg: ab3100_ldo_k {
+					regulator-compatible = "ab3100_ldo_k";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <2750000>;
+					startup-delay-us = <200>;
+				};
+				ab3100_ext_reg: ab3100_ext {
+					regulator-compatible = "ab3100_ext";
+				};
+				ab3100_buck_reg: ab3100_buck {
+					regulator-compatible = "ab3100_buck";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1800000>;
+					startup-delay-us = <1000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			};
+		};
 	};
 
 	i2c1: i2c at c0005000 {
@@ -79,6 +152,12 @@
 		interrupts = <9>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		fwcam0: fwcam at 0x10 {
+			reg = <0x10>;
+		};
+		fwcam1: fwcam at 0x5d {
+			reg = <0x5d>;
+		};
 	};
 
 	amba {
-- 
1.7.11.3
