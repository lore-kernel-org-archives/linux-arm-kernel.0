From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Dec 2015 16:20:12 +0800
Subject: [PATCH 3/4] irqchip/sunxi-nmi: Support sun9i A80 NMI controller
In-Reply-To: <1449130813-22400-1-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
Message-ID: <1449130813-22400-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 moves the NMI controller into the PRCM address space, and also
rearranges the registers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 4ef178078e5b..0820f67cc9a7 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -50,6 +50,12 @@ static struct sunxi_sc_nmi_reg_offs sun6i_reg_offs = {
 	.enable	= 0x34,
 };
 
+static struct sunxi_sc_nmi_reg_offs sun9i_reg_offs = {
+	.ctrl	= 0x00,
+	.pend	= 0x08,
+	.enable	= 0x04,
+};
+
 static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
 				      u32 val)
 {
@@ -207,3 +213,10 @@ static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
 	return sunxi_sc_nmi_irq_init(node, &sun7i_reg_offs);
 }
 IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_nmi_irq_init);
+
+static int __init sun9i_nmi_irq_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun9i_reg_offs);
+}
+IRQCHIP_DECLARE(sun9i_nmi, "allwinner,sun9i-a80-nmi", sun9i_nmi_irq_init);
-- 
2.6.2
