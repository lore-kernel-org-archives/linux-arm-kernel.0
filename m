From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 15:08:49 +0100
Subject: [PATCH 2/3] ARM: Kirkwood: Convert NSA310 to use gpio-poweroff driver
In-Reply-To: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
References: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
Message-ID: <1356703730-4926-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the C code and add a Device Tree node for gpio-poweroff.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-nsa310.dts |    5 +++++
 arch/arm/mach-kirkwood/board-nsa310.c |   33 ---------------------------------
 2 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 2dc1d09..85cce36 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -142,6 +142,11 @@
 		};
 	};
 
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio1 16 0>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index d04184d..7a56273 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -19,8 +18,6 @@
 #include "common.h"
 #include "mpp.h"
 
-#define NSA310_GPIO_POWER_OFF		48
-
 static unsigned int nsa310_mpp_config[] __initdata = {
 	MPP12_GPIO, /* led esata green */
 	MPP13_GPIO, /* led esata red */
@@ -45,42 +42,12 @@ static struct i2c_board_info __initdata nsa310_i2c_info[] = {
 	{ I2C_BOARD_INFO("adt7476", 0x2e) },
 };
 
-static void nsa310_power_off(void)
-{
-	gpio_set_value(NSA310_GPIO_POWER_OFF, 1);
-}
-
-static int __init nsa310_gpio_request(unsigned int gpio, unsigned long flags,
-				       const char *label)
-{
-	int err;
-
-	err = gpio_request_one(gpio, flags, label);
-	if (err)
-		pr_err("NSA-310: can't setup GPIO%u (%s), err=%d\n",
-			gpio, label, err);
-
-	return err;
-}
-
-static void __init nsa310_gpio_init(void)
-{
-	int err;
-
-	err = nsa310_gpio_request(NSA310_GPIO_POWER_OFF, GPIOF_OUT_INIT_LOW,
-				  "Power Off");
-	if (!err)
-		pm_power_off = nsa310_power_off;
-}
-
 void __init nsa310_init(void)
 {
 	u32 dev, rev;
 
 	kirkwood_mpp_conf(nsa310_mpp_config);
 
-	nsa310_gpio_init();
-
 	kirkwood_pcie_id(&dev, &rev);
 
 	i2c_register_board_info(0, ARRAY_AND_SIZE(nsa310_i2c_info));
-- 
1.7.10.4
