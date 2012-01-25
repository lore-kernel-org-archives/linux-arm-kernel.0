From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:39:55 +0000
Subject: [PATCH 29/33] MFD: ucb1x00: convert to use genirq
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq40x-0000Zh-0v@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ucb1x00 driver to use genirq's interrupt services, rather
than its own private implementation.  This allows a wider range of
drivers to use the GPIO interrupts (such as the gpio_keys driver)
without being aware of the UCB1x00's private IRQ system.

This prevents the UCB1x00 core driver from being built as a module,
so adjust the configuration to add that restriction.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/Kconfig         |    5 +-
 drivers/mfd/ucb1x00-core.c  |  247 +++++++++++++++++--------------------------
 drivers/mfd/ucb1x00-ts.c    |   37 +++++--
 include/linux/mfd/ucb1x00.h |   22 +---
 4 files changed, 132 insertions(+), 179 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index cd13e9f..28a301b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -847,8 +847,9 @@ config MCP_SA11X0
 
 # Chip drivers
 config MCP_UCB1200
-	tristate "Support for UCB1200 / UCB1300"
-	depends on MCP
+	bool "Support for UCB1200 / UCB1300"
+	depends on MCP_SA11X0
+	select MCP
 
 config MCP_UCB1200_TS
 	tristate "Touchscreen interface support"
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 6fab825..400604d 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/mfd/ucb1x00.h>
@@ -178,6 +179,13 @@ static int ucb1x00_gpio_direction_output(struct gpio_chip *chip, unsigned offset
 	return 0;
 }
 
+static int ucb1x00_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct ucb1x00 *ucb = container_of(chip, struct ucb1x00, gpio);
+
+	return ucb->irq_base > 0 ? ucb->irq_base + offset : -ENXIO;
+}
+
 /*
  * UCB1300 data sheet says we must:
  *  1. enable ADC	=> 5us (including reference startup time)
@@ -274,10 +282,9 @@ void ucb1x00_adc_disable(struct ucb1x00 *ucb)
  * SIBCLK to talk to the chip.  We leave the clock running until
  * we have finished processing all interrupts from the chip.
  */
-static irqreturn_t ucb1x00_irq(int irqnr, void *devid)
+static void ucb1x00_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct ucb1x00 *ucb = devid;
-	struct ucb1x00_irq *irq;
+	struct ucb1x00 *ucb = irq_desc_get_handler_data(desc);
 	unsigned int isr, i;
 
 	ucb1x00_enable(ucb);
@@ -285,157 +292,84 @@ static irqreturn_t ucb1x00_irq(int irqnr, void *devid)
 	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, isr);
 	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
 
-	for (i = 0, irq = ucb->irq_handler; i < 16 && isr; i++, isr >>= 1, irq++)
-		if (isr & 1 && irq->fn)
-			irq->fn(i, irq->devid);
+	for (i = 0; i < 16 && isr; i++, isr >>= 1, irq++)
+		if (isr & 1)
+			generic_handle_irq(ucb->irq_base + i);
 	ucb1x00_disable(ucb);
-
-	return IRQ_HANDLED;
 }
 
-/**
- *	ucb1x00_hook_irq - hook a UCB1x00 interrupt
- *	@ucb:   UCB1x00 structure describing chip
- *	@idx:   interrupt index
- *	@fn:    function to call when interrupt is triggered
- *	@devid: device id to pass to interrupt handler
- *
- *	Hook the specified interrupt.  You can only register one handler
- *	for each interrupt source.  The interrupt source is not enabled
- *	by this function; use ucb1x00_enable_irq instead.
- *
- *	Interrupt handlers will be called with other interrupts enabled.
- *
- *	Returns zero on success, or one of the following errors:
- *	 -EINVAL if the interrupt index is invalid
- *	 -EBUSY if the interrupt has already been hooked
- */
-int ucb1x00_hook_irq(struct ucb1x00 *ucb, unsigned int idx, void (*fn)(int, void *), void *devid)
+static void ucb1x00_irq_update(struct ucb1x00 *ucb, unsigned mask)
 {
-	struct ucb1x00_irq *irq;
-	int ret = -EINVAL;
-
-	if (idx < 16) {
-		irq = ucb->irq_handler + idx;
-		ret = -EBUSY;
-
-		spin_lock_irq(&ucb->lock);
-		if (irq->fn == NULL) {
-			irq->devid = devid;
-			irq->fn = fn;
-			ret = 0;
-		}
-		spin_unlock_irq(&ucb->lock);
-	}
-	return ret;
+	ucb1x00_enable(ucb);
+	if (ucb->irq_ris_enbl & mask)
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl &
+				  ucb->irq_mask);
+	if (ucb->irq_fal_enbl & mask)
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl &
+				  ucb->irq_mask);
+	ucb1x00_disable(ucb);
 }
 
