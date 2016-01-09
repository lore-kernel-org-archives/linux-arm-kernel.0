From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sat,  9 Jan 2016 13:54:18 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: Add the SDIO wifi on Radxa Rock2
 square
In-Reply-To: <1452344058-27434-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1452344058-27434-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1452344058-27434-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the sdio0 slot on the Rock2 square which has a broadcom wifi chip
attached and add a power sequence to enable the wifi chip and turn on
the required 32k clock.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/boot/dts/rk3288-rock2-square.dts | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 8af35c8..dd53af3 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -63,6 +63,16 @@
 		#sound-dai-cells = <0>;
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "xin32k";
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable>;
+	};
+
 	vcc_usb_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -88,6 +98,21 @@
 	};
 };
 
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk &sdio0_int>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc_18>;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
@@ -112,7 +137,7 @@
 };
 
 &i2c0 {
-	hym8563 at 51 {
+	hym8563: hym8563 at 51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
@@ -148,6 +173,12 @@
 			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	sdio {
+		wifi_enable: wifi-enable {
+			rockchip,pins = <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &spdif {
-- 
2.7.0.rc3
