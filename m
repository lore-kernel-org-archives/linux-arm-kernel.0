From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:52 +0800
Subject: [PATCH v4 16/16] arm64: dts: add wifi nodes support for hi6220-hikey
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-17-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wifi nodes support for hi6220-hikey

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index cc1148d..e92a30c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -65,6 +65,35 @@
 		uart3: uart at f7113000 {
 			status = "ok";
 		};
+
+		dwmmc_2: dwmmc2 at f723f000 {
+			ti,non-removable;
+			non-removable;
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
+		wlan_en_reg: regulator at 1 {
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
