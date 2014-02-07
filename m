From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Feb 2014 12:29:19 +0100
Subject: [PATCH] gpio: mvebu: use chained_irq_{enter,
 exit} for GIC compatibility
Message-ID: <1391772559-28357-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On currently supported SoCs, the GPIO block used on Marvell EBU SoCs
is always connected to the Marvell MPIC. However, we are going to
introduce the support for newer Marvell EBU SoCs that use the
Cortex-A9 core, and therefore use the GIC as their main interrupt
controller, to which the GPIO block controlled by the gpio-mvebu
driver is connected.

The GIC interrupt controller driver uses the fasteoi flow handler. In
order to ensure that the eoi hook of the GIC driver gets called, the
GPIO driver should call chained_irq_enter() and chained_irq_exit() in
its handler. Without this, the first GPIO interrupt locks up the
system because it doesn't get acked at the GIC level.

This change is similar to for example commit
0d978eb7349941139241a99acf05de6dd49b78d1 ("gpio: davinci: use
chained_irq_enter/chained_irq_exit API").

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/gpio/gpio-mvebu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3b1fd1c..d425094 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -44,6 +44,7 @@
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/irqchip/chained_irq.h>
 
 /*
  * GPIO unit register offsets.
@@ -438,12 +439,15 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct mvebu_gpio_chip *mvchip = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	u32 cause, type;
 	int i;
 
 	if (mvchip == NULL)
 		return;
 
+	chained_irq_enter(chip, desc);
+
 	cause = readl_relaxed(mvebu_gpioreg_data_in(mvchip)) &
 		readl_relaxed(mvebu_gpioreg_level_mask(mvchip));
 	cause |= readl_relaxed(mvebu_gpioreg_edge_cause(mvchip)) &
@@ -466,8 +470,11 @@ static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			polarity ^= 1 << i;
 			writel_relaxed(polarity, mvebu_gpioreg_in_pol(mvchip));
 		}
+
 		generic_handle_irq(irq);
 	}
+
+	chained_irq_exit(chip, desc);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.8.3.2
