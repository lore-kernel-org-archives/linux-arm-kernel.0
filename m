From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 10:15:39 +0100
Subject: [PATCH 2/9 v2] ARM: at91: dt: enable usb ohci for sam9g20,
 sam9g45 amd sam9x5
In-Reply-To: <20120307084924.GK21255@game.jcrosoft.org>
References: <20120307084924.GK21255@game.jcrosoft.org>
Message-ID: <1331111746-21393-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9g25ek.dts    |    8 ++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    6 ++++++
 arch/arm/boot/dts/at91sam9x5.dtsi      |    7 +++++++
 arch/arm/boot/dts/usb_a9g20.dts        |    5 +++++
 arch/arm/mach-at91/at91sam9260.c       |    1 +
 arch/arm/mach-at91/at91sam9g45.c       |    1 +
 arch/arm/mach-at91/at91sam9x5.c        |    4 +++-
 9 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index f803f31..8c5c175 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -188,6 +188,13 @@
 				>;
 			status = "disabled";
 		};
+
+		usb0: ohci at 00500000 {
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+			reg = <0x00500000 0x100000>;
+			interrupts = <20 4>;
+			status = "disabled";
+		};
 	};
 
 	i2c-gpio at 0 {
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index c7596bf..93d5e36 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -33,5 +33,13 @@
 				status = "okay";
 			};
 		};
+
+		usb0: ohci at 00600000 {
+			status = "okay";
+			num-ports = <2>;
+			atmel,vbus-gpio = <&pioD 19 0
+					   &pioD 20 0
+					  >;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 93e095b..db9a51a 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -196,6 +196,13 @@
 				>;
 			status = "disabled";
 		};
+
+		usb0: ohci at 00700000 {
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+			reg = <0x00700000 0x100000>;
+			interrupts = <22 4>;
+			status = "disabled";
+		};
 	};
 
 	i2c-gpio at 0 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 62ceffe..ce4640e 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -57,7 +57,13 @@
 				label = "data";
 				reg = <0x4000000 0xC000000>;
 			};
+		};
 
+		usb0: ohci at 00700000 {
+			status = "okay";
+			num-ports = <2>;
+			atmel,vbus-gpio = <&pioD 1 0
+					   &pioD 3 0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index ad9570b..7b43014 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -187,6 +187,13 @@
 				>;
 			status = "disabled";
 		};
+
+		usb0: ohci at 00600000 {
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+			reg = <0x00600000 0x100000>;
+			interrupts = <22 4>;
+			status = "disabled";
+		};
 	};
 
 	i2c-gpio at 0 {
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 07012ca..55d0e54 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -73,6 +73,11 @@
 				reg = <0x7ca0000 0x8360000>;
 			};
 		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <2>;
+			status = "okay";
+		};
 	};
 
 	leds {
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 14b5a9c..d1e5750 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -216,6 +216,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "fffdc000.timer", &tc3_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
+	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 0014573..f58775e 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -232,6 +232,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	/* more tc lookup table for DT entries */
 	CLKDEV_CON_DEV_ID("t0_clk", "fff7c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
+	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 7bec5a4..40888ab 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -131,7 +131,7 @@ static struct clk dma1_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 static struct clk uhphs_clk = {
-	.name		= "uhphs_clk",
+	.name		= "uhphs",
 	.pmc_mask	= 1 << AT91SAM9X5_ID_UHPHS,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
@@ -230,6 +230,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	/* additional fake clock for macb_hclk */
 	CLKDEV_CON_DEV_ID("hclk", "f802c000.ethernet", &macb0_clk),
 	CLKDEV_CON_DEV_ID("hclk", "f8030000.ethernet", &macb1_clk),
+	CLKDEV_CON_DEV_ID("hclk", "600000.ohci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("ohci_clk", "600000.ohci", &uhphs_clk),
 };
 
 /*
-- 
1.7.7
