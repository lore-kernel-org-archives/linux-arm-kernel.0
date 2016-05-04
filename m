From: eric.auger@linaro.org (Eric Auger)
Date: Wed,  4 May 2016 15:18:12 +0000
Subject: [PATCH v9 6/8] irqchip/gicv2m: implement msi_doorbell_info callback
In-Reply-To: <1462375094-2390-1-git-send-email-eric.auger@linaro.org>
References: <1462375094-2390-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1462375094-2390-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the msi_doorbell_info callback in the
gicv2m driver.

The driver now is able to return its doorbell characteristics
(base, size, prot). A single doorbell is exposed.

This will allow the msi layer to iommu_map this doorbell when
requested.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v8 -> v9:
- use global_doorbell instead of percpu_doorbells

v7 -> v8:
- gicv2m_msi_doorbell_info does not return a pointer to const
- remove spurious !v2m check
- add IOMMU_MMIO flag

v7: creation
---
 drivers/irqchip/irq-gic-v2m.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 28f047c..c77c41f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/iommu.h>
 
 /*
 * MSI_TYPER:
@@ -64,6 +65,7 @@ struct v2m_data {
 	u32 nr_spis;		/* The number of SPIs for MSIs */
 	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
+	struct irq_chip_msi_doorbell_info doorbell_info;
 };
 
 static void gicv2m_mask_msi_irq(struct irq_data *d)
@@ -105,6 +107,14 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data -= v2m->spi_start;
 }
 
+static struct irq_chip_msi_doorbell_info *
+gicv2m_msi_doorbell_info(struct irq_data *data)
+{
+	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
+
+	return &v2m->doorbell_info;
+}
+
 static struct irq_chip gicv2m_irq_chip = {
 	.name			= "GICv2m",
 	.irq_mask		= irq_chip_mask_parent,
@@ -112,6 +122,7 @@ static struct irq_chip gicv2m_irq_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_compose_msi_msg	= gicv2m_compose_msi_msg,
+	.msi_doorbell_info	= gicv2m_msi_doorbell_info,
 };
 
 static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
@@ -311,6 +322,11 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 
 	memcpy(&v2m->res, res, sizeof(struct resource));
 
+	v2m->doorbell_info.global_doorbell = v2m->res.start;
+	v2m->doorbell_info.doorbell_is_percpu = false;
+	v2m->doorbell_info.size = sizeof(u32);
+	v2m->doorbell_info.prot = IOMMU_WRITE | IOMMU_MMIO;
+
 	v2m->base = ioremap(v2m->res.start, resource_size(&v2m->res));
 	if (!v2m->base) {
 		pr_err("Failed to map GICv2m resource\n");
-- 
1.9.1
