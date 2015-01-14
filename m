From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 13 Jan 2015 16:03:21 -0800
Subject: [PATCH] ARM: dts: exynos5422-odroidxu3: add INA2xx sensors
Message-ID: <1421193801-24637-1-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@linaro.org>

The odroid-xu3 has 4 INA231 current sensors on board which can be
accessed from the Linux via the hwmon interface.

There is one sensor for each of these power rails:

- A15 cluster: VDD_ARM
- A7 cluster: VDD_KFC
- GPU: VDD_G3D
- memory: VDD_MEM

In addition to adding the sensors, LDO26 from the PMIC needs to be
enabled because it's powering these sensor.

Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Applies on top of "ARM: dts: Add dts file for odroid XU3 board" from Sjoerd Simons.

 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index c29123c0734d..7874da20939f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -174,6 +174,13 @@
 					regulator-always-on;
 				};
 
+				ldo26_reg: LDO26 {
+					regulator-name = "vdd_ldo26";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+				};
+
 				buck1_reg: BUCK1 {
 					regulator-name = "vdd_mif";
 					regulator-min-microvolt = <800000>;
@@ -257,6 +264,38 @@
 		};
 	};
 
+	i2c_0: i2c at 12C60000 {
+		status = "okay";
+
+		/* A15 cluster: VDD_ARM */
+		ina220 at 40 {
+			compatible = "ti,ina230";
+			reg = <0x40>;
+			shunt-resistor = <10000>;
+		};
+
+		/* memory: VDD_MEM */
+		ina220 at 41 {
+			compatible = "ti,ina230";
+			reg = <0x41>;
+			shunt-resistor = <10000>;
+		};
+
+		/* GPU: VDD_G3D */
+		ina220 at 44 {
+			compatible = "ti,ina230";
+			reg = <0x44>;
+			shunt-resistor = <10000>;
+		};
+
+		/* A7 cluster: VDD_KFC */
+		ina220 at 45 {
+			compatible = "ti,ina230";
+			reg = <0x45>;
+			shunt-resistor = <10000>;
+		};
+	};
+
 	i2c_2: i2c at 12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
-- 
2.1.3
