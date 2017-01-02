From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 14:59:07 +0000
Subject: [PATCH 6/9] ARM: dts: armada388-clearfog: move SPI CS1
In-Reply-To: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
References: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO44p-00082p-F7@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the SPI CS1 configuration to the clearfog .dts file as this is only
present on pro models.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts  | 14 ++++++++++++++
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 10 ++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index 1ee953112d23..b56ce4a32519 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -179,4 +179,18 @@
 		marvell,pins = "mpp23", "mpp41";
 		marvell,function = "gpio";
 	};
+	clearfog_spi1_cs_pins: spi1-cs-pins {
+		marvell,pins = "mpp55";
+		marvell,function = "spi1";
+	};
+};
+
+&spi1 {
+	/*
+	 * Add SPI CS pins for clearfog:
+	 * CS0: W25Q32 (not populated on uSOM)
+	 * CS1:
+	 * CS2: mikrobus
+	 */
+	pinctrl-0 = <&spi1_pins &clearfog_spi1_cs_pins &mikro_spi_pins>;
 };
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index ef4fbc6db7cf..30b75379377a 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -227,10 +227,6 @@
 					marvell,pins = "mpp20";
 					marvell,function = "gpio";
 				};
-				clearfog_spi1_cs_pins: spi1-cs-pins {
-					marvell,pins = "mpp55";
-					marvell,function = "spi1";
-				};
 				mikro_pins: mikro-pins {
 					/* int: mpp22 rst: mpp29 */
 					marvell,pins = "mpp22", "mpp29";
@@ -323,12 +319,10 @@
 	/*
 	 * Add SPI CS pins for clearfog:
 	 * CS0: W25Q32 (not populated on uSOM)
-	 * CS1:
+	 * CS1: PIC microcontroller (Pro models)
 	 * CS2: mikrobus
 	 */
-	pinctrl-0 = <&spi1_pins
-		     &clearfog_spi1_cs_pins
-		     &mikro_spi_pins>;
+	pinctrl-0 = <&spi1_pins &mikro_spi_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.7.4
