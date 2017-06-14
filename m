From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 16:23:38 +0800
Subject: [PATCH v3 21/21] arm64: dts: hi3660-hikey960: add nodes for WiFi
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Message-ID: <20170614082338.15673-22-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for WiFi. HiKey960 is using TI WL1837MOD module.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index cec0b60..6609b0f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -145,6 +145,20 @@
 			};
 		};
 	};
+
+	wlan_en: wlan-en-1-8v {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		/* GPIO_051_WIFI_EN */
+		gpio = <&gpio6 3 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &i2c0 {
@@ -208,3 +222,22 @@
 	vqmmc-supply = <&ldo9>;
 	status = "okay";
 };
+
+&dwmmc2 { /* WIFI */
+	broken-cd;
+	/* WL_EN */
+	vmmc-supply = <&wlan_en>;
+	ti,non-removable;
+	non-removable;
+	#address-cells = <0x1>;
+	#size-cells = <0x0>;
+	status = "ok";
+
+	wlcore: wlcore at 2 {
+		compatible = "ti,wl1837";
+		reg = <2>;      /* sdio func num */
+		/* WL_IRQ, GPIO_179_WL_WAKEUP_AP */
+		interrupt-parent = <&gpio22>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+	};
+};
-- 
2.10.2
