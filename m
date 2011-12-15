From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 20:16:06 +0100
Subject: [PATCH 4/6] ARM: at91/gpio: add .to_irq gpio_chip handler and rework
 irq_to_gpio
In-Reply-To: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1323976568-20244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <57a5d54dd158c909a3c854b5bfc873a5f43e60ea.1323975517.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the gpio_to_irq() macro by a plain gpiolib .to_irq() handler.
The irq_to_gpio() macro is removed. A local replacement is created
to fill the need of the gpio driver, internally.

Those calls are using the irqdomain to translate hardware to Linux
IRQ numbers.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/gpio.c              |   23 +++++++++++++++++++++++
 arch/arm/mach-at91/include/mach/gpio.h |   12 ------------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index edb453a..c390f71 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/errno.h>
+#include <linux/device.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -46,6 +47,7 @@ static int at91_gpiolib_direction_output(struct gpio_chip *chip,
 					 unsigned offset, int val);
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset);
+static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 
 #define AT91_GPIO_CHIP(name, base_gpio, nr_gpio)			\
 	{								\
@@ -57,6 +59,7 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 			.set		  = at91_gpiolib_set,		\
 			.dbg_show	  = at91_gpiolib_dbg_show,	\
 			.base		  = base_gpio,			\
+			.to_irq		  = at91_gpiolib_to_irq,	\
 			.ngpio		  = nr_gpio,			\
 		},							\
 	}
@@ -86,6 +89,16 @@ static inline unsigned pin_to_mask(unsigned pin)
 }
 
 
+/*
+ * As gpio IRQs are stacked without holes, we can determine
+ * the gpio form an irq number comparing it with the first IRQ of first
+ * GPIO/IRQ domain.
+ */
+static inline unsigned irq_to_gpio(unsigned irq)
+{
+	return irq - irq_domain_to_irq(&gpio_chip[0].domain, 0);
+}
+
 /*--------------------------------------------------------------------------*/
 
 /* Not all hardware capabilities are exposed through these calls; they
@@ -625,6 +638,16 @@ static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	}
 }
 
+static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
+	int retirq = irq_domain_to_irq(&at91_gpio->domain, offset);
+
+	dev_dbg(chip->dev, "request IRQ for GPIO %d, return %d\n", offset,
+		retirq);
+	return retirq;
+}
+
 #ifdef CONFIG_OF_GPIO
 static void __init of_at91_gpio_init_one(struct device_node *np)
 {
diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index e3fd225..7cf009b 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -204,18 +204,6 @@ extern int at91_get_gpio_value(unsigned pin);
 extern void at91_gpio_suspend(void);
 extern void at91_gpio_resume(void);
 
-/*-------------------------------------------------------------------------*/
-
-/* wrappers for "new style" GPIO calls. the old AT91-specific ones should
- * eventually be removed (along with this errno.h inclusion), and the
- * gpio request/free calls should probably be implemented.
- */
-
-#include <asm/errno.h>
-
-#define gpio_to_irq(gpio) (gpio + NR_AIC_IRQS)
-#define irq_to_gpio(irq)  (irq - NR_AIC_IRQS)
-
 #endif	/* __ASSEMBLY__ */
 
 #endif
-- 
1.7.5.4
