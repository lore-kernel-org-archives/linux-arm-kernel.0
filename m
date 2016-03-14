From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 10:12:54 +0900
Subject: [PATCH] ARM: dts: Add initial pin configuration for exynos3250-rinato
Message-ID: <1457917974-314-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial pin configuration using pinctrl subsystem
to reduce leakage power-consumption of gpio pins in normal state.
All pins included in this patch are NC (not connected) pin.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 38 +++++++++++++++++
 arch/arm/boot/dts/exynos3250-rinato.dts   | 70 ++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index 5ab81c39e2c9..ecf79386e891 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -16,11 +16,49 @@
 #define PIN_PULL_DOWN		1
 #define PIN_PULL_UP		3
 
+#define PIN_DRV_LV1		0
+#define PIN_DRV_LV2		2
+#define PIN_DRV_LV3		1
+#define PIN_DRV_LV4		3
+
 #define PIN_PDN_OUT0		0
 #define PIN_PDN_OUT1		1
 #define PIN_PDN_INPUT		2
 #define PIN_PDN_PREV		3
 
+#define PIN_IN(_pin, _pull, _drv)			\
+	_pin {						\
+		samsung,pins = #_pin;			\
+		samsung,pin-function = <0>;		\
+		samsung,pin-pud = <PIN_PULL_ ##_pull>;	\
+		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+	}
+
+#define PIN_OUT(_pin, _drv)				\
+	_pin {						\
+		samsung,pins = #_pin;			\
+		samsung,pin-function = <1>;		\
+		samsung,pin-pud = <0>;			\
+		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+	}
+
+#define PIN_OUT_SET(_pin, _val, _drv)			\
+	_pin {						\
+		samsung,pins = #_pin;			\
+		samsung,pin-function = <1>;		\
+		samsung,pin-pud = <0>;			\
+		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+		samsung,pin-val = <_val>;		\
+	}
+
+#define PIN_CFG(_pin, _sel, _pull, _drv)		\
+	_pin {						\
+		samsung,pins = #_pin;			\
+		samsung,pin-function = <_sel>;		\
+		samsung,pin-pud = <PIN_PULL_ ##_pull>;	\
+		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+	}
+
 #define PIN_SLP(_pin, _mode, _pull)				\
 	_pin {							\
 		samsung,pins = #_pin;				\
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3e64d5dcdd60..1c78a2153776 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -681,7 +681,21 @@
 
 &pinctrl_0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&sleep0>;
+	pinctrl-0 = <&initial0 &sleep0>;
+
+	initial0: initial-state {
+		PIN_IN(gpa1-4, DOWN, LV1);
+		PIN_IN(gpa1-5, DOWN, LV1);
+
+		PIN_IN(gpc0-0, DOWN, LV1);
+		PIN_IN(gpc0-1, DOWN, LV1);
+		PIN_IN(gpc0-2, DOWN, LV1);
+		PIN_IN(gpc0-3, DOWN, LV1);
+		PIN_IN(gpc0-4, DOWN, LV1);
+
+		PIN_IN(gpd0-0, DOWN, LV1);
+		PIN_IN(gpd0-1, DOWN, LV1);
+	};
 
 	sleep0: sleep-state {
 		PIN_SLP(gpa0-0, INPUT, DOWN);
@@ -735,7 +749,59 @@
 
 &pinctrl_1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&sleep1>;
+	pinctrl-0 = <&initial1 &sleep1>;
+
+	initial1: initial-state {
+		PIN_IN(gpe0-6, DOWN, LV1);
+		PIN_IN(gpe0-7, DOWN, LV1);
+
+		PIN_IN(gpe1-0, DOWN, LV1);
+		PIN_IN(gpe1-3, DOWN, LV1);
+		PIN_IN(gpe1-4, DOWN, LV1);
+		PIN_IN(gpe1-5, DOWN, LV1);
+		PIN_IN(gpe1-6, DOWN, LV1);
+
+		PIN_IN(gpk2-0, DOWN, LV1);
+		PIN_IN(gpk2-1, DOWN, LV1);
+		PIN_IN(gpk2-2, DOWN, LV1);
+		PIN_IN(gpk2-3, DOWN, LV1);
+		PIN_IN(gpk2-4, DOWN, LV1);
+		PIN_IN(gpk2-5, DOWN, LV1);
+		PIN_IN(gpk2-6, DOWN, LV1);
+
+		PIN_IN(gpm0-0, DOWN, LV1);
+		PIN_IN(gpm0-1, DOWN, LV1);
+		PIN_IN(gpm0-2, DOWN, LV1);
+		PIN_IN(gpm0-3, DOWN, LV1);
+		PIN_IN(gpm0-4, DOWN, LV1);
+		PIN_IN(gpm0-5, DOWN, LV1);
+		PIN_IN(gpm0-6, DOWN, LV1);
+		PIN_IN(gpm0-7, DOWN, LV1);
+
+		PIN_IN(gpm1-0, DOWN, LV1);
+		PIN_IN(gpm1-1, DOWN, LV1);
+		PIN_IN(gpm1-2, DOWN, LV1);
+		PIN_IN(gpm1-3, DOWN, LV1);
+		PIN_IN(gpm1-4, DOWN, LV1);
+		PIN_IN(gpm1-5, DOWN, LV1);
+		PIN_IN(gpm1-6, DOWN, LV1);
+		PIN_IN(gpm2-0, DOWN, LV1);
+		PIN_IN(gpm2-1, DOWN, LV1);
+
+		PIN_IN(gpm3-0, DOWN, LV1);
+		PIN_IN(gpm3-1, DOWN, LV1);
+		PIN_IN(gpm3-2, DOWN, LV1);
+		PIN_IN(gpm3-3, DOWN, LV1);
+		PIN_IN(gpm3-4, DOWN, LV1);
+
+		PIN_IN(gpm4-1, DOWN, LV1);
+		PIN_IN(gpm4-2, DOWN, LV1);
+		PIN_IN(gpm4-3, DOWN, LV1);
+		PIN_IN(gpm4-4, DOWN, LV1);
+		PIN_IN(gpm4-5, DOWN, LV1);
+		PIN_IN(gpm4-6, DOWN, LV1);
+		PIN_IN(gpm4-7, DOWN, LV1);
+	};
 
 	sleep1: sleep-state {
 		PIN_SLP(gpe0-0, PREV, NONE);
-- 
1.9.1
