From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 29 Oct 2018 15:12:40 +0530
Subject: [PATCH v3 2/7] arm64: dts: rockchip: rock960: Add on-board LED support
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181029094245.7886-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add on-board LED support for Rock960 board based on the following
standard used by rest of the 96Boards:

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/rockchip/rk3399-rock960.dts      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 3c3308daec98..12285c51cceb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -13,6 +13,53 @@
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_led1>, <&user_led2>, <&user_led3>,
+			    <&user_led4>, <&wlan_led>, <&bt_led>;
+
+		user_led1 {
+			label = "green:user1";
+			gpios = <&gpio4 RK_PC2 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "green:user2";
+			gpios = <&gpio4 RK_PC6 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "green:user3";
+			gpios = <&gpio4 RK_PD0 0>;
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "green:user4";
+			gpios = <&gpio4 RK_PD4 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "yellow:wlan";
+			gpios = <&gpio4 RK_PD5 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "blue:bt";
+			gpios = <&gpio4 RK_PD6 0>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
+
 };
 
 &pcie0 {
@@ -20,6 +67,38 @@
 };
 
 &pinctrl {
+	leds {
+		user_led1: user_led1 {
+			rockchip,pins =
+				<4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led2: user_led2 {
+			rockchip,pins =
+				<4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led3: user_led3 {
+			rockchip,pins =
+				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led4: user_led4 {
+			rockchip,pins =
+				<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led: wlan_led {
+			rockchip,pins =
+				<4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_led: bt_led {
+			rockchip,pins =
+				<4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pcie {
 		pcie_drv: pcie-drv {
 			rockchip,pins =
-- 
2.17.1
