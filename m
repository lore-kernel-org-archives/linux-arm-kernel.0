From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  7 Sep 2017 16:54:07 +0200
Subject: [PATCH] pinctrl: armada-37xx: Fix gpio interrupt setup
Message-ID: <20170907145407.32368-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit dc749a09ea5e ("gpiolib: allow gpio irqchip to map irqs
dynamically"), the irqs for gpio are not statically allocated during in
gpiochip_irqchip_add.

This driver was based on this assumption for initializing the mask
associated to each interrupt this led to a NULL pointer crash in the
kernel:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
Mem abort info:
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000068
  CM = 0, WnR = 1
[0000000000000000] user address but active_mm is swapper
Internal error: Oops: 96000044 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-06657-g3b9f8ed25dbe #576
Hardware name: Marvell Armada 3720 Development Board DB-88F3720-DDR3 (DT)
task: ffff80001d908000 task.stack: ffff000008068000
PC is at armada_37xx_pinctrl_probe+0x5f8/0x670
LR is at armada_37xx_pinctrl_probe+0x5e8/0x670
pc : [<ffff000008e25cdc>] lr : [<ffff000008e25ccc>] pstate: 60000045
sp : ffff00000806bb80
x29: ffff00000806bb80 x28: 0000000000000024
x27: 000000000000000c x26: 0000000000000001
x25: ffff80001efee760 x24: 0000000000000000
x23: ffff80001db6f570 x22: ffff80001db6f438
x21: 0000000000000000 x20: ffff80001d9f4810
x19: ffff80001db6f418 x18: 0000000000000000
x17: 0000000000000001 x16: 0000000000000019
x15: ffffffffffffffff x14: 0140000000000000
x13: 0000000000000000 x12: 0000000000000030
x11: 0101010101010101 x10: 0000000000000040
x9 : ffff000009923580 x8 : ffff80001d400248
x7 : ffff80001d400270 x6 : 0000000000000000
x5 : ffff80001d400248 x4 : ffff80001d400270
x3 : 0000000000000000 x2 : 0000000000000001
x1 : 0000000000000001 x0 : 0000000000000000
Process swapper/0 (pid: 1, stack limit = 0xffff000008068000)
Call trace:
Exception stack(0xffff00000806ba40 to 0xffff00000806bb80)
ba40: 0000000000000000 0000000000000001 0000000000000001 0000000000000000
ba60: ffff80001d400270 ffff80001d400248 0000000000000000 ffff80001d400270
ba80: ffff80001d400248 ffff000009923580 0000000000000040 0101010101010101
baa0: 0000000000000030 0000000000000000 0140000000000000 ffffffffffffffff
bac0: 0000000000000019 0000000000000001 0000000000000000 ffff80001db6f418
bae0: ffff80001d9f4810 0000000000000000 ffff80001db6f438 ffff80001db6f570
bb00: 0000000000000000 ffff80001efee760 0000000000000001 000000000000000c
bb20: 0000000000000024 ffff00000806bb80 ffff000008e25ccc ffff00000806bb80
bb40: ffff000008e25cdc 0000000060000045 ffff00000806bb60 ffff0000081189b8
bb60: ffffffffffffffff ffff00000811cf1c ffff00000806bb80 ffff000008e25cdc
[<ffff000008e25cdc>] armada_37xx_pinctrl_probe+0x5f8/0x670
[<ffff00000859d8c8>] platform_drv_probe+0x58/0xb8
[<ffff00000859bb44>] driver_probe_device+0x22c/0x2d8
[<ffff00000859bcac>] __driver_attach+0xbc/0xc0
[<ffff000008599c84>] bus_for_each_dev+0x4c/0x98
[<ffff00000859b440>] driver_attach+0x20/0x28
[<ffff00000859af90>] bus_add_driver+0x1b8/0x228
[<ffff00000859c648>] driver_register+0x60/0xf8
[<ffff00000859df64>] __platform_driver_probe+0x74/0x130
[<ffff000008e256dc>] armada_37xx_pinctrl_driver_init+0x20/0x28
[<ffff000008083980>] do_one_initcall+0x38/0x128
[<ffff000008e00cf4>] kernel_init_freeable+0x188/0x22c
[<ffff0000089b56e8>] kernel_init+0x10/0x100
[<ffff000008084bb0>] ret_from_fork+0x10/0x18
Code: f9403fa2 12001341 1100075a 9ac12041 (b9000001)
---[ end trace 8b0f4e05e1603208 ]---

This patch moves the initialization of the mask field in the irq_startup
function. However some callbacks such as irq_set_type and irq_set_wake
could be called before irq_startup. For those functions the mask is
computed at each call which is not a issue as these functions are not
located in a hot path but are used sporadically for configuration.

Fixes: dc749a09ea5e ("gpiolib: allow gpio irqchip to map irqs
dynamically")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi Linus,

It would be very nice if you could appliy this patch for being merged in v4.14-rc1.

Thanks,

Gregory

 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 41 ++++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index b8b6ab072cd0..71b944748304 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -550,9 +550,9 @@ static int armada_37xx_irq_set_wake(struct irq_data *d, unsigned int on)
 	spin_lock_irqsave(&info->irq_lock, flags);
 	val = readl(info->base + reg);
 	if (on)
-		val |= d->mask;
+		val |= (BIT(d->hwirq % GPIO_PER_REG));
 	else
-		val &= ~d->mask;
+		val &= ~(BIT(d->hwirq % GPIO_PER_REG));
 	writel(val, info->base + reg);
 	spin_unlock_irqrestore(&info->irq_lock, flags);
 
@@ -571,10 +571,10 @@ static int armada_37xx_irq_set_type(struct irq_data *d, unsigned int type)
 	val = readl(info->base + reg);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		val &= ~d->mask;
+		val &= ~(BIT(d->hwirq % GPIO_PER_REG));
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		val |= d->mask;
+		val |= (BIT(d->hwirq % GPIO_PER_REG));
 		break;
 	default:
 		spin_unlock_irqrestore(&info->irq_lock, flags);
@@ -624,11 +624,27 @@ static void armada_37xx_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static unsigned int armada_37xx_irq_startup(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int irq = d->hwirq - chip->irq_base;
+	/*
+	 * The mask field is a "precomputed bitmask for accessing the
+	 * chip registers" which was introduced for the generic
+	 * irqchip framework. As we don't use this framework, we can
+	 * reuse this field for our own usage.
+	 */
+	d->mask = BIT(irq % GPIO_PER_REG);
+
+	armada_37xx_irq_unmask(d);
+
+	return 0;
+}
+
 static int armada_37xx_irqchip_register(struct platform_device *pdev,
 					struct armada_37xx_pinctrl *info)
 {
 	struct device_node *np = info->dev->of_node;
-	int nrirqs = info->data->nr_pins;
 	struct gpio_chip *gc = &info->gpio_chip;
 	struct irq_chip *irqchip = &info->irq_chip;
 	struct resource res;
@@ -666,8 +682,8 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	irqchip->irq_unmask = armada_37xx_irq_unmask;
 	irqchip->irq_set_wake = armada_37xx_irq_set_wake;
 	irqchip->irq_set_type = armada_37xx_irq_set_type;
+	irqchip->irq_startup = armada_37xx_irq_startup;
 	irqchip->name = info->data->name;
-
 	ret = gpiochip_irqchip_add(gc, irqchip, 0,
 				   handle_edge_irq, IRQ_TYPE_NONE);
 	if (ret) {
@@ -680,19 +696,6 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	 * controller. But we do not take advantage of this and use
 	 * the chained irq with all of them.
 	 */
-	for (i = 0; i < nrirqs; i++) {
-		struct irq_data *d = irq_get_irq_data(gc->irq_base + i);
-
-		/*
-		 * The mask field is a "precomputed bitmask for
-		 * accessing the chip registers" which was introduced
-		 * for the generic irqchip framework. As we don't use
-		 * this framework, we can reuse this field for our own
-		 * usage.
-		 */
-		d->mask = BIT(i % GPIO_PER_REG);
-	}
-
 	for (i = 0; i < nr_irq_parent; i++) {
 		int irq = irq_of_parse_and_map(np, i);
 
-- 
2.14.1
