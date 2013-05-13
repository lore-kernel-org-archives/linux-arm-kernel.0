From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:34 +0400
Subject: [PATCH 12/15] ARM: clps711x: edb7211: Add support for I2C
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-15-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-edb7211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index db804b4..970f4e1 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/memblock.h>
 #include <linux/types.h>
+#include <linux/i2c-gpio.h>
 #include <linux/interrupt.h>
 #include <linux/backlight.h>
 #include <linux/platform_device.h>
@@ -37,6 +38,9 @@
 #define EDB7211_LCDEN		CLPS711X_GPIO(3, 2)
 #define EDB7211_LCDBL		CLPS711X_GPIO(3, 3)
 
+#define EDB7211_I2C_SDA		CLPS711X_GPIO(3, 4)
+#define EDB7211_I2C_SCL		CLPS711X_GPIO(3, 5)
+
 #define EDB7211_FLASH0_BASE	(CS0_PHYS_BASE)
 #define EDB7211_FLASH1_BASE	(CS1_PHYS_BASE)
 
@@ -46,6 +50,12 @@
 /* The extra 8 lines of the keyboard matrix */
 #define EDB7211_EXTKBD_BASE	(CS3_PHYS_BASE)
 
+static struct i2c_gpio_platform_data edb7211_i2c_pdata __initdata = {
+	.sda_pin	= EDB7211_I2C_SDA,
+	.scl_pin	= EDB7211_I2C_SCL,
+	.scl_is_output_only = 1,
+};
+
 static struct resource edb7211_cs8900_resource[] __initdata = {
 	DEFINE_RES_MEM(EDB7211_CS8900_BASE, SZ_1K),
 	DEFINE_RES_IRQ(EDB7211_CS8900_IRQ),
@@ -173,6 +183,9 @@ static void __init edb7211_init_late(void)
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 	platform_device_register_simple("cs89x0", 0, edb7211_cs8900_resource,
 					ARRAY_SIZE(edb7211_cs8900_resource));
+	platform_device_register_data(&platform_bus, "i2c-gpio", 0,
+				      &edb7211_i2c_pdata,
+				      sizeof(edb7211_i2c_pdata));
 }
 
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
-- 
1.8.1.5
