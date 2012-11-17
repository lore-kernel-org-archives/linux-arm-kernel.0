From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:44 +0100
Subject: [PATCH v2 02/14] ARM: Kirkwood: Make use of mvebu pincltl and gpio
 drivers
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the generic mvebu kirkwood pincltr driver and generic mvebu
gpio driver. This requires minor changes to the DT, and the calls to
configure plat-orion gpio driver are removed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Michael Walle <michael@walle.cc>
Tested-by: Simon Baatz <gmbnomis@gmail.com>
Tested-by: Jamie Lentin <jm@lentin.co.uk>
Tested-by: Joshua Coombs <josh.coombs@gmail.com>
---
 arch/arm/Kconfig                |    2 ++
 arch/arm/boot/dts/kirkwood.dtsi |   10 ++++++++--
 arch/arm/plat-orion/irq.c       |    6 +-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..bf1df2b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -547,6 +547,8 @@ config ARCH_KIRKWOOD
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
 	select PCI
+	select PINCTRL
+	select PINCTRL_KIRKWOOD
 	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 4e5b815..6f4a97a 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -4,6 +4,10 @@
 	compatible = "marvell,kirkwood";
 	interrupt-parent = <&intc>;
 
+	aliases {
+	       gpio0 = &gpio0;
+	       gpio1 = &gpio1;
+	};
 	intc: interrupt-controller {
 		compatible = "marvell,orion-intc", "marvell,intc";
 		interrupt-controller;
@@ -24,7 +28,8 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0x10100 0x40>;
-			ngpio = <32>;
+			ngpios = <32>;
+			interrupt-controller;
 			interrupts = <35>, <36>, <37>, <38>;
 		};
 
@@ -33,7 +38,8 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0x10140 0x40>;
-			ngpio = <18>;
+			ngpios = <18>;
+			interrupt-controller;
 			interrupts = <39>, <40>, <41>;
 		};
 
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 1867944..8db0b98 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -41,7 +41,7 @@ void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 static int __init orion_add_irq_domain(struct device_node *np,
 				       struct device_node *interrupt_parent)
 {
-	int i = 0, irq_gpio;
+	int i = 0;
 	void __iomem *base;
 
 	do {
@@ -54,10 +54,6 @@ static int __init orion_add_irq_domain(struct device_node *np,
 
 	irq_domain_add_legacy(np, i * 32, 0, 0,
 			      &irq_domain_simple_ops, NULL);
-
-	irq_gpio = i * 32;
-	orion_gpio_of_init(irq_gpio);
-
 	return 0;
 }
 
-- 
1.7.10.4
