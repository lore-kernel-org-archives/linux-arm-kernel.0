From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Jan 2012 16:27:51 +0100
Subject: [PATCH 3/3] ARM: at91: sam9g20 & sam9g45 add spi DT support
In-Reply-To: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1327937271-23668-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam9m10g45ek:
	add dataflash support
usb_a9g20:
	add mmc spi support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/at91sam9g20.dtsi     |   14 ++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |   14 ++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   21 +++++++++++++++++++++
 arch/arm/boot/dts/usb_a9g20.dts        |   11 +++++++++++
 arch/arm/mach-at91/at91sam9260.c       |    2 ++
 arch/arm/mach-at91/at91sam9g45.c       |    2 ++
 6 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 2b4f7e4..1fc569b 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -202,6 +202,20 @@
 				status = "disabled";
 			};
 
+			spi0: spi at fffc8000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffc8000 0x4000>;
+				interrupts = <12>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffcc000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffcc000 0x4000>;
+				interrupts = <13>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index be88fc5..9a08ab4 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -193,6 +193,20 @@
 				status = "disabled";
 			};
 
+			spi0: spi at fffa4000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa4000 0x4000>;
+				interrupts = <14>;
+				status = "disabled";
+			};
+
+			spi1: spi at fffa8000 {
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfffa8000 0x4000>;
+				interrupts = <15>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 30d9cd7..62cb7eb 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -58,6 +58,27 @@
 				};
 
 			};
+
+			spi0: spi at fffa4000 {
+				status = "okay";
+				flash: at45db321d at 0 {
+					compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+					ncs-gpio = <&pioB 3 0>;
+					spi-max-frequency = <15000000>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0x0 0x40000>;
+						read-only;
+					};
+
+					partition at 40000 {
+						label = "Kernel";
+						reg = <0x40000 0x3c0000>;
+					};
+				};
+			};
+
 		};
 	};
 
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index e6c7970..1dfb7a9 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -84,6 +84,17 @@
 				status = "okay";
 			};
 
+			spi1: spi at fffcc000 {
+				status = "okay";
+				mmc-slot at 0 {
+					compatible = "mmc-spi-slot";
+					ncs-gpio = <&pioB 3 0>;
+					gpios = <&pioC 4 0   /* CD */
+						>;
+					voltage-ranges = <3200 3400>;
+					spi-max-frequency = <20000000>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index fb5ddd4..f518493 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -211,6 +211,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fffd4000.serial", &usart4_clk),
 	CLKDEV_CON_DEV_ID("usart", "fffd8000.serial", &usart5_clk),
 	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffc8000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffcc000.spi", &spi1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 744b357..5fab92f 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -233,6 +233,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "fff98000.serial", &usart3_clk),
 	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
+	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
-- 
1.7.7
