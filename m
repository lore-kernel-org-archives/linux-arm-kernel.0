From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Mon, 27 Feb 2017 14:49:28 +0100
Subject: [PATCH 1/1] pinctrl: st: add irq_request_resources callback
Message-ID: <1488203368-13574-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

When using GPIO as IRQ source, the GPIO must be configured
in INPUT. The callback dedicated for this was missing in
pinctrl-st driver.

This fix the following kernel error when trying to lock a gpio
as IRQ:

[    7.521095] gpio gpiochip7: (PIO11): gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
[    7.526018] gpio gpiochip7: (PIO11): unable to lock HW IRQ 6 for IRQ
[    7.529405] genirq: Failed to request resources for 0-0053 (irq 81) on irqchip GPIO

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 676efcc..84c2af8 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1285,6 +1285,14 @@ static void st_gpio_irq_unmask(struct irq_data *d)
 	writel(BIT(d->hwirq), bank->base + REG_PIO_SET_PMASK);
 }
 
+static int st_gpio_irq_request_resources(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	int pin = d->hwirq;
+
+	return st_gpio_direction_input(gc, pin);
+}
+
 static int st_gpio_irq_set_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -1438,12 +1446,13 @@ static void st_gpio_irqmux_handler(struct irq_desc *desc)
 };
 
 static struct irq_chip st_gpio_irqchip = {
-	.name		= "GPIO",
-	.irq_disable	= st_gpio_irq_mask,
-	.irq_mask	= st_gpio_irq_mask,
-	.irq_unmask	= st_gpio_irq_unmask,
-	.irq_set_type	= st_gpio_irq_set_type,
-	.flags		= IRQCHIP_SKIP_SET_WAKE,
+	.name			= "GPIO",
+	.irq_request_resources	= st_gpio_irq_request_resources,
+	.irq_disable		= st_gpio_irq_mask,
+	.irq_mask		= st_gpio_irq_mask,
+	.irq_unmask		= st_gpio_irq_unmask,
+	.irq_set_type		= st_gpio_irq_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int st_gpiolib_register_bank(struct st_pinctrl *info,
-- 
1.9.1
