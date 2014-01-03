From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  3 Jan 2014 00:14:13 -0200
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY reset
Message-ID: <1388715253-17206-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 7a399e3a2e (fec: Do not assume that PHY reset is active low), we no
longer assume that the PHY reset is active low.

Now we need to retrieve this information from the device tree instead.

Passing '0' as the phy-reset-gpios means 'active high' according to the 
definition from include/dt-bindings/gpio/gpio.h:

#define GPIO_ACTIVE_HIGH 0
#define GPIO_ACTIVE_LOW 1

, so in order to keep things working as before we need to explicitly pass
GPIO_ACTIVE_LOW as the flag.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

This is needed for 3.13 as 7a399e3a2e (fec: Do not assume that PHY reset is 
active low) already reached mainline.

 arch/arm/boot/dts/imx28-apf28.dts              | 2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10037.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10057.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10058.dts           | 2 +-
 arch/arm/boot/dts/imx28-duckbill.dts           | 2 +-
 arch/arm/boot/dts/imx28-evk.dts                | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts             | 2 +-
 arch/arm/boot/dts/imx28.dtsi                   | 1 +
 arch/arm/boot/dts/imx50-evk.dts                | 2 +-
 arch/arm/boot/dts/imx50.dtsi                   | 1 +
 arch/arm/boot/dts/imx53-evk.dts                | 2 +-
 arch/arm/boot/dts/imx53-mba53.dts              | 2 +-
 arch/arm/boot/dts/imx53-qsb.dts                | 2 +-
 arch/arm/boot/dts/imx53-smd.dts                | 2 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi    | 2 +-
 arch/arm/boot/dts/imx53.dtsi                   | 1 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts        | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts           | 2 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi         | 2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                 | 1 +
 30 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 7198fe3..070e59c 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -78,7 +78,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 334dea5..d750846 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -155,7 +155,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac1_pins_a>;
-			phy-reset-gpios = <&gpio0 23 0>;
+			phy-reset-gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
index e5beaa5..3d13b32 100644
--- a/arch/arm/boot/dts/imx28-cfa10037.dts
+++ b/arch/arm/boot/dts/imx28-cfa10037.dts
@@ -64,7 +64,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a
 				&mac0_pins_cfa10037>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 7d51459..e3b964a 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -327,7 +327,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a
 				&mac0_pins_cfa10049>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index c4e00ce..fe23064 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -162,7 +162,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index 7c9cc78..0e17e3e 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -129,7 +129,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index 5f326c1..b2eb88e 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -82,7 +82,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
 			phy-supply = <&reg_3p3v>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e4cc44c..afadd47 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -264,7 +264,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
 			phy-supply = <&reg_fec_3v3>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 15f3b39..f960ede 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -189,7 +189,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index db44a0d..747bb21 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 #include "imx28-pinfunc.h"
 
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index a859264..1cafdea 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -54,7 +54,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 12 0>;
+	phy-reset-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 01c0499..207b714 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -14,6 +14,7 @@
 #include "skeleton.dtsi"
 #include "imx50-pingrp.h"
 #include <dt-bindings/clock/imx5-clock.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 214ac2e..82b3773 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -145,6 +145,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 0358366..3a5ec3e 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -183,7 +183,7 @@
 };
 
 &fec {
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 4c04459..35334e3 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -338,7 +338,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index e84decf..4d28bbd 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -217,6 +217,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index 04a2895..19a3289 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -101,7 +101,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 2 0>;
+	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 90359da..ccf8bb6 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -13,6 +13,7 @@
 #include "skeleton.dtsi"
 #include "imx53-pingrp.h"
 #include <dt-bindings/clock/imx5-clock.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 84f5143..5791260 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -64,7 +64,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 0>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 5f76342..18df522 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -153,7 +153,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index 05b4796..dea52ff 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -174,7 +174,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 0>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index fb29da0..7f81df9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -91,7 +91,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index a6c77b5..ceb5d43 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -138,7 +138,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 35028a5..92506b1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -147,7 +147,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 34b26b9..609d85b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -137,7 +137,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 30 0>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index c1be487..f23ed67 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -16,7 +16,7 @@
 	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
 	phy-mode = "rgmii";
 	phy-reset-duration = <2>;
-	phy-reset-gpios = <&gpio4 15 0>;
+	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index e83ffc7..d75dc0d 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -152,7 +152,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 27 0>;
+	phy-reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
 	txen-skew-ps = <0>;
 	txc-skew-ps = <3000>;
 	rxdv-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 91e5dd4..10b912b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -132,7 +132,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 88894b1..c290017 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -142,7 +142,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 29 0>;
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 8948016..ac948fc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
-- 
1.8.1.2
