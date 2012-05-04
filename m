From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  4 May 2012 23:45:29 +0800
Subject: [PATCH 4/4] ARM: mxs: add gpio support for device tree boot
In-Reply-To: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
References: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336146329-3821-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds gpio support for device tree boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |   35 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx28.dtsi |   55 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-mxs/mach-mxs.c |   12 +++++++++
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 7761ed0..8c83bc4 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -14,6 +14,12 @@
 / {
 	interrupt-parent = <&icoll>;
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+	};
+
 	cpus {
 		cpu at 0 {
 			compatible = "arm,arm926ejs";
@@ -72,8 +78,35 @@
 			};
 
 			pinctrl at 80018000 {
+				compatible = "fsl,imx23-pinctrl", "simple-bus";
 				reg = <0x80018000 2000>;
-				status = "disabled";
+
+				gpio0: gpio at 0 {
+					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
+					interrupts = <16>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio1: gpio at 1 {
+					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
+					interrupts = <17>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio2: gpio at 2 {
+					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
+					interrupts = <18>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 
 			digctl at 8001c000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e75c5b0..6e03e58 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -14,6 +14,14 @@
 / {
 	interrupt-parent = <&icoll>;
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+	};
+
 	cpus {
 		cpu at 0 {
 			compatible = "arm,arm926ejs";
@@ -95,8 +103,53 @@
 			};
 
 			pinctrl at 80018000 {
+				compatible = "fsl,imx28-pinctrl", "simple-bus";
 				reg = <0x80018000 2000>;
-				status = "disabled";
+
+				gpio0: gpio at 0 {
+					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					interrupts = <127>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio1: gpio at 1 {
+					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					interrupts = <126>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio2: gpio at 2 {
+					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					interrupts = <125>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio3: gpio at 3 {
+					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					interrupts = <124>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				gpio4: gpio at 4 {
+					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					interrupts = <123>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 
 			digctl at 8001c000 {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index ae07c9d..309f781 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -26,8 +26,20 @@ static int __init mxs_icoll_add_irq_domain(struct device_node *np,
 	return 0;
 }
 
+static int __init mxs_gpio_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	static int gpio_irq_base = MXS_GPIO_IRQ_START;
+
+	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops, NULL);
+	gpio_irq_base += 32;
+
+	return 0;
+}
+
 static const struct of_device_id mxs_irq_match[] __initconst = {
 	{ .compatible = "fsl,mxs-icoll", .data = mxs_icoll_add_irq_domain, },
+	{ .compatible = "fsl,mxs-gpio", .data = mxs_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
-- 
1.7.5.4
