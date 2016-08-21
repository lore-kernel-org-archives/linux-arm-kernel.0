From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 21 Aug 2016 10:11:23 +0800
Subject: [PATCH 7/9] ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC device node
 and regulators
In-Reply-To: <20160821021125.1521-1-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
Message-ID: <20160821021125.1521-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP806 PMIC is the secondary PMIC. It provides various supply
voltages for the SoC and other peripherals. The PMIC's interrupt
line is connected to NMI pin of the SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 113 ++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index caf0091e71ba..aeb4037c8768 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -332,6 +332,118 @@
 		};
 	};
 
+	axp806: pmic at 745 {
+		compatible = "x-powers,axp806";
+		reg = <0x745>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		bldoin-supply = <&reg_dcdce>;
+
+		regulators {
+			reg_s_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "avcc";
+			};
+
+			aldo2 {
+				/*
+				 * unused, but use a different name to
+				 * avoid name clash with axp809's aldo's
+				 */
+				regulator-name = "s_aldo2";
+			};
+
+			aldo3 {
+				/*
+				 * unused, but use a different name to
+				 * avoid name clash with axp809's aldo's
+				 */
+				regulator-name = "s_aldo3";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-name = "vcc18-efuse-adc-display-csi";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-name =
+					"vdd18-drampll-vcc18-pll-cpvdd";
+			};
+
+			bldo3 {
+				/* unused */
+			};
+
+			reg_bldo4: bldo4 {
+				regulator-min-microvolt = <1080000>;
+				regulator-max-microvolt = <1320000>;
+				regulator-name = "vcc12-hsic";
+			};
+
+			reg_cldo1: cldo1 {
+				/*
+				 * This was 3V in the original design, but
+				 * 3.3V is the recommended supply voltage
+				 * for the Ethernet PHY.
+				 */
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-gmac-phy";
+			};
+
+			reg_cldo2: cldo2 {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-name = "afvcc-cam";
+			};
+
+			reg_cldo3: cldo3 {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-io-wifi-codec-io2";
+			};
+
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpub";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-vpu";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <2100000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-name = "vcc-bldo-codec-ldoin";
+			};
+
+			sw {
+				/*
+				 * unused, but use a different name to
+				 * avoid name clash with axp809's sw
+				 */
+				regulator-name = "s_sw";
+			};
+		};
+	};
+
 	ac100: codec at e89 {
 		compatible = "x-powers,ac100";
 		reg = <0xe89>;
@@ -371,6 +483,7 @@
 };
 
 &usbphy2 {
+	phy-supply = <&reg_bldo4>;
 	status = "okay";
 };
 
-- 
2.9.3
