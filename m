From: michael@walle.cc (Michael Walle)
Date: Sun, 21 Oct 2012 01:34:54 +0200
Subject: [PATCH 2/2] ARM: kirkwood: use gpio-fan DT binding on lsxl
In-Reply-To: <1350776094-16778-1-git-send-email-michael@walle.cc>
References: <1350776094-16778-1-git-send-email-michael@walle.cc>
Message-ID: <1350776094-16778-2-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove board specific gpio-fan driver registration. Moved into device tree.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi |   11 ++++++++
 arch/arm/mach-kirkwood/board-lsxl.c  |   47 ----------------------------------
 2 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 8fea375..798e60e 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -94,4 +94,15 @@
 			gpios = <&gpio1 16 1>;
 		};
 	};
+
+	gpio_fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio0 19 1
+		         &gpio0 18 1>;
+		gpio-fan,speed-map = <0    3
+		                      1500 2
+		                      3250 1
+		                      5000 0>;
+		alarm-gpios = <&gpio1 8 0>;
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index 64e5cc6..7e18cad 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
-#include <linux/gpio-fan.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -45,51 +44,6 @@ static unsigned int lsxl_mpp_config[] __initdata = {
 	0
 };
 
-#define LSXL_GPIO_FAN_HIGH	18
-#define LSXL_GPIO_FAN_LOW	19
-#define LSXL_GPIO_FAN_LOCK	40
-
-static struct gpio_fan_alarm lsxl_alarm = {
-	.gpio = LSXL_GPIO_FAN_LOCK,
-};
-
-static struct gpio_fan_speed lsxl_speeds[] = {
-	{
-		.rpm = 0,
-		.ctrl_val = 3,
-	}, {
-		.rpm = 1500,
-		.ctrl_val = 1,
-	}, {
-		.rpm = 3250,
-		.ctrl_val = 2,
-	}, {
-		.rpm = 5000,
-		.ctrl_val = 0,
-	}
-};
-
-static int lsxl_gpio_list[] = {
-	LSXL_GPIO_FAN_HIGH, LSXL_GPIO_FAN_LOW,
-};
-
-static struct gpio_fan_platform_data lsxl_fan_data = {
-	.num_ctrl = ARRAY_SIZE(lsxl_gpio_list),
-	.ctrl = lsxl_gpio_list,
-	.alarm = &lsxl_alarm,
-	.num_speed = ARRAY_SIZE(lsxl_speeds),
-	.speed = lsxl_speeds,
-};
-
-static struct platform_device lsxl_fan_device = {
-	.name = "gpio-fan",
-	.id = -1,
-	.num_resources = 0,
-	.dev = {
-		.platform_data = &lsxl_fan_data,
-	},
-};
-
 /*
  * On the LS-XHL/LS-CHLv2, the shutdown process is following:
  * - Userland monitors key events until the power switch goes to off position
@@ -120,7 +74,6 @@ void __init lsxl_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&lsxl_ge00_data);
 	kirkwood_ge01_init(&lsxl_ge01_data);
-	platform_device_register(&lsxl_fan_device);
 
 	/* register power-off method */
 	pm_power_off = lsxl_power_off;
-- 
1.7.2.5
