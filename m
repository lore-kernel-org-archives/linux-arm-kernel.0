From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 08:22:36 +0100
Subject: [PATCH 4/6] ARM: S3C24XX: Update missed gpio calls to use gpiolib
In-Reply-To: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
References: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274080958-369-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update a couple of S3C24XX and S3C2412 files that are still
using the GPIO number to register mapping calls to get the
s3c_gpio_chip and use the base field from that.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2412/gpio.c |   12 +++++++-----
 arch/arm/plat-s3c24xx/gpio.c |    8 +++++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c2412/gpio.c b/arch/arm/mach-s3c2412/gpio.c
index 71c5793..3404a87 100644
--- a/arch/arm/mach-s3c2412/gpio.c
+++ b/arch/arm/mach-s3c2412/gpio.c
@@ -16,18 +16,20 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include <mach/regs-gpio.h>
-
 #include <mach/hardware.h>
 
+#include <plat/gpio-core.h>
+
 int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state)
 {
-	void __iomem *base = S3C24XX_GPIO_BASE(pin);
-	unsigned long offs = S3C2410_GPIO_OFFSET(pin);
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	unsigned long offs = pin - chip->chip.base;
 	unsigned long flags;
 	unsigned long slpcon;
 
@@ -45,12 +47,12 @@ int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state)
 
 	local_irq_save(flags);
 
-	slpcon = __raw_readl(base + 0x0C);
+	slpcon = __raw_readl(chip->base + 0x0C);
 
 	slpcon &= ~(3 << offs);
 	slpcon |= state << offs;
 
-	__raw_writel(slpcon, base + 0x0C);
+	__raw_writel(slpcon, chip->base + 0x0C);
 
 	local_irq_restore(flags);
 
diff --git a/arch/arm/plat-s3c24xx/gpio.c b/arch/arm/plat-s3c24xx/gpio.c
index 45126d3..2f3d7c0 100644
--- a/arch/arm/plat-s3c24xx/gpio.c
+++ b/arch/arm/plat-s3c24xx/gpio.c
@@ -34,6 +34,8 @@
 
 #include <mach/regs-gpio.h>
 
+#include <plat/gpio-core.h>
+
 /* gpiolib wrappers until these are totally eliminated */
 
 void s3c2410_gpio_pullup(unsigned int pin, unsigned int to)
@@ -68,10 +70,10 @@ EXPORT_SYMBOL(s3c2410_gpio_setpin);
 
 unsigned int s3c2410_gpio_getpin(unsigned int pin)
 {
-	void __iomem *base = S3C24XX_GPIO_BASE(pin);
-	unsigned long offs = S3C2410_GPIO_OFFSET(pin);
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	unsigned long offs = pin - chip->chip.base;
 
-	return __raw_readl(base + 0x04) & (1<< offs);
+	return __raw_readl(chip->base + 0x04) & (1<< offs);
 }
 
 EXPORT_SYMBOL(s3c2410_gpio_getpin);
-- 
1.6.3.3
