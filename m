From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Aug 2015 23:44:39 +0200
Subject: [PATCH 2/3] ARM: dts: rockchip: add usb phys to Cortex-A9 socs
In-Reply-To: <1617149.AMXNNUATDo@diego>
References: <1617149.AMXNNUATDo@diego>
Message-ID: <1667603.JGEDfygFyh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the usbphy nodes to rk3066 and rk3188, which share the usb hosts
in rk3xxx.dtsi and also enables it on boards based around these socs.

The usb-phy itself is the same as used on the rk3288 already.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-marsboard.dts |  4 ++++
 arch/arm/boot/dts/rk3066a-rayeager.dts  |  4 ++++
 arch/arm/boot/dts/rk3066a.dtsi          | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts  |  4 ++++
 arch/arm/boot/dts/rk3188.dtsi           | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi           |  4 ++++
 6 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 4355966..08f5b43 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -202,6 +202,10 @@
 	status = "okay";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 7ccd376..e36383c 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -460,6 +460,10 @@
 	status = "okay";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &usb_otg {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index d32229b..870e6f5 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -169,6 +169,28 @@
 		clock-names = "timer", "pclk";
 	};
 
+	usbphy: phy {
+		compatible = "rockchip,rk3066a-usb-phy", "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usbphy0: usb-phy0 {
+			#phy-cells = <0>;
+			reg = <0x17c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+		};
+
+		usbphy1: usb-phy1 {
+			#phy-cells = <0>;
+			reg = <0x188>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+		};
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3066a-pinctrl";
 		rockchip,grf = <&grf>;
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 4bb014d..d2180e5 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -359,6 +359,10 @@
 	status = "okay";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &usb_host {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 0f23aed..3163042 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -130,6 +130,28 @@
 		#reset-cells = <1>;
 	};
 
+	usbphy: phy {
+		compatible = "rockchip,rk3188-usb-phy", "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		usbphy0: usb-phy0 {
+			#phy-cells = <0>;
+			reg = <0x10c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+		};
+
+		usbphy1: usb-phy1 {
+			#phy-cells = <0>;
+			reg = <0x11c>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+		};
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3188-pinctrl";
 		rockchip,grf = <&grf>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index c571ac8..4497d28 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -177,6 +177,8 @@
 		g-rx-fifo-size = <275>;
 		g-tx-fifo-size = <256 128 128 64 64 32>;
 		g-use-dma;
+		phys = <&usbphy0>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
@@ -187,6 +189,8 @@
 		clocks = <&cru HCLK_OTG1>;
 		clock-names = "otg";
 		dr_mode = "host";
+		phys = <&usbphy1>;
+		phy-names = "usb2-phy";
 		status = "disabled";
 	};
 
-- 
2.1.4