-/**
- *	ucb1x00_enable_irq - enable an UCB1x00 interrupt source
- *	@ucb: UCB1x00 structure describing chip
- *	@idx: interrupt index
- *	@edges: interrupt edges to enable
- *
- *	Enable the specified interrupt to trigger on %UCB_RISING,
- *	%UCB_FALLING or both edges.  The interrupt should have been
- *	hooked by ucb1x00_hook_irq.
- */
-void ucb1x00_enable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
+static void ucb1x00_irq_noop(struct irq_data *data)
 {
-	unsigned long flags;
-
-	if (idx < 16) {
-		spin_lock_irqsave(&ucb->lock, flags);
-
-		ucb1x00_enable(ucb);
-		if (edges & UCB_RISING) {
-			ucb->irq_ris_enbl |= 1 << idx;
-			ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		}
-		if (edges & UCB_FALLING) {
-			ucb->irq_fal_enbl |= 1 << idx;
-			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		}
-		ucb1x00_disable(ucb);
-		spin_unlock_irqrestore(&ucb->lock, flags);
-	}
 }
 
-/**
- *	ucb1x00_disable_irq - disable an UCB1x00 interrupt source
- *	@ucb: UCB1x00 structure describing chip
- *	@edges: interrupt edges to disable
- *
- *	Disable the specified interrupt triggering on the specified
- *	(%UCB_RISING, %UCB_FALLING or both) edges.
- */
-void ucb1x00_disable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
+static void ucb1x00_irq_mask(struct irq_data *data)
 {
-	unsigned long flags;
+	struct ucb1x00 *ucb = irq_data_get_irq_chip_data(data);
+	unsigned mask = 1 << (data->irq - ucb->irq_base);
 
-	if (idx < 16) {
-		spin_lock_irqsave(&ucb->lock, flags);
-
-		ucb1x00_enable(ucb);
-		if (edges & UCB_RISING) {
-			ucb->irq_ris_enbl &= ~(1 << idx);
-			ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		}
-		if (edges & UCB_FALLING) {
-			ucb->irq_fal_enbl &= ~(1 << idx);
-			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		}
-		ucb1x00_disable(ucb);
-		spin_unlock_irqrestore(&ucb->lock, flags);
-	}
+	raw_spin_lock(&ucb->irq_lock);
+	ucb->irq_mask &= ~mask;
+	ucb1x00_irq_update(ucb, mask);
+	raw_spin_unlock(&ucb->irq_lock);
 }
 
-/**
- *	ucb1x00_free_irq - disable and free the specified UCB1x00 interrupt
- *	@ucb: UCB1x00 structure describing chip
- *	@idx: interrupt index
- *	@devid: device id.
- *
- *	Disable the interrupt source and remove the handler.  devid must
- *	match the devid passed when hooking the interrupt.
- *
- *	Returns zero on success, or one of the following errors:
- *	 -EINVAL if the interrupt index is invalid
- *	 -ENOENT if devid does not match
- */
-int ucb1x00_free_irq(struct ucb1x00 *ucb, unsigned int idx, void *devid)
+static void ucb1x00_irq_unmask(struct irq_data *data)
 {
-	struct ucb1x00_irq *irq;
-	int ret;
+	struct ucb1x00 *ucb = irq_data_get_irq_chip_data(data);
+	unsigned mask = 1 << (data->irq - ucb->irq_base);
 
-	if (idx >= 16)
-		goto bad;
-
-	irq = ucb->irq_handler + idx;
-	ret = -ENOENT;
+	raw_spin_lock(&ucb->irq_lock);
+	ucb->irq_mask |= mask;
+	ucb1x00_irq_update(ucb, mask);
+	raw_spin_unlock(&ucb->irq_lock);
+}
 
