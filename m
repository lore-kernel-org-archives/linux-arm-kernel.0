From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  1 Sep 2016 07:28:52 +0800
Subject: [PATCH v3 5/5] arm64: dts: rockchip: enable the gmac for rk3399 evb
 board
In-Reply-To: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
References: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1472686132-27827-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We add the required and optional properties for evb board.
See the [0] to get the detail information.

[0]:
Documentation/devicetree/bindings/net/rockchip-dwmac.txt

Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index d47b4e9..ed6f2e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -94,12 +94,43 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_phy";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 };
 
 &emmc_phy {
 	status = "okay";
 };
 
+&gmac {
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	snps,reset-gpio = <&gpio3 15 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	assigned-clocks = <&cru SCLK_RMII_SRC>;
+	assigned-clock-parents = <&clkin_gmac>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	tx_delay = <0x28>;
+	rx_delay = <0x11>;
+	status = "okay";
+};
+
 &pwm0 {
 	status = "okay";
 };
-- 
1.9.1
