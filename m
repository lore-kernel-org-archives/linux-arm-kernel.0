From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Aug 2018 13:03:29 +0200
Subject: [PATCH 2/2] gpio: ftgpio: Support debounce timer
Message-ID: <20180826110329.17778-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FTGPIO010 has a debounce timer or rather prescaler that
will affect interrupts fireing off the block. We can support
this to get proper debounce on e.g. keypresses.

Since the same prescaler is used across all GPIO lines of
the silicon block, we need to bail out if the prescaler is
already set and in use by another line.

If the prescaler is already set to what we need, fine, we
reuse it. This happens more often than not when the same
debounce time is set for several GPIO keys, so we support
that usecase easily with this code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ftgpio010.c | 74 +++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index c26feab143a3..3645607440b5 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -161,6 +161,73 @@ static void ftgpio_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static int ftgpio_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
+				  unsigned long config)
+{
+	enum pin_config_param param = pinconf_to_config_param(config);
+	u32 arg = pinconf_to_config_argument(config);
+	struct ftgpio_gpio *g = gpiochip_get_data(gc);
+	unsigned long pclk_freq;
+	u32 deb_div;
+	u32 val;
+
+	if (param != PIN_CONFIG_INPUT_DEBOUNCE)
+		return -ENOTSUPP;
+
+	/*
+	 * Debounce only works if interrupts are enabled. The manual
+	 * states that if PCLK is 66 MHz, and this is set to 0x7D0, then
+	 * PCLK is divided down to 33 kHz for the debounce timer. 0x7D0 is
+	 * 2000 decimal, so what they mean is simply that the PCLK is
+	 * divided by this value.
+	 *
+	 * As we get a debounce setting in microseconds, we calculate the
+	 * desired period time and see if we can get a suitable debounce
+	 * time.
+	 */
+	pclk_freq = clk_get_rate(g->clk);
+	deb_div = DIV_ROUND_CLOSEST(pclk_freq, arg);
+
+	/* This register is only 24 bits wide */
+	if (deb_div > (1 << 24))
+		return -ENOTSUPP;
+
+	dev_dbg(g->dev, "prescale divisor: %08x, resulting frequency %lu Hz\n",
+		deb_div, (pclk_freq/deb_div));
+
+	val = readl(g->base + GPIO_DEBOUNCE_PRESCALE);
+	if (val == deb_div) {
+		/*
+		 * The debounce timer happens to already be set to the
+		 * desireable value, what a coincidence! We can just enable
+		 * debounce on this GPIO line and return. This happens more
+		 * often than you think, for example when all GPIO keys
+		 * on a system are requesting the same debounce interval.
+		 */
+		val = readl(g->base + GPIO_DEBOUNCE_EN);
+		val |= BIT(offset);
+		writel(val, g->base + GPIO_DEBOUNCE_EN);
+		return 0;
+	}
+
+	val = readl(g->base + GPIO_DEBOUNCE_EN);
+	if (val) {
+		/*
+		 * Oh no! Someone is already using the debounce with
+		 * another setting than what we need. Bummer.
+		 */
+		return -ENOTSUPP;
+	}
+
+	/* First come, first serve */
+	writel(deb_div, g->base + GPIO_DEBOUNCE_PRESCALE);
+	/* Enable debounce */
+	val |= BIT(offset);
+	writel(val, g->base + GPIO_DEBOUNCE_EN);
+
+	return 0;
+}
+
 static int ftgpio_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -208,6 +275,10 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	g->gc.owner = THIS_MODULE;
 	/* ngpio is set by bgpio_init() */
 
+	/* We need a silicon clock to do debounce */
+	if (!IS_ERR(g->clk))
+		g->gc.set_config = ftgpio_gpio_set_config;
+
 	ret = devm_gpiochip_add_data(dev, &g->gc, g);
 	if (ret)
 		goto dis_clk;
@@ -217,6 +288,9 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	writel(0x0, g->base + GPIO_INT_MASK);
 	writel(~0x0, g->base + GPIO_INT_CLR);
 
+	/* Clear any use of debounce */
+	writel(val, g->base + GPIO_DEBOUNCE_EN);
+
 	ret = gpiochip_irqchip_add(&g->gc, &ftgpio_gpio_irqchip,
 				   0, handle_bad_irq,
 				   IRQ_TYPE_NONE);
-- 
2.17.1