-	spin_lock_irq(&ucb->lock);
-	if (irq->devid == devid) {
-		ucb->irq_ris_enbl &= ~(1 << idx);
-		ucb->irq_fal_enbl &= ~(1 << idx);
+static int ucb1x00_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct ucb1x00 *ucb = irq_data_get_irq_chip_data(data);
+	unsigned mask = 1 << (data->irq - ucb->irq_base);
 
-		ucb1x00_enable(ucb);
-		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		ucb1x00_disable(ucb);
+	raw_spin_lock(&ucb->irq_lock);
+	if (type & IRQ_TYPE_EDGE_RISING)
+		ucb->irq_ris_enbl |= mask;
+	else
+		ucb->irq_ris_enbl &= ~mask;
 
-		irq->fn = NULL;
-		irq->devid = NULL;
-		ret = 0;
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		ucb->irq_fal_enbl |= mask;
+	else
+		ucb->irq_fal_enbl &= ~mask;
+	if (ucb->irq_mask & mask) {
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl &
+				  ucb->irq_mask);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl &
+				  ucb->irq_mask);
 	}
-	spin_unlock_irq(&ucb->lock);
-	return ret;
+	raw_spin_unlock(&ucb->irq_lock);
 
-bad:
-	printk(KERN_ERR "Freeing bad UCB1x00 irq %d\n", idx);
-	return -EINVAL;
+	return 0;
 }
 
+static struct irq_chip ucb1x00_irqchip = {
+	.name = "ucb1x00",
+	.irq_ack = ucb1x00_irq_noop,
+	.irq_mask = ucb1x00_irq_mask,
+	.irq_unmask = ucb1x00_irq_unmask,
+	.irq_set_type = ucb1x00_irq_set_type,
+};
+
 static int ucb1x00_add_dev(struct ucb1x00 *ucb, struct ucb1x00_driver *drv)
 {
 	struct ucb1x00_dev *dev;
@@ -545,9 +479,8 @@ static int ucb1x00_probe(struct mcp *mcp)
 	struct ucb1x00_plat_data *pdata = mcp->attached_device.platform_data;
 	struct ucb1x00_driver *drv;
 	struct ucb1x00 *ucb;
-	unsigned int id;
+	unsigned id, i, irq_base;
 	int ret = -ENODEV;
-	int temp;
 
 	/* Tell the platform to deassert the UCB1x00 reset */
 	if (pdata && pdata->reset)
@@ -572,7 +505,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 	ucb->dev.parent = &mcp->attached_device;
 	dev_set_name(&ucb->dev, "ucb1x00");
 
-	spin_lock_init(&ucb->lock);
+	raw_spin_lock_init(&ucb->irq_lock);
 	spin_lock_init(&ucb->io_lock);
 	mutex_init(&ucb->adc_mutex);
 
@@ -593,6 +526,26 @@ static int ucb1x00_probe(struct mcp *mcp)
 	}
 
 	ucb->gpio.base = -1;
+	irq_base = pdata ? pdata->irq_base : 0;
+	ucb->irq_base = irq_alloc_descs(-1, irq_base, 16, -1);
+	if (ucb->irq_base < 0) {
+		dev_err(&ucb->dev, "unable to allocate 16 irqs: %d\n",
+			ucb->irq_base);
+		goto err_irq_alloc;
+	}
+
+	for (i = 0; i < 16; i++) {
+		unsigned irq = ucb->irq_base + i;
+
+		irq_set_chip_and_handler(irq, &ucb1x00_irqchip, handle_edge_irq);
+		irq_set_chip_data(irq, ucb);
+		set_irq_flags(irq, IRQF_VALID | IRQ_NOREQUEST);
+	}
+
+	irq_set_irq_type(ucb->irq, IRQ_TYPE_EDGE_RISING);
+	irq_set_handler_data(ucb->irq, ucb);
+	irq_set_chained_handler(ucb->irq, ucb1x00_irq);
+
 	if (pdata && pdata->gpio_base) {
 		ucb->gpio.label = dev_name(&ucb->dev);
 		ucb->gpio.dev = &ucb->dev;
@@ -603,20 +556,13 @@ static int ucb1x00_probe(struct mcp *mcp)
 		ucb->gpio.get = ucb1x00_gpio_get;
 		ucb->gpio.direction_input = ucb1x00_gpio_direction_input;
 		ucb->gpio.direction_output = ucb1x00_gpio_direction_output;
+		ucb->gpio.to_irq = ucb1x00_to_irq;
 		ret = gpiochip_add(&ucb->gpio);
 		if (ret)
 			goto err_gpio_add;
 	} else
 		dev_info(&ucb->dev, "gpio_base not set so no gpiolib support");
 
