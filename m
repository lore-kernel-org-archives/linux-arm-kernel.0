From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:29 -0500
Subject: [PATCH 03/10] irqchip: versatile-fpga: add pass-thru enable support
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Set the PIC_ENABLES register when the passthru-mask property is present.
This enables interrupts on the secondary controller to be passed thru
directly to the primary controller.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-versatile-fpga.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 3ae2bb8..328440b 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -26,6 +26,8 @@
 #define FIQ_ENABLE_SET		0x28
 #define FIQ_ENABLE_CLEAR	0x2C
 
+#define PIC_ENABLES             0x20	/* set interrupt pass through bits */
+
 /**
  * struct fpga_irq_data - irq data container for the FPGA IRQ controller
  * @base: memory offset in virtual memory
@@ -185,6 +187,7 @@ int __init fpga_irq_of_init(struct device_node *node,
 	void __iomem *base;
 	u32 clear_mask;
 	u32 valid_mask;
+	u32 passthru_mask;
 	int parent_irq;
 
 	if (WARN_ON(!node))
@@ -209,6 +212,9 @@ int __init fpga_irq_of_init(struct device_node *node,
 	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
 	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
 
+	if (!of_property_read_u32(node, "passthru-mask", &passthru_mask))
+		writel(passthru_mask, base + PIC_ENABLES);
+
 	return 0;
 }
 #endif
-- 
1.9.1
