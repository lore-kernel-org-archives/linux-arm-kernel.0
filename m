From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Mar 2016 14:58:44 +0100
Subject: [PATCH v4 6/8] arm64: dts: rockchip: Add power key to GeekBox
In-Reply-To: <1458136727-32075-1-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
Message-ID: <1458136727-32075-7-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Julien Chauveau <chauveau.julien@gmail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Renamed power button sub-node name (Julien)
 
 v2 -> v3:
 * Adopted wakeup-source instead of gpio-key,wakeup (Julien)
 * Dropped gpio-keys #address-cells and #size-cells properties (Julien)
 * Dropped power button reg property (Julien)
 * Adopted KEY_POWER (Julien)
 * Fixed power button pinctrl pull setting (Julien)
 
 v2: New
 
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index cef4c12bda48..46cdddfcea6c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -42,6 +42,7 @@
 
 /dts-v1/;
 #include "rk3368.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "GeekBox";
@@ -70,6 +71,19 @@
 		pinctrl-0 = <&ir_int>;
 	};
 
+	keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_key>;
+
+		power {
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			label = "GPIO Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
 	leds: gpio-leds {
 		compatible = "gpio-leds";
 
@@ -265,6 +279,12 @@
 		};
 	};
 
+	keys {
+		pwr_key: pwr-key {
+			rockchip,pins = <0 2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_sleep: pmic-sleep {
 			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.6.2
