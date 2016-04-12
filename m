From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Apr 2016 15:05:44 +0200
Subject: [PATCH] ARM: dts: ux500: configure the accelerometers open drain
Message-ID: <1460466344-17516-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the two accelerometers sharing GPIO line 82 as:

- Open drain so that they can share the same interrupt line.

Configure the corresponding interrupt pin:

- Trigger on the falling edge since open drain implies that we
  do not actively drive the line high, but we will actively drive
  it low to generate interrupts and then it moves from high to low
  i.e. a falling edge.

- Pulled up so the line will be biased to high unless an IRQ
  is active on any device on the line, and thus it goes high
  again after the interrupt is deasserted.

Cc: linux-iio at vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 55f9d0cc90f3..4e94a4197b18 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -93,14 +93,15 @@
 				/* Accelerometer */
 				compatible = "st,lsm303dlh-accel";
 				st,drdy-int-pin = <1>;
+				int-pin-open-drain;
 				reg = <0x18>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_tvk_mode>;
 				interrupt-parent = <&gpio2>;
-				interrupts = <18 IRQ_TYPE_EDGE_RISING>,
-					     <19 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <18 IRQ_TYPE_EDGE_FALLING>,
+					     <19 IRQ_TYPE_EDGE_FALLING>;
 			};
 			lsm303dlh at 1e {
 				/*
@@ -118,14 +119,15 @@
 				/* Accelerometer */
 				compatible = "st,lis331dl-accel";
 				st,drdy-int-pin = <1>;
+				int-pin-open-drain;
 				reg = <0x1c>;
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&accel_tvk_mode>;
 				interrupt-parent = <&gpio2>;
-				interrupts = <18 IRQ_TYPE_EDGE_RISING>,
-					     <19 IRQ_TYPE_EDGE_RISING>;
+				interrupts = <18 IRQ_TYPE_EDGE_FALLING>,
+					     <19 IRQ_TYPE_EDGE_FALLING>;
 			};
 			ak8974 at 0f {
 				/* Magnetometer */
@@ -216,7 +218,7 @@
 					/* Accelerometer interrupt lines 1 & 2 */
 					tvk_cfg {
 						pins = "GPIO82_C1", "GPIO83_D3";
-						ste,config = <&gpio_in_pd>;
+						ste,config = <&gpio_in_pu>;
 					};
 				};
 			};
-- 
2.4.3
