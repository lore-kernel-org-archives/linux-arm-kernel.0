From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 16:46:28 +0100
Subject: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
In-Reply-To: <1455551208-2825510-1-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
Message-ID: <1455551208-2825510-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiolib has removed the irq_to_gpio() API several years ago,
but the global header still provided a non-working stub.

Apparently one new user has shown up in arch/mips, so this patch
moves the broken definition to where it is used, ensuring that
we get new users but not changing the current behavior on jz4740.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/jz4740/gpio.c |  7 +++++++
 include/linux/gpio.h    | 12 ------------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 8c6d76c9b2d6..e9bb43714892 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/compiler.h>
 
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -270,6 +271,12 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
 }
 EXPORT_SYMBOL(jz_gpio_port_get_value);
 
+static inline __deprecated int irq_to_gpio(unsigned int irq)
+{
+	/* this has clearly not worked for a long time */
+	return -EINVAL;
+}
+
 #define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
 
 static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index d12b5d566e4b..6fc1c9e74854 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -70,11 +70,6 @@ static inline int gpio_to_irq(unsigned int gpio)
 	return __gpio_to_irq(gpio);
 }
 
-static inline int irq_to_gpio(unsigned int irq)
-{
-	return -EINVAL;
-}
-
 #endif /* ! CONFIG_ARCH_HAVE_CUSTOM_GPIO_H */
 
 /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
@@ -222,13 +217,6 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *chip,
 	WARN_ON(1);
 }
 
-static inline int irq_to_gpio(unsigned irq)
-{
-	/* irq can never have been returned from gpio_to_irq() */
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 static inline int
 gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 		       unsigned int gpio_offset, unsigned int pin_offset,
-- 
2.7.0
