From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  2 May 2015 23:11:35 +0200
Subject: [PATCH v2 2/2] doc: dt: add documentation for lpc1850-gpio driver
In-Reply-To: <1430601095-31984-1-git-send-email-manabian@gmail.com>
References: <1430601095-31984-1-git-send-email-manabian@gmail.com>
Message-ID: <1430601095-31984-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/gpio/nxp,lpc1850-gpio.txt  | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt b/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
new file mode 100644
index 000000000000..eb7cdd69e10b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
@@ -0,0 +1,39 @@
+NXP LPC18xx/43xx GPIO controller Device Tree Bindings
+-----------------------------------------------------
+
+Required properties:
+- compatible		: Should be "nxp,lpc1850-gpio"
+- reg			: Address and length of the register set for the device
+- clocks		: Clock specifier (see clock bindings for details)
+- gpio-controller	: Marks the device node as a GPIO controller.
+- #gpio-cells 		: Should be two
+			  - First cell is the GPIO line number
+			  - Second cell is used to specify polarity
+
+Optional properties:
+- gpio-ranges		: Mapping between GPIO and pinctrl
+
+Example:
+#define LPC_GPIO(port, pin)	(port * 32 + pin)
+#define LPC_PIN(port, pin)	(0x##port * 32 + pin)
+
+gpio: gpio at 400f4000 {
+	compatible = "nxp,lpc1850-gpio";
+	reg = <0x400f4000 0x4000>;
+	clocks = <&ccu1 CLK_CPU_GPIO>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	gpio-ranges =	<&pinctrl LPC_GPIO(0,0)  LPC_PIN(0,0)  2>,
+			...
+			<&pinctrl LPC_GPIO(7,19) LPC_PIN(f,5)  7>;
+};
+
+gpio_joystick {
+	compatible = "gpio-keys-polled";
+	...
+
+	button at 0 {
+		...
+		gpios = <&gpio LPC_GPIO(4,8) GPIO_ACTIVE_LOW>;
+	};
+};
-- 
1.8.0
