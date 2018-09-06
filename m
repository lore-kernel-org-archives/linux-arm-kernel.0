From: stefan@agner.ch (Stefan Agner)
Date: Thu,  6 Sep 2018 16:46:58 -0700
Subject: [PATCH] ARM: dts: imx6q-apalis: mux RESET_MOCI# signal
Message-ID: <20180906234658.12205-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl properties on the IOMUXC node get overwritten by the
carrier board level device tree, hence the pinctrl_reset_moci
pinctrl does not get applied.

Associate the pinctrl_reset_moci pinctrl with the PCIe node where
we also make use of the pin as a reset GPIO.

Since the pin is muxed as a GPIO by default not muxing it explicitly
worked fine in practise.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 2 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 4 ----
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 707ac9a46115..0edd3043d9c1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -196,6 +196,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
 	/* active-high meaning opposite of regular PERST# active-low polarity */
 	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 	reset-gpio-active-high;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 4e1c8feaef82..b94bb687be6b 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -196,6 +196,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
 	/* active-high meaning opposite of regular PERST# active-low polarity */
 	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 	reset-gpio-active-high;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 469e3d0e2827..302fd6adc8a7 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -200,6 +200,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
 	/* active-high meaning opposite of regular PERST# active-low polarity */
 	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 	reset-gpio-active-high;
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 05f07ea3e8c8..3dc99dd8dde1 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -482,10 +482,6 @@
 };
 
 &iomuxc {
-	/* pins used on module */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_reset_moci>;
-
 	pinctrl_apalis_gpio1: gpio2io04grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D4__GPIO2_IO04 0x130b0
-- 
2.18.0
