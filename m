From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  2 Aug 2016 17:23:33 +0000
Subject: [PATCH v12 07/11] irqchip/gic-v2m: Register the MSI global doorbell
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1470158617-7022-8-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the msi-doorbell API to register the global doorbell
and implement the irq_get_msi_doorbell_info

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v11 -> v12:
- use irq_get_msi_doorbell_info new name
- simplify error handling

v10 -> v11:
- use the new registration API and re-implement the msi_doorbell_info
  ops

v9 -> v10:
- introduce the registration concept in place of msi_doorbell_info
  callback

v8 -> v9:
- use global_doorbell instead of percpu_doorbells

v7 -> v8:
- gicv2m_msi_doorbell_info does not return a pointer to const
- remove spurious !v2m check
- add IOMMU_MMIO flag

v7: creation
---
 drivers/irqchip/irq-gic-v2m.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index ad0d296..37d8437 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -24,6 +24,8 @@
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/iommu.h>
+#include <linux/msi-doorbell.h>
 
 /*
 * MSI_TYPER:
@@ -68,6 +70,7 @@ struct v2m_data {
 	u32 spi_offset;		/* offset to be subtracted from SPI number */
 	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
+	struct msi_doorbell_info *doorbell_info; /* MSI doorbell */
 };
 
 static void gicv2m_mask_msi_irq(struct irq_data *d)
@@ -109,13 +112,22 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data -= v2m->spi_offset;
 }
 
+static struct msi_doorbell_info *
+gicv2m_irq_get_msi_doorbell_info(struct irq_data *data)
+{
+	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
+
+	return v2m->doorbell_info;
+}
+
 static struct irq_chip gicv2m_irq_chip = {
-	.name			= "GICv2m",
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.irq_compose_msi_msg	= gicv2m_compose_msi_msg,
+	.name				= "GICv2m",
+	.irq_mask			= irq_chip_mask_parent,
+	.irq_unmask			= irq_chip_unmask_parent,
+	.irq_eoi			= irq_chip_eoi_parent,
+	.irq_set_affinity		= irq_chip_set_affinity_parent,
+	.irq_compose_msi_msg		= gicv2m_compose_msi_msg,
+	.irq_get_msi_doorbell_info	= gicv2m_irq_get_msi_doorbell_info,
 };
 
 static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
@@ -366,12 +378,21 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 		goto err_iounmap;
 	}
 
+	v2m->doorbell_info =
+		msi_doorbell_register_global(v2m->res.start, sizeof(u32),
+					     IOMMU_WRITE | IOMMU_MMIO, false);
+	if (!v2m->doorbell_info) {
+		ret = -ENOMEM;
+		goto err_free_bm;
+	}
+
 	list_add_tail(&v2m->entry, &v2m_nodes);
 
 	pr_info("range%pR, SPI[%d:%d]\n", res,
 		v2m->spi_start, (v2m->spi_start + v2m->nr_spis - 1));
 	return 0;
-
+err_free_bm:
+	kfree(v2m->bm);
 err_iounmap:
 	iounmap(v2m->base);
 err_free_v2m:
-- 
1.9.1
