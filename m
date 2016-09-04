From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:06 +0200
Subject: [PATCH v3 03/17] ARM: dts: exynos: Use common macros for pinctrl
 configuration
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Replace duplicated macros in each DTSI file with a common macro coming
from header.  Include the header in each pinctrl DTSI so further changes
could use it.

Although PIN_FUNC_SPC_2 does not bring much information about the
function itself, it still is more descriptive then hard-coded
number <2>.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 76 +++++++++++-------------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  2 +
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi |  2 +
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 21 +++----
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |  2 +
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 96 +++++++++++++++----------------
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi |  2 +
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi |  2 +
 8 files changed, 96 insertions(+), 107 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index 40ea7de44933..ed22d94f4fe5 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -12,58 +12,46 @@
  * published by the Free Software Foundation.
 */
 
-#define PIN_PULL_NONE		0
-#define PIN_PULL_DOWN		1
-#define PIN_PULL_UP		3
-
-#define PIN_DRV_LV1		0
-#define PIN_DRV_LV2		2
-#define PIN_DRV_LV3		1
-#define PIN_DRV_LV4		3
-
-#define PIN_PDN_OUT0		0
-#define PIN_PDN_OUT1		1
-#define PIN_PDN_INPUT		2
-#define PIN_PDN_PREV		3
-
-#define PIN_IN(_pin, _pull, _drv)			\
-	_pin {						\
-		samsung,pins = #_pin;			\
-		samsung,pin-function = <0>;		\
-		samsung,pin-pud = <PIN_PULL_ ##_pull>;	\
-		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+#include <dt-bindings/pinctrl/samsung.h>
+
+#define PIN_IN(_pin, _pull, _drv)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;		\
+		samsung,pin-pud = <EXYNOS_PIN_PULL_ ##_pull>;		\
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;		\
 	}
 
-#define PIN_OUT(_pin, _drv)				\
-	_pin {						\
-		samsung,pins = #_pin;			\
-		samsung,pin-function = <1>;		\
-		samsung,pin-pud = <0>;			\
-		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+#define PIN_OUT(_pin, _drv)						\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;	\
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;		\
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;		\
 	}
 
-#define PIN_OUT_SET(_pin, _val, _drv)			\
-	_pin {						\
-		samsung,pins = #_pin;			\
-		samsung,pin-function = <1>;		\
-		samsung,pin-pud = <0>;			\
-		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
-		samsung,pin-val = <_val>;		\
+#define PIN_OUT_SET(_pin, _val, _drv)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;	\
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;		\
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;		\
+		samsung,pin-val = <_val>;				\
 	}
 
-#define PIN_CFG(_pin, _sel, _pull, _drv)		\
-	_pin {						\
-		samsung,pins = #_pin;			\
-		samsung,pin-function = <_sel>;		\
-		samsung,pin-pud = <PIN_PULL_ ##_pull>;	\
-		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+#define PIN_CFG(_pin, _sel, _pull, _drv)				\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-function = <_sel>;				\
+		samsung,pin-pud = <EXYNOS_PIN_PULL_ ##_pull>;		\
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;		\
 	}
 
