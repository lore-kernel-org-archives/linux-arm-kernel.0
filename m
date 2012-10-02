From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Oct 2012 09:13:15 +0100
Subject: [PATCH 02/10] ARM: ux500: Strip out duplicate touch screen platform
 information
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349165603-24401-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're currently carrying two 'struct bu21013_platform_device's which
are identical for no apparent reason. Here we remove the extra burden
and apply the same information to the two different instances of the
bu21012_tp driver registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-stuib.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-stuib.c b/arch/arm/mach-ux500/board-mop500-stuib.c
index 8c97977..564f57d 100644
--- a/arch/arm/mach-ux500/board-mop500-stuib.c
+++ b/arch/arm/mach-ux500/board-mop500-stuib.c
@@ -162,18 +162,6 @@ static struct bu21013_platform_device tsc_plat_device = {
 	.y_flip = true,
 };
 
-static struct bu21013_platform_device tsc_plat2_device = {
-	.cs_en = bu21013_gpio_board_init,
-	.cs_dis = bu21013_gpio_board_exit,
-	.irq_read_val = bu21013_read_pin_val,
-	.irq = NOMADIK_GPIO_TO_IRQ(TOUCH_GPIO_PIN),
-	.touch_x_max = TOUCH_XMAX,
-	.touch_y_max = TOUCH_YMAX,
-	.ext_clk = false,
-	.x_flip = false,
-	.y_flip = true,
-};
-
 static struct i2c_board_info __initdata u8500_i2c3_devices_stuib[] = {
 	{
 		I2C_BOARD_INFO("bu21013_tp", 0x5C),
@@ -181,21 +169,17 @@ static struct i2c_board_info __initdata u8500_i2c3_devices_stuib[] = {
 	},
 	{
 		I2C_BOARD_INFO("bu21013_tp", 0x5D),
-		.platform_data = &tsc_plat2_device,
+		.platform_data = &tsc_plat_device,
 	},
 
 };
 
 void __init mop500_stuib_init(void)
 {
-	if (machine_is_hrefv60()) {
+	if (machine_is_hrefv60())
 		tsc_plat_device.cs_pin = HREFV60_TOUCH_RST_GPIO;
-		tsc_plat2_device.cs_pin = HREFV60_TOUCH_RST_GPIO;
-	} else {
+	else
 		tsc_plat_device.cs_pin = GPIO_BU21013_CS;
-		tsc_plat2_device.cs_pin = GPIO_BU21013_CS;
-
-	}
 
 	mop500_uib_i2c_add(0, mop500_i2c0_devices_stuib,
 			ARRAY_SIZE(mop500_i2c0_devices_stuib));
-- 
1.7.9.5
