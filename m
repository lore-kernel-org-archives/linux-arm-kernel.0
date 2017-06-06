From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jun 2017 13:59:24 +0800
Subject: [PATCH 02/10] irqchip: sunxi-nmi: Document interrupt disabling and
 clearing at probe time
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606055932.22548-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi-nmi disables all its interrupts and clears any pending
interrupts at probe time.

Add comments documenting it, just to make it clear.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 177efb473c7d..9a7f6971cc3a 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -201,7 +201,10 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[1].regs.type		= reg_offs->ctrl;
 	gc->chip_types[1].handler		= handle_edge_irq;
 
+	/* Disable any active interrupts */
 	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
+
+	/* Clear any pending NMI interrupts */
 	sunxi_sc_nmi_write(gc, reg_offs->pend, SUNXI_NMI_IRQ_BIT);
 
 	irq_set_chained_handler_and_data(irq, sunxi_sc_nmi_handle_irq, domain);
-- 
2.11.0
