From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:01 +0200
Subject: [PATCH 04/16] at91: regroup gpio and pinctrl under the same ranges
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix also the reg size as we have 512 bytes bank not 256 bytes per gpio/mux
controller

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   59 ++++++++++++---------
 arch/arm/boot/dts/at91sam9263.dtsi |  102 +++++++++++++++++++-----------------
 arch/arm/boot/dts/at91sam9g45.dtsi |   95 +++++++++++++++++----------------
 arch/arm/boot/dts/at91sam9n12.dtsi |   83 +++++++++++++++--------------
 arch/arm/boot/dts/at91sam9x5.dtsi  |   77 ++++++++++++++-------------
 5 files changed, 225 insertions(+), 191 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 7c95f76..3ae7abcd 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -97,34 +97,41 @@
 				interrupts = <26 4 0 27 4 0 28 4 0>;
 			};
 
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+			pinctrl at fffff400 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				ranges = <0xfffff400 0xfffff400 0x600>;
+
+				pioA: gpio at fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+				pioB: gpio at fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
+				pioC: gpio at fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 195019b..ff882a6 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -88,54 +88,60 @@
 				reg = <0xfffffd10 0x10>;
 			};
 
-			pioA: gpio at fffff200 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioB: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioC: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioD: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioE: gpio at fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
+			pinctrl at fffff200 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				ranges = <0xfffff200 0xfffff200 0xa00>;
+
+				pioA: gpio at fffff200 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioB: gpio at fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioC: gpio at fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioD: gpio at fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioE: gpio at fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
 			};
 
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 63751b1..990f2b1 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -106,54 +106,61 @@
 				interrupts = <21 4 0>;
 			};
 
-			pioA: gpio at fffff200 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+			pinctrl at fffff200 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				ranges = <0xfffff200 0xfffff200 0xa00>;
+
+				pioA: gpio at fffff200 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioB: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+				pioB: gpio at fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioC: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+				pioC: gpio at fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioD: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <5 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+				pioD: gpio at fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <5 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioE: gpio at fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <5 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
+				pioE: gpio at fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <5 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index ef9336a..29706bd 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -100,44 +100,51 @@
 				interrupts = <20 4 0>;
 			};
 
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			pioD: gpio at fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
+			pinctrl at fffff400 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				ranges = <0xfffff400 0xfffff400 0x800>;
+
+				pioA: gpio at fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioB: gpio at fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioC: gpio at fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
+
+				pioD: gpio at fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 8a387a8..bc6cd3f 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -108,44 +108,51 @@
 				interrupts = <21 4 0>;
 			};
 
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+			pinctrl at fffff200 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				ranges = <0xfffff400 0xfffff400 0x800>;
+
+				pioA: gpio at fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+				pioB: gpio at fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
+				pioC: gpio at fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 
-			pioD: gpio at fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
+				pioD: gpio at fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+				};
 			};
 
 			dbgu: serial at fffff200 {
-- 
1.7.10.4
