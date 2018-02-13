From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 13 Feb 2018 22:01:55 +0900
Subject: [PATCH v3 2/3] arm64: dts: uniphier: add speaker out for UniPhier
 LD11/LD20 boards
In-Reply-To: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
References: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180213130156.27827-3-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds codec node for TI TAS571x on UniPhier LD11/20
global boards. And adds settings of AIO for speaker out.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes in v3:
  - Use phandle of endpoint directly instead of port node
---
 .../boot/dts/socionext/uniphier-ld11-global.dts     | 21 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts     | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index fb6bf435dc96..f057ee80f38e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld11.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD11 Global Board (REF_LD11_GP)";
@@ -44,6 +45,7 @@
 		widgets = "Headphone", "Headphone Jack";
 
 		dais = <&i2s_port2
+			&i2s_port3
 			&i2s_port4
 			&spdif_port0>;
 	};
@@ -71,6 +73,20 @@
 &i2c0 {
 	status = "okay";
 
+	tas5707a at 1d {
+		compatible = "ti,tas5711";
+		reg = <0x1d>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(23, 4) GPIO_ACTIVE_LOW>;
+		pdn-gpios = <&gpio UNIPHIER_GPIO_PORT(23, 5) GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+
+		port at 0 {
+			tas_speaker: endpoint {
+				remote-endpoint = <&i2s_hpcmout1>;
+			};
+		};
+	};
+
 	eeprom at 50 {
 		compatible = "st,24c64", "atmel,24c64";
 		reg = <0x50>;
@@ -94,6 +110,11 @@
 	status = "okay";
 };
 
+&i2s_hpcmout1 {
+	dai-format = "i2s";
+	remote-endpoint = <&tas_speaker>;
+};
+
 &spdif_hiecout1 {
 	remote-endpoint = <&spdif_tx>;
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 2d49163cfde4..b2e197bc968c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld20.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD20 Global Board (REF_LD20_GP)";
@@ -44,6 +45,7 @@
 		widgets = "Headphone", "Headphone Jack";
 
 		dais = <&i2s_port2
+			&i2s_port3
 			&i2s_port4
 			&spdif_port0>;
 	};
@@ -70,12 +72,31 @@
 
 &i2c0 {
 	status = "okay";
+
+	tas5707 at 1b {
+		compatible = "ti,tas5711";
+		reg = <0x1b>;
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(0, 0) GPIO_ACTIVE_LOW>;
+		pdn-gpios = <&gpio UNIPHIER_GPIO_PORT(0, 1) GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+
+		port at 0 {
+			tas_speaker: endpoint {
+				remote-endpoint = <&i2s_hpcmout1>;
+			};
+		};
+	};
 };
 
 &nand {
 	status = "okay";
 };
 
+&i2s_hpcmout1 {
+	dai-format = "i2s";
+	remote-endpoint = <&tas_speaker>;
+};
+
 &spdif_hiecout1 {
 	remote-endpoint = <&spdif_tx>;
 };
-- 
2.15.1
