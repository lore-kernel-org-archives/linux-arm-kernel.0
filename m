From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:22 +0200
Subject: [PATCH v2 06/15] ARM: dts: uses handles to reference nodes for changes
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-7-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the handles for subsequent changes to nodes, similar to like the rk3288
submission does it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 91 ++++++++++++++++------------------
 arch/arm/boot/dts/rk3066a.dtsi         | 30 +++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 36 +++++++-------
 arch/arm/boot/dts/rk3188.dtsi          | 36 +++++++++++---
 4 files changed, 119 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 6131675..38910f6 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -24,24 +24,6 @@
 		reg = <0x60000000 0x40000000>;
 	};
 
-	uart0: serial at 10124000 {
-		status = "okay";
-	};
-
-	uart1: serial at 10126000 {
-		status = "okay";
-	};
-
-	uart2: serial at 20064000 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2_xfer>;
-		status = "okay";
-	};
-
-	uart3: serial at 20068000 {
-		status = "okay";
-	};
-
 	vcc_sd0: fixed-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
@@ -51,36 +33,6 @@
 		startup-delay-us = <100000>;
 	};
 
-	dwmmc at 10214000 { /* sdmmc */
-		num-slots = <1>;
-		status = "okay";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
-		vmmc-supply = <&vcc_sd0>;
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-		};
-	};
-
-	dwmmc at 10218000 { /* wifi */
-		num-slots = <1>;
-		status = "okay";
-		non-removable;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -106,3 +58,46 @@
 		/* VOL+ comes somehow thru the ADC */
 	};
 };
+
+&mmc0 { /* sdmmc */
+	num-slots = <1>;
+	status = "okay";
+	vmmc-supply = <&vcc_sd0>;
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		disable-wp;
+	};
+};
+
+&mmc1 { /* wifi */
+	num-slots = <1>;
+	status = "okay";
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		disable-wp;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index ecf722e..460932b2 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -291,3 +291,33 @@
 		};
 	};
 };
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_xfer>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_xfer>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_xfer>;
+};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 7a002f5..241e2a4 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -23,24 +23,6 @@
 		reg = <0x60000000 0x80000000>;
 	};
 
-	uart0: serial at 10124000 {
-		status = "okay";
-	};
-
-	uart1: serial at 10126000 {
-		status = "okay";
-	};
-
-	uart2: serial at 20064000 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&uart2_xfer>;
-		status = "okay";
-	};
-
-	uart3: serial at 20068000 {
-		status = "okay";
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -76,3 +58,21 @@
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_xfer>;
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 7b631ec..4a9f702 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -52,14 +52,6 @@
 		};
 	};
 
-	global-timer at 1013c200 {
-		interrupts = <GIC_PPI 11 0xf04>;
-	};
-
-	local-timer at 1013c600 {
-		interrupts = <GIC_PPI 13 0xf04>;
-	};
-
 	sram: sram at 10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x8000>;
@@ -271,3 +263,31 @@
 		};
 	};
 };
+
+&global_timer {
+	interrupts = <GIC_PPI 11 0xf04>;
+};
+
+&local_timer {
+	interrupts = <GIC_PPI 13 0xf04>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_xfer>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_xfer>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_xfer>;
+};
-- 
2.0.1
