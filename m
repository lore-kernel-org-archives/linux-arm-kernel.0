From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Aug 2014 11:47:29 -0700
Subject: [PATCH] ARM: dts: Move the PMIC interrupt pinctrl line to rk3288-evb
 common
Message-ID: <1407782849-11056-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMIC interrupt pinctrl line was added to the rk3288-evb-act8846,
but it's the same line on both the ACT8846 version and the RK808
version.  This makes a lot of sense since they share the same SoC
daugherboard.  Move the pinctrl definition to the common file so we
can use it for the RK808 version.

NOTE: The PMIC interrupt doesn't _actually_ go to the PMIC on the
ACT8846 version of the board (it does on the RK808), but our
convention is to label things as they're labelled on the schematics.
In the very least you can argue that this is the interrupt from the
PMIC daughtercard even if it doesn't actually go to the PMIC chip.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 10 +---------
 arch/arm/boot/dts/rk3288-evb.dtsi        |  6 ++++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 7d59ff4..a76dd44 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -26,7 +26,7 @@
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&hym8563_int>;
+		pinctrl-0 = <&pmic_int>;
 
 		#clock-cells = <0>;
 		clock-output-names = "xin32k";
@@ -124,11 +124,3 @@
 		};
 	};
 };
-
-&pinctrl {
-	hym8563 {
-		hym8563_int: hym8563-int {
-			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4f57209..ae3e10b 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -84,6 +84,12 @@
 		};
 	};
 
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	usb {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.0.0.526.g5318336
