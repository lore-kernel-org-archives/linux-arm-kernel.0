From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  4 Jan 2014 10:14:37 +0100
Subject: [PATCH v2 3/4] ARM: sun4i: dts: Add ahci / sata support
In-Reply-To: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1388826878-5602-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oliver Schinagl <oliver@schinagl.nl>

This patch adds sunxi sata support to A10 boards that have such a connector.
Some boards also feature a regulator via a GPIO and support for this is also
added.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  9 +++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index aef8207..fd6d512 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -48,6 +48,10 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			mmc0_cd_pin_a1000: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index f50fb2b..53ac453 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -51,7 +51,19 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			pwr-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
+			ahci_pwr_pin_cubieboard: ahci_pwr_pin at 0 {
+				allwinner,pins = "PB8";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			mmc0_cd_pin_cubieboard: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
 				allwinner,function = "gpio_in";
@@ -102,4 +114,19 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-names = "default";
+
+		reg_ahci_5v: ahci-5v {
+			compatible = "regulator-fixed";
+			regulator-name = "ahci-5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-0 = <&ahci_pwr_pin_cubieboard>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 4736dd2..731b491 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -331,6 +331,15 @@
 			status = "disabled";
 		};
 
+		sata: ahci at 01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <56>;
+			clocks = <&ahb_gates 25>, <&pll6 0>;
+			clock-names = "ahb_sata", "pll6_sata";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
-- 
1.8.4.2
