From: william.wu@rock-chips.com (William Wu)
Date: Wed, 31 May 2017 09:21:24 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: enable usb for rk3229 evb board
In-Reply-To: <1496193684-30449-1-git-send-email-william.wu@rock-chips.com>
References: <1496193684-30449-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <1496193684-30449-3-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip's rk3229 evaluation board has one usb otg controller
and three usb host controllers. Each usb controller connect
with one usb2 phy port through UTMI+ interface. And the three
usb host interfaces use the same GPIO VBUS drive. Let's enable
them to support usb on rk3229 evb board.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 275092a..1b55192 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -58,6 +58,17 @@
 		#clock-cells = <0>;
 	};
 
+	vcc_host: vcc-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc_host";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc_phy: vcc-phy-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -85,6 +96,69 @@
 	status = "okay";
 };
 
+&pinctrl {
+	usb {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
 &uart2 {
 	status = "okay";
 };
+
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_otg: otg-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+
+	u2phy1_host: host-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host2_ehci {
+	status = "okay";
+};
+
+&usb_host2_ohci {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
-- 
2.0.0
