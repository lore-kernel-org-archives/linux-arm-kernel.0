From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:22 +0000
Subject: [PATCH v13 06/15] irqchip/gic-v2m: Register the MSI doorbell
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1475743531-4780-7-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the GIC V2M global doorbell. The registered information
are used to set up the KVM passthrough use case.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v12 -> v13:
- use new msi doorbell registration prototype
- remove iommu protection attributes
- add unregistration in teardown

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
 drivers/irqchip/irq-gic-v2m.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 863e073..343f19f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/msi-doorbell.h>
 
 /*
 * MSI_TYPER:
@@ -70,6 +71,7 @@ struct v2m_data {
 	u32 spi_offset;		/* offset to be subtracted from SPI number */
 	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
+	struct msi_doorbell_info *doorbell_info; /* MSI doorbell */
 };
 
 static void gicv2m_mask_msi_irq(struct irq_data *d)
@@ -254,6 +256,7 @@ static void gicv2m_teardown(void)
 	struct v2m_data *v2m, *tmp;
 
 	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
+		msi_doorbell_unregister_global(v2m->doorbell_info);
 		list_del(&v2m->entry);
 		kfree(v2m->bm);
 		iounmap(v2m->base);
@@ -370,12 +373,18 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 		goto err_iounmap;
 	}
 
+	ret = msi_doorbell_register_global(v2m->res.start, sizeof(u32),
+					   false, &v2m->doorbell_info);
+	if (ret)
+		goto err_free_bm;
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
