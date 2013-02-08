From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  8 Feb 2013 02:25:54 +0100
Subject: [PATCH 1/3] ARM: at91: add TWI bindings to RM9200 DT
In-Reply-To: <1360286756-29705-1-git-send-email-manabian@gmail.com>
References: <1360286756-29705-1-git-send-email-manabian@gmail.com>
Message-ID: <1360286756-29705-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 20 ++++++++++++++++++++
 arch/arm/mach-at91/at91rm9200.c   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index b0268a5..a7031c6 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -29,6 +29,7 @@
 		gpio3 = &pioD;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2c0 = &i2c0;
 		ssc0 = &ssc0;
 		ssc1 = &ssc1;
 		ssc2 = &ssc2;
@@ -91,6 +92,17 @@
 				interrupts = <20 4 0 21 4 0 22 4 0>;
 			};
 
+			i2c0: i2c at fffb8000 {
+				compatible = "atmel,at91rm9200-i2c";
+				reg = <0xfffb8000 0x4000>;
+				interrupts = <12 4 6>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_twi>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			mmc0: mmc at fffb4000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfffb4000 0x4000>;
@@ -365,6 +377,14 @@
 					};
 				};
 
+				twi {
+					pinctrl_twi: twi-0 {
+						atmel,pins =
+							<0 25 0x1 0x2	/* PA25 periph A with multi drive */
+							 0 26 0x1 0x2>;	/* PA26 periph A with multi drive */
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 9706c00..36b05fc 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -212,6 +212,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t2_clk", "fffa4000.timer", &tc5_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "fffb4000.mmc", &mmc_clk),
 	CLKDEV_CON_DEV_ID("emac_clk", "fffbc000.ethernet", &ether_clk),
+	CLKDEV_CON_DEV_ID(NULL, "fffb8000.i2c", &twi_clk),
 	CLKDEV_CON_DEV_ID("hclk", "300000.ohci", &ohci_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
-- 
1.8.0
