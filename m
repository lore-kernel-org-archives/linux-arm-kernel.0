From: cheat.sc.linux@outlook.com (Maruyama Shohei)
Date: Thu, 23 Aug 2018 16:35:32 +0000
Subject: [PATCH v2] arm64: dts: rockchip: add WiFi module support for
 Firefly-RK3399
Message-ID: <SLXP216MB05430124E8F6C3345D473155D1370@SLXP216MB0543.KORP216.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shohei Maruyama <cheat.sc.linux@outlook.com>

This commit adds WiFi module support for the Firefly-RK3399.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
---

Changes for v2:
	- Remove cd and wp gpios
	- Fix wrong interrupt pin
	- Add pinctrl for interrupt

 .../boot/dts/rockchip/rk3399-firefly.dts      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 2a352763c848..b1b49d382f63 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -610,6 +610,12 @@
 		};
 	};
 
+	wifi {
+		wifi_host_wake_l: wifi-host-wake-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	rt5640 {
 		rt5640_hpcon: rt5640-hpcon {
 			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -642,6 +648,36 @@
 	status = "okay";
 };
 
+&sdio0 {
+	/* WiFi & BT combo module Ampak AP6356S */
+	mmc-pwrseq = <&sdio_pwrseq>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	num-slots = <1>;
+	bus-width = <4>;
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	keep-power-in-suspend;
+	non-removable;
+	sd-uhs-sdr104;
+
+	/* Power supply */
+	vqmmc-supply = &vcc1v8_s3;	/* IO line */
+	vmmc-supply = &vcc_sdio;	/* card's power */
+
+	status = "okay";
+
+	brcmf: wifi at 1 {
+		compatible = "brcm,bcm4329-fmac";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+		brcm,drive-strength = <5>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.18.0
