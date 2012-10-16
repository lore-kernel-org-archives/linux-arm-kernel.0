From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 16 Oct 2012 15:06:26 +0200
Subject: [PATCH] ARM: VIC: use irq_domain_add_simple()
Message-ID: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Instead of allocating descriptors on-the-fly for the device tree
initialization case, use irq_domain_add_simple() which will take
care of this if you pass negative as the first_irq.

Alter the signature of __vic_init() to pass the first_irq as
signed so this works as expected.

Switching the VIC to use irq_domain_add_simple() also has the
upside of displaying the same WARNING when you boot with
pre-allocated descriptors on systems using SPARSE_IRQ but
yet not using device tree.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/vic.c               | 18 ++++++------------
 arch/arm/include/asm/hardware/vic.h |  2 +-
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index e0d5388..4fd5d98 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -218,7 +218,7 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	v->resume_sources = resume_sources;
 	v->irq = irq;
 	vic_id++;
-	v->domain = irq_domain_add_legacy(node, fls(valid_sources), irq, 0,
+	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
 					  &vic_irqdomain_ops, v);
 }
 
@@ -350,7 +350,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	vic_register(base, irq_start, vic_sources, 0, node);
 }
 
-void __init __vic_init(void __iomem *base, unsigned int irq_start,
+void __init __vic_init(void __iomem *base, int irq_start,
 			      u32 vic_sources, u32 resume_sources,
 			      struct device_node *node)
 {
@@ -416,18 +416,12 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	if (WARN_ON(!regs))
 		return -EIO;
 
-	irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
-	if (WARN_ON(irq_base < 0))
-		goto out_unmap;
-
-	__vic_init(regs, irq_base, ~0, ~0, node);
+	/*
+	 * Passing -1 as first IRQ makes the simple domain allocate descriptors
+	 */
+	__vic_init(regs, -1, ~0, ~0, node);
 
 	return 0;
-
- out_unmap:
-	iounmap(regs);
-
-	return -EIO;
 }
 #endif /* CONFIG OF */
 
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index e14af1a..2bebad3 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -47,7 +47,7 @@
 struct device_node;
 struct pt_regs;
 
-void __vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources,
+void __vic_init(void __iomem *base, int irq_start, u32 vic_sources,
 		u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
 int vic_of_init(struct device_node *node, struct device_node *parent);
-- 
1.7.11.3
