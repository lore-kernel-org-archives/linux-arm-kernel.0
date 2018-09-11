From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 11 Sep 2018 08:00:30 +0530
Subject: [PATCH v2 3/4] arm64: boot: dts: rockchip: Add support for Rock960
 board
In-Reply-To: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180911023031.4892-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree support for Rock960 board, one of the Consumer Edition
boards of the 96Boards family. This board support utilizes the common
Rock960 family board support that includes Ficus 96Board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-rock960.dts      | 139 ++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b0092d95b574..57c0d76458e6 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
new file mode 100644
index 000000000000..37242b64a7a3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+/dts-v1/;
+#include "rk3399-rock960.dtsi"
+
+/ {
+	model = "96boards Rock960";
+	compatible = "vamrs,rock960", "rockchip,rk3399";
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	vcc3v3_pcie: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_drv>;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc5v0_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+};
+
+&pinctrl {
+	pcie {
+		pcie_drv: pcie-drv {
+			rockchip,pins =
+				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+	};
+
+	usb2 {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&tcphy0 {
+	status = "okay";
+};
+
+&tcphy1 {
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
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
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+	dr_mode = "otg";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.17.1
