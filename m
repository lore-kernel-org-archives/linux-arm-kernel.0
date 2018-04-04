From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  4 Apr 2018 15:16:24 +0200
Subject: [PATCH 1/4] ARM: imx: vpr200: drop at24_platform_data
In-Reply-To: <20180404131627.9135-1-brgl@bgdev.pl>
References: <20180404131627.9135-1-brgl@bgdev.pl>
Message-ID: <20180404131627.9135-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The information contained in the platform data struct is redundant.

Page size == 1 is the safe default assumed if no pagesize property is
given. The EEPROM size can be indicated to the driver using the
correct model name.

Drop the at24_platform_data entirely.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/mach-imx/mach-vpr200.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 5ff154c9a086..da3336aaa4c5 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -29,7 +29,6 @@
 #include <asm/mach/time.h>
 
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/mfd/mc13xxx.h>
 
 #include "common.h"
@@ -145,15 +144,9 @@ static const struct imxi2c_platform_data vpr200_i2c0_data __initconst = {
 	.bitrate = 50000,
 };
 
-static struct at24_platform_data vpr200_eeprom = {
-	.byte_len = 2048 / 8,
-	.page_size = 1,
-};
-
 static struct i2c_board_info vpr200_i2c_devices[] = {
 	{
-		I2C_BOARD_INFO("at24", 0x50), /* E0=0, E1=0, E2=0 */
-		.platform_data = &vpr200_eeprom,
+		I2C_BOARD_INFO("24c02", 0x50), /* E0=0, E1=0, E2=0 */
 	}, {
 		I2C_BOARD_INFO("mc13892", 0x08),
 		.platform_data = &vpr200_pmic,
-- 
2.16.3
