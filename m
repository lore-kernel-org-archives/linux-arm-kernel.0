From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:25:24 +0200
Subject: [PATCH 5/5] ARM: Dove: Make use of MVEBU GPIO driver
In-Reply-To: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351088724-11142-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

The MVEBU driver is generic to all Marvell Orion/XP/370 SoCs. Allow
Dove DT to enable and use it. Also fix dove DT to pass the expected
properties and add gpio aliases.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/Kconfig            |    1 +
 arch/arm/boot/dts/dove.dtsi |   14 +++++++++++---
 drivers/gpio/Kconfig        |    2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b12d1dd..bde1015 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -533,6 +533,7 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 1617c0c..f101323 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -4,6 +4,12 @@
 	compatible = "marvell,dove";
 	model = "Marvell Armada 88AP510 SoC";
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+	};
+
 	soc at f1000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -77,7 +83,8 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0xd0400 0x20>;
-			ngpio = <32>;
+			ngpios = <32>;
+			interrupt-controller;
 			interrupts = <12>, <13>, <14>, <60>;
 		};
 
@@ -86,7 +93,8 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0xd0420 0x20>;
-			ngpio = <32>;
+			ngpios = <32>;
+			interrupt-controller;
 			interrupts = <61>;
 		};
 
@@ -95,7 +103,7 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 			reg = <0xe8400 0x0c>;
-			ngpio = <8>;
+			ngpios = <8>;
 		};
 
 		spi0: spi at 10600 {
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2155aef..2a0c1e1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -152,7 +152,7 @@ config GPIO_MSM_V2
 
 config GPIO_MVEBU
 	def_bool y
-	depends on ARCH_MVEBU || ARCH_KIRKWOOD
+	depends on ARCH_MVEBU || ARCH_KIRKWOOD || ARCH_DOVE
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
-- 
1.7.10.4
