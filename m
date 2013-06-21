From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 14:52:18 +0200
Subject: [PATCH 2/2] staging: drm/imx: use generic irq chip unused field to
 block out invalid irqs
In-Reply-To: <1371819139-22039-1-git-send-email-p.zabel@pengutronix.de>
References: <1371819139-22039-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371819139-22039-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This depends on the patch "genirq: irqchip: Add mask to block out invalid irqs"
and masks out reserved bits using the unused interrupt bitfield.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index c135c66..b470cda 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -1129,6 +1129,16 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	unsigned long unused[IPU_NUM_IRQS / 32] = {
+		0x400100d0, 0xffe000fd,
+		0x400100d0, 0xffe000fd,
+		0x400100d0, 0xffe000fd,
+		0x4077ffff, 0xffe7e1fd,
+		0x23fffffe, 0x8880fff0,
+		0xf98fe7d0, 0xfff81fff,
+		0x400100d0, 0xffe000fd,
+		0x00000000,
+	};
 	int ret, i;
 
 	ipu->domain = irq_domain_add_linear(ipu->dev->of_node, IPU_NUM_IRQS,
@@ -1149,6 +1159,7 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 	for (i = 0; i < IPU_NUM_IRQS; i += 32) {
 		gc = irq_get_domain_generic_chip(ipu->domain, i);
 		gc->reg_base = ipu->cm_reg;
+		gc->unused = unused[i / 32];
 		ct = gc->chip_types;
 		ct->chip.irq_ack = irq_gc_ack_set_bit;
 		ct->chip.irq_mask = irq_gc_mask_clr_bit;
-- 
1.8.3.1
