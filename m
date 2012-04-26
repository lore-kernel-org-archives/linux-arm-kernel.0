From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 11:52:50 -0600
Subject: [PATCH 3/4] ARM: dt: tegra seaboard: add i2c devices
In-Reply-To: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
References: <1335462771-21791-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1335462771-21791-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>

Add the known i2c devices on seaboard to the i2c table.

Also rename the temperature sensor device node, and mark it as a nct1008
instead of an adt7461 (which it is -- the chips are compatible though).

Signed-off-by: Olof Johansson <olof@lixom.net>
[swarren: Removed isl29018 from patch; it's already there now. Fixed
 interrupts properties now that Tegra GPIO is an interrupt controller.
 Moved smart-battery to the correct I2C bus.]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-seaboard.dts |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 19db40a..c4d171e 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -282,10 +282,24 @@
 			interrupt-parent = <&gpio>;
 			interrupts = < 202 0x04 >; /* GPIO PZ2 */
 		};
+
+		gyrometer at 68 {
+			compatible = "invn,mpu3050";
+			reg = <0x68>;
+			interrupt-parent = <&gpio>;
+			interrupts = <204 0x04>; /* gpio PZ4 */
+		};
 	};
 
 	i2c at 7000c400 {
 		clock-frequency = <100000>;
+
+		smart-battery at b {
+			compatible = "ti,bq20z75", "smart-battery-1.1";
+			reg = <0xb>;
+			ti,i2c-retry-count = <2>;
+			ti,poll-retry-count = <10>;
+		};
 	};
 
 	i2c at 7000c500 {
@@ -295,10 +309,17 @@
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
+			interrupt-parent = <&gpio>;
+			interrupts = <109 0x04>; /* gpio PN5 */
+		};
 	};
 
 	i2s at 70002a00 {
-- 
1.7.0.4
