From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 15:14:10 +0100
Subject: [PATCH 1/5] ARM: Kirkwood: Convert NS2 to gpio-poweroff.
Message-ID: <1356704050-5047-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove C code and add a Device Tree node in its place.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

This is untested. I've been known to get the active hi/low the wrong
way around so that the board powers off as the driver loads at boot
time. So it would be very good to have a tested-by: sign off.


 arch/arm/boot/dts/kirkwood-ns2-common.dtsi |    6 ++++++
 arch/arm/mach-kirkwood/board-ns2.c         |   14 --------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 9bc6785..58c4103 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -60,4 +60,10 @@
 			gpios = <&gpio0 12 0>;
 		};
 	};
+
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 31 0>;
+	};
+
 };
diff --git a/arch/arm/mach-kirkwood/board-ns2.c b/arch/arm/mach-kirkwood/board-ns2.c
index 8821720..f263449 100644
--- a/arch/arm/mach-kirkwood/board-ns2.c
+++ b/arch/arm/mach-kirkwood/board-ns2.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
 #include "common.h"
 #include "mpp.h"
@@ -59,13 +58,6 @@ static unsigned int ns2_mpp_config[] __initdata = {
 	0
 };
 
-#define NS2_GPIO_POWER_OFF	31
-
-static void ns2_power_off(void)
-{
-	gpio_set_value(NS2_GPIO_POWER_OFF, 1);
-}
-
 void __init ns2_init(void)
 {
 	/*
@@ -77,10 +69,4 @@ void __init ns2_init(void)
 	    of_machine_is_compatible("lacie,netspace_mini_v2"))
 		ns2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
 	kirkwood_ge00_init(&ns2_ge00_data);
-
-	if (gpio_request(NS2_GPIO_POWER_OFF, "power-off") == 0 &&
-	    gpio_direction_output(NS2_GPIO_POWER_OFF, 0) == 0)
-		pm_power_off = ns2_power_off;
-	else
-		pr_err("ns2: failed to configure power-off GPIO\n");
 }
-- 
1.7.10.4
