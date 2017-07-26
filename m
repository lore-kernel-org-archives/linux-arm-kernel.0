From: romain.perier@collabora.com (Romain Perier)
Date: Wed, 26 Jul 2017 15:55:25 +0200
Subject: [PATCH RESEND v3 2/3] arm: dts: rockchip: Don't set otp-gpio pinctrl
 by default in rk3288.dtsi
In-Reply-To: <20170726135526.475-1-romain.perier@collabora.com>
References: <20170726135526.475-1-romain.perier@collabora.com>
Message-ID: <20170726135526.475-11-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tsadc supports two reset methods: the cru and the otp_gpio. All
boards except veyron and the evb simply use the cru-method and reuse the
pin for something else. On the Firefly-RK3288 this is for example the
case with the headphone. To prevent pinctrl-conflicts with these don't
set the otp-gpio pinctrl by default but only in the boards using it.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi    | 4 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi | 4 ++++
 arch/arm/boot/dts/rk3288.dtsi        | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 0dec94c3583b..28a69334b2d1 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -290,6 +290,10 @@
 };
 
 &tsadc {
+	pinctrl-names = "init", "default", "sleep";
+	pinctrl-0 = <&otp_gpio>;
+	pinctrl-1 = <&otp_out>;
+	pinctrl-2 = <&otp_gpio>;
 	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index d709fa1847f9..697c9a78cb7e 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -398,6 +398,10 @@
 &tsadc {
 	status = "okay";
 
+	pinctrl-names = "init", "default", "sleep";
+	pinctrl-0 = <&otp_gpio>;
+	pinctrl-1 = <&otp_out>;
+	pinctrl-2 = <&otp_gpio>;
 	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2484f11761ea..3a752c0cbc73 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -541,10 +541,6 @@
 		clock-names = "tsadc", "apb_pclk";
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
-		pinctrl-names = "init", "default", "sleep";
-		pinctrl-0 = <&otp_gpio>;
-		pinctrl-1 = <&otp_out>;
-		pinctrl-2 = <&otp_gpio>;
 		#thermal-sensor-cells = <1>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
-- 
2.11.0
