From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 Feb 2011 08:25:25 +0100
Subject: [PATCH 3/5] ARM: Samsung: add function to register gpio interrupt	bank
	data
In-Reply-To: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
References: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1297927527-1338-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all global data from common s5p gpio interrupt
handler code. This enables to reuse this code on S5PC210 platform.
Instead of global data (IRQ_GPIOINT interrupt number,
S5P_GPIOINT_GROUP_MAXNR groups count), a s5p_register_gpioint_bank()
function is introduced. It is aimed to be called from gpiolib init.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/gpiolib.c               |    1 +
 arch/arm/mach-s5pv210/gpiolib.c               |    1 +
 arch/arm/plat-s5p/irq-gpioint.c               |   69 +++++++++++++++++++++----
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |   16 ++++++
 4 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s5pc100/gpiolib.c b/arch/arm/mach-s5pc100/gpiolib.c
index 20856eb..2842394 100644
--- a/arch/arm/mach-s5pc100/gpiolib.c
+++ b/arch/arm/mach-s5pc100/gpiolib.c
@@ -348,6 +348,7 @@ static __init int s5pc100_gpiolib_init(void)
 	}
 
 	samsung_gpiolib_add_4bit_chips(s5pc100_gpio_chips, nr_chips);
+	s5p_register_gpioint_bank(IRQ_GPIOINT, 0, S5P_GPIOINT_GROUP_MAXNR);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index ab673ef..1ba20a7 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -281,6 +281,7 @@ static __init int s5pv210_gpiolib_init(void)
 	}
 
 	samsung_gpiolib_add_4bit_chips(s5pv210_gpio_4bit, nr_chips);
+	s5p_register_gpioint_bank(IRQ_GPIOINT, 0, S5P_GPIOINT_GROUP_MAXNR);
 
 	return 0;
 }
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
index af10328..70329e6 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/slab.h>
 
 #include <mach/map.h>
 #include <plat/gpio-core.h>
@@ -29,7 +30,17 @@
 #define PEND_OFFSET		0xA00
 #define REG_OFFSET(x)		((x) << 2)
 
-static struct s3c_gpio_chip *irq_chips[S5P_GPIOINT_GROUP_MAXNR];
+struct s5p_gpioint_bank
+{
+	struct list_head	list;
+	int			start;
+	int			nr_groups;
+	int			irq;
+	struct s3c_gpio_chip	**chips;
+	void			(*handler)(unsigned int, struct irq_desc *);
+};
+
+LIST_HEAD(banks);
 
 static int s5p_gpioint_get_offset(struct irq_data *data)
 {
@@ -139,11 +150,12 @@ static struct irq_chip s5p_gpioint = {
 
 static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct s5p_gpioint_bank *bank = get_irq_data(irq);
 	int group, pend_offset, mask_offset;
 	unsigned int pend, mask;
 
-	for (group = 0; group < S5P_GPIOINT_GROUP_MAXNR; group++) {
-		struct s3c_gpio_chip *chip = irq_chips[group];
+	for (group = 0; group < bank->nr_groups; group++) {
+		struct s3c_gpio_chip *chip = bank->chips[group];
 		if (!chip)
 			continue;
 
@@ -168,23 +180,44 @@ static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 static __init int s5p_gpioint_add(struct s3c_gpio_chip *chip)
 {
 	static int used_gpioint_groups = 0;
-	static bool handler_registered = 0;
 	int irq, group = chip->group;
 	int i;
+	struct s5p_gpioint_bank *bank = NULL;
 
 	if (used_gpioint_groups >= S5P_GPIOINT_GROUP_COUNT)
 		return -ENOMEM;
 
+	list_for_each_entry(bank, &banks, list) {
+		if (group >= bank->start &&
+		    group < bank->start + bank->nr_groups)
+			break;
+	}
+	if (!bank)
+		return -EINVAL;
+
+	if (!bank->handler) {
+		bank->chips = kzalloc(sizeof(struct s3c_gpio_chip *) *
+				      bank->nr_groups, GFP_KERNEL);
+		if (!bank->chips)
+			return -ENOMEM;
+
+		set_irq_chained_handler(bank->irq, s5p_gpioint_handler);
+		set_irq_data(bank->irq, bank);
+		bank->handler = s5p_gpioint_handler;
+		printk(KERN_INFO "Registered chained gpio int handler for interrupt %d.\n",
+		       bank->irq);
+	}
+
+	/*
+	 * chained GPIO irq has been sucessfully registered, allocate new gpio
+	 * int group and assign irq nubmers
+	 */
+
 	chip->irq_base = S5P_GPIOINT_BASE +
 			 used_gpioint_groups * S5P_GPIOINT_GROUP_SIZE;
 	used_gpioint_groups++;
 
-	if (!handler_registered) {
-		set_irq_chained_handler(IRQ_GPIOINT, s5p_gpioint_handler);
-		handler_registered = 1;
-	}
-
-	irq_chips[group] = chip;
+	bank->chips[group - bank->start] = chip;
 	for (i = 0; i < chip->chip.ngpio; i++) {
 		irq = chip->irq_base + i;
 		set_irq_chip(irq, &s5p_gpioint);
@@ -221,3 +254,19 @@ int __init s5p_register_gpio_interrupt(int pin)
 	}
 	return ret;
 }
+
+int __init s5p_register_gpioint_bank(int chain_irq, int start, int nr_groups)
+{
+	struct s5p_gpioint_bank *bank;
+
+	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
+	if (!bank)
+		return -ENOMEM;
+
+	bank->start = start;
+	bank->nr_groups = nr_groups;
+	bank->irq = chain_irq;
+
+	list_add_tail(&bank->list, &banks);
+	return 0;
+}
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index e4b5cf1..5e04fa6 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -225,4 +225,20 @@ extern int s5p_gpio_set_drvstr(unsigned int pin, s5p_gpio_drvstr_t drvstr);
  */
 extern int s5p_register_gpio_interrupt(int pin);
 
+/** s5p_register_gpioint_bank() - add gpio bank for further gpio interrupt
+ * registration (see s5p_register_gpio_interrupt function)
+ * @chain_irq: chained irq number for the gpio int handler for this bank
+ * @start: start gpio group number of this bank
+ * @nr_groups: number of gpio groups handled by this bank
+ *
+ * This functions registers initial information about gpio banks that
+ * can be later used by the s5p_register_gpio_interrupt() function to
+ * enable support for gpio interrupt for particular gpio group.
+ */
+#ifdef CONFIG_S5P_GPIO_INT
+extern int s5p_register_gpioint_bank(int chain_irq, int start, int nr_groups);
+#else
+#define s5p_register_gpioint_bank(chain_irq, start, nr_groups) do { } while (0)
+#endif
+
 #endif /* __PLAT_GPIO_CFG_H */
-- 
1.7.1.569.g6f426
