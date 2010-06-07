From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  7 Jun 2010 07:27:53 +0200
Subject: [PATCH 2/2] pxa/spitz: Add isl6271a voltage regulator
In-Reply-To: <1275888473-22512-1-git-send-email-marek.vasut@gmail.com>
References: <1275888473-22512-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275888473-22512-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index c1048a3..5767ceb 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -26,6 +26,7 @@
 #include <linux/spi/corgi_lcd.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -709,6 +710,34 @@ static struct platform_device sharpsl_rom_device = {
 	.dev.platform_data = &sharpsl_rom_data,
 };
 
+static struct regulator_consumer_supply isl6271a_consumers[] = {
+	{
+		.supply	= "vcc_core",
+	}
+};
+
+static struct regulator_init_data isl6271a_info[] = {
+	{
+		.constraints = {
+			.name		= "vcc_core range",
+			.min_uV		= 850000,
+			.max_uV		= 1600000,
+			.always_on	= 1,
+			.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		},
+		.consumer_supplies	= isl6271_consumers,
+		.num_consumer_supplies	= ARRAY_SIZE(isl6271_consumers),
+	}
+};
+
+static struct i2c_board_info spitz_pi2c_board_info[] = {
+	{
+		.type		= "isl6271a",
+		.addr		= 0x1b,
+		.platform_data	= &isl6271_info,
+	},
+};
+
 static struct platform_device *devices[] __initdata = {
 	&spitzscoop_device,
 	&spitzkbd_device,
@@ -765,6 +794,9 @@ static void __init common_init(void)
 	pxa_set_ficp_info(&spitz_ficp_platform_data);
 	set_pxa_fb_info(&spitz_pxafb_info);
 	pxa_set_i2c_info(NULL);
+
+	pxa27x_set_i2c_power_info(NULL);
+	i2c_register_board_info(1, ARRAY_AND_SIZE(spitz_pi2c_board_info));
 }
 
 #if defined(CONFIG_MACH_AKITA) || defined(CONFIG_MACH_BORZOI)
-- 
1.7.1
