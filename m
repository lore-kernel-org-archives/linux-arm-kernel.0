From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:13 -0500
Subject: [PATCH v2 03/11] irqchip: versatile-fpga: add support for arm,
 versatile-sic
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The secondary controller on ARM Versatile AB and PB is similar to
other ARM platforms, but has a pass-thru register to connect some
interrupts directly to interrupt inputs on the primary interrupt
controller. The PIC_ENABLES register needs to be configured for
proper operation when the matching node is arm,versatile-sic. Add the
the necessary IRQCHIP_DECLARE as well.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
v2:
- Rework to use the compatible string for pass-thru register setup.

 drivers/irqchip/irq-versatile-fpga.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 8e0bb56..90bf131 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -28,6 +28,8 @@
 #define FIQ_ENABLE_SET		0x28
 #define FIQ_ENABLE_CLEAR	0x2C
 
+#define PIC_ENABLES             0x20	/* set interrupt pass through bits */
+
 /**
  * struct fpga_irq_data - irq data container for the FPGA IRQ controller
  * @base: memory offset in virtual memory
@@ -213,7 +215,15 @@ int __init fpga_irq_of_init(struct device_node *node,
 	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
 	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
 
+	/*
+	 * On Versatile AB/PB, some secondary interrupts have a direct
+	 * pass-thru to the primary controller which need to be enabled.
+	 */
+	if (of_device_is_compatible(node, "arm,versatile-sic"))
+		writel(0xffd00000, base + PIC_ENABLES);
+
 	return 0;
 }
 IRQCHIP_DECLARE(arm_fpga, "arm,versatile-fpga-irq", fpga_irq_of_init);
+IRQCHIP_DECLARE(arm_fpga_sic, "arm,versatile-sic", fpga_irq_of_init);
 #endif
-- 
1.9.1
