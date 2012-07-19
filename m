From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu, 19 Jul 2012 21:31:00 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Describe DNS32? gpio-keys in DT.
In-Reply-To: <1342729860-14647-1-git-send-email-jm@lentin.co.uk>
References: <y>
 <1342729860-14647-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1342729860-14647-5-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move description of GPIO keys on both the DNS320 and DNS325 into DT.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |   21 +++++++++++++++++++
 arch/arm/mach-kirkwood/board-dnskw.c  |   37 ---------------------------------
 2 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 067672c..2bad626 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -4,6 +4,27 @@
 	model = "D-Link DNS NASes (kirkwood-based)";
 	compatible = "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "Power button";
+			linux,code = <116>;
+			gpios = <&gpio1 2 1>;
+		};
+		button at 2 {
+			label = "USB unmount button";
+			linux,code = <161>;
+			gpios = <&gpio1 15 1>;
+		};
+		button at 3 {
+			label = "Reset button";
+			linux,code = <0x198>;
+			gpios = <&gpio1 16 1>;
+		};
+	};
+
 	ocp at f1000000 {
 		sata at 80000 {
 			status = "okay";
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index aac9c90..4ab3506 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -19,7 +19,6 @@
 #include <linux/of.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
-#include <linux/gpio_keys.h>
 #include <linux/gpio-fan.h>
 #include <linux/leds.h>
 #include <asm/mach-types.h>
@@ -68,41 +67,6 @@ static unsigned int dnskw_mpp_config[] __initdata = {
 	0
 };
 
-static struct gpio_keys_button dnskw_button_pins[] = {
-	{
-		.code		= KEY_POWER,
-		.gpio		= 34,
-		.desc		= "Power button",
-		.active_low	= 1,
-	},
-	{
-		.code		= KEY_EJECTCD,
-		.gpio		= 47,
-		.desc		= "USB unmount button",
-		.active_low	= 1,
-	},
-	{
-		.code		= KEY_RESTART,
-		.gpio		= 48,
-		.desc		= "Reset button",
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_platform_data dnskw_button_data = {
-	.buttons	= dnskw_button_pins,
-	.nbuttons	= ARRAY_SIZE(dnskw_button_pins),
-};
-
-static struct platform_device dnskw_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &dnskw_button_data,
-	}
-};
-
 /* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
 static struct gpio_fan_speed dnskw_fan_speed[] = {
 	{    0,  0 },
@@ -150,7 +114,6 @@ void __init dnskw_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
 
-	platform_device_register(&dnskw_button_device);
 	platform_device_register(&dnskw_fan_device);
 
 	/* Register power-off GPIO. */
-- 
1.7.10.4
