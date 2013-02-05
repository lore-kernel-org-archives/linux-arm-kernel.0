From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:22 +0100
Subject: [PATCH 01/14] mfd: ab8500: prepare to handle AB8500 GPIO's IRQs
 correctly
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-2-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

In an upcoming patch, the gpio-ab8500 driver will relinquish all
IRQ handling capability and pass it back into the AB8500 core
driver. This will aid in reducing massive code duplication within
the kernel. Also, most of the functionality is already in the
AB8500 core driver, as the GPIO IRQs are actually sandwiched
between lots of other IRQs which the core driver already handles.

All we're doing here is providing the core driver with knowledge
that each GPIO has two IRQs assigned to it; one for rising and
a separate one for falling.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, it'd be nice if you could ACK these first four patches,
the series basically simplifies things a lot by not cascading
the AB8500 IRQs and duplicate code in the pinctrl driver.
---
 drivers/mfd/ab8500-core.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index e1650ba..e1ba0be 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -367,16 +367,40 @@ static void ab8500_irq_mask(struct irq_data *data)
 	int mask = 1 << (offset % 8);
 
 	ab8500->mask[index] |= mask;
+
+	/* The AB8500 GPIOs have two interrupts each (rising & falling). */
+	if (offset >= AB8500_INT_GPIO6R && offset <= AB8500_INT_GPIO41R)
+		ab8500->mask[index + 2] |= mask;
+	if (offset >= AB9540_INT_GPIO50R && offset <= AB9540_INT_GPIO54R)
+		ab8500->mask[index + 1] |= mask;
+	if (offset == AB8540_INT_GPIO43R || offset == AB8540_INT_GPIO44R)
+		ab8500->mask[index] |= (mask >> 1);
 }
 
 static void ab8500_irq_unmask(struct irq_data *data)
 {
 	struct ab8500 *ab8500 = irq_data_get_irq_chip_data(data);
+	unsigned int type = irqd_get_trigger_type(data);
 	int offset = data->hwirq;
 	int index = offset / 8;
 	int mask = 1 << (offset % 8);
 
-	ab8500->mask[index] &= ~mask;
+	if (type & IRQ_TYPE_EDGE_RISING)
+		ab8500->mask[index] &= ~mask;
+
+	/* The AB8500 GPIOs have two interrupts each (rising & falling). */
+	if (type & IRQ_TYPE_EDGE_FALLING) {
+		if (offset >= AB8500_INT_GPIO6R && offset <= AB8500_INT_GPIO41R)
+			ab8500->mask[index + 2] &= ~mask;
+		else if (offset >= AB9540_INT_GPIO50R && offset <= AB9540_INT_GPIO54R)
+			ab8500->mask[index + 1] &= ~mask;
+		else if (offset == AB8540_INT_GPIO43R || offset == AB8540_INT_GPIO44R)
+			ab8500->mask[index] &= ~(mask >> 1);
+		else
+			ab8500->mask[index] &= ~mask;
+	} else
+		/* Satisfies the case where type is not set. */
+		ab8500->mask[index] &= ~mask;
 }
 
 static struct irq_chip ab8500_irq_chip = {
-- 
1.7.11.3
