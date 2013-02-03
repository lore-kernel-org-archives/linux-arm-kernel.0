From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Feb 2013 10:55:39 +0100
Subject: [PATCH] gpio: mvebu: Add clk support to prevent lockup
Message-ID: <1359885339-14858-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kirkwood SoC GPIO cores use the tclk. Add code to
clk_prepare_enable() tclk, otherwise there is a danger of locking up
the SoC by accessing the GPIO registers when tclk is not ticking.

Reported-by: Simon Baatz <gmbnomis@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi |    2 ++
 drivers/gpio/gpio-mvebu.c       |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index d6ab442..6c5d75f 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -38,6 +38,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupts = <35>, <36>, <37>, <38>;
+			clocks = <&gate_clk 7>;
 		};
 
 		gpio1: gpio at 10140 {
@@ -49,6 +50,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupts = <39>, <40>, <41>;
+			clocks = <&gate_clk 7>;
 		};
 
 		serial at 12000 {
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6819d63..456663c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -41,6 +41,7 @@
 #include <linux/io.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 
 /*
@@ -495,6 +496,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	struct clk *clk;
 	unsigned int ngpios;
 	int soc_variant;
 	int i, cpu, id;
@@ -528,6 +530,11 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 		return id;
 	}
 
+	clk = devm_clk_get(&pdev->dev, NULL);
+	/* Not all SoCs require a clock.*/
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
+
 	mvchip->soc_variant = soc_variant;
 	mvchip->chip.label = dev_name(&pdev->dev);
 	mvchip->chip.dev = &pdev->dev;
-- 
1.7.10.4
