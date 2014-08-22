From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Aug 2014 13:25:10 -0600
Subject: [PATCH] ARM: tegra: apalis/colibri t30: fix on-module 5v0 supplies
Message-ID: <1408735510-2654-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel@ziswiler.com>

Working on Gigabit/PCIe support in U-Boot for Apalis T30 I realised
that the current device tree source includes for our modules only
happen to work due to referencing the on-carrier 5v0 supply from USB
which is not at all available on-module. The modules actually contain
TPS60150 charge pumps to generate the PMIC required 5 volts from the
one and only 3.3 volt module supply. This patch fixes this.

(Note: When back-porting this to v3.16 stable releases, simply drop the
change to tegra30-apalis.dtsi; that file was added in v3.17)

Cc: <stable@vger.kernel.org> #v3.16+
Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 11 ++++++++++-
 arch/arm/boot/dts/tegra30-colibri.dtsi | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 8adaa7871dd3..a5446cba9804 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -423,7 +423,7 @@
 			vcc4-supply = <&sys_3v3_reg>;
 			vcc5-supply = <&sys_3v3_reg>;
 			vcc6-supply = <&vio_reg>;
-			vcc7-supply = <&sys_5v0_reg>;
+			vcc7-supply = <&charge_pump_5v0_reg>;
 			vccio-supply = <&sys_3v3_reg>;
 
 			regulators {
@@ -674,5 +674,14 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		charge_pump_5v0_reg: regulator at 101 {
+			compatible = "regulator-fixed";
+			reg = <101>;
+			regulator-name = "5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index bf16f8e65627..c4ed1bec4d92 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -201,7 +201,7 @@
 			vcc4-supply = <&sys_3v3_reg>;
 			vcc5-supply = <&sys_3v3_reg>;
 			vcc6-supply = <&vio_reg>;
-			vcc7-supply = <&sys_5v0_reg>;
+			vcc7-supply = <&charge_pump_5v0_reg>;
 			vccio-supply = <&sys_3v3_reg>;
 
 			regulators {
@@ -373,5 +373,14 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		charge_pump_5v0_reg: regulator at 101 {
+			compatible = "regulator-fixed";
+			reg = <101>;
+			regulator-name = "5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
 	};
 };
-- 
1.9.1
