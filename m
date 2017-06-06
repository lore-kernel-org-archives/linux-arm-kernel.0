From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jun 2017 13:59:28 +0800
Subject: [PATCH 06/10] irqchip: sunxi-nmi: Support sun6i-a31-r-intc compatible
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606055932.22548-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_INTC on the A31 is undocumented. It was previously supported
by the sun6i-a31-sc-nmi compatible. This compatible however required
the register region to start at the first used register, rather than
the boundaries laid out in the SoC's memory map. The new compatible
fixes the alignment, while also naming it properly.

Since the only difference between the old and new compatibles are
a fixed offset for the registers, and since the old one is deprecated,
this patch adds a set of register defines for the new compatible,
while modifying the old set to reference the new set minus a fixed
offset.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index e713ec66322b..a412b5d5d0fa 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -27,9 +27,18 @@
 
 #define SUNXI_NMI_IRQ_BIT	BIT(0)
 
-#define SUN6I_NMI_CTRL		0x00
-#define SUN6I_NMI_PENDING	0x04
-#define SUN6I_NMI_ENABLE	0x34
+#define SUN6I_R_INTC_CTRL	0x0c
+#define SUN6I_R_INTC_PENDING	0x10
+#define SUN6I_R_INTC_ENABLE	0x40
+
+/*
+ * For deprecated sun6i-a31-sc-nmi compatible.
+ * Registers are offset by 0x0c.
+ */
+#define SUN6I_R_INTC_NMI_OFFSET	0x0c
+#define SUN6I_NMI_CTRL		(SUN6I_R_INTC_CTRL - SUN6I_R_INTC_NMI_OFFSET)
+#define SUN6I_NMI_PENDING	(SUN6I_R_INTC_PENDING - SUN6I_R_INTC_NMI_OFFSET)
+#define SUN6I_NMI_ENABLE	(SUN6I_R_INTC_ENABLE - SUN6I_R_INTC_NMI_OFFSET)
 
 #define SUN7I_NMI_CTRL		0x00
 #define SUN7I_NMI_PENDING	0x04
@@ -52,6 +61,12 @@ struct sunxi_sc_nmi_reg_offs {
 	u32 enable;
 };
 
+static const struct sunxi_sc_nmi_reg_offs sun6i_r_intc_reg_offs __initconst = {
+	.ctrl	= SUN6I_R_INTC_CTRL,
+	.pend	= SUN6I_R_INTC_PENDING,
+	.enable	= SUN6I_R_INTC_ENABLE,
+};
+
 static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
 	.ctrl	= SUN6I_NMI_CTRL,
 	.pend	= SUN6I_NMI_PENDING,
@@ -217,6 +232,14 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	return ret;
 }
 
+static int __init sun6i_r_intc_irq_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun6i_r_intc_reg_offs);
+}
+IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc",
+		sun6i_r_intc_irq_init);
+
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-- 
2.11.0
