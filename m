From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:25:21 +0200
Subject: [PATCH 2/5] ARM: Kirkwood: Allow use of MVEBU GPIO driver.
In-Reply-To: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351088724-11142-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This GPIO driver is generic to all Marvel Orion/XP/370 SoCs. Allow
Kirkwood to enable and use it. Fix the kirkwood DT to pass the
expected properties and remove the old gpio probing code.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/boot/dts/kirkwood.dtsi |   11 +++++++++--
 arch/arm/plat-orion/irq.c       |    5 +----
 drivers/gpio/Kconfig            |    2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 160cd40..0203af8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -544,6 +544,7 @@ config ARCH_DOVE
 config ARCH_KIRKWOOD
 	bool "Marvell Kirkwood"
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
 	select PCI
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 4e5b815..5bc7a8b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -4,6 +4,11 @@
 	compatible = "marvell,kirkwood";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+	};
+
 	intc: interrupt-controller {
 		compatible = "marvell,orion-intc", "marvell,intc";
 		interrupt-controller;
@@ -24,7 +29,8 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0x10100 0x40>;
-			ngpio = <32>;
+			ngpios = <32>;
+			interrupt-controller;
 			interrupts = <35>, <36>, <37>, <38>;
 		};
 
@@ -33,7 +39,8 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0x10140 0x40>;
-			ngpio = <18>;
+			ngpios = <18>;
+			interrupt-controller;
 			interrupts = <39>, <40>, <41>;
 		};
 
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 1867944..eec296a 100644
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
@@ -55,9 +55,6 @@ static int __init orion_add_irq_domain(struct device_node *np,
 	irq_domain_add_legacy(np, i * 32, 0, 0,
 			      &irq_domain_simple_ops, NULL);
 
-	irq_gpio = i * 32;
-	orion_gpio_of_init(irq_gpio);
-
 	return 0;
 }
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d055cee..2155aef 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -152,7 +152,7 @@ config GPIO_MSM_V2
 
 config GPIO_MVEBU
 	def_bool y
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || ARCH_KIRKWOOD
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
-- 
1.7.10.4
