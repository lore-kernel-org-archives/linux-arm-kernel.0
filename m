From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 13:23:08 +0100
Subject: [PATCH 3/4 v4] ARM: at91: sam9g20 add spi DT support
In-Reply-To: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
References: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1331122989-14451-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb_a9g20:
	add mmc spi support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi |   18 ++++++++++++++++++
 arch/arm/boot/dts/usb_a9g20.dts    |   13 +++++++++++++
 arch/arm/mach-at91/at91sam9260.c   |    2 ++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 3cb4226..aef3d5be 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -203,6 +203,24 @@
 				interrupts = <10 4>;
 				status = "disabled";
 			};
+
+			spi0: spi at fffc8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffc8000 0x4000>;
+				interrupts = <12 4>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffcc000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffcc000 0x4000>;
+				interrupts = <13 4>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 390c481..9efaff3 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -46,6 +46,19 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			spi1: spi at fffcc000 {
+				cs-gpios = <&pioB 3 0>;
+				status = "okay";
+				mmc-slot at 0 {
+					compatible = "mmc-spi-slot";
+					reg = <0>;
+					gpios = <&pioC 4 0   /* CD */
+						>;
+					voltage-ranges = <3200 3400>;
+					spi-max-frequency = <20000000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index d1e5750..c6e5d0f 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -217,6 +217,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
 	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.7
