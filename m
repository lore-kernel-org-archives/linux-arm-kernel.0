From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 12:40:25 -0600
Subject: [PATCH V2 1/5] gpio: clean up gpio-ranges documentation
Message-ID: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This change makes documentation of the the gpio-ranges property shorter
and more succinct, more consistent with the style of the rest of the
document, and not mention Linux-specifics such as the API
pinctrl_request_gpio(); DT binding documents should be OS independant
where at all possible.

This change also removes any mention of the #gpio-range-cells property.
Such properties are useful when one node references a second node, and
that second node dictates the format of the reference. However, that is
not the case here; the definition of gpio-ranges itself always dictates
its format entirely, and hence the value #gpio-range-cells must always
be 3, and hence there is no point requiring any referenced node to
include this property.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Patches 2-6 need to be applied in the same branch, since they all build
upon each-other.
---
 Documentation/devicetree/bindings/gpio/gpio.txt | 48 ++++++++++++-------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index d933af3..b262378 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -75,23 +75,29 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
 		gpio-controller;
 	};
 
-2.1) gpio-controller and pinctrl subsystem
-------------------------------------------
+2.1) gpio- and pin-controller interaction
+-----------------------------------------
 
-gpio-controller on a SOC might be tightly coupled with the pinctrl
-subsystem, in the sense that the pins can be used by other functions
-together with optional gpio feature.
+Some or all of the GPIOs provided by a GPIO controller may be routed to pins
+on the package via a pin controller. This allows muxing those pins between
+GPIO and other functions.
 
-While the pin allocation is totally managed by the pin ctrl subsystem,
-gpio (under gpiolib) is still maintained by gpio drivers. It may happen
-that different pin ranges in a SoC is managed by different gpio drivers.
+It is useful to represent which GPIOs correspond to which pins on which pin
+controllers. The gpio-ranges property described below represents this, and
+contains information strucutres as follows:
 
-This makes it logical to let gpio drivers announce their pin ranges to
-the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
-request the corresponding pin before any gpio usage.
+	gpio-range-list ::= <single-gpio-range> [gpio-range-list]
+	single-gpio-range ::=
+			<pinctrl-phandle> <gpio-base> <pinctrl-base> <count>
+	gpio-phandle : phandle to pin controller node.
+	gpio-base : Base GPIO ID in the GPIO controller
+	pinctrl-base : Base pinctrl pin ID in the pin controller
+	count : The number of GPIOs/pins in this range
 
-For this, the gpio controller can use a pinctrl phandle and pins to
-announce the pinrange to the pin ctrl subsystem. For example,
+The "pin controller node" mentioned above must conform to the bindings
+described in ../pinctrl/pinctrl-bindings.txt.
+
+Example:
 
 	qe_pio_e: gpio-controller at 1460 {
 		#gpio-cells = <2>;
@@ -99,16 +105,8 @@ announce the pinrange to the pin ctrl subsystem. For example,
 		reg = <0x1460 0x18>;
 		gpio-controller;
 		gpio-ranges = <&pinctrl1 0 20 10>, <&pinctrl2 10 50 20>;
+	};
 
-    }
-
-where,
-   &pinctrl1 and &pinctrl2 is the phandle to the pinctrl DT node.
-
-   Next values specify the base pin and number of pins for the range
-   handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
-   pin 29 under pinctrl1 with gpio offset 0 and pin 50 to pin 69 under
-   pinctrl2 with gpio offset 10 is handled by this gpio controller.
-
-The pinctrl node must have "#gpio-range-cells" property to show number of
-arguments to pass with phandle from gpio controllers node.
+Here, a single GPIO controller has GPIOs 0..9 routed to pin controller
+pinctrl1's pins 20..29, and GPIOs 10..19 routed to pin controller pinctrl2's
+pins 50..59.
-- 
1.8.1.5
