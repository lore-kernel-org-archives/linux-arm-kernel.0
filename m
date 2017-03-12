From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 00:28:13 +0100
Subject: [PATCH 1/6] gpio: gemini: augment DT bindings
Message-ID: <20170312232818.26304-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT bindings assumed that this IP block was coming from
Cortina Systems, which turns out not to be true. It is a
standard IP block from Faraday Technology and also used in the
Moxa moxart SoC.

We augment the bindings to cover all existing parts and rename
it after the IP block. This involves deleting the old Moxa
bindings that now are contained in this binding.

Cc: devicetree at vger.kernel.org
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 ...{cortina,gemini-gpio.txt => faraday,ftgpio010.txt} |  9 ++++++---
 .../devicetree/bindings/gpio/moxa,moxart-gpio.txt     | 19 -------------------
 2 files changed, 6 insertions(+), 22 deletions(-)
 rename Documentation/devicetree/bindings/gpio/{cortina,gemini-gpio.txt => faraday,ftgpio010.txt} (70%)
 delete mode 100644 Documentation/devicetree/bindings/gpio/moxa,moxart-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
similarity index 70%
rename from Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt
rename to Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
index 5c9246c054e5..d04236558619 100644
--- a/Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
@@ -1,8 +1,11 @@
-Cortina Systems Gemini GPIO Controller
+Faraday Technology FTGPIO010 GPIO Controller
 
 Required properties:
 
-- compatible : Must be "cortina,gemini-gpio"
+- compatible : Should be one of
+  "cortina,gemini-gpio", "faraday,ftgpio010"
+  "moxa,moxart-gpio", "faraday,ftgpio010"
+  "faraday,ftgpio010"
 - reg : Should contain registers location and length
 - interrupts : Should contain the interrupt line for the GPIO block
 - gpio-controller : marks this as a GPIO controller
@@ -14,7 +17,7 @@ Required properties:
 Example:
 
 gpio at 4d000000 {
-	compatible = "cortina,gemini-gpio";
+	compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 	reg = <0x4d000000 0x100>;
 	interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 	gpio-controller;
diff --git a/Documentation/devicetree/bindings/gpio/moxa,moxart-gpio.txt b/Documentation/devicetree/bindings/gpio/moxa,moxart-gpio.txt
deleted file mode 100644
index f8e8f185a3db..000000000000
--- a/Documentation/devicetree/bindings/gpio/moxa,moxart-gpio.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-MOXA ART GPIO Controller
-
-Required properties:
-
-- #gpio-cells : Should be 2, The first cell is the pin number,
-		the second cell is used to specify polarity:
-			0 = active high
-			1 = active low
-- compatible : Must be "moxa,moxart-gpio"
-- reg : Should contain registers location and length
-
-Example:
-
-	gpio: gpio at 98700000 {
-		gpio-controller;
-		#gpio-cells = <2>;
-		compatible = "moxa,moxart-gpio";
-		reg =	<0x98700000 0xC>;
-	};
-- 
2.9.3
