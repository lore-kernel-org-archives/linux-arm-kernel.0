From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 17 Apr 2014 17:53:11 +0200
Subject: [PATCH 2/5] ARM: Kirkwood: Use DT to instansiate codec
In-Reply-To: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
Message-ID: <1397749994-24983-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ALC5623 codec has a DT binding, instansiate it using DT
rather than a platform device.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-t5325.dts |  8 ++++++++
 arch/arm/mach-mvebu/board-t5325.c    | 15 ---------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 0bd70d928c69..dbb730642543 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -127,6 +127,14 @@
 
 		i2c at 11000 {
 			status = "okay";
+
+			alc5621: alc5621 at 1a {
+				compatible = "realtek,alc5621";
+				reg = <0x1a>;
+				#sound-dai-cells = <0>;
+				add-ctrl = <0x3700>;
+				jack-det-ctrl = <0x4810>;
+			};
 		};
 
 		serial at 12000 {
diff --git a/arch/arm/mach-mvebu/board-t5325.c b/arch/arm/mach-mvebu/board-t5325.c
index 65ace6db9f28..f2401b298218 100644
--- a/arch/arm/mach-mvebu/board-t5325.c
+++ b/arch/arm/mach-mvebu/board-t5325.c
@@ -11,10 +11,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <sound/alc5623.h>
 #include "board.h"
 
 static struct platform_device hp_t5325_audio_device = {
@@ -22,20 +20,7 @@ static struct platform_device hp_t5325_audio_device = {
 	.id		= -1,
 };
 
-static struct alc5623_platform_data alc5621_data = {
-	.add_ctrl = 0x3700,
-	.jack_det_ctrl = 0x4810,
-};
-
-static struct i2c_board_info i2c_board_info[] __initdata = {
-	{
-		I2C_BOARD_INFO("alc5621", 0x1a),
-		.platform_data = &alc5621_data,
-	},
-};
-
 void __init t5325_init(void)
 {
-	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
 	platform_device_register(&hp_t5325_audio_device);
 }
-- 
1.9.2
