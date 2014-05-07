From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 May 2014 15:41:49 +0200
Subject: [PATCH] ARM: dt: fix up PL011 device tree bindings
Message-ID: <1399470109-8021-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the map match the reality, the current binding text is
nonsense:

- The clock required for the clocking of the serial port
  must come first and is not optional (as the driver will
  otherwise proceed to grab and use the apb_pclk as uartclk),
  and the apb_pclk that clocks the logic must come second
  as the code will retrieve the first clock by index,
  whereas the PrimeCell but will explicitly look for
  "apb_pclk" so this can be specified later, as it is
  looked up by name.

- The pin control state "default" is the only mandated
  state, the sleep state is entirely optional.

We also add an example to avoid further confusion.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/serial/pl011.txt | 25 ++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index 5d2e840ae65c..7a33d67c8349 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -6,12 +6,29 @@ Required properties:
 - interrupts: exactly one interrupt specifier
 
 Optional properties:
-- pinctrl: When present, must have one state named "sleep"
-	   and one state named "default"
-- clocks:  When present, must refer to exactly one clock named
-	   "apb_pclk"
+- pinctrl: When present, must have one state named "default",
+	   and may contain a second name named "sleep". The former
+	   state sets up pins for ordinary operation whereas
+	   the latter state will put the associated pins to sleep
+	   when the UART is unused
+- clocks:  When present, the first clock listed must be named
+	   "uartclk" and clock the external serial line, and the
+	   second clock listed must be named "amba_pclk" and clocks
+	   the internal logic of the serial core
 - dmas:	   When present, may have one or two dma channels.
 	   The first one must be named "rx", the second one
 	   must be named "tx".
 
 See also bindings/arm/primecell.txt
+
+Example:
+
+uart at 80120000 {
+	compatible = "arm,pl011", "arm,primecell";
+	reg = <0x80120000 0x1000>;
+	interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&dma 13 0 0x2>, <&dma 13 0 0x0>;
+	dma-names = "rx", "tx";
+	clocks = <&foo_clk>, <&bar_clk>;
+	clock-names = "uartclk", "apb_pclk";
+};
-- 
1.9.0
