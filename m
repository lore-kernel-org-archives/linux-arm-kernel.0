From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 20 Dec 2012 19:53:53 +0100
Subject: [PATCH 2/2] ARM: VIC: fix bug in VIC irqdomain code
Message-ID: <1356029633-30239-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The VIC irqdomain code added in commit
07c9249f1fa90cc8189bed44c0bcece664596a72
"ARM: 7554/1: VIC: use irq_domain_add_simple()"

Had two bugs:

1) It didn't call irq_create_mapping() once on each
   valid irq source in the slowpath when registering
   the controller.

2) It passed a -1 as IRQ offset for the DT case, whereas
   0 should be passed as invalid IRQ instead.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/vic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index e4df17c..8f324b9 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -206,6 +206,7 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 				struct device_node *node)
 {
 	struct vic_device *v;
+	int i;
 
 	if (vic_id >= ARRAY_SIZE(vic_devices)) {
 		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
@@ -220,6 +221,10 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	vic_id++;
 	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
 					  &vic_irqdomain_ops, v);
+	/* create an IRQ mapping for each valid IRQ */
+	for (i = 0; i < fls(valid_sources); i++)
+		if (valid_sources & (1 << i))
+			irq_create_mapping(v->domain, i);
 }
 
 static void vic_ack_irq(struct irq_data *d)
@@ -416,9 +421,9 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 		return -EIO;
 
 	/*
-	 * Passing -1 as first IRQ makes the simple domain allocate descriptors
+	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, -1, ~0, ~0, node);
+	__vic_init(regs, 0, ~0, ~0, node);
 
 	return 0;
 }
-- 
1.7.11.3
