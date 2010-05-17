From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 08:22:33 +0100
Subject: [PATCH 1/6] ARM: SAMSUNG: Add spinlock locking to GPIO banks
Message-ID: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add locking to each GPIO bank to allow for SMP capable code
to use the gpiolib functions. See the gpio-core.h header file
for more information.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/gpio-config.c            |   12 ++++++------
 arch/arm/plat-samsung/gpio.c                   |   15 +++++++++------
 arch/arm/plat-samsung/include/plat/gpio-core.h |   14 ++++++++++++++
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index 3282db3..a76eef5 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -33,9 +33,9 @@ int s3c_gpio_cfgpin(unsigned int pin, unsigned int config)
 
 	offset = pin - chip->chip.base;
 
-	local_irq_save(flags);
+	s3c_gpio_lock(chip, flags);
 	ret = s3c_gpio_do_setcfg(chip, offset, config);
-	local_irq_restore(flags);
+	s3c_gpio_unlock(chip, flags);
 
 	return ret;
 }
@@ -51,9 +51,9 @@ unsigned s3c_gpio_getcfg(unsigned int pin)
 	if (chip) {
 		offset = pin - chip->chip.base;
 
-		local_irq_save(flags);
+		s3c_gpio_lock(chip, flags);
 		ret = s3c_gpio_do_getcfg(chip, offset);
-		local_irq_restore(flags);
+		s3c_gpio_unlock(chip, flags);
 	}
 
 	return ret;
@@ -72,9 +72,9 @@ int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull)
 
 	offset = pin - chip->chip.base;
 
-	local_irq_save(flags);
+	s3c_gpio_lock(chip, flags);
 	ret = s3c_gpio_do_setpull(chip, offset, pull);
-	local_irq_restore(flags);
+	s3c_gpio_unlock(chip, flags);
 
 	return ret;
 }
diff --git a/arch/arm/plat-samsung/gpio.c b/arch/arm/plat-samsung/gpio.c
index 28d2ab8..b83a833 100644
--- a/arch/arm/plat-samsung/gpio.c
+++ b/arch/arm/plat-samsung/gpio.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/spinlock.h>
 
 #include <plat/gpio-core.h>
 
@@ -52,14 +53,14 @@ static int s3c_gpiolib_input(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 	unsigned long con;
 
-	local_irq_save(flags);
+	s3c_gpio_lock(ourchip, flags);
 
 	con = __raw_readl(base + 0x00);
 	con &= ~(3 << (offset * 2));
 
 	__raw_writel(con, base + 0x00);
 
-	local_irq_restore(flags);
+	s3c_gpio_unlock(ourchip, flags);
 	return 0;
 }
 
@@ -72,7 +73,7 @@ static int s3c_gpiolib_output(struct gpio_chip *chip,
 	unsigned long dat;
 	unsigned long con;
 
-	local_irq_save(flags);
+	s3c_gpio_lock(ourchip, flags);
 
 	dat = __raw_readl(base + 0x04);
 	dat &= ~(1 << offset);
@@ -87,7 +88,7 @@ static int s3c_gpiolib_output(struct gpio_chip *chip,
 	__raw_writel(con, base + 0x00);
 	__raw_writel(dat, base + 0x04);
 
-	local_irq_restore(flags);
+	s3c_gpio_unlock(ourchip, flags);
 	return 0;
 }
 
@@ -99,7 +100,7 @@ static void s3c_gpiolib_set(struct gpio_chip *chip,
 	unsigned long flags;
 	unsigned long dat;
 
-	local_irq_save(flags);
+	s3c_gpio_lock(ourchip, flags);
 
 	dat = __raw_readl(base + 0x04);
 	dat &= ~(1 << offset);
@@ -107,7 +108,7 @@ static void s3c_gpiolib_set(struct gpio_chip *chip,
 		dat |= 1 << offset;
 	__raw_writel(dat, base + 0x04);
 
-	local_irq_restore(flags);
+	s3c_gpio_unlock(ourchip, flags);
 }
 
 static int s3c_gpiolib_get(struct gpio_chip *chip, unsigned offset)
@@ -131,6 +132,8 @@ __init void s3c_gpiolib_add(struct s3c_gpio_chip *chip)
 	BUG_ON(!gc->label);
 	BUG_ON(!gc->ngpio);
 
+	spin_lock_init(&chip->lock);
+
 	if (!gc->direction_input)
 		gc->direction_input = s3c_gpiolib_input;
 	if (!gc->direction_output)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index f0584f2..f3a68d1 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -44,16 +44,26 @@ struct s3c_gpio_cfg;
  * @chip: The chip structure to be exported via gpiolib.
  * @base: The base pointer to the gpio configuration registers.
  * @config: special function and pull-resistor control information.
+ * @lock: Lock for exclusive access to this gpio bank.
  * @pm_save: Save information for suspend/resume support.
  *
  * This wrapper provides the necessary information for the Samsung
  * specific gpios being registered with gpiolib.
+ *
+ * The lock protects each gpio bank from multiple access of the shared
+ * configuration registers, or from reading of data whilst another thread
+ * is writing to the register set.
+ *
+ * Each chip has its own lock to avoid any  contention between different
+ * CPU cores trying to get one lock for different GPIO banks, where each
+ * bank of GPIO has its own register space and configuration registers.
  */
 struct s3c_gpio_chip {
 	struct gpio_chip	chip;
 	struct s3c_gpio_cfg	*config;
 	struct s3c_gpio_pm	*pm;
 	void __iomem		*base;
+	spinlock_t		 lock;
 #ifdef CONFIG_PM
 	u32			pm_save[4];
 #endif
@@ -138,3 +148,7 @@ extern struct s3c_gpio_pm s3c_gpio_pm_4bit;
 #define __gpio_pm(x) NULL
 
 #endif /* CONFIG_PM */
+
+/* locking wrappers to deal with multiple access to the same gpio bank */
+#define s3c_gpio_lock(_oc, _fl) spin_lock_irqsave(&(_oc)->lock, _fl)
+#define s3c_gpio_unlock(_oc, _fl) spin_unlock_irqrestore(&(_oc)->lock, _fl)
-- 
1.6.3.3
