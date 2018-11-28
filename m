From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 29 Nov 2018 00:48:40 +0200
Subject: [PATCH 1/2] dt-bindings: gpio: lpc18xx: describe interrupt
 controllers of GPIO controller
In-Reply-To: <20181128224841.3646-1-vz@mleia.com>
References: <20181128224841.3646-1-vz@mleia.com>
Message-ID: <20181128224841.3646-2-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From LPC18xx and LPC43xx User Manuals the GPIO controller consists of
the following weakly connected blocks:
* GPIO pin interrupt block at 0x40087000,
* GPIO GROUP0 interrupt block at 0x40088000,
* GPIO GROUP1 interrupt block at 0x40089000,
* GPIO port block at 0x400F4000.

While all 4 sub-controller blocks have their own I/O addresses, moreover
all 3 interrupt blocks are APB0 peripherals and high-speed GPIO block is
an AHB slave, according to the hardware manual interrupt controllers and
GPIO controller block are seen as a single device, all 4 sub-controllers
have the shared reset signal RGU #28 and the same shared clock to access
registers CLK_Mx_GPIO on CCU1.

The change adds descriptions of the currently missing interrupt controller
blocks found on GPIO controller, new added properties are 'reg-names',
'resets', 'interrupt-controller' and '#interrupt-cells', also the example
is updated to reflect the changes in device tree binding description.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../bindings/gpio/nxp,lpc1850-gpio.txt        | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt b/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
index eb7cdd69e10b..627efc78ecf2 100644
--- a/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
@@ -3,12 +3,24 @@ NXP LPC18xx/43xx GPIO controller Device Tree Bindings
 
 Required properties:
 - compatible		: Should be "nxp,lpc1850-gpio"
-- reg			: Address and length of the register set for the device
-- clocks		: Clock specifier (see clock bindings for details)
-- gpio-controller	: Marks the device node as a GPIO controller.
-- #gpio-cells 		: Should be two
-			  - First cell is the GPIO line number
-			  - Second cell is used to specify polarity
+- reg			: List of addresses and lengths of the GPIO controller
+			  register sets
+- reg-names		: Should be "gpio", "gpio-pin-ic", "gpio-group0-ic" and
+			  "gpio-gpoup1-ic"
+- clocks		: Phandle and clock specifier pair for GPIO controller
+- resets		: Phandle and reset specifier pair for GPIO controller
+- gpio-controller	: Marks the device node as a GPIO controller
+- #gpio-cells 		: Should be two:
+			  - The first cell is the GPIO line number
+			  - The second cell is used to specify polarity
+- interrupt-controller	: Marks the device node as an interrupt controller
+- #interrupt-cells	: Should be two:
+			  - The first cell is an interrupt number within
+			    0..9 range, for GPIO pin interrupts it is equal
+			    to 'nxp,gpio-pin-interrupt' property value of
+			    GPIO pin configuration, 8 is for GPIO GROUP0
+			    interrupt, 9 is for GPIO GROUP1 interrupt
+			  - The second cell is used to specify interrupt type
 
 Optional properties:
 - gpio-ranges		: Mapping between GPIO and pinctrl
@@ -19,21 +31,29 @@ Example:
 
 gpio: gpio at 400f4000 {
 	compatible = "nxp,lpc1850-gpio";
-	reg = <0x400f4000 0x4000>;
+	reg = <0x400f4000 0x4000>, <0x40087000 0x1000>,
+	      <0x40088000 0x1000>, <0x40089000 0x1000>;
+	reg-names = "gpio", "gpio-pin-ic",
+		    "gpio-group0-ic", "gpio-gpoup1-ic";
 	clocks = <&ccu1 CLK_CPU_GPIO>;
+	resets = <&rgu 28>;
 	gpio-controller;
 	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
 	gpio-ranges =	<&pinctrl LPC_GPIO(0,0)  LPC_PIN(0,0)  2>,
 			...
 			<&pinctrl LPC_GPIO(7,19) LPC_PIN(f,5)  7>;
 };
 
 gpio_joystick {
-	compatible = "gpio-keys-polled";
+	compatible = "gpio-keys";
 	...
 
-	button at 0 {
+	button0 {
 		...
+		interrupt-parent = <&gpio>;
+		interrupts = <1 IRQ_TYPE_EDGE_BOTH>;
 		gpios = <&gpio LPC_GPIO(4,8) GPIO_ACTIVE_LOW>;
 	};
 };
-- 
2.17.1
