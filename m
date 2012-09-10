From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 10 Sep 2012 14:51:52 +0100
Subject: [PATCH V2 2/2] ARM: kirkwood: Use devicetree to define DNS-32[05] fan
In-Reply-To: <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1347285112-13542-3-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove more board-specific code by using devicetree to define the fan
attached to both boards.

Changes since V1:-
* Remove now-useless gpio-fan.h [Andrew Lunn]

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |   10 ++++++++++
 arch/arm/mach-kirkwood/board-dnskw.c  |   26 --------------------------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 7408655..9b32d02 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -25,6 +25,16 @@
 		};
 	};
 
+	gpio_fan {
+		/* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
+		compatible = "gpio-fan";
+		gpios = <&gpio1 14 1
+			 &gpio1 13 1>;
+		gpio-fan,speed-map = <0    0
+				      3000 1
+				      6000 2>;
+	};
+
 	ocp at f1000000 {
 		sata at 80000 {
 			status = "okay";
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 4ab3506..6ac7a8d 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
-#include <linux/gpio-fan.h>
 #include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -67,29 +66,6 @@ static unsigned int dnskw_mpp_config[] __initdata = {
 	0
 };
 
-/* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
-static struct gpio_fan_speed dnskw_fan_speed[] = {
-	{    0,  0 },
-	{ 3000,	 1 },
-	{ 6000,	 2 },
-};
-static unsigned dnskw_fan_pins[] = {46, 45};
-
-static struct gpio_fan_platform_data dnskw_fan_data = {
-	.num_ctrl	= ARRAY_SIZE(dnskw_fan_pins),
-	.ctrl		= dnskw_fan_pins,
-	.num_speed	= ARRAY_SIZE(dnskw_fan_speed),
-	.speed		= dnskw_fan_speed,
-};
-
-static struct platform_device dnskw_fan_device = {
-	.name	= "gpio-fan",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &dnskw_fan_data,
-	},
-};
-
 static void dnskw_power_off(void)
 {
 	gpio_set_value(36, 1);
@@ -114,8 +90,6 @@ void __init dnskw_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
 
-	platform_device_register(&dnskw_fan_device);
-
 	/* Register power-off GPIO. */
 	if (gpio_request(36, "dnskw:power:off") == 0
 	    && gpio_direction_output(36, 0) == 0)
-- 
1.7.10.4
