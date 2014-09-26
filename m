From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Fri, 26 Sep 2014 11:07:30 +0300
Subject: [PATCH 1/2] ARM: DT: apq8064: create qcom-apq8064-board-common.dtsi
In-Reply-To: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
References: <1411718851-17436-1-git-send-email-mike.rapoport@gmail.com>
Message-ID: <1411718851-17436-2-git-send-email-mike.rapoport@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way similar boards will be able to share common definitions.

Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064-board-common.dtsi | 57 ++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts       | 54 +---------------------
 2 files changed, 58 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-board-common.dtsi

diff --git a/arch/arm/boot/dts/qcom-apq8064-board-common.dtsi b/arch/arm/boot/dts/qcom-apq8064-board-common.dtsi
new file mode 100644
index 0000000..c92d3e9
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-board-common.dtsi
@@ -0,0 +1,57 @@
+#include "qcom-apq8064-v2.0.dtsi"
+
+/ {
+
+	soc {
+		pinctrl at 800000 {
+			i2c1_pins: i2c1 {
+				mux {
+					pins = "gpio20", "gpio21";
+					function = "gsbi1";
+				};
+			};
+		};
+
+		gsbi at 12440000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+
+			i2c at 12460000 {
+				status = "okay";
+				clock-frequency = <200000>;
+				pinctrl-0 = <&i2c1_pins>;
+				pinctrl-names = "default";
+
+				eeprom: eeprom at 52 {
+					compatible = "atmel,24c128";
+					reg = <0x52>;
+					pagesize = <32>;
+				};
+			};
+		};
+
+		gsbi at 16600000 {
+			status = "ok";
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			serial at 16640000 {
+				status = "ok";
+			};
+		};
+
+		amba {
+			/* eMMC */
+			sdcc1: sdcc at 12400000 {
+				status = "okay";
+			};
+
+			/* External micro SD card */
+			sdcc3: sdcc at 12180000 {
+				status = "okay";
+			};
+			/* WLAN */
+			sdcc4: sdcc at 121c0000 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index b396c83..61784d7 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -1,59 +1,7 @@
-#include "qcom-apq8064-v2.0.dtsi"
+#include "qcom-apq8064-board-common.dtsi"
 
 / {
 	model = "Qualcomm APQ8064/IFC6410";
 	compatible = "qcom,apq8064-ifc6410", "qcom,apq8064";
 
-	soc {
-		pinctrl at 800000 {
-			i2c1_pins: i2c1 {
-				mux {
-					pins = "gpio20", "gpio21";
-					function = "gsbi1";
-				};
-			};
-		};
-
-		gsbi at 12440000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C>;
-
-			i2c at 12460000 {
-				status = "okay";
-				clock-frequency = <200000>;
-				pinctrl-0 = <&i2c1_pins>;
-				pinctrl-names = "default";
-
-				eeprom: eeprom at 52 {
-					compatible = "atmel,24c128";
-					reg = <0x52>;
-					pagesize = <32>;
-				};
-			};
-		};
-
-		gsbi at 16600000 {
-			status = "ok";
-			qcom,mode = <GSBI_PROT_I2C_UART>;
-			serial at 16640000 {
-				status = "ok";
-			};
-		};
-
-		amba {
-			/* eMMC */
-			sdcc1: sdcc at 12400000 {
-				status = "okay";
-			};
-
-			/* External micro SD card */
-			sdcc3: sdcc at 12180000 {
-				status = "okay";
-			};
-			/* WLAN */
-			sdcc4: sdcc at 121c0000 {
-				status = "okay";
-			};
-		};
-	};
 };
-- 
1.9.1
