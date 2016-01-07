From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  7 Jan 2016 16:25:51 +0800
Subject: [PATCH v2 08/12] ARM: dts: rockchip: add the wifi/bt regulator for
 kylin board
In-Reply-To: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452155155-16232-9-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the wifi/bt regulator for simple mmc sequence.
Also, add the exteral clock and reset gpios for simple mmmc sequence
on kylin board.

Without this the wifi/bluetooth module doesn't work properly at bootup.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- As Heiko comment, modify it to fit the simple-mmc-sequence.

 arch/arm/boot/dts/rk3036-kylin.dts | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index b2e5f5d..4346ce5 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -40,6 +40,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/clock/rockchip,rk808.h>
 #include "rk3036.dtsi"
 
 / {
@@ -76,6 +77,43 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	bt_regulator: bt-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_enable_l>;
+		regulator-name = "bt_regulator";
+	};
+
+	wifi_regulator: wifi-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		regulator-name = "wifi_regulator";
+		vin-supply = <&bt_regulator>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 RK808_CLKOUT1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_wake_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - PDN (power down when low)
+		 */
+		reset-gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
+		ext-vcc-supply = <&wifi_regulator>;
+	};
+
 };
 
 &acodec {
@@ -312,6 +350,7 @@
 	cap-sdio-irq;
 	default-sample-phase = <90>;
 	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
@@ -337,6 +376,20 @@
 		};
 	};
 
+	sdio {
+		wifi_enable_h: wifienable-h {
+			rockchip,pins = <0 26 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_enable_l: bt-enable-l {
+			rockchip,pins = <2 9 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_h: bt-wake-h {
+			rockchip,pins = <2 8 RK_FUNC_GPIO &pcfg_pull_default>;
+		};
+	};
+
 	sleep {
 		global_pwroff: global-pwroff {
 			rockchip,pins = <2 7 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.9.1
