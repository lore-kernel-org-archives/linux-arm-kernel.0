From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 18 Apr 2012 17:30:54 +0200
Subject: [PATCH 2/2] ARM: VIC: use the domain mapping function to assign
 handlers
Message-ID: <1334763054-19340-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This removes the internal functions for assigning IRQ
handlers to each interrupt in favor of using the internal
map iterator in the irq domain code.

Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/vic.c |   44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index c558a3e..e0d5388 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -39,6 +39,7 @@
  * struct vic_device - VIC PM device
  * @irq: The IRQ number for the base of the VIC.
  * @base: The register base for the VIC.
+ * @valid_sources: A bitmask of valid interrupts
  * @resume_sources: A bitmask of interrupts for resume.
  * @resume_irqs: The IRQs enabled for resume.
  * @int_select: Save for VIC_INT_SELECT.
@@ -50,6 +51,7 @@
 struct vic_device {
 	void __iomem	*base;
 	int		irq;
+	u32		valid_sources;
 	u32		resume_sources;
 	u32		resume_irqs;
 	u32		int_select;
@@ -164,6 +166,27 @@ static int __init vic_pm_init(void)
 late_initcall(vic_pm_init);
 #endif /* CONFIG_PM */
 
+static struct irq_chip vic_chip;
+
+static int vic_irqdomain_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	struct vic_device *v = d->host_data;
+
+	/* Skip invalid IRQs, only register handlers for the real ones */
+	if (!(v->valid_sources & (1 << hwirq)))
+		return -ENOTSUPP;
+	irq_set_chip_and_handler(irq, &vic_chip, handle_level_irq);
+	irq_set_chip_data(irq, v->base);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
+
+static struct irq_domain_ops vic_irqdomain_ops = {
+	.map = vic_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
 /**
  * vic_register() - Register a VIC.
  * @base: The base address of the VIC.
@@ -191,6 +214,7 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 
 	v = &vic_devices[vic_id];
 	v->base = base;
+	v->valid_sources = valid_sources;
 	v->resume_sources = resume_sources;
 	v->irq = irq;
 	vic_id++;
@@ -289,23 +313,6 @@ static void __init vic_clear_interrupts(void __iomem *base)
 	}
 }
 
-static void __init vic_set_irq_sources(void __iomem *base,
-				unsigned int irq_start, u32 vic_sources)
-{
-	unsigned int i;
-
-	for (i = 0; i < 32; i++) {
-		if (vic_sources & (1 << i)) {
-			unsigned int irq = irq_start + i;
-
-			irq_set_chip_and_handler(irq, &vic_chip,
-						 handle_level_irq);
-			irq_set_chip_data(irq, base);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		}
-	}
-}
-
 /*
  * The PL190 cell from ARM has been modified by ST to handle 64 interrupts.
  * The original cell has 32 interrupts, while the modified one has 64,
@@ -340,7 +347,6 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 		writel(32, base + VIC_PL190_DEF_VECT_ADDR);
 	}
 
-	vic_set_irq_sources(base, irq_start, vic_sources);
 	vic_register(base, irq_start, vic_sources, 0, node);
 }
 
@@ -381,8 +387,6 @@ void __init __vic_init(void __iomem *base, unsigned int irq_start,
 
 	vic_init2(base);
 
-	vic_set_irq_sources(base, irq_start, vic_sources);
-
 	vic_register(base, irq_start, vic_sources, resume_sources, node);
 }
 
-- 
1.7.9.2
