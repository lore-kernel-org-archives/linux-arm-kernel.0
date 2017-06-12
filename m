From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 12 Jun 2017 14:14:16 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: use cs-gpios for cros_ec_spi
In-Reply-To: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1497248057-16550-2-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cros_ec requires CS line to be active after last message. But the CS
would be toggled when powering off/on rockchip spi, which breaks ec xfer.
Use GPIO CS to prevent that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index eb50593..329a634 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -790,6 +790,8 @@ ap_i2c_audio: &i2c8 {
 &spi5 {
 	status = "okay";
 
+	cs-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
+
 	cros_ec: ec at 0 {
 		compatible = "google,cros-ec-spi";
 		reg = <0>;
@@ -813,6 +815,10 @@ ap_i2c_audio: &i2c8 {
 	};
 };
 
+&spi5_cs0 {
+	rockchip,pins = <2 23 RK_FUNC_GPIO &pcfg_pull_up>;
+};
+
 &tsadc {
 	status = "okay";
 
-- 
2.1.4
