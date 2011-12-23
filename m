From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Dec 2011 18:33:13 -0800
Subject: [PATCH] dt/tegra: seaboard: add i2c devices
Message-ID: <1324607593-2378-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the known i2c devices on seaboard to the i2c table.

Also rename the temperature sensor device node, and mark it as a nct1008 instead
of an adt7461 (which it is -- the chips are compatible though).


Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/tegra-seaboard.dts |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index b55a02e..b64e0bd 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -13,6 +13,18 @@
 
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
+
+		light-sensor at 44 {
+			compatible = "isil,isl29018";
+			reg = <0x44>;
+			interrupts = < 0 202 0x04 >; /* gpio PZ2 */
+		};
+
+		gyrometer at 68 {
+			compatible = "invn,mpu3050";
+			reg = <0x68>;
+			interrupts = < 0 204 0x04 >; /* gpio PZ4 */
+		};
 	};
 
 	i2c at 7000c400 {
@@ -21,15 +33,28 @@
 
 	i2c at 7000c500 {
 		clock-frequency = <400000>;
+
+		smart-battery at b {
+			compatible = "ti,bq20z75", "smart-battery-1.1";
+			ti,i2c-retry-count = < 2 >;
+			ti,poll-retry-count = < 10 >;
+			reg = <0xb>;
+		};
 	};
 
 	i2c at 7000d000 {
 		clock-frequency = <400000>;
 
-		adt7461 at 4c {
-			compatible = "adt7461";
+		temperature-sensor at 4c {
+			compatible = "nct1008";
 			reg = <0x4c>;
 		};
+
+		magnetometer at c {
+			compatible = "ak8975";
+			reg = <0xc>;
+			interrupts = < 0 109 0x04 >; /* gpio PN5 */
+		};
 	};
 
 	serial at 70006000 {
-- 
1.7.8.GIT
