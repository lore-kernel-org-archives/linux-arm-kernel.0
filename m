From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Fri, 19 Jan 2018 18:25:35 +0900
Subject: [PATCH v2 8/9] arm64: dts: uniphier: add speaker out for UniPhier
 LD11/LD20 boards
In-Reply-To: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180119092536.22501-9-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds codec node for TI TAS571x on UniPhier LD11/20
global boards. And adds settings of AIO for speaker out.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-global.dts      | 20 ++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts      | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 4eb8d00a8c02..ca09251a3eab 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld11.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD11 Global Board (REF_LD11_GP)";
@@ -45,6 +46,7 @@
 			widgets = "Headphone", "Headphone Jack";
 
 			dais = <&i2s_port2
+				&i2s_port3
 				&i2s_port4
 				&spdif_port0>;
 		};
@@ -73,6 +75,20 @@
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
@@ -109,17 +125,21 @@
 
 	i2s_port2: port at 2 {
 		i2s_line: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_line>;
 		};
 	};
 
 	i2s_port3: port at 3 {
 		i2s_hpcmout1: endpoint {
+			dai-format = "i2s";
+			remote-endpoint = <&tas_speaker>;
 		};
 	};
 
 	i2s_port4: port at 4 {
 		i2s_pcmout3: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_hp>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index ebcd65631bca..0728832ce552 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "uniphier-ld20.dtsi"
+#include "dt-bindings/gpio/uniphier-gpio.h"
 
 / {
 	model = "UniPhier LD20 Global Board (REF_LD20_GP)";
@@ -45,6 +46,7 @@
 			widgets = "Headphone", "Headphone Jack";
 
 			dais = <&i2s_port2
+				&i2s_port3
 				&i2s_port4
 				&spdif_port0>;
 		};
@@ -72,6 +74,20 @@
 
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
@@ -91,17 +107,21 @@
 
 	i2s_port2: port at 2 {
 		i2s_line: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_line>;
 		};
 	};
 
 	i2s_port3: port at 3 {
 		i2s_hpcmout1: endpoint {
+			dai-format = "i2s";
+			remote-endpoint = <&tas_speaker>;
 		};
 	};
 
 	i2s_port4: port at 4 {
 		i2s_pcmout3: endpoint {
+			dai-format = "i2s";
 			remote-endpoint = <&evea_hp>;
 		};
 	};
-- 
2.15.0
