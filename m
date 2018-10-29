From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 29 Oct 2018 14:30:00 +0530
Subject: [PATCH v2 1/7] arm64: dts: rockchip: ficus: Add on-board LED support
In-Reply-To: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
References: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181029090006.4353-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add on-board LED support for Ficus board based on the following
standard used by other 96Boards:

red:user1  default-trigger: heartbeat
red:user2  default-trigger: mmc0/disk-activity (onboard-storage)
red:user3  default-trigger: mmc1 (SD-card)
red:user4  default-trigger: none, panic-indicator
red:wlan   default-trigger: phy0tx
red:bt     default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index cce266da28cd..027d428917b8 100644
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
+			label = "red:user1";
+			gpios = <&gpio4 25 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "red:user2";
+			gpios = <&gpio4 26 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "red:user3";
+			gpios = <&gpio4 30 0>;
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "red:user4";
+			gpios = <&gpio1 0 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "red:wlan";
+			gpios = <&gpio1 1 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "red:bt";
+			gpios = <&gpio1 4 0>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
 };
 
 &gmac {
@@ -66,6 +112,38 @@
 				<4 27 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	leds {
+		user_led1: user_led1 {
+			rockchip,pins =
+				<4 25 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led2: user_led2 {
+			rockchip,pins =
+				<4 26 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led3: user_led3 {
+			rockchip,pins =
+				<4 30 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led4: user_led4 {
+			rockchip,pins =
+				<1 0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led: wlan_led {
+			rockchip,pins =
+				<1 1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_led: bt_led {
+			rockchip,pins =
+				<1 4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &usbdrd_dwc3_0 {
-- 
2.17.1
