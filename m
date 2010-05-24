From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 05:21:29 +0100
Subject: [PATCH] ARM: SAMSUNG: gpio: add list of gpios
In-Reply-To: <1274674889-20216-1-git-send-email-ben-linux@fluff.org>
References: <1274674889-20216-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274674889-20216-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a list of register gpio chips so that the gpio-pm core does not
need to go searching the entire space to find a chip.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/gpio.c                   |    4 +++
 arch/arm/plat-samsung/include/plat/gpio-core.h |   15 ++++++++++++++
 arch/arm/plat-samsung/pm-gpio.c                |   25 +----------------------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-samsung/gpio.c b/arch/arm/plat-samsung/gpio.c
index b83a833..0d983d3 100644
--- a/arch/arm/plat-samsung/gpio.c
+++ b/arch/arm/plat-samsung/gpio.c
@@ -123,6 +123,8 @@ static int s3c_gpiolib_get(struct gpio_chip *chip, unsigned offset)
 	return val;
 }
 
+LIST_HEAD(s3c_gpio_list);
+
 __init void s3c_gpiolib_add(struct s3c_gpio_chip *chip)
 {
 	struct gpio_chip *gc = &chip->chip;
@@ -134,6 +136,8 @@ __init void s3c_gpiolib_add(struct s3c_gpio_chip *chip)
 
 	spin_lock_init(&chip->lock);
 
+	list_add_tail(&chip->list, &s3c_gpio_list);
+
 	if (!gc->direction_input)
 		gc->direction_input = s3c_gpiolib_input;
 	if (!gc->direction_output)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index f3a68d1..fb02d70 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -42,6 +42,7 @@ struct s3c_gpio_cfg;
 /**
  * struct s3c_gpio_chip - wrapper for specific implementation of gpio
  * @chip: The chip structure to be exported via gpiolib.
+ * @list: A list of all registered chips for items like PM.
  * @base: The base pointer to the gpio configuration registers.
  * @config: special function and pull-resistor control information.
  * @lock: Lock for exclusive access to this gpio bank.
@@ -60,6 +61,7 @@ struct s3c_gpio_cfg;
  */
 struct s3c_gpio_chip {
 	struct gpio_chip	chip;
+	struct list_head	list;
 	struct s3c_gpio_cfg	*config;
 	struct s3c_gpio_pm	*pm;
 	void __iomem		*base;
@@ -152,3 +154,16 @@ extern struct s3c_gpio_pm s3c_gpio_pm_4bit;
 /* locking wrappers to deal with multiple access to the same gpio bank */
 #define s3c_gpio_lock(_oc, _fl) spin_lock_irqsave(&(_oc)->lock, _fl)
 #define s3c_gpio_unlock(_oc, _fl) spin_unlock_irqrestore(&(_oc)->lock, _fl)
+
+/* s3c_gpio_chip list managment
+ *
+ * This lists all the s3c_gpio_chips register in the system for items like
+ * the gpio-pm code which needs to run for all chips.
+ *
+ * Not for export past the core implementation.
+ */
+
+extern struct list_head s3c_gpio_list;
+
+/* iterate over all gpio registered */
+#define s3c_gpio_forall(_it) list_for_each_entry(_it, &s3c_gpio_list, list)
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index 7df03f8..c241dae 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -327,15 +327,8 @@ static void s3c_pm_save_gpio(struct s3c_gpio_chip *ourchip)
 void s3c_pm_save_gpios(void)
 {
 	struct s3c_gpio_chip *ourchip;
-	unsigned int gpio_nr;
-
-	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
-		ourchip = s3c_gpiolib_getchip(gpio_nr);
-		if (!ourchip) {
-			gpio_nr++;
-			continue;
-		}
 
+	s3c_gpio_forall(ourchip) {
 		s3c_pm_save_gpio(ourchip);
 
 		S3C_PMDBG("%s: save %08x,%08x,%08x,%08x\n",
@@ -344,9 +337,6 @@ void s3c_pm_save_gpios(void)
 			  ourchip->pm_save[1],
 			  ourchip->pm_save[2],
 			  ourchip->pm_save[3]);
-
-		gpio_nr += ourchip->chip.ngpio;
-		gpio_nr += CONFIG_S3C_GPIO_SPACE;
 	}
 }
 
@@ -367,18 +357,7 @@ static void s3c_pm_resume_gpio(struct s3c_gpio_chip *ourchip)
 void s3c_pm_restore_gpios(void)
 {
 	struct s3c_gpio_chip *ourchip;
-	unsigned int gpio_nr;
-
-	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
-		ourchip = s3c_gpiolib_getchip(gpio_nr);
-		if (!ourchip) {
-			gpio_nr++;
-			continue;
-		}
 
+	s3c_gpio_forall(ourchip)
 		s3c_pm_resume_gpio(ourchip);
-
-		gpio_nr += ourchip->chip.ngpio;
-		gpio_nr += CONFIG_S3C_GPIO_SPACE;
-	}
 }
-- 
1.6.3.3
