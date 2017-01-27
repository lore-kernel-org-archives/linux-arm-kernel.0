From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 27 Jan 2017 17:15:16 +0100
Subject: [PATCH 3/8] Documentation: dt: Add bindings for STM32 pinctrl
In-Reply-To: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485533721-9019-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds "ngpios" and "gpio-ranges" bindings definition.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index b24583a..25d9809 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -37,8 +37,23 @@ Optional properties:
  - st,syscfg: Should be phandle/offset pair. The phandle to the syscon node
    which includes IRQ mux selection register, and the offset of the IRQ mux
    selection register.
+ - ngpios: Number of gpios in a bank (to use if bank gpio numbers is less
+   than 16).
+ - gpio-ranges: Define a dedicated mapping between a pin-controller and
+   a gpio controller. Format is <&phandle a b c> with:
+	-(phandle): phandle of pin-controller.
+	-(a): gpio base offset in range.
+	-(b): pin base offset in range.
+	-(c): gpio count in range
+   This entry has to be used either if there are holes inside a bank:
+	GPIOB0/B1/B2/B14/B15 (see example 2)
+   or if banks are not contiguous:
+	GPIOA/B/C/E...
+   NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
+   have to use a "gpio-ranges" entry.
+   More details in Documentation/devicetree/bindings/gpio/gpio.txt.
 
-Example:
+Example 1:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
 ...
 
@@ -60,6 +75,43 @@ Example:
 		pin-functions nodes follow...
 	};
 
+Example 2:
+#include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+...
+
+	pinctrl: pin-controller {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,stm32f429-pinctrl";
+		ranges = <0 0x40020000 0x3000>;
+		pins-are-numbered;
+
+		gpioa: gpio at 40020000 {
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0x0 0x400>;
+			resets = <&reset_ahb1 0>;
+			st,bank-name = "GPIOA";
+			gpio-ranges = <&pinctrl 0 0 16>;
+		};
+
+		gpiob: gpio at 40020400 {
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0x0 0x400>;
+			resets = <&reset_ahb1 0>;
+			st,bank-name = "GPIOB";
+			ngpios = 4;
+			gpio-ranges = <&pinctrl 0 16 3>,
+				      <&pinctrl 14 30 2>;
+		};
+
+
+		...
+		pin-functions nodes follow...
+	};
+
+
 Contents of function subnode node:
 ----------------------------------
 Subnode format
-- 
1.9.1
