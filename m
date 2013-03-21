From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 21 Mar 2013 19:17:41 +0530
Subject: [PATCH V2 2/4] ARM: tegra: dalmore: add TPS65090 node
In-Reply-To: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
References: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1363873663-19272-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra114 reference platform, Dalmore, uses the TPS65090 as
secondary PMICs which is mainly act as voltage switch regulator
controlled by i2c communication.

Add DT node for TPS65090.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Fix compilation error on this patch which was introduced on prev set.

 arch/arm/boot/dts/tegra114-dalmore.dts |   92 ++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 6be9434..6e9d757 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -731,6 +731,83 @@
 			regulator-boot-on;
 			regulator-always-on;
 		};
+
+		tps65090 at 48 {
+			compatible = "ti,tps65090";
+			reg = <0x48>;
+			interrupt-parent = <&gpio>;
+			interrupts = <72 0x04>; /* gpio PJ0 */
+
+			vsys1-supply = <&vdd_ac_bat_reg>;
+			vsys2-supply = <&vdd_ac_bat_reg>;
+			vsys3-supply = <&vdd_ac_bat_reg>;
+			infet1-supply = <&vdd_ac_bat_reg>;
+			infet2-supply = <&vdd_ac_bat_reg>;
+			infet3-supply = <&tps65090_dcdc2_reg>;
+			infet4-supply = <&tps65090_dcdc2_reg>;
+			infet5-supply = <&tps65090_dcdc2_reg>;
+			infet6-supply = <&tps65090_dcdc2_reg>;
+			infet7-supply = <&tps65090_dcdc2_reg>;
+			vsys-l1-supply = <&vdd_ac_bat_reg>;
+			vsys-l2-supply = <&vdd_ac_bat_reg>;
+
+			regulators {
+				dcdc1 {
+					regulator-name = "vdd-sys-5v0";
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				tps65090_dcdc2_reg: dcdc2 {
+					regulator-name = "vdd-sys-3v3";
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				dcdc3 {
+					regulator-name = "vdd-ao";
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				fet1 {
+					regulator-name = "vdd-lcd-bl";
+				};
+
+				fet3 {
+					regulator-name = "vdd-modem-3v3";
+				};
+
+				fet4 {
+					regulator-name = "avdd-lcd";
+				};
+
+				fet5 {
+					regulator-name = "vdd-lvds";
+				};
+
+				fet6 {
+					regulator-name = "vdd-sd-slot";
+					regulator-boot-on;
+				};
+
+				fet7 {
+					regulator-name = "vdd-com-3v3";
+				};
+
+				ldo1 {
+					regulator-name = "vdd-sby-5v0";
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo2 {
+					regulator-name = "vdd-sby-3v3";
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			};
+		};
 	};
 
 	pmc {
@@ -747,4 +824,19 @@
 		bus-width = <8>;
 		status = "okay";
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_ac_bat_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vdd_ac_bat";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
 };
-- 
1.7.1.1
