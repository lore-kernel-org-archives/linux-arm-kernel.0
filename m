From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 12:48:21 +0100
Subject: [RFC PATCH 4/5] iop: convert to basic-mmio-gpio
In-Reply-To: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1302522502-24381-5-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic-mmio-gpio driver is capable of supporting this controller so
convert the platform to use it for basic GPIO support.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/include/asm/hardware/iop3xx.h     |    6 +-
 arch/arm/mach-iop32x/include/mach/iop32x.h |    2 +-
 arch/arm/mach-iop33x/include/mach/iop33x.h |    2 +-
 arch/arm/plat-iop/gpio.c                   |   89 +++++++--------------------
 4 files changed, 28 insertions(+), 71 deletions(-)

diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 5daea29..078c07a 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -169,9 +169,9 @@ extern int iop3xx_get_init_atu(void);
 #define IOP3XX_PERCR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0710)
 
 /* General Purpose I/O  */
-#define IOP3XX_GPOE		(volatile u32 *)IOP3XX_GPIO_REG(0x0000)
-#define IOP3XX_GPID		(volatile u32 *)IOP3XX_GPIO_REG(0x0004)
-#define IOP3XX_GPOD		(volatile u32 *)IOP3XX_GPIO_REG(0x0008)
+#define IOP3XX_GPOE		IOP3XX_GPIO_REG(0x0000)
+#define IOP3XX_GPID		IOP3XX_GPIO_REG(0x0004)
+#define IOP3XX_GPOD		IOP3XX_GPIO_REG(0x0008)
 
 /* Timers  */
 #define IOP3XX_TU_TMR0		(volatile u32 *)IOP3XX_TIMER_REG(0x0000)
diff --git a/arch/arm/mach-iop32x/include/mach/iop32x.h b/arch/arm/mach-iop32x/include/mach/iop32x.h
index 941f363..880441b 100644
--- a/arch/arm/mach-iop32x/include/mach/iop32x.h
+++ b/arch/arm/mach-iop32x/include/mach/iop32x.h
@@ -19,7 +19,7 @@
  * Peripherals that are shared between the iop32x and iop33x but
  * located at different addresses.
  */
-#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07c4 + (reg))
+#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_PHYS_BASE + 0x07c4 + (reg))
 #define IOP3XX_TIMER_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07e0 + (reg))
 
 #include <asm/hardware/iop3xx.h>
diff --git a/arch/arm/mach-iop33x/include/mach/iop33x.h b/arch/arm/mach-iop33x/include/mach/iop33x.h
index a89c0a2..acf8b23 100644
--- a/arch/arm/mach-iop33x/include/mach/iop33x.h
+++ b/arch/arm/mach-iop33x/include/mach/iop33x.h
@@ -18,7 +18,7 @@
  * Peripherals that are shared between the iop32x and iop33x but
  * located at different addresses.
  */
-#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780 + (reg))
+#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_PHYS_BASE + 0x1780 + (reg))
 #define IOP3XX_TIMER_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07d0 + (reg))
 
 #include <asm/hardware/iop3xx.h>
diff --git a/arch/arm/plat-iop/gpio.c b/arch/arm/plat-iop/gpio.c
index 640e498..c4f7f24 100644
--- a/arch/arm/plat-iop/gpio.c
+++ b/arch/arm/plat-iop/gpio.c
@@ -10,82 +10,39 @@
  * your option) any later version.
  */
 
+#include <linux/basic_mmio_gpio.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 #include <asm/hardware/iop3xx.h>
 
-void gpio_line_config(int line, int direction)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (direction == GPIO_IN) {
-		*IOP3XX_GPOE |= 1 << line;
-	} else if (direction == GPIO_OUT) {
-		*IOP3XX_GPOE &= ~(1 << line);
-	}
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(gpio_line_config);
-
-int gpio_line_get(int line)
-{
-	return !!(*IOP3XX_GPID & (1 << line));
-}
-EXPORT_SYMBOL(gpio_line_get);
-
-void gpio_line_set(int line, int value)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (value == GPIO_LOW) {
-		*IOP3XX_GPOD &= ~(1 << line);
-	} else if (value == GPIO_HIGH) {
-		*IOP3XX_GPOD |= 1 << line;
+#define GPIO_RES(__name, __addr) \
+	{ \
+		.start = (__addr), \
+		.end = (__addr) + 0x3, \
+		.flags = IORESOURCE_MEM, \
+		.name = #__name, \
 	}
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(gpio_line_set);
-
-static int iop3xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-{
-	gpio_line_config(gpio, GPIO_IN);
-	return 0;
-}
-
-static int iop3xx_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int level)
-{
-	gpio_line_set(gpio, level);
-	gpio_line_config(gpio, GPIO_OUT);
-	return 0;
-}
-
-static int iop3xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
-{
-	return gpio_line_get(gpio);
-}
-
-static void iop3xx_gpio_set_value(struct gpio_chip *chip, unsigned gpio, int value)
-{
-	gpio_line_set(gpio, value);
-}
-
-static struct gpio_chip iop3xx_chip = {
-	.label			= "iop3xx",
-	.direction_input	= iop3xx_gpio_direction_input,
-	.get			= iop3xx_gpio_get_value,
-	.direction_output	= iop3xx_gpio_direction_output,
-	.set			= iop3xx_gpio_set_value,
-	.base			= 0,
-	.ngpio			= IOP3XX_N_GPIOS,
-};
 
 static int __init iop3xx_gpio_setup(void)
 {
-	return gpiochip_add(&iop3xx_chip);
+	struct resource res[] = {
+		GPIO_RES(dat, IOP3XX_GPID),
+		GPIO_RES(set, IOP3XX_GPOD),
+		GPIO_RES(dirin, IOP3XX_GPOE),
+	};
+	struct bgpio_pdata pdata = {
+		.ngpio	= IOP3XX_N_GPIOS,
+	};
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_resndata(NULL, "basic-mmio-gpio", 0,
+						 res, ARRAY_SIZE(res), &pdata,
+						 sizeof(pdata));
+	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
 arch_initcall(iop3xx_gpio_setup);
-- 
1.7.4.2