-	ret = request_irq(ucb->irq, ucb1x00_irq, IRQF_TRIGGER_RISING,
-			  "UCB1x00", ucb);
-	if (ret) {
-		dev_err(&ucb->dev, "ucb1x00: unable to grab irq%d: %d\n",
-			ucb->irq, ret);
-		goto err_irq;
-	}
-
 	mcp_set_drvdata(mcp, ucb);
 
 	INIT_LIST_HEAD(&ucb->devs);
@@ -629,10 +575,11 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 	return ret;
 
- err_irq:
-	if (ucb->gpio.base != -1)
-		temp = gpiochip_remove(&ucb->gpio);
  err_gpio_add:
+	irq_set_chained_handler(ucb->irq, NULL);
+ err_irq_alloc:
+	if (ucb->irq_base > 0)
+		irq_free_descs(ucb->irq_base, 16);
  err_no_irq:
 	device_del(&ucb->dev);
  err_dev_add:
@@ -664,7 +611,8 @@ static void ucb1x00_remove(struct mcp *mcp)
 			dev_err(&ucb->dev, "Can't remove gpio chip: %d\n", ret);
 	}
 
-	free_irq(ucb->irq, ucb);
+	irq_set_chained_handler(ucb->irq, NULL);
+	irq_free_descs(ucb->irq_base, 16);
 	device_unregister(&ucb->dev);
 
 	if (pdata && pdata->reset)
@@ -772,11 +720,6 @@ EXPORT_SYMBOL(ucb1x00_adc_enable);
 EXPORT_SYMBOL(ucb1x00_adc_read);
 EXPORT_SYMBOL(ucb1x00_adc_disable);
 
-EXPORT_SYMBOL(ucb1x00_hook_irq);
-EXPORT_SYMBOL(ucb1x00_free_irq);
-EXPORT_SYMBOL(ucb1x00_enable_irq);
-EXPORT_SYMBOL(ucb1x00_disable_irq);
-
 EXPORT_SYMBOL(ucb1x00_register_driver);
 EXPORT_SYMBOL(ucb1x00_unregister_driver);
 
diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
index 742d0c7..1e0e20c 100644
--- a/drivers/mfd/ucb1x00-ts.c
+++ b/drivers/mfd/ucb1x00-ts.c
@@ -20,8 +20,9 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
-#include <linux/smp.h>
+#include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/string.h>
@@ -41,6 +42,8 @@ struct ucb1x00_ts {
 	struct input_dev	*idev;
 	struct ucb1x00		*ucb;
 
+	spinlock_t		irq_lock;
+	unsigned		irq_disabled;
 	wait_queue_head_t	irq_wait;
 	struct task_struct	*rtask;
 	u16			x_res;
@@ -237,7 +240,12 @@ static int ucb1x00_thread(void *_ts)
 		if (ucb1x00_ts_pen_down(ts)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 
-			ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX, machine_is_collie() ? UCB_RISING : UCB_FALLING);
+			spin_lock_irq(&ts->irq_lock);
+			if (ts->irq_disabled) {
+				ts->irq_disabled = 0;
+				enable_irq(ts->ucb->irq_base + UCB_IRQ_TSPX);
+			}
+			spin_unlock_irq(&ts->irq_lock);
 			ucb1x00_disable(ts->ucb);
 
 			/*
@@ -280,23 +288,37 @@ static int ucb1x00_thread(void *_ts)
  * We only detect touch screen _touches_ with this interrupt
  * handler, and even then we just schedule our task.
  */
-static void ucb1x00_ts_irq(int idx, void *id)
+static irqreturn_t ucb1x00_ts_irq(int irq, void *id)
 {
 	struct ucb1x00_ts *ts = id;
 
-	ucb1x00_disable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
+	spin_lock(&ts->irq_lock);
+	ts->irq_disabled = 1;
+	disable_irq_nosync(ts->ucb->irq_base + UCB_IRQ_TSPX);
+	spin_unlock(&ts->irq_lock);
 	wake_up(&ts->irq_wait);
+
+	return IRQ_HANDLED;
 }
 
 static int ucb1x00_ts_open(struct input_dev *idev)
 {
 	struct ucb1x00_ts *ts = input_get_drvdata(idev);
+	unsigned long flags = 0;
 	int ret = 0;
 
 	BUG_ON(ts->rtask);
 
+	if (machine_is_collie())
+		flags = IRQF_TRIGGER_RISING;
+	else
+		flags = IRQF_TRIGGER_FALLING;
+
+	ts->irq_disabled = 0;
+
 	init_waitqueue_head(&ts->irq_wait);
-	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
+	ret = request_irq(ts->ucb->irq_base + UCB_IRQ_TSPX, ucb1x00_ts_irq,
+			  flags, "ucb1x00-ts", ts);
 	if (ret < 0)
 		goto out;
 
@@ -313,7 +335,7 @@ static int ucb1x00_ts_open(struct input_dev *idev)
 	if (!IS_ERR(ts->rtask)) {
 		ret = 0;
 	} else {
-		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+		free_irq(ts->ucb->irq_base + UCB_IRQ_TSPX, ts);
 		ts->rtask = NULL;
 		ret = -EFAULT;
 	}
@@ -333,7 +355,7 @@ static void ucb1x00_ts_close(struct input_dev *idev)
 		kthread_stop(ts->rtask);
 
 	ucb1x00_enable(ts->ucb);
-	ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+	free_irq(ts->ucb->irq_base + UCB_IRQ_TSPX, ts);
 	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, 0);
 	ucb1x00_disable(ts->ucb);
 }
@@ -358,6 +380,7 @@ static int ucb1x00_ts_add(struct ucb1x00_dev *dev)
 	ts->ucb = dev->ucb;
 	ts->idev = idev;
 	ts->adcsync = adcsync ? UCB_SYNC : UCB_NOSYNC;
+	spin_lock_init(&ts->irq_lock);
 
 	idev->name       = "Touchscreen panel";
 	idev->id.product = ts->ucb->id;
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 253c12c..6fb9074 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -112,18 +112,15 @@ enum ucb1x00_reset {
 
 struct ucb1x00_plat_data {
 	void			(*reset)(enum ucb1x00_reset);
+	unsigned		irq_base;
 	int			gpio_base;
 };
 
-struct ucb1x00_irq {
-	void *devid;
-	void (*fn)(int, void *);
-};
-
 struct ucb1x00 {
-	spinlock_t		lock;
+	raw_spinlock_t		irq_lock;
 	struct mcp		*mcp;
 	unsigned int		irq;
+	int			irq_base;
 	struct mutex		adc_mutex;
 	spinlock_t		io_lock;
 	u16			id;
@@ -132,7 +129,7 @@ struct ucb1x00 {
 	u16			adc_cr;
 	u16			irq_fal_enbl;
 	u16			irq_ris_enbl;
-	struct ucb1x00_irq	irq_handler[16];
+	u16			irq_mask;
 	struct device		dev;
 	struct list_head	node;
 	struct list_head	devs;
@@ -255,15 +252,4 @@ unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync);
 void ucb1x00_adc_enable(struct ucb1x00 *ucb);
 void ucb1x00_adc_disable(struct ucb1x00 *ucb);
 
-/*
- * Which edges of the IRQ do you want to control today?
- */
-#define UCB_RISING	(1 << 0)
-#define UCB_FALLING	(1 << 1)
-
-int ucb1x00_hook_irq(struct ucb1x00 *ucb, unsigned int idx, void (*fn)(int, void *), void *devid);
-void ucb1x00_enable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges);
-void ucb1x00_disable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges);
-int ucb1x00_free_irq(struct ucb1x00 *ucb, unsigned int idx, void *devid);
-
 #endif
-- 
1.7.4.4
