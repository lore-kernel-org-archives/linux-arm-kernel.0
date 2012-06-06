From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:35:19 +0200
Subject: [PATCH 6/7] ARM: nomadik: register the I2C devices
Message-ID: <1339018519-29190-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board data to register all the Nomadik I2C devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/board-nhk8815.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 43b844e..029a741 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/i2c.h>
 #include <linux/io.h>
 #include <asm/hardware/vic.h>
 #include <asm/sizes.h>
@@ -242,6 +243,30 @@ static struct sys_timer nomadik_timer = {
 	.init	= nomadik_timer_init,
 };
 
+static struct i2c_board_info __initdata nhk8815_i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("stw4811", 0x2d),
+	},
+};
+
+static struct i2c_board_info __initdata nhk8815_i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("camera", 0x10),
+	},
+	{
+		I2C_BOARD_INFO("stw5095", 0x1a),
+	},
+	{
+		I2C_BOARD_INFO("lis3lv02dl", 0x1d),
+	},
+};
+
+static struct i2c_board_info __initdata nhk8815_i2c2_devices[] = {
+	{
+		I2C_BOARD_INFO("stw4811-usb", 0x2d),
+	},
+};
+
 static void __init nhk8815_platform_init(void)
 {
 	cpu8815_platform_init();
@@ -251,6 +276,13 @@ static void __init nhk8815_platform_init(void)
 
 	amba_apb_device_add(NULL, "uart0", NOMADIK_UART0_BASE, SZ_4K, IRQ_UART0, 0, NULL, 0);
 	amba_apb_device_add(NULL, "uart1", NOMADIK_UART1_BASE, SZ_4K, IRQ_UART1, 0, NULL, 0);
+
+	i2c_register_board_info(0, nhk8815_i2c0_devices,
+				ARRAY_SIZE(nhk8815_i2c0_devices));
+	i2c_register_board_info(1, nhk8815_i2c1_devices,
+				ARRAY_SIZE(nhk8815_i2c1_devices));
+	i2c_register_board_info(2, nhk8815_i2c2_devices,
+				ARRAY_SIZE(nhk8815_i2c2_devices));
 }
 
 MACHINE_START(NOMADIK, "NHK8815")
-- 
1.7.7.6
