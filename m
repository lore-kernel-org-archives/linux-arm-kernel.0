From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Feb 2016 13:19:08 +0800
Subject: [PATCH 5/5] arm64: dts: add wifi nodes support for hi6220-hikey
In-Reply-To: <1455859148-29098-1-git-send-email-guodong.xu@linaro.org>
References: <1455859148-29098-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1455859148-29098-6-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wifi nodes support for hi6220-hikey

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 5a004b4..eba6ec7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -47,6 +47,7 @@
 		i2c0: i2c at f7100000 {
 			status = "ok";
 		};
+
 		i2c1: i2c at f7101000 {
 			status = "ok";
 		};
@@ -62,6 +63,33 @@
 		uart3: uart at f7113000 {
 			status = "ok";
 		};
+
+		dwmmc_2: dwmmc2 at f723f000 {
+			/* WL_EN */
+			vmmc-supply = <&wlan_en_reg>;
+
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			wlcore: wlcore at 2 {
+				compatible = "ti,wl1835";
+				reg = <2>;	/* sdio func num */
+				/* WL_IRQ, WL_HOST_WAKE_GPIO1_3 */
+				interrupt-parent = <&gpio1>;
+				interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
+		wlan_en_reg: fixedregulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "wlan-en-regulator";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			/* WLAN_EN GPIO */
+			gpio = <&gpio0 5 0>;
+			/* WLAN card specific delay */
+			startup-delay-us = <70000>;
+			enable-active-high;
+		};
 	};
 
 	leds {
-- 
1.9.1
