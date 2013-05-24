From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:49 +0200
Subject: [PATCH 12/21] arm: kirkwood: keymile: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the pinmux mechanism was added in Kirkwood, the device driver
core was not yet providing the possibility of attaching pinmux
configurations to all devices, drivers had to do it explicitly, and
not all drivers were doing this.

Now that the driver core does that in a generic way, it makes sense to
attach the pinmux configuration to their corresponding devices.

This allows the pinctrl subsystem to show in debugfs to which device
is related which pins, for example:

pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Note: not sure what the pmx_i2c_gpio_sda and pmx_i2c_gpio_scl pinmux
configurations are for. Certainly for an I2C bus bit-banged over
GPIOs, but I don't see where such an I2C bus is declared in the Device
Tree.
---
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index 5bbd054..66b971b 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -18,9 +18,7 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-
-			pinctrl-0 = < &pmx_nand &pmx_i2c_gpio_sda
-				&pmx_i2c_gpio_scl >;
+			pinctrl-0 = < &pmx_i2c_gpio_sda &pmx_i2c_gpio_scl >;
 			pinctrl-names = "default";
 
 			pmx_i2c_gpio_sda: pmx-gpio-sda {
@@ -38,6 +36,8 @@
 		};
 
 		nand at 3000000 {
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 			status = "ok";
 			chip-delay = <25>;
 		};
-- 
1.7.9.5
