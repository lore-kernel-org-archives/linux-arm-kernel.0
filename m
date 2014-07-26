From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:28 +0200
Subject: [PATCH v2 12/15] ARM: dts: rk3188-radxarock: enable sd-card slot
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-13-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Radxa Rock contains one sd-card slot. Add the supplying regulator
and enable its dw_mmc node.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index a281293..7628b48 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -57,6 +57,16 @@
 			default-state = "off";
 		};
 	};
+
+	vcc_sd0: sdmmc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "sdmmc-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 1 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
 };
 
 &i2c1 {
@@ -159,6 +169,18 @@
 	};
 };
 
+&mmc0 {
+	num-slots = <1>;
+	status = "okay";
+	vmmc-supply = <&vcc_sd0>;
+
+	slot at 0 {
+		reg = <0>;
+		bus-width = <4>;
+		disable-wp;
+	};
+};
+
 &pinctrl {
 	pcfg_output_low: pcfg-output-low {
 		output-low;
-- 
2.0.1