-#define PIN_SLP(_pin, _mode, _pull)				\
-	_pin {							\
-		samsung,pins = #_pin;				\
-		samsung,pin-con-pdn = <PIN_PDN_ ##_mode>;	\
-		samsung,pin-pud-pdn = <PIN_PULL_ ##_pull>;	\
+#define PIN_SLP(_pin, _mode, _pull)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_ ##_pull>;	\
 	}
 
 &pinctrl_0 {
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 9331c6252eff..cc65537ff79b 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -14,6 +14,8 @@
  * published by the Free Software Foundation.
 */
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 / {
 	pinctrl at 11400000 {
 		gpa0: gpa0 {
diff --git a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
index 75af9c56123e..63714445dddb 100644
--- a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
@@ -11,6 +11,8 @@
  * published by the Free Software Foundation.
 */
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 &pinctrl_0 {
 	gpa0: gpa0 {
 		gpio-controller;
diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index 856b29254374..b5ded0ccce07 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -12,20 +12,13 @@
  * published by the Free Software Foundation.
 */
 
-#define PIN_PULL_NONE		0
-#define PIN_PULL_DOWN		1
-#define PIN_PULL_UP		3
-
-#define PIN_PDN_OUT0		0
-#define PIN_PDN_OUT1		1
-#define PIN_PDN_INPUT		2
-#define PIN_PDN_PREV		3
-
-#define PIN_SLP(_pin, _mode, _pull)				\
-	_pin {							\
-		samsung,pins = #_pin;				\
-		samsung,pin-con-pdn = <PIN_PDN_ ##_mode>;	\
-		samsung,pin-pud-pdn = <PIN_PULL_ ##_pull>;	\
+#include <dt-bindings/pinctrl/samsung.h>
+
+#define PIN_SLP(_pin, _mode, _pull)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_ ##_pull>;	\
 	}
 
 / {
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 880917e508b2..d1a4ea0fb838 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -12,6 +12,8 @@
  * published by the Free Software Foundation.
 */
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 &pinctrl_0 {
 	gpa0: gpa0 {
 		gpio-controller;
diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index f6ee55ea0708..39c046758029 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -12,9 +12,7 @@
  * published by the Free Software Foundation.
 */
 
-#define PIN_PULL_NONE	0
-#define PIN_PULL_DOWN	1
-#define PIN_PULL_UP	3
+#include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_0 {
 	gpa0: gpa0 {
@@ -188,56 +186,56 @@
 	uart0_data: uart0-data {
 		samsung,pins = "gpa0-0", "gpa0-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	uart0_fctl: uart0-fctl {
 		samsung,pins = "gpa0-2", "gpa0-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	uart1_data: uart1-data {
 		samsung,pins = "gpa1-0", "gpa1-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	uart1_fctl: uart1-fctl {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	uart2_data: uart2-data {
 		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	spi0_bus: spi0-bus {
 		samsung,pins = "gpa2-0", "gpa2-2", "gpa2-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	spi1_bus: spi1-bus {
 		samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	usb3_vbus0_en: usb3-vbus0-en {
 		samsung,pins = "gpa2-4";
 		samsung,pin-function = <1>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
@@ -245,7 +243,7 @@
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 				"gpb0-4";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
@@ -253,105 +251,105 @@
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 				"gpb0-4";
 		samsung,pin-function = <3>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	spdif1_bus: spdif1-bus {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2";
 		samsung,pin-function = <4>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	spi2_bus: spi2-bus {
 		samsung,pins = "gpb1-0", "gpb1-2", "gpb1-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c0_hs_bus: i2c0-hs-bus {
 		samsung,pins = "gpb3-0", "gpb3-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c1_hs_bus: i2c1-hs-bus {
 		samsung,pins = "gpb3-2", "gpb3-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c2_hs_bus: i2c2-hs-bus {
 		samsung,pins = "gpb3-4", "gpb3-5";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c3_hs_bus: i2c3-hs-bus {
 		samsung,pins = "gpb3-6", "gpb3-7";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c4_bus: i2c4-bus {
 		samsung,pins = "gpb4-0", "gpb4-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c5_bus: i2c5-bus {
 		samsung,pins = "gpb4-2", "gpb4-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c6_bus: i2c6-bus {
 		samsung,pins = "gpb4-4", "gpb4-5";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c7_bus: i2c7-bus {
 		samsung,pins = "gpb4-6", "gpb4-7";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c8_bus: i2c8-bus {
 		samsung,pins = "gpb5-0", "gpb5-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c9_bus: i2c9-bus {
 		samsung,pins = "gpb5-2", "gpb5-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c10_bus: i2c10-bus {
 		samsung,pins = "gpb5-4", "gpb5-5";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	i2c11_bus: i2c11-bus {
 		samsung,pins = "gpb5-6", "gpb5-7";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
@@ -360,7 +358,7 @@
 			"gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 			"gpe1-0", "gpe1-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
@@ -368,35 +366,35 @@
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
 			"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
 		samsung,pin-function = <3>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	cam_i2c1_bus: cam-i2c1-bus {
 		samsung,pins = "gpf0-2", "gpf0-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	cam_i2c0_bus: cam-i2c0-bus {
 		samsung,pins = "gpf0-0", "gpf0-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <0>;
 	};
 
 	cam_spi0_bus: cam-spi0-bus {
 		samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 
 	cam_spi1_bus: cam-spi1-bus {
 		samsung,pins = "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <0>;
 	};
 };
@@ -445,112 +443,112 @@
 	sd0_clk: sd0-clk {
 		samsung,pins = "gpc0-0";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd0_cmd: sd0-cmd {
 		samsung,pins = "gpc0-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd0_bus1: sd0-bus-width1 {
 		samsung,pins = "gpc0-2";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd0_bus4: sd0-bus-width4 {
 		samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd0_bus8: sd0-bus-width8 {
 		samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd0_rdqs: sd0-rdqs {
 		samsung,pins = "gpc0-6";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpc1-0";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd1_cmd: sd1-cmd {
 		samsung,pins = "gpc1-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd1_bus1: sd1-bus-width1 {
 		samsung,pins = "gpc1-2";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd1_bus4: sd1-bus-width4 {
 		samsung,pins = "gpc1-3", "gpc1-4", "gpc1-5";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd1_bus8: sd1-bus-width8 {
 		samsung,pins = "gpc4-0", "gpc4-1", "gpc4-2", "gpc4-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd2_clk: sd2-clk {
 		samsung,pins = "gpc2-0";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd2_cmd: sd2-cmd {
 		samsung,pins = "gpc2-1";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd2_cd: sd2-cd {
 		samsung,pins = "gpc2-2";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd2_bus1: sd2-bus-width1 {
 		samsung,pins = "gpc2-3";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 
 	sd2_bus4: sd2-bus-width4 {
 		samsung,pins = "gpc2-4", "gpc2-5", "gpc2-6";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <3>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index b58a0f29f42c..bf43792efe27 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -9,6 +9,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 &pinctrl_0 {
 	gpa0: gpa0 {
 		gpio-controller;
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index 14beb7e07323..cf7d2986780a 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -12,6 +12,8 @@
  * published by the Free Software Foundation.
 */
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 &pinctrl_0 {
 	gpy7: gpy7 {
 		gpio-controller;
-- 
2.7.4
