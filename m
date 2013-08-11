From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 11 Aug 2013 15:26:49 +0100
Subject: [PATCH 1/2] Convert power recovery pin to a fixed regulator
In-Reply-To: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
References: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1376231210-6484-2-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dnskw_gpio_register() is broken, and probably has been for a while,
since dnskw_init() is called too early to register GPIOs. Instead use a
fixed regulator to turn the pin high, which knows to defer the
registration until later.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi | 13 +++++++++++++
 arch/arm/mach-kirkwood/board-dnskw.c  | 15 ---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index d544f77..9e74127 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -217,6 +217,19 @@
 			regulator-boot-on;
 			gpio = <&gpio1 8 0>;
 		};
+		power_back_on: regulator at 3 {
+			/* Turning this pin high means the NAS will turn on
+			immediately after a power failure. */
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "Recover after power failure";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 5 0>;
+			enable-active-high;
+		};
 	};
 };
 
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 2af7a95..0b441b9 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -14,23 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
 #include "common.h"
 
-/* Register any GPIO for output and set the value */
-static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
-{
-	if (gpio_request(gpio, name) == 0 &&
-	    gpio_direction_output(gpio, 0) == 0) {
-		gpio_set_value(gpio, def);
-		if (gpio_export(gpio, 0) != 0)
-			pr_err("dnskw: Failed to export GPIO %s\n", name);
-	} else
-		pr_err("dnskw: Failed to register %s\n", name);
-}
-
 void __init dnskw_init(void)
 {
-	/* Set NAS to turn back on after a power failure */
-	dnskw_gpio_register(37, "dnskw:power:recover", 1);
 }
-- 
1.8.3.1
