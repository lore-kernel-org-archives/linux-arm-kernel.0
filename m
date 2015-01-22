From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 22 Jan 2015 13:54:28 -0800
Subject: [PATCH v3] ARM: dts: exynos5422-odroidxu3: add on-board INA231 sensors
Message-ID: <1421963668-28359-1-git-send-email-khilman@kernel.org>
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
Reviewed-By: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
v3: extend existing i2c_0 node 
v2: use "ti,ina231" as compatible string.

Applies on top of "ARM: dts: Add dts file for odroid XU3 board" from Sjoerd Simons.

 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index c29123c0734d..38694a4a5417 100644
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
@@ -330,3 +337,35 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "otg";
 };
+
+&i2c_0 {
+	status = "okay";
+
+	/* A15 cluster: VDD_ARM */
+	ina231 at 40 {
+		compatible = "ti,ina231";
+		reg = <0x40>;
+		shunt-resistor = <10000>;
+	};
+
+	/* memory: VDD_MEM */
+	ina231 at 41 {
+		compatible = "ti,ina231";
+		reg = <0x41>;
+		shunt-resistor = <10000>;
+	};
+
+	/* GPU: VDD_G3D */
+	ina231 at 44 {
+		compatible = "ti,ina231";
+		reg = <0x44>;
+		shunt-resistor = <10000>;
+	};
+
+	/* A7 cluster: VDD_KFC */
+	ina231 at 45 {
+		compatible = "ti,ina231";
+		reg = <0x45>;
+		shunt-resistor = <10000>;
+	};
+};
-- 
2.1.3
