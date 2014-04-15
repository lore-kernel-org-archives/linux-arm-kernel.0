From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 14:43:48 +0800
Subject: [PATCH 3/4] gpio: make handler_data configurable while using
 gpiolib_irqchip
In-Reply-To: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397544229-20545-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

since it is called handler_data, drivers should have the ability to
set handler_data based on real hardware.
GPIOLIB_IRQCHIP doesn't use handler_data by itself, so it will not
break GPIO core.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/gpio/gpiolib.c      |   10 +++-------
 include/linux/gpio/driver.h |    2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 761013f..4b90d14 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1351,24 +1351,20 @@ static struct gpio_chip *find_chip_by_name(const char *name)
 
 /**
  * gpiochip_add_chained_irqchip() - adds a chained irqchip to a gpiochip
- * @gpiochip: the gpiochip to add the irqchip to
+ * @handler_data: handler_data which will be used by ISR of interrupt parent
  * @irqchip: the irqchip to add to the gpiochip
  * @parent_irq: the irq number corresponding to the parent IRQ for this
  * chained irqchip
  * @parent_handler: the parent interrupt handler for the accumulated IRQ
  * coming out of the gpiochip
  */
-void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
+void gpiochip_set_chained_irqchip(void *handler_data,
 				  struct irq_chip *irqchip,
 				  int parent_irq,
 				  irq_flow_handler_t parent_handler)
 {
 	irq_set_chained_handler(parent_irq, parent_handler);
-	/*
-	 * The parent irqchip is already using the chip_data for this
-	 * irqchip, so our callbacks simply use the handler_data.
-	 */
-	irq_set_handler_data(parent_irq, gpiochip);
+	irq_set_handler_data(parent_irq, handler_data);
 }
 EXPORT_SYMBOL_GPL(gpiochip_set_chained_irqchip);
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 1827b43..52a0758 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -207,7 +207,7 @@ void gpiod_add_lookup_table(struct gpiod_lookup_table *table);
 
 #ifdef CONFIG_GPIOLIB_IRQCHIP
 
-void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
+void gpiochip_set_chained_irqchip(void *handler_data,
 		struct irq_chip *irqchip,
 		int parent_irq,
 		irq_flow_handler_t parent_handler);
-- 
1.7.5.4
