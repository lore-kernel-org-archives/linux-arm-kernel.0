From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:46 +0200
Subject: [PATCH 11/16] ARM: Kirkwood: Describe iConnects temperature sensor in
 DT.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have I2C support in DT, describe the LM63 in
the DT file for the iConnect.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-iconnect.dts |    8 ++++++++
 arch/arm/mach-kirkwood/board-iconnect.c |   10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 1ba75d4..a7dd07b 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -18,6 +18,14 @@
 	};
 
 	ocp at f1000000 {
+		i2c at 11000 {
+			status = "okay";
+
+			lm63: lm63 at 4c {
+				compatible = "national,lm63";
+				reg = <0x4c>;
+			};
+		};
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "ok";
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index b0d3cc4..df043aa 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -20,7 +20,6 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
-#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <asm/mach/arch.h>
@@ -90,12 +89,6 @@ static unsigned int iconnect_mpp_config[] __initdata = {
 	0
 };
 
-static struct i2c_board_info __initdata iconnect_board_info[] = {
-	{
-		I2C_BOARD_INFO("lm63", 0x4c),
-	},
-};
-
 static struct mtd_partition iconnect_nand_parts[] = {
 	{
 		.name = "flash",
@@ -142,9 +135,6 @@ void __init iconnect_init(void)
 {
 	kirkwood_mpp_conf(iconnect_mpp_config);
 	kirkwood_nand_init(ARRAY_AND_SIZE(iconnect_nand_parts), 25);
-	kirkwood_i2c_init();
-	i2c_register_board_info(0, iconnect_board_info,
-		ARRAY_SIZE(iconnect_board_info));
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&iconnect_ge00_data);
-- 
1.7.10
