From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 11 Jun 2012 17:05:16 +0200
Subject: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from DT
In-Reply-To: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree support for the TPS6586x PMU used on Harmony has recently
been added. This commit adds the required device tree nodes to probe the
PMU from the device tree.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

---
Changes in v2:
- new patch
---
 arch/arm/boot/dts/tegra-harmony.dts    |   83 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-dt-tegra20.c |    6 ---
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index f146dbf..c98aa2a 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -275,6 +275,89 @@
 	i2c at 7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
+
+		tps6586x at 34 {
+			compatible = "ti,tps6586x";
+			reg = <0x34>;
+			interrupts = <0 88 0x4>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				sm0 {
+					regulator-min-microvolt = < 725000>;
+					regulator-max-microvolt = <1500000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				sm1 {
+					regulator-min-microvolt = < 725000>;
+					regulator-max-microvolt = <1500000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				sm2 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <4550000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				ldo0 {
+					regulator-name = "PCIE CLK";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo1 {
+					regulator-min-microvolt = < 725000>;
+					regulator-max-microvolt = <1500000>;
+				};
+
+				ldo2 {
+					regulator-min-microvolt = < 725000>;
+					regulator-max-microvolt = <1500000>;
+				};
+
+				ldo3 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo4 {
+					regulator-min-microvolt = <1700000>;
+					regulator-max-microvolt = <2475000>;
+				};
+
+				ldo5 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo6 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo7 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo8 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldo9 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <3300000>;
+				};
+			};
+		};
 	};
 
 	pmc {
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 0f29c05..a9a54e6 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -136,12 +136,6 @@ static void __init harmony_init(void)
 {
 	int ret;
 
-	ret = harmony_regulator_init();
-	if (ret) {
-		pr_err("harmony_regulator_init() failed: %d\n", ret);
-		return;
-	}
-
 	ret = harmony_pcie_init();
 	if (ret)
 		pr_err("harmony_pcie_init() failed: %d\n", ret);
-- 
1.7.10.4
