From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Nov 2015 10:22:59 +0100
Subject: [PATCH] ARM: ux500: Assign proper sensore IRQs for Snowball
Message-ID: <1446715379-4374-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Snowball gyro and magnetometer DRDY (data ready) lines are used
as interrupt triggers by the IIO subsystem, triggering new data
retrieveal on edges on this signal. Thus assign them as the primary
interrupt in the device tree. The "other interrupt" coming out of
the sensors is for alarms and similar complex events, the DRDY is
for periodic measures, which is what we want.

After this the generic_buffer tool from IIO tools gives a nice
stream of readings after enabling the desired channels in sysfs.

Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index e80e42163883..08f82077b64d 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -281,7 +281,8 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&magneto_snowball_mode>;
-				gpios = <&gpio5 5 0x4>; /* DRDY line */
+				interrupt-parent = <&gpio5>;
+				interrupts = <5 IRQ_TYPE_EDGE_RISING>; /* DRDY line */
 			};
 			l3g4200d at 68 {
 				/* Gyroscope */
@@ -292,9 +293,9 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&gyro_snowball_mode>;
-				gpios = <&gpio5 6 0x4>; /* DRDY line */
 				interrupt-parent = <&gpio5>;
-				interrupts = <9 IRQ_TYPE_EDGE_RISING>; /* INT1 */
+				interrupts = <6 IRQ_TYPE_EDGE_RISING>, /* DRDY line */
+					     <9 IRQ_TYPE_EDGE_RISING>; /* INT1 */
 			};
 			lsp001wm at 5c {
 				/* Barometer/pressure sensor */
-- 
2.4.3
