From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 16:46:17 +0800
Subject: [PATCH] ARM: imx: fix mc9s08dz60_gpiochip_match parameter type
Message-ID: <1333183577-2109-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the change made by commit 6e2cf65 (gpio: constify the data
parameter to gpiochip_find()), the following compile warning is seen
on imx_v6_v7_defconfig build.

  CC      arch/arm/mach-imx/mach-mx35_3ds.o
arch/arm/mach-imx/mach-mx35_3ds.c: In function ?mx35_3ds_lcd_set_power?:
arch/arm/mach-imx/mach-mx35_3ds.c:112:5: warning: passing argument 2 of ?gpiochip_find? from incompatible pointer type [enabled by default]
include/asm-generic/gpio.h:145:26: note: expected ?int (*)(struct gpio_chip *, const void *)? but argument is of type ?int (*)(struct gpio_chip *, void *)?

Change mc9s08dz60_gpiochip_match parameter type accordingly to fix
the warning.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-mx35_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index e14291d..6ae51c6 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -97,7 +97,7 @@ static struct i2c_board_info __initdata i2c_devices_3ds[] = {
 static int lcd_power_gpio = -ENXIO;
 
 static int mc9s08dz60_gpiochip_match(struct gpio_chip *chip,
-						     void *data)
+						     const void *data)
 {
 	return !strcmp(chip->label, data);
 }
-- 
1.7.5.4
