From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Sep 2017 11:39:05 +0200
Subject: [PATCH 6/7] dt-bindings: i2c: i2c-gpio: Add support for named gpios
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Message-ID: <20170917093906.16325-7-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas () glider ! be>

The current i2c-gpio DT bindings use a single unnamed "gpios" property
to refer to the SDA and SCL signal lines by index.  This is error-prone
for the casual DT writer and reviewer, as one has to look up the order
in the DT bindings.

Fix this by amending the DT bindings to use two separate named gpios
properties, and deprecate the old unnamed variant.

Take this opportunity to clearly deprecate the "i2c-gpio,sda-open-drain"
and "i2c-gpio,scl-open-drain" flags as well. The commit describes
in detail what these flags actually mean, and why they should not be
used in new device trees.

Cc: devicetree at vger.kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Augmented to what I and Rob would like]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Create a special section for the deprecated bindings
- Also deprecate the open drain bool properties
- Update the example to use the new style of bindings
---
 Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 32 ++++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
index 4f8ec947c6bd..38a05562d1d2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
@@ -2,25 +2,39 @@ Device-Tree bindings for i2c gpio driver
 
 Required properties:
 	- compatible = "i2c-gpio";
-	- gpios: sda and scl gpio
-
+	- sda-gpios: gpio used for the sda signal, this should be flagged as
+	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
+	  open drain.
+	- scl-gpios: gpio used for the scl signal, this should be flagged as
+	  active high using open drain with (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)
+	  from <dt-bindings/gpio/gpio.h> since the signal is by definition
+	  open drain.
 
 Optional properties:
-	- i2c-gpio,sda-open-drain: sda as open drain
-	- i2c-gpio,scl-open-drain: scl as open drain
 	- i2c-gpio,scl-output-only: scl as output only
 	- i2c-gpio,delay-us: delay between GPIO operations (may depend on each platform)
 	- i2c-gpio,timeout-ms: timeout to get data
 
+Deprecated properties, do not use in new device tree sources:
+	- gpios: sda and scl gpio, alternative for {sda,scl}-gpios
+	- i2c-gpio,sda-open-drain: this means that something outside of our
+	  control has put the GPIO line used for SDA into open drain mode, and
+	  that something is not the GPIO chip. It is essentially an
+	  inconsistency flag.
+	- i2c-gpio,scl-open-drain: this means that something outside of our
+	  control has put the GPIO line used for SCL into open drain mode, and
+	  that something is not the GPIO chip. It is essentially an
+	  inconsistency flag.
+
 Example nodes:
 
+#include <dt-bindings/gpio/gpio.h>
+
 i2c at 0 {
 	compatible = "i2c-gpio";
-	gpios = <&pioA 23 0 /* sda */
-		 &pioA 24 0 /* scl */
-		>;
-	i2c-gpio,sda-open-drain;
-	i2c-gpio,scl-open-drain;
+	sda-gpios = <&pioA 23 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&pioA 24 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 	i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.13.5
