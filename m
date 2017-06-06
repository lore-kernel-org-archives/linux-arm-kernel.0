From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jun 2017 13:59:23 +0800
Subject: [PATCH 01/10] irqchip: sunxi-nmi: Convert magic numbers to defines
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606055932.22548-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi-nmi driver has a bunch of raw register offsets and bit values.

Convert them into define macros for better readability.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 668730c5cb66..177efb473c7d 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -25,6 +25,20 @@
 
 #define SUNXI_NMI_SRC_TYPE_MASK	0x00000003
 
+#define SUNXI_NMI_IRQ_BIT	BIT(0)
+
+#define SUN6I_NMI_CTRL		0x00
+#define SUN6I_NMI_PENDING	0x04
+#define SUN6I_NMI_ENABLE	0x34
+
+#define SUN7I_NMI_CTRL		0x00
+#define SUN7I_NMI_PENDING	0x04
+#define SUN7I_NMI_ENABLE	0x08
+
+#define SUN9I_NMI_CTRL		0x00
+#define SUN9I_NMI_ENABLE	0x04
+#define SUN9I_NMI_PENDING	0x08
+
 enum {
 	SUNXI_SRC_TYPE_LEVEL_LOW = 0,
 	SUNXI_SRC_TYPE_EDGE_FALLING,
@@ -39,21 +53,21 @@ struct sunxi_sc_nmi_reg_offs {
 };
 
 static struct sunxi_sc_nmi_reg_offs sun7i_reg_offs = {
-	.ctrl	= 0x00,
-	.pend	= 0x04,
-	.enable	= 0x08,
+	.ctrl	= SUN7I_NMI_CTRL,
+	.pend	= SUN7I_NMI_PENDING,
+	.enable	= SUN7I_NMI_ENABLE,
 };
 
 static struct sunxi_sc_nmi_reg_offs sun6i_reg_offs = {
-	.ctrl	= 0x00,
-	.pend	= 0x04,
-	.enable	= 0x34,
+	.ctrl	= SUN6I_NMI_CTRL,
+	.pend	= SUN6I_NMI_PENDING,
+	.enable	= SUN6I_NMI_ENABLE,
 };
 
 static struct sunxi_sc_nmi_reg_offs sun9i_reg_offs = {
-	.ctrl	= 0x00,
-	.pend	= 0x08,
-	.enable	= 0x04,
+	.ctrl	= SUN9I_NMI_CTRL,
+	.pend	= SUN9I_NMI_PENDING,
+	.enable	= SUN9I_NMI_ENABLE,
 };
 
 static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
@@ -188,7 +202,7 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[1].handler		= handle_edge_irq;
 
 	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
-	sunxi_sc_nmi_write(gc, reg_offs->pend, 0x1);
+	sunxi_sc_nmi_write(gc, reg_offs->pend, SUNXI_NMI_IRQ_BIT);
 
 	irq_set_chained_handler_and_data(irq, sunxi_sc_nmi_handle_irq, domain);
 
-- 
2.11.0
