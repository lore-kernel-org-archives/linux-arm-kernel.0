From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 10:15:41 +0100
Subject: [PATCH 4/9] ARM: at91: dt: enable usb ehci for sam9g45 and sam9x5
In-Reply-To: <20120307084924.GK21255@game.jcrosoft.org>
References: <20120307084924.GK21255@game.jcrosoft.org>
Message-ID: <1331111746-21393-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts    |    4 ++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    4 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi      |    7 +++++++
 arch/arm/mach-at91/at91sam9g45.c       |    1 +
 arch/arm/mach-at91/at91sam9x5.c        |    1 +
 drivers/usb/Kconfig                    |    2 +-
 7 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 93d5e36..ac0dc00 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -41,5 +41,9 @@
 					   &pioD 20 0
 					  >;
 		};
+
+		usb1: ehci at 00700000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index db9a51a..4b54424 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -203,6 +203,13 @@
 			interrupts = <22 4>;
 			status = "disabled";
 		};
+
+		usb1: ehci at 00800000 {
+			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
+			reg = <0x00800000 0x100000>;
+			interrupts = <22 4>;
+			status = "disabled";
+		};
 	};
 
 	i2c-gpio at 0 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index ce4640e..4b1eb36 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -65,6 +65,10 @@
 			atmel,vbus-gpio = <&pioD 1 0
 					   &pioD 3 0>;
 		};
+
+		usb1: ehci at 00800000 {
+			status = "okay";
+		};
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 7b43014..ac3c96c 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -194,6 +194,13 @@
 			interrupts = <22 4>;
 			status = "disabled";
 		};
+
+		usb1: ehci at 00700000 {
+			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
+			reg = <0x00700000 0x100000>;
+			interrupts = <22 4>;
+			status = "disabled";
+		};
 	};
 
 	i2c-gpio at 0 {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index f58775e..df3bcea 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -233,6 +233,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "fff7c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 40888ab..7333276 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -232,6 +232,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("hclk", "f8030000.ethernet", &macb1_clk),
 	CLKDEV_CON_DEV_ID("hclk", "600000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ohci_clk", "600000.ohci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("ehci_clk", "700000.ehci", &uhphs_clk),
 };
 
 /*
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 75823a1..afee052 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -65,7 +65,7 @@ config USB_ARCH_HAS_EHCI
 	default y if PPC_MPC512x
 	default y if ARCH_IXP4XX
 	default y if ARCH_W90X900
-	default y if ARCH_AT91SAM9G45
+	default y if ARCH_AT91SAM9G45 || ARCH_AT91SAM9X5
 	default y if ARCH_MXC
 	default y if ARCH_OMAP3
 	default y if ARCH_CNS3XXX
-- 
1.7.7
