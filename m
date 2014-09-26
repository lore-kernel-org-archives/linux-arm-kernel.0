From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Fri, 26 Sep 2014 18:56:30 +0300
Subject: [PATCH v2] ARM: DT: apq8064: add CM-QS600 board
Message-ID: <1411746990-12518-1-git-send-email-mike.rapoport@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
---
v2 changes: duplicate the settings for the cm-qs600 board in its .dts file as Kumar suggested


 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 59 +++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index aaa1a68..71d2ade 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -340,6 +340,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8064-ifc6410.dtb \
+	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8074-dragonboard.dtb \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
new file mode 100644
index 0000000..db7cf03
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -0,0 +1,59 @@
+#include "qcom-apq8064-v2.0.dtsi"
+
+/ {
+	model = "CompuLab CM-QS600";
+	compatible = "qcom,apq8064-cm-qs600", "qcom,apq8064";
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
-- 
1.9.1
