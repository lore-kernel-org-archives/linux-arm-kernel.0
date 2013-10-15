From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:49:56 +0200
Subject: [PATCH 6/6] pinctrl: rockchip: emulate both edge triggered interrupts
In-Reply-To: <201310151246.49402.heiko@sntech.de>
References: <201310151246.49402.heiko@sntech.de>
Message-ID: <201310151249.56469.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio interrupt controller on Rockchip socs can do edge triggers only
for single edges but not both. Nevertheless a lot of gpio users rely on
the availability of both-edge triggered interrupts - i.e. gpio-keys.

Therefore implement a solution similar to pinctrl-coh901 re-setting the
triggering edge depending on the gpio value in the interrupt demuxer.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c |   61 +++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 4db286c..e8988a1 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -101,7 +101,7 @@ struct rockchip_pin_bank {
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	grange;
 	spinlock_t			slock;
-
+	u32				toggle_edge_mode;
 };
 
 #define PIN_BANK(id, pins, label)			\
@@ -1076,7 +1076,9 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
 	struct rockchip_pin_bank *bank = irq_get_handler_data(irq);
+	u32 polarity = 0, data = 0;
 	u32 pend;
+	bool edge_changed = false;
 
 	dev_dbg(bank->drvdata->dev, "got irq for bank %s\n", bank->name);
 
@@ -1084,6 +1086,12 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 
 	pend = readl_relaxed(bank->reg_base + GPIO_INT_STATUS);
 
+	if (bank->toggle_edge_mode) {
+		polarity = readl_relaxed(bank->reg_base +
+					 GPIO_INT_POLARITY);
+		data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
+	}
+
 	while (pend) {
 		unsigned int virq;
 
@@ -1098,9 +1106,30 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 
 		dev_dbg(bank->drvdata->dev, "handling irq %d\n", irq);
 
+		/*
+		 * Triggering IRQ on both rising and falling edge
+		 * needs manual intervention.
+		 */
+		if (bank->toggle_edge_mode & BIT(irq)) {
+			if (data & BIT(irq))
+				polarity &= ~BIT(irq);
+			else
+				polarity |= BIT(irq);
+
+			edge_changed = true;
+		}
+
 		generic_handle_irq(virq);
 	}
 
+	if (bank->toggle_edge_mode && edge_changed) {
+		/* Interrupt params should only be set with ints disabled */
+		data = readl_relaxed(bank->reg_base + GPIO_INTEN);
+		writel_relaxed(0, bank->reg_base + GPIO_INTEN);
+		writel(polarity, bank->reg_base + GPIO_INT_POLARITY);
+		writel(data, bank->reg_base + GPIO_INTEN);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
@@ -1113,6 +1142,12 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	u32 level;
 	u32 data;
 
+	/* make sure the pin is configured as gpio input */
+	rockchip_set_mux(bank, d->hwirq, RK_FUNC_GPIO);
+	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
+	data &= ~mask;
+	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
+
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		__irq_set_handler_locked(d->irq, handle_edge_irq);
 	else
@@ -1124,19 +1159,37 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	polarity = readl_relaxed(gc->reg_base + GPIO_INT_POLARITY);
 
 	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+		bank->toggle_edge_mode |= mask;
+		level |= mask;
+
+		/*
+		 * Determine gpio state. If 1 next interrupt should be falling
+		 * otherwise rising.
+		 */
+		data = readl(bank->reg_base + GPIO_EXT_PORT);
+		if (data & mask)
+			polarity &= ~mask;
+		else
+			polarity |= mask;
+		break;
 	case IRQ_TYPE_EDGE_RISING:
+		bank->toggle_edge_mode &= ~mask;
 		level |= mask;
 		polarity |= mask;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
+		bank->toggle_edge_mode &= ~mask;
 		level |= mask;
 		polarity &= ~mask;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
+		bank->toggle_edge_mode &= ~mask;
 		level &= ~mask;
 		polarity |= mask;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
+		bank->toggle_edge_mode &= ~mask;
 		level &= ~mask;
 		polarity &= ~mask;
 		break;
@@ -1150,12 +1203,6 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 
 	irq_gc_unlock(gc);
 
-	/* make sure the pin is configured as gpio input */
-	rockchip_set_mux(bank, d->hwirq, RK_FUNC_GPIO);
-	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
-	data &= ~mask;
-	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
-
 	return 0;
 }
 
-- 
1.7.10.4
