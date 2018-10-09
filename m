From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue,  9 Oct 2018 19:35:17 +0530
Subject: [PATCH 1/6] arm64: dts: rockchip: ficus: Add on-board LED support
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181009140522.6492-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add on-board LED support for Ficus board based on the following
standard used by other 96Boards:

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index cce266da28cd..10a4d3882dd8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -23,6 +23,52 @@
 		clock-output-names = "clkin_gmac";
 		#clock-cells = <0>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_led1>, <&user_led2>, <&user_led3>,
+			    <&user_led4>, <&wlan_led>, <&bt_led>;
+
+		user_led1 {
+			label = "rk3399-ficus:green:user1";
+			gpios = <&gpio4 RK_PD1 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "rk3399-ficus:green:user2";
+			gpios = <&gpio4 RK_PD2 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "rk3399-ficus:green:user3";
+			gpios = <&gpio4 RK_PD6 0>;
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "rk3399-ficus:green:user4";
+			gpios = <&gpio1 RK_PA0 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "rk3399-ficus:yellow:wlan";
+			gpios = <&gpio1 RK_PA1 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "rk3399-ficus:blue:bt";
+			gpios = <&gpio1 RK_PA4 0>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
 };
 
 &gmac {
@@ -53,6 +99,38 @@
 		};
 	};
 
+	leds {
+		user_led1: user_led1 {
+			rockchip,pins =
+				<4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led2: user_led2 {
+			rockchip,pins =
+				<4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led3: user_led3 {
+			rockchip,pins =
+				<4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led4: user_led4 {
+			rockchip,pins =
+				<1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led: wlan_led {
+			rockchip,pins =
+				<1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_led: bt_led {
+			rockchip,pins =
+				<1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pcie {
 		pcie_drv: pcie-drv {
 			rockchip,pins =
-- 
2.17.1
