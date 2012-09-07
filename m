From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri,  7 Sep 2012 17:34:35 +0100
Subject: [PATCH 2/2] ARM: kirkwood: Use devicetree to define DNS-32[05] fan
In-Reply-To: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1347035675-23907-3-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove more board-specific code by using devicetree to define the fan
attached to both boards.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |   10 ++++++++++
 arch/arm/mach-kirkwood/board-dnskw.c  |   25 -------------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

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
index 4ab3506..e202a07 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -67,29 +67,6 @@ static unsigned int dnskw_mpp_config[] __initdata = {
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
@@ -114,8 +91,6 @@ void __init dnskw_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
 
-	platform_device_register(&dnskw_fan_device);
-
 	/* Register power-off GPIO. */
 	if (gpio_request(36, "dnskw:power:off") == 0
 	    && gpio_direction_output(36, 0) == 0)
-- 
1.7.10.4
