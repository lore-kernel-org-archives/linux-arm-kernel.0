From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Wed, 27 Jun 2012 15:54:50 +0200
Subject: [PATCH v5 9/9] ARM: mvebu: MPIC: read number of interrupts from
 control register
In-Reply-To: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1340805290-9051-10-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Read the number of MPIC interrupts from the controller and only register
that many.

[gregory.clement at free-electrons.com: rename armada symbol name to fit
with new name: armada_370_xp]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/mach-mvebu/irq-armada-370-xp.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/irq-armada-370-xp.c b/arch/arm/mach-mvebu/irq-armada-370-xp.c
index 645a8d3..5f5f939 100644
--- a/arch/arm/mach-mvebu/irq-armada-370-xp.c
+++ b/arch/arm/mach-mvebu/irq-armada-370-xp.c
@@ -29,13 +29,12 @@
 #define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
 
+#define ARMADA_370_XP_INT_CONTROL		(0x00)
 #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
 #define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
 
 #define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
 
-#define ARMADA_370_XP_NR_IRQS			(115)
-
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
@@ -81,14 +80,18 @@ static struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
+	u32 control;
+
 	main_int_base = of_iomap(node, 0);
 	per_cpu_int_base = of_iomap(node, 1);
 
 	BUG_ON(!main_int_base);
 	BUG_ON(!per_cpu_int_base);
 
+	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+
 	armada_370_xp_mpic_domain =
-	    irq_domain_add_linear(node, ARMADA_370_XP_NR_IRQS,
+	    irq_domain_add_linear(node, (control >> 2) & 0x3ff,
 				  &armada_370_xp_mpic_irq_ops, NULL);
 
 	if (!armada_370_xp_mpic_domain)
-- 
1.7.9.5
