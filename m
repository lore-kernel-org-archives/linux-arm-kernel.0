From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 09:51:06 +0100
Subject: [PATCH v3 3/3] ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff.
In-Reply-To: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353142266-1289-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts |    6 ++++++
 arch/arm/mach-kirkwood/board-ib62x0.c |   13 -------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 66794ed..6a9558d 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -79,4 +79,10 @@
 			gpios = <&gpio0 27 0>;
 		};
 	};
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 24 0>;
+	};
+
+
 };
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index cfc47f8..7b8adf5 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -17,7 +17,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/gpio.h>
 #include <linux/input.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -25,8 +24,6 @@
 #include "common.h"
 #include "mpp.h"
 
-#define IB62X0_GPIO_POWER_OFF	24
-
 static struct mv643xx_eth_platform_data ib62x0_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
@@ -49,11 +46,6 @@ static unsigned int ib62x0_mpp_config[] __initdata = {
 	0
 };
 
-static void ib62x0_power_off(void)
-{
-	gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
-}
-
 void __init ib62x0_init(void)
 {
 	/*
@@ -63,9 +55,4 @@ void __init ib62x0_init(void)
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&ib62x0_ge00_data);
-	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
-	    gpio_direction_output(IB62X0_GPIO_POWER_OFF, 0) == 0)
-		pm_power_off = ib62x0_power_off;
-	else
-		pr_err("board-ib62x0: failed to configure power-off GPIO\n");
 }
-- 
1.7.10.4
