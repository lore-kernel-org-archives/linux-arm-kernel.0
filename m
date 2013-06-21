From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:27:39 +0200
Subject: [PATCH 2/2] staging: drm/imx: convert IPU irq driver to
 irq_domain_add_linear
In-Reply-To: <1371803259-18369-1-git-send-email-p.zabel@pengutronix.de>
References: <1371803259-18369-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371803259-18369-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPU has a lot of interrupts. Instead of allocating descs for all
of them, register a linear irq domain and create mappings as needed.
This was listed in the TODO as a prerequisite to move the IPU driver
out of staging.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/TODO                |  1 -
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 66 +++++++++++++++++++----------
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h    |  2 +-
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/imx-drm/TODO b/drivers/staging/imx-drm/TODO
index 123acbe..f806415 100644
--- a/drivers/staging/imx-drm/TODO
+++ b/drivers/staging/imx-drm/TODO
@@ -6,7 +6,6 @@ TODO:
 - Factor out more code to common helper functions
 - decide where to put the base driver. It is not specific to a subsystem
   and would be used by DRM/KMS and media/V4L2
-- convert irq driver to irq_domain_add_linear
 
 Missing features (not necessarily for moving out of staging):
 
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index 0127601..1a7b59e 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of_device.h>
 
 #include "imx-ipu-v3.h"
@@ -799,16 +800,18 @@ err_di_0:
 static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_regs)
 {
 	unsigned long status;
-	int i, bit, irq_base;
+	int i, bit, irq;
 
 	for (i = 0; i < num_regs; i++) {
 
 		status = ipu_cm_read(ipu, IPU_INT_STAT(regs[i]));
 		status &= ipu_cm_read(ipu, IPU_INT_CTRL(regs[i]));
 
-		irq_base = ipu->irq_start + regs[i] * 32;
-		for_each_set_bit(bit, &status, 32)
-			generic_handle_irq(irq_base + bit);
+		for_each_set_bit(bit, &status, 32) {
+			irq = irq_linear_revmap(ipu->domain, regs[i] * 32 + bit);
+			if (irq)
+				generic_handle_irq(irq);
+		}
 	}
 }
 
@@ -841,7 +844,7 @@ static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
 static void ipu_ack_irq(struct irq_data *d)
 {
 	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->irq - ipu->irq_start;
+	irq_hw_number_t irq = d->hwirq;
 
 	ipu_cm_write(ipu, 1 << (irq % 32), IPU_INT_STAT(irq / 32));
 }
@@ -849,7 +852,7 @@ static void ipu_ack_irq(struct irq_data *d)
 static void ipu_unmask_irq(struct irq_data *d)
 {
 	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->irq - ipu->irq_start;
+	irq_hw_number_t irq = d->hwirq;
 	unsigned long flags;
 	u32 reg;
 
@@ -865,7 +868,7 @@ static void ipu_unmask_irq(struct irq_data *d)
 static void ipu_mask_irq(struct irq_data *d)
 {
 	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->irq - ipu->irq_start;
+	irq_hw_number_t irq = d->hwirq;
 	unsigned long flags;
 	u32 reg;
 
@@ -888,7 +891,12 @@ static struct irq_chip ipu_irq_chip = {
 int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
 		enum ipu_channel_irq irq_type)
 {
-	return ipu->irq_start + irq_type + channel->num;
+	int irq = irq_linear_revmap(ipu->domain, irq_type + channel->num);
+
+	if (!irq)
+		irq = irq_create_mapping(ipu->domain, irq_type + channel->num);
+
+	return irq;
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_channel_irq);
 
@@ -975,18 +983,30 @@ err_register:
 	return ret;
 }
 
-static int ipu_irq_init(struct ipu_soc *ipu)
+static int ipu_irq_map(struct irq_domain *h, unsigned int irq,
+		       irq_hw_number_t hw)
 {
-	int i;
+	struct ipu_soc *ipu = h->host_data;
+
+	irq_set_chip_and_handler(irq, &ipu_irq_chip, handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+	irq_set_chip_data(irq, ipu);
+
+	return 0;
+}
 
-	ipu->irq_start = irq_alloc_descs(-1, 0, IPU_NUM_IRQS, 0);
-	if (ipu->irq_start < 0)
-		return ipu->irq_start;
+const struct irq_domain_ops ipu_irq_domain_ops = {
+	.map = ipu_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
 
-	for (i = ipu->irq_start; i < ipu->irq_start + IPU_NUM_IRQS; i++) {
-		irq_set_chip_and_handler(i, &ipu_irq_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-		irq_set_chip_data(i, ipu);
+static int ipu_irq_init(struct ipu_soc *ipu)
+{
+	ipu->domain = irq_domain_add_linear(ipu->dev->of_node, IPU_NUM_IRQS,
+					    &ipu_irq_domain_ops, ipu);
+	if (!ipu->domain) {
+		dev_err(ipu->dev, "failed to add irq domain\n");
+		return -ENODEV;
 	}
 
 	irq_set_chained_handler(ipu->irq_sync, ipu_irq_handler);
@@ -999,20 +1019,20 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 
 static void ipu_irq_exit(struct ipu_soc *ipu)
 {
-	int i;
+	int i, irq;
 
 	irq_set_chained_handler(ipu->irq_err, NULL);
 	irq_set_handler_data(ipu->irq_err, NULL);
 	irq_set_chained_handler(ipu->irq_sync, NULL);
 	irq_set_handler_data(ipu->irq_sync, NULL);
 
-	for (i = ipu->irq_start; i < ipu->irq_start + IPU_NUM_IRQS; i++) {
-		set_irq_flags(i, 0);
-		irq_set_chip(i, NULL);
-		irq_set_chip_data(i, NULL);
+	for (i = 0; i < IPU_NUM_IRQS; i++) {
+		irq = irq_linear_revmap(ipu->domain, i);
+		if (irq)
+			irq_dispose_mapping(irq);
 	}
 
-	irq_free_descs(ipu->irq_start, IPU_NUM_IRQS);
+	irq_domain_remove(ipu->domain);
 }
 
 static int ipu_probe(struct platform_device *pdev)
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
index 12d7eaf..4df0050 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
@@ -170,9 +170,9 @@ struct ipu_soc {
 
 	struct ipuv3_channel	channel[64];
 
-	int			irq_start;
 	int			irq_sync;
 	int			irq_err;
+	struct irq_domain	*domain;
 
 	struct ipu_dc_priv	*dc_priv;
 	struct ipu_dp_priv	*dp_priv;
-- 
1.8.3.1
