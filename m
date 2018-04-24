From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Apr 2018 20:05:05 +0530
Subject: [PATCH 3/4] ARM: davinci: fix GPIO lookup for I2C
In-Reply-To: <20180424143506.25793-1-nsekhar@ti.com>
References: <20180424143506.25793-1-nsekhar@ti.com>
Message-ID: <20180424143506.25793-4-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
I2C can correctly lookup the recovery gpios.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Also, the I2C device uses an id of 1 on DM644x and DM355.

Fixes: e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c  | 6 +++---
 arch/arm/mach-davinci/board-dm644x-evm.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index cb30637d9eaf..14557f893798 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -110,11 +110,11 @@ static struct platform_device davinci_nand_device = {
 };
 
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
-	.dev_id = "i2c_davinci",
+	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", 15, "sda",
+		GPIO_LOOKUP("davinci_gpio.0", 15, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio", 14, "scl",
+		GPIO_LOOKUP("davinci_gpio.0", 14, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 5bf024784738..5b0b95e04cac 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -597,11 +597,11 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 };
 
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
-	.dev_id = "i2c_davinci",
+	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", 44, "sda",
+		GPIO_LOOKUP("davinci_gpio.0", 44, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio", 43, "scl",
+		GPIO_LOOKUP("davinci_gpio.0", 43, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.16.2
