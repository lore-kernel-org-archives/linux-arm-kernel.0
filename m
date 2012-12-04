From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  4 Dec 2012 19:10:59 +0100
Subject: [PATCH 4/4] ARM: at91: add EMAC bindings to RM9200 DT
In-Reply-To: <1354644659-31385-1-git-send-email-manabian@gmail.com>
References: <1354644659-31385-1-git-send-email-manabian@gmail.com>
Message-ID: <1354644659-31385-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek.dts |  5 +++++
 arch/arm/mach-at91/at91rm9200.c    |  1 +
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 6ff27bb..b0268a5 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -127,6 +127,16 @@
 				status = "disable";
 			};
 
+			macb0: ethernet at fffbc000 {
+				compatible = "cdns,at91rm9200-emac", "cdns,emac";
+				reg = <0xfffbc000 0x4000>;
+				interrupts = <24 4 3>;
+				phy-mode = "rmii";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_macb_rmii>;
+				status = "disabled";
+			};
+
 			pinctrl at fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -246,6 +256,34 @@
 					};
 				};
 
+				macb {
+					pinctrl_macb_rmii: macb_rmii-0 {
+						atmel,pins =
+							<0 7 0x1 0x0	/* PA7 periph A */
+							 0 8 0x1 0x0	/* PA8 periph A */
+							 0 9 0x1 0x0	/* PA9 periph A */
+							 0 10 0x1 0x0	/* PA10 periph A */
+							 0 11 0x1 0x0	/* PA11 periph A */
+							 0 12 0x1 0x0	/* PA12 periph A */
+							 0 13 0x1 0x0	/* PA13 periph A */
+							 0 14 0x1 0x0	/* PA14 periph A */
+							 0 15 0x1 0x0	/* PA15 periph A */
+							 0 16 0x1 0x0>;	/* PA16 periph A */
+					};
+
+					pinctrl_macb_rmii_mii: macb_rmii_mii-0 {
+						atmel,pins =
+							<1 12 0x2 0x0	/* PB12 periph B */
+							 1 13 0x2 0x0	/* PB13 periph B */
+							 1 14 0x2 0x0	/* PB14 periph B */
+							 1 15 0x2 0x0	/* PB15 periph B */
+							 1 16 0x2 0x0	/* PB16 periph B */
+							 1 17 0x2 0x0	/* PB17 periph B */
+							 1 18 0x2 0x0	/* PB18 periph B */
+							 1 19 0x2 0x0>;	/* PB19 periph B */
+					};
+				};
+
 				mmc0 {
 					pinctrl_mmc0_clk: mmc0_clk-0 {
 						atmel,pins =
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index 8aa4893..e586d85 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -44,6 +44,11 @@
 				status = "okay";
 			};
 
+			macb0: ethernet at fffbc000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
 			usb1: gadget at fffb0000 {
 				atmel,vbus-gpio = <&pioD 4 0>;
 				status = "okay";
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index ffb339b..41e86e3 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -208,6 +208,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "fffa4000.timer", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "fffa4000.timer", &tc5_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "fffb4000.mmc", &mmc_clk),
+	CLKDEV_CON_DEV_ID("emac_clk", "fffbc000.ethernet", &ether_clk),
 	CLKDEV_CON_DEV_ID("hclk", "300000.ohci", &ohci_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
-- 
1.8.0
