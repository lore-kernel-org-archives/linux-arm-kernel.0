From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 Sep 2014 19:09:26 +0200
Subject: [PATCH 5/9] gpio: vf610: Extend with wakeup support
In-Reply-To: <cover.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
Message-ID: <704b6bb97147b3d0ee1557b43d85ab9376c28666.1411404079.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support Vybrid GPIO's as wakeup source by requesting the parent
IRQ as wakeup IRQ.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpio/gpio-vf610.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 5f59424..50326af 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -196,12 +196,28 @@ static void vf610_gpio_irq_unmask(struct irq_data *d)
 			  pcr_base);
 }
 
+static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
+{
+	struct vf610_gpio_port *port = irq_data_get_irq_chip_data(d);
+
+	if (enable)
+		enable_irq_wake(port->irq);
+	else
+		disable_irq_wake(port->irq);
+
+	return 0;
+}
+
+
 static struct irq_chip vf610_gpio_irq_chip = {
 	.name		= "gpio-vf610",
 	.irq_ack	= vf610_gpio_irq_ack,
 	.irq_mask	= vf610_gpio_irq_mask,
 	.irq_unmask	= vf610_gpio_irq_unmask,
 	.irq_set_type	= vf610_gpio_irq_set_type,
+#ifdef CONFIG_PM_SLEEP
+	.irq_set_wake	= vf610_gpio_irq_set_wake,
+#endif
 };
 
 static int vf610_gpio_probe(struct platform_device *pdev)
-- 
2.1.0
