From: cheat.sc.linux@outlook.com (Maruyama Shohei)
Date: Wed, 18 Jul 2018 14:58:16 +0000
Subject: [PATCH 1/3] arm64: dts: rockchip: add WiFi module support for
 Firefly-RK3399
Message-ID: <PS2P216MB05327A3B7901DEE585B0BA21D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shohei Maruyama <cheat.sc.linux@outlook.com>

This commit adds WiFi module support for the Firefly-RK3399.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
---
 .../boot/dts/rockchip/rk3399-firefly.dts      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 2a352763c848..8ac29824923c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -642,6 +642,41 @@
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
+	disable-wp;
+	cap-sd-highspeed;
+	keep-power-in-suspend;
+	non-removable;
+	sd-uhs-sdr104;
+
+	/* Card detection */
+	cd-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_LOW>;
+
+	/* Write protection */
+	wp-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
+
+	/* Power supply */
+	vqmmc-supply = &vcc1v8_s3;	/* IO line */
+	vmmc-supply = &vcc_sdio;	/* card's power */
+
+	status = "okay";
+
+	brcmf: wifi at 1 {
+		compatible = "brcm,bcm4329-fmac";
+		brcm,drive-strength = <5>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA4 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.18.0
