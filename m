From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 23 Oct 2012 15:56:41 +0200
Subject: [PATCH 1/1] gpio/at91: auto request and configure the pio as input
 when the interrupt is used via DT
Message-ID: <1351000601-3141-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we do this

	interrupt-parent = <&pioA>;
	interrupts = <7 0x0>;

The current core map the irq correctly but the gpio is not configured as input.
The pinctrl configure the pin as gpio with the correct mux parameter but is
not responsible to configure it as input.

So do it during the xlate

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/pinctrl/pinctrl-at91.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 01bf924..7d95c80 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1255,9 +1255,33 @@ static int at91_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	return 0;
 }
 
+int at91_gpio_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+			const u32 *intspec, unsigned int intsize,
+			irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	struct at91_gpio_chip *at91_gpio = d->host_data;
+	int ret;
+	int pin = at91_gpio->chip.base + intspec[0];
+
+	if (WARN_ON(intsize < 2))
+		return -EINVAL;
+	*out_hwirq = intspec[0];
+	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+
+	ret = gpio_request(pin, ctrlr->full_name);
+	if (ret)
+		return ret;
+
+	ret = gpio_direction_input(pin);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static struct irq_domain_ops at91_gpio_ops = {
 	.map	= at91_gpio_irq_map,
-	.xlate	= irq_domain_xlate_twocell,
+	.xlate	= at91_gpio_irq_domain_xlate,
 };
 
 static int at91_gpio_of_irq_setup(struct device_node *node,
-- 
1.7.10.4
