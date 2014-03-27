From: carlo@caione.org (Carlo Caione)
Date: Thu, 27 Mar 2014 18:02:39 +0100
Subject: [PATCH 2/2] ARM: sun7i/sun6i: irqchip: Disable NMI before registering
 the handler
In-Reply-To: <1395939759-11135-1-git-send-email-carlo@caione.org>
References: <1395939759-11135-1-git-send-email-carlo@caione.org>
Message-ID: <1395939759-11135-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>

It is advisable to disable the NMI before registering the IRQ handler as
registering the IRQ handler unmasks the IRQ on the GIC, so if U-Boot has
left the NMI enabled and the NMI pin is active we will immediately get
an interrupt before any driver has claimed the downstream interrupt of
the NMI.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 1c8566c..12f547a 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -179,12 +179,12 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[1].regs.type		= reg_offs->ctrl;
 	gc->chip_types[1].handler		= handle_edge_irq;
 
-	irq_set_handler_data(irq, domain);
-	irq_set_chained_handler(irq, sunxi_sc_nmi_handle_irq);
-
 	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
 	sunxi_sc_nmi_write(gc, reg_offs->pend, 0x1);
 
+	irq_set_handler_data(irq, domain);
+	irq_set_chained_handler(irq, sunxi_sc_nmi_handle_irq);
+
 	return 0;
 
 fail_irqd_remove:
-- 
1.8.4.1
