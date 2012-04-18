From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 18 Apr 2012 17:30:43 +0200
Subject: [PATCH 1/2] ARM: VIC: respect list of valid sources
Message-ID: <1334763043-19304-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The current IRQ domain implementation in the VIC allocates 32
interrupts for each VIC instance no matter whether the
controller actually use all the IRQs or not. Alter this so
we only allocate a domain up until the last IRQ marked valid.

Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/vic.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7e288f9..c558a3e 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -168,6 +168,7 @@ late_initcall(vic_pm_init);
  * vic_register() - Register a VIC.
  * @base: The base address of the VIC.
  * @irq: The base IRQ for the VIC.
+ * @valid_sources: bitmask of valid interrupts
  * @resume_sources: bitmask of interrupts allowed for resume sources.
  * @node: The device tree node associated with the VIC.
  *
@@ -178,7 +179,8 @@ late_initcall(vic_pm_init);
  * This also configures the IRQ domain for the VIC.
  */
 static void __init vic_register(void __iomem *base, unsigned int irq,
-				u32 resume_sources, struct device_node *node)
+				u32 valid_sources, u32 resume_sources,
+				struct device_node *node)
 {
 	struct vic_device *v;
 
@@ -192,8 +194,8 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	v->resume_sources = resume_sources;
 	v->irq = irq;
 	vic_id++;
-	v->domain = irq_domain_add_legacy(node, 32, irq, 0,
-					  &irq_domain_simple_ops, v);
+	v->domain = irq_domain_add_legacy(node, fls(valid_sources), irq, 0,
+					  &vic_irqdomain_ops, v);
 }
 
 static void vic_ack_irq(struct irq_data *d)
@@ -339,7 +341,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	}
 
 	vic_set_irq_sources(base, irq_start, vic_sources);
-	vic_register(base, irq_start, 0, node);
+	vic_register(base, irq_start, vic_sources, 0, node);
 }
 
 void __init __vic_init(void __iomem *base, unsigned int irq_start,
@@ -381,7 +383,7 @@ void __init __vic_init(void __iomem *base, unsigned int irq_start,
 
 	vic_set_irq_sources(base, irq_start, vic_sources);
 
-	vic_register(base, irq_start, resume_sources, node);
+	vic_register(base, irq_start, vic_sources, resume_sources, node);
 }
 
 /**
-- 
1.7.9.2
