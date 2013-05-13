From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 13 May 2013 17:53:51 +0900
Subject: [PATCH 1/3] gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH
In-Reply-To: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1368435233-8587-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As hardware support for this feature is not universal for all SoCs a flag,
has_both_edge_trigger, has been added to the platform data of the driver to
allow this feature to be enabled.

The motivation for this is to allow use of the gpio-keys driver on the
lager board which is based on the r8a7790 SoC. This patch has been lightly
exercised using that driver on that board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/gpio/gpio-rcar.c                | 27 ++++++++++++++++++++++-----
 include/linux/platform_data/gpio-rcar.h |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 0f3d647..33d8f6a 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -49,6 +49,7 @@ struct gpio_rcar_priv {
 #define POSNEG 0x20
 #define EDGLEVEL 0x24
 #define FILONOFF 0x28
+#define BOTHEDGE 0x4c
 
 static inline u32 gpio_rcar_read(struct gpio_rcar_priv *p, int offs)
 {
@@ -91,7 +92,8 @@ static void gpio_rcar_irq_enable(struct irq_data *d)
 static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 						  unsigned int hwirq,
 						  bool active_high_rising_edge,
-						  bool level_trigger)
+						  bool level_trigger,
+						  bool both)
 {
 	unsigned long flags;
 
@@ -111,6 +113,11 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	/* Select "Interrupt Input Mode" in IOINTSEL */
 	gpio_rcar_modify_bit(p, IOINTSEL, hwirq, true);
 
+	if (p->config.has_both_edge_trigger && !level_trigger) {
+		/* Select one edge or both edges in BOTHEDGE */
+		gpio_rcar_modify_bit(p, IOINTSEL, hwirq, both);
+	}
+
 	/* Write INTCLR in case of edge trigger */
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
@@ -127,16 +134,26 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_HIGH:
-		gpio_rcar_config_interrupt_input_mode(p, hwirq, true, true);
+		gpio_rcar_config_interrupt_input_mode(p, hwirq, true, true,
+						      false);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		gpio_rcar_config_interrupt_input_mode(p, hwirq, false, true);
+		gpio_rcar_config_interrupt_input_mode(p, hwirq, false, true,
+						      false);
 		break;
 	case IRQ_TYPE_EDGE_RISING:
-		gpio_rcar_config_interrupt_input_mode(p, hwirq, true, false);
+		gpio_rcar_config_interrupt_input_mode(p, hwirq, true, false,
+						      false);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		gpio_rcar_config_interrupt_input_mode(p, hwirq, false, false);
+		gpio_rcar_config_interrupt_input_mode(p, hwirq, false, false,
+						      false);
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		if (!p->config.has_both_edge_trigger)
+			return -EINVAL;
+		gpio_rcar_config_interrupt_input_mode(p, hwirq, true, false,
+						      true);
 		break;
 	default:
 		return -EINVAL;
diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index cc472f6..dfea5c6 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -21,6 +21,7 @@ struct gpio_rcar_config {
 	unsigned int irq_base;
 	unsigned int number_of_pins;
 	const char *pctl_name;
+	unsigned has_both_edge_trigger:1;
 };
 
 #define RCAR_GP_PIN(bank, pin)		(((bank) * 32) + (pin))
-- 
1.8.2.1
