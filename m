From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 13:23:09 +0100
Subject: [PATCH 4/4 v4] ARM: at91: sam9g45 add spi DT support
In-Reply-To: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
References: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1331122989-14451-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam9m10g45ek:
	add dataflash support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     |   18 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   23 +++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9g45.c       |    2 ++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 7a685f9..8a11530 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -271,6 +271,24 @@
 					atmel,can-isoc = <1>;
 				};
 			};
+
+			spi0: spi at fffa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x4000>;
+				interrupts = <14 4>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffa8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x4000>;
+				interrupts = <15 4>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index b9382e3..2b96ab2 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -51,6 +51,29 @@
 				atmel,vbus-gpio = <&pioB 19 0>;
 				status = "okay";
 			};
+
+			spi0: spi at fffa4000 {
+				cs-gpios = <&pioB 3 0>;
+				status = "okay";
+				flash: at45db321d at 0 {
+					compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+					reg = <0>;
+					spi-max-frequency = <15000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0x0 0x40110>;
+						read-only;
+					};
+
+					partition at 40110 {
+						label = "Kernel";
+						reg = <0x40110 0x3dfef0>;
+					};
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index da80f0c..06547bf 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -236,6 +236,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("hclk", "600000.gadget", &utmi_clk),
 	CLKDEV_CON_DEV_ID("pclk", "600000.gadget", &udphs_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.7
