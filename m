From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:01:59 +0200
Subject: [PATCH 02/14] at91: regroup gpio and pinctrl under a simple-bus
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix also the reg size as we have 512 bytes bank not 256 bytes per gpio/mux
controller

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |   54 ++++++++++++---------
 arch/arm/boot/dts/at91sam9263.dtsi |   93 +++++++++++++++++++-----------------
 arch/arm/boot/dts/at91sam9g45.dtsi |   87 ++++++++++++++++++---------------
 arch/arm/boot/dts/at91sam9n12.dtsi |   76 ++++++++++++++++-------------
 arch/arm/boot/dts/at91sam9x5.dtsi  |   70 +++++++++++++++------------
 5 files changed, 210 insertions(+), 170 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 66389c1..4aa155d 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -97,31 +97,39 @@
 				interrupts = <26 4 0 27 4 0 28 4 0>;
 			};
 
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+			pinctrl at fffff400 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				reg = <0xfffff400 0x600>;
+
+				pioA: gpio at fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+				pioB: gpio at fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
+				pioC: gpio at fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 			};
 
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index b460d6c..f1c838e 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -88,49 +88,56 @@
 				reg = <0xfffffd10 0x10>;
 			};
 
-			pioA: gpio at fffff200 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioB: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioC: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioD: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioE: gpio at fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
+			pinctrl at fffff200 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				reg = <0xfffff200 0xa00>;
+
+				pioA: gpio at fffff200 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioB: gpio at fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioC: gpio at fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioD: gpio at fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioE: gpio at fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
 			};
 
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index bafa880..f04bc8d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -106,49 +106,58 @@
 				interrupts = <21 4 0>;
 			};
 
-			pioA: gpio at fffff200 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+			pinctrl at fffff200 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+
+				reg = <0xfffff200 0xa00>;
+
+				pioA: gpio at fffff200 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioB: gpio at fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+				pioB: gpio at fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioC: gpio at fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <4 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+				pioC: gpio at fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <4 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioD: gpio at fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <5 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+				pioD: gpio at fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <5 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioE: gpio at fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <5 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
+				pioE: gpio at fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <5 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 			};
 
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index bfac0df..575c891 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -100,40 +100,48 @@
 				interrupts = <20 4 0>;
 			};
 
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
-
-			pioD: gpio at fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
+			pinctrl at fffff400 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				reg = <0xfffff400 0x800>;
+
+				pioA: gpio at fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioB: gpio at fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioC: gpio at fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
+
+				pioD: gpio at fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 			};
 
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 4a18c39..8c314d5 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -108,40 +108,48 @@
 				interrupts = <21 4 0>;
 			};
 
-			pioA: gpio at fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+			pinctrl at fffff200 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
+				reg = <0xfffff400 0x800>;
+
+				pioA: gpio at fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioB: gpio at fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <2 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+				pioB: gpio at fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <2 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioC: gpio at fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-			};
+				pioC: gpio at fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 
-			pioD: gpio at fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <3 4 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
+				pioD: gpio at fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <3 4 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+				};
 			};
 
 			dbgu: serial at fffff200 {
-- 
1.7.10.4
