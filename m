From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2012 00:44:09 +0200
Subject: [PATCH 3/3] plat-versatile: internalize FPGA IRQ data
Message-ID: <1334184249-18932-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the FPGA IRQ data container into the implementation
and out of the public interface, it is only used internally now.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-versatile/fpga-irq.c              |   14 ++++++++++++++
 arch/arm/plat-versatile/include/plat/fpga-irq.h |    7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
index b7e06ea..dc57dcd 100644
--- a/arch/arm/plat-versatile/fpga-irq.c
+++ b/arch/arm/plat-versatile/fpga-irq.c
@@ -15,6 +15,20 @@
 #define IRQ_ENABLE_SET		0x08
 #define IRQ_ENABLE_CLEAR	0x0c
 
+/**
+ * struct fpga_irq_data - irq data container for the FPGA IRQ controller
+ * @base: memory offset in virtual memory
+ * @irq_start: first IRQ number handled by this instance
+ * @chip: chip container for this instance
+ * @domain: domain for this instance
+ */
+struct fpga_irq_data {
+	void __iomem *base;
+	unsigned int irq_start;
+	struct irq_chip chip;
+	struct irq_domain *domain;
+};
+
 /* we cannot allocate memory when VICs are initially registered */
 static struct fpga_irq_data fpga_irq_devices[CONFIG_PLAT_VERSATILE_FPGA_IRQ_NR];
 static int fpga_irq_id;
diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
index 7f8009a..91bcfb6 100644
--- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
+++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
@@ -1,13 +1,6 @@
 #ifndef PLAT_FPGA_IRQ_H
 #define PLAT_FPGA_IRQ_H
 
-struct fpga_irq_data {
-	void __iomem *base;
-	unsigned int irq_start;
-	struct irq_chip chip;
-	struct irq_domain *domain;
-};
-
 struct device_node;
 struct pt_regs;
 
-- 
1.7.7.6
