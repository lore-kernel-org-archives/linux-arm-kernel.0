From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 15:01:49 +0100
Subject: [PATCH v2 4/4] ARM: dts: da850-evm: add the output port to the vpif
 node
In-Reply-To: <1487772109-10014-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487772109-10014-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487772109-10014-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the vpif node with an output port with a single channel.

NOTE: this is still mostly just hardware description - the actual
driver is registered using pdata-quirks. We need the node however
for correct pin control function selection.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 19 +++++++++++++++----
 arch/arm/boot/dts/da850.dtsi    |  8 +++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 3968a18..0298734 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -300,20 +300,31 @@
 
 &vpif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&vpif_capture_pins>;
+	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
 	status = "okay";
 
+	enable-gpios = <&tca6416 7 GPIO_ACTIVE_HIGH
+			&tca6416 6 GPIO_ACTIVE_HIGH
+			&tca6416 5 GPIO_ACTIVE_LOW>;
+
 	/* VPIF capture port */
-	port {
-		vpif_ch0: endpoint at 0 {
+	port at 0 {
+		vpif_input_ch0: endpoint at 0 {
 			reg = <0>;
 			bus-width = <8>;
 		};
 
-		vpif_ch1: endpoint at 1 {
+		vpif_input_ch1: endpoint at 1 {
 			reg = <1>;
 			bus-width = <8>;
 			data-shift = <8>;
 		};
 	};
+
+	/* VPIF display port */
+	port at 1 {
+		vpif_output_ch0: endpoint {
+			bus-width = <8>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 5150331..c708155 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -358,7 +358,13 @@
 			status = "disabled";
 
 			/* VPIF capture port */
-			port {
+			port at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			/* VPIF display port */
+			port at 1 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
-- 
2.9.3
