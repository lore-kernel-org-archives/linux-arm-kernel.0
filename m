From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 21:01:35 +0530
Subject: [PATCH v2] ARM: davinci: fix GPIO lookup for I2C
Message-ID: <20180501153135.32746-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
I2C can correctly lookup the recovery gpios.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Also, the I2C device uses an id of 1 on DM644x and DM355.

While at it, convert to using GPIO_TO_PIN() for referring to GPIO pin
numbers, like it is done in rest of the board support files.

Fixes: e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2: use GPIO_TO_PIN() to fix comment by David Lechner.

 arch/arm/mach-davinci/board-dm355-evm.c  |  9 ++++++---
 arch/arm/mach-davinci/board-dm644x-evm.c | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 762d29683a3a..23ab9e8bc04c 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -110,12 +110,15 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+#define DM355_I2C_SDA_PIN	GPIO_TO_PIN(0, 15)
+#define DM355_I2C_SCL_PIN	GPIO_TO_PIN(0, 14)
+
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
-	.dev_id = "i2c_davinci",
+	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", 15, "sda",
+		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio", 14, "scl",
+		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 95b55aae1366..509e64ab1994 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
+#include <linux/platform_data/gpio-davinci.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -596,12 +597,15 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 };
 
+#define DM644X_I2C_SDA_PIN	GPIO_TO_PIN(2, 12)
+#define DM644X_I2C_SCL_PIN	GPIO_TO_PIN(2, 11)
+
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
-	.dev_id = "i2c_davinci",
+	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", 44, "sda",
+		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio", 43, "scl",
+		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.16.2
