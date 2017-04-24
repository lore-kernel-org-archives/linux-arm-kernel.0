From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 25 Apr 2017 00:00:56 +0800
Subject: [PATCH v4 03/10] irqchip/sunxi-nmi: add support for the NMI in A64
 R_INTC
In-Reply-To: <20170424160103.9447-1-icenowy@aosc.io>
References: <20170424160103.9447-1-icenowy@aosc.io>
Message-ID: <20170424160103.9447-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the newly imported compatible for the A64 R_INTC in
irq-sunxi-nmi driver

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v4, which is part of NMI refactor.

 drivers/irqchip/irq-sunxi-nmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 668730c5cb66..5f7408b1cd4d 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -56,6 +56,12 @@ static struct sunxi_sc_nmi_reg_offs sun9i_reg_offs = {
 	.enable	= 0x04,
 };
 
+static struct sunxi_sc_nmi_reg_offs sun50i_reg_offs = {
+	.ctrl	= 0x0c,
+	.pend	= 0x10,
+	.enable	= 0x40,
+};
+
 static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
 				      u32 val)
 {
@@ -220,3 +226,10 @@ static int __init sun9i_nmi_irq_init(struct device_node *node,
 	return sunxi_sc_nmi_irq_init(node, &sun9i_reg_offs);
 }
 IRQCHIP_DECLARE(sun9i_nmi, "allwinner,sun9i-a80-nmi", sun9i_nmi_irq_init);
+
+static int __init sun50i_nmi_irq_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun50i_reg_offs);
+}
+IRQCHIP_DECLARE(sun50i_nmi, "allwinner,sun50i-a80-nmi", sun50i_nmi_irq_init);
-- 
2.12.2
