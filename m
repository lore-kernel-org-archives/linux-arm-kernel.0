From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 10:15:46 +0100
Subject: [PATCH 9/9] ARM: at91: sam9x5 add udc DT support
In-Reply-To: <20120307084924.GK21255@game.jcrosoft.org>
References: <20120307084924.GK21255@game.jcrosoft.org>
Message-ID: <1331111746-21393-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts |    5 +++
 arch/arm/boot/dts/at91sam9x5.dtsi   |   67 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9x5.c     |    2 +
 3 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index ac0dc00..8e949d3 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,11 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			usb2: gadget at f803c000 {
+				atmel,vbus-gpio = <&pioB 16 0>;
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00600000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index ac3c96c..0579698 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -171,6 +171,73 @@
 				interrupts = <27 4>;
 				status = "disabled";
 			};
+
+			usb2: gadget at f803c000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91sam9rl-udc";
+				reg = <0x00500000 0x80000
+				       0xf803c000 0x400>;
+				interrupts = <23 4>;
+				status = "disabled";
+
+				ep0 {
+					reg = <0>;
+					atmel,fifo-size = <64>;
+					atmel,nb-banks = <1>;
+					atmel,can-dma = <0>;
+					atmel,can-isoc = <0>;
+				};
+
+				ep1 {
+					reg = <1>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <2>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+
+				ep2 {
+					reg = <2>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <2>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+
+				ep3 {
+					reg = <3>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <0>;
+				};
+
+				ep4 {
+					reg = <4>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <0>;
+				};
+
+				ep5 {
+					reg = <5>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+
+				ep6 {
+					reg = <6>;
+					atmel,fifo-size = <1024>;
+					atmel,nb-banks = <3>;
+					atmel,can-dma = <1>;
+					atmel,can-isoc = <1>;
+				};
+			};
+
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 7333276..66f2cb5 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -233,6 +233,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("hclk", "600000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ohci_clk", "600000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ehci_clk", "700000.ehci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("hclk", "500000.gadget", &utmi_clk),
+	CLKDEV_CON_DEV_ID("pclk", "500000.gadget", &udphs_clk),
 };
 
 /*
-- 
1.7.7
